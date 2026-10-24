#!/usr/bin/env python3
"""Generate and safely replace 8 EnglishLab listening MP3s with neural speech.

Run from project root after copying script + voice plan into EnglishLab:
  python scripts/generate_natural_listening.py --dry-run
  python -m pip install edge-tts imageio-ffmpeg
  python scripts/generate_natural_listening.py --provider edge

Or official Azure Speech REST (requires env AZURE_SPEECH_KEY and AZURE_SPEECH_REGION):
  python scripts/generate_natural_listening.py --provider azure

No source MP3 is replaced unless ALL outputs generated and validated.
Existing audio is copied to backup/listening-legacy-TIMESTAMP before replacement.
"""
import argparse
import asyncio
import hashlib
import html
import json
import os
import re
import shutil
import subprocess
import sys
import tempfile
import time
from datetime import datetime, timezone
from pathlib import Path
from urllib.error import HTTPError, URLError
from urllib.request import Request, urlopen

DEFAULT_ROOT = Path(__file__).resolve().parents[1]
EXPECTED_SLUGS = {
    'at-the-library', 'weekend-plans', 'missed-the-bus', 'at-the-cafe',
    'rainy-afternoon', 'asking-directions', 'new-job', 'at-the-clinic'
}


def parse_turns(transcript: str):
    lines = [line.strip() for line in transcript.splitlines() if line.strip()]
    if not lines:
        raise ValueError('Empty transcript')
    parsed = []
    for line in lines:
        match = re.match(r'^([A-Za-z][A-Za-z -]{0,40}):\s*(.+)$', line)
        if match:
            parsed.append((match.group(1), match.group(2)))
        else:
            parsed.append(('narrator', line))
    return parsed


def load_data(root, data_file=None, plan_file=None):
    data_file = Path(data_file) if data_file else root/'db'/'v12_listening.json'
    plan_file = Path(plan_file) if plan_file else root/'db'/'listening_voice_plan.json'
    if not data_file.exists() and not data_file.is_absolute():
        data_file = root/'references'/'v12_listening_original_reference.json'
    elif not data_file.exists() and data_file.name=='v12_listening.json':
        data_file = root/'references'/'v12_listening_original_reference.json'
    data = json.loads(data_file.read_text(encoding='utf-8'))
    plan = json.loads(plan_file.read_text(encoding='utf-8'))
    slugs = [row['slug'] for row in data]
    if len(slugs)!=8 or len(set(slugs))!=8 or set(slugs)!=EXPECTED_SLUGS:
        raise ValueError(f'Expected exactly eight original listening sessions, found {slugs}')
    for row in data:
        if row['filename'] != row['slug']+'.mp3':
            raise ValueError('Unexpected audio filename for '+row['slug'])
        voice_map = plan['voices'].get(row['slug'], {})
        for speaker, content in parse_turns(row['transcript']):
            if not content.strip() or speaker not in voice_map:
                raise ValueError(f'No voice mapping/content for {row["slug"]}:{speaker}')
        if len(row.get('questions',[]))!=4:
            raise ValueError('Each listening session must retain 4 questions')
    return data,plan


def build_ssml(track, plan):
    voice_map=plan['voices'][track['slug']]
    pause = int(plan.get('pause_ms',450))
    rate = plan.get('speaking_rate','-6%')
    parts=['<speak version="1.0" xmlns="http://www.w3.org/2001/10/synthesis" xml:lang="en-US">']
    for speaker, utterance in parse_turns(track['transcript']):
        voice = html.escape(voice_map[speaker], quote=True)
        safe_text = html.escape(utterance, quote=False)
        # Speaker names label dialogue in subtitles but are deliberately not read aloud.
        parts.append(f'<voice name="{voice}"><prosody rate="{rate}">{safe_text}</prosody><break time="{pause}ms"/></voice>')
    parts.append('</speak>')
    ssml=''.join(parts)
    import xml.etree.ElementTree as ET
    ET.fromstring(ssml)
    return ssml


def ffmpeg_executable():
    binary=shutil.which('ffmpeg')
    if binary:return binary
    try:
        import imageio_ffmpeg
        return imageio_ffmpeg.get_ffmpeg_exe()
    except (ImportError, RuntimeError):
        raise RuntimeError('ffmpeg missing. Install ffmpeg or run: python -m pip install imageio-ffmpeg')


def verify_mp3(file_path, ffmpeg=None, min_bytes=16000):
    if not file_path.exists() or file_path.stat().st_size<min_bytes:
        raise ValueError(f'File missing or too short: {file_path}')
    header = file_path.read_bytes()[:4]
    if not (header[:3]==b'ID3' or (header[0]==0xFF and (header[1]&0xE0)==0xE0)):
        raise ValueError(f'Not an MP3 audio stream: {file_path}')
    if ffmpeg:
        proc=subprocess.run([ffmpeg,'-hide_banner','-loglevel','error','-i',str(file_path),'-f','null','-'],stdout=subprocess.PIPE,stderr=subprocess.PIPE,timeout=120)
        if proc.returncode:
            raise ValueError(f'Cannot decode MP3 {file_path}: {proc.stderr.decode(errors="replace")[:500]}')


def write_manifest_preview(root, tracks, plan):
    preview_dir=root/'docs'/'neural_ssml_previews'
    preview_dir.mkdir(parents=True,exist_ok=True)
    for track in tracks:
        (preview_dir/(track['slug']+'.ssml')).write_text(build_ssml(track,plan)+'\n',encoding='utf-8')
    return preview_dir


def azure_generate(track, plan, output):
    key=os.environ.get('AZURE_SPEECH_KEY')
    region=os.environ.get('AZURE_SPEECH_REGION')
    if not key or not region:
        raise RuntimeError('Azure requires AZURE_SPEECH_KEY and AZURE_SPEECH_REGION environment variables')
    if not re.fullmatch(r'[a-z0-9-]+',region):
        raise ValueError('AZURE_SPEECH_REGION must be a regional identifier, e.g. southeastasia')
    url=f'https://{region}.tts.speech.microsoft.com/cognitiveservices/v1'
    body=build_ssml(track,plan).encode('utf-8')
    req=Request(url, data=body,headers={
        'Ocp-Apim-Subscription-Key':key,
        'Content-Type':'application/ssml+xml',
        'X-Microsoft-OutputFormat':plan['output_format'],
        'User-Agent':'EnglishLabNaturalListening/1.3'
    },method='POST')
    for attempt in range(3):
        try:
            with urlopen(req,timeout=75) as response:
                if response.status!=200 or 'audio' not in response.headers.get('Content-Type','').lower():
                    raise RuntimeError('Speech response not audio: '+str(response.status))
                output.write_bytes(response.read())
            return
        except (URLError,HTTPError) as err:
            code=getattr(err,'code',None)
            if code in (401,403):
                raise RuntimeError('Azure Speech credentials/region invalid (401/403)') from err
            if attempt==2:raise RuntimeError(f'Azure Speech request failed: {err}') from err
            time.sleep((attempt+1)*2)


async def edge_generate(tracks,plan,work):
    try:import edge_tts
    except ImportError as exc:raise RuntimeError('Missing edge-tts: python -m pip install edge-tts imageio-ffmpeg') from exc
    ff=ffmpeg_executable()
    pause_ms=int(plan.get('pause_ms',450))
    silence=work/'silence.mp3'
    proc=subprocess.run([ff,'-hide_banner','-loglevel','error','-y','-f','lavfi','-i','anullsrc=r=24000:cl=mono','-t',str(pause_ms/1000),'-ac','1','-ar','24000','-codec:a','libmp3lame','-b:a','96k',str(silence)],capture_output=True,text=True)
    if proc.returncode:raise RuntimeError('Cannot create pause audio: '+proc.stderr)
    for track in tracks:
        slug=track['slug']; tmp=work/slug; tmp.mkdir()
        voice_map=plan['voices'][slug]
        items=[]
        for i,(speaker,utterance) in enumerate(parse_turns(track['transcript'])):
            piece=tmp/f'part_{i:02d}.mp3'
            for attempt in range(3):
                try:
                    # Use the OS resolver on Windows; aiohttp's optional async DNS
                    # resolver can fail even when Windows resolves the service.
                    import aiohttp
                    connector = aiohttp.TCPConnector(resolver=aiohttp.ThreadedResolver())
                    try:
                        await edge_tts.Communicate(utterance,voice=voice_map[speaker],rate=plan.get('speaking_rate','-6%'),connector=connector).save(str(piece))
                    finally:
                        await connector.close()
                    # Short dialogue turns may legitimately be below 16 KB.
                    # Decode every segment; retain the larger limit for final tracks.
                    verify_mp3(piece,ff,min_bytes=1000)
                    break
                except Exception as exc:
                    if attempt==2:raise RuntimeError(f'Neural TTS failed for {slug} line {i+1}: {exc}') from exc
                    await asyncio.sleep((attempt+1)*2)
            items.append(piece)
        playlist=tmp/'concat.txt'
        lines=[]
        for i,piece in enumerate(items):
            lines.append(f"file '{piece.name}'")
            if i<len(items)-1:
                # relative path to temporary work subdirectory
                shutil.copy2(silence,tmp/'silence.mp3') if i==0 else None
                lines.append("file 'silence.mp3'")
        playlist.write_text('\n'.join(lines)+'\n',encoding='utf-8')
        out=work/(slug+'.mp3')
        args=[ff,'-hide_banner','-loglevel','error','-y','-f','concat','-safe','0','-i','concat.txt','-ac','1','-ar','24000','-codec:a','libmp3lame','-b:a','96k',str(out)]
        proc=subprocess.run(args,cwd=tmp,capture_output=True,text=True,timeout=180)
        if proc.returncode:raise RuntimeError(f'ffmpeg concat failed {slug}: {proc.stderr}')
        verify_mp3(out,ff)
        print(f'Generated {slug}: {out.stat().st_size:,} bytes',flush=True)


def main():
    parser=argparse.ArgumentParser(description='EnglishLab eight natural neural listening MP3 replacement')
    parser.add_argument('--provider',choices=['edge','azure'],default='edge')
    parser.add_argument('--root',type=Path,default=DEFAULT_ROOT,help='EnglishLab repository root')
    parser.add_argument('--target',type=Path,help='Audio directory (default: root/src/public/audio)')
    parser.add_argument('--dry-run',action='store_true',help='Validate scripts, show voices; no network or changes')
    parser.add_argument('--data',type=Path,help='Path to v12_listening.json')
    parser.add_argument('--plan',type=Path,help='Path to listening_voice_plan.json')
    args=parser.parse_args()
    root=args.root.expanduser().resolve()
    target=(args.target or root/'src'/'public'/'audio').expanduser().resolve()
    tracks,plan=load_data(root,args.data,args.plan)
    for track in tracks:build_ssml(track,plan)
    print(f'Validated {len(tracks)} listening tracks / {sum(len(x["questions"]) for x in tracks)} unchanged questions')
    for track in tracks:
        print(' - '+track['filename']+' '+', '.join(f'{k}={v}' for k,v in plan['voices'][track['slug']].items()))
    if args.dry_run:
        print('DRY RUN: no audio regenerated, no file overwritten.')
        return
    if not target.is_dir():
        raise RuntimeError('Existing audio folder not found: '+str(target)+'; use --target for custom layouts')
    # Prevent generating for the wrong project. If source folder contains other existing audio files, leave intact.
    original_paths=[target/track['filename'] for track in tracks]
    missing=[str(p) for p in original_paths if not p.is_file()]
    if missing:
        raise RuntimeError('Expected original audio tracks missing; refusing to overwrite: '+', '.join(missing))
    with tempfile.TemporaryDirectory(prefix='englishlab-listening-') as tmp:
        work=Path(tmp)
        if args.provider=='edge':
            asyncio.run(edge_generate(tracks,plan,work))
        else:
            ff=shutil.which('ffmpeg')
            for track in tracks:
                p=work/track['filename']
                azure_generate(track,plan,p)
                verify_mp3(p,ff)
                print(f'Generated {track["slug"]}: {p.stat().st_size:,} bytes',flush=True)
        # All eight must exist and be valid before any existing file is replaced.
        for track in tracks:verify_mp3(work/track['filename'],shutil.which('ffmpeg'))
        backup=root/'backup'/('listening-legacy-'+datetime.now(timezone.utc).strftime('%Y%m%dT%H%M%SZ'))
        backup.mkdir(parents=True,exist_ok=False)
        for p in original_paths:shutil.copy2(p,backup/p.name)
        changed=[]
        try:
            for track in tracks:
                dest=target/track['filename']
                shutil.copy2(work/track['filename'],target/(track['filename']+'.new'))
                os.replace(target/(track['filename']+'.new'),dest)
                changed.append(dest)
        except Exception:
            for p in changed:shutil.copy2(backup/p.name,p)
            raise
        report={
            'version':'1.3-listening-neural',
            'provider':args.provider,
            'generated_at_utc':datetime.now(timezone.utc).isoformat(),
            'backup':str(backup),
            'tracks':[{'slug':track['slug'],'filename':track['filename'],'sha256':hashlib.sha256((target/track['filename']).read_bytes()).hexdigest(),'bytes':(target/track['filename']).stat().st_size} for track in tracks]
        }
        report_path=root/'db'/'listening_audio_report.json'
        report_path.write_text(json.dumps(report,indent=2,ensure_ascii=False)+'\n',encoding='utf-8')
        print('\nSUCCESS: all 8 neural MP3s replaced. Backup: '+str(backup))
        print('Generation report: '+str(report_path))
        print('Next (optional): node scripts/update_listening_audio_metadata.js')


if __name__=='__main__':
    try:main()
    except Exception as exc:
        print('ERROR:',exc,file=sys.stderr)
        sys.exit(1)
