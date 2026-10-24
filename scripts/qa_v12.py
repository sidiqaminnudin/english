from pathlib import Path
import json,subprocess,re,collections,shutil
root=Path(__file__).resolve().parents[1]
def load(name):return json.loads((root/'db'/name).read_text())
modules=load('v12_modules.json');mcq=load('v12_mcq.json');translation=load('v12_translation.json');listening=load('v12_listening.json')
assert len(modules)==8
slugs={x['slug'] for x in modules}
assert len(slugs)==len(modules)
lessons={m['slug']:{l['slug'] for l in m['lessons']} for m in modules}
assert sum(len(x) for x in lessons.values())==24
assert all(len(m['lessons'])==3 and all(len(l['body'])>280 for l in m['lessons']) for m in modules)
assert len(mcq)>=190
codes=set()
for q in mcq:
 assert q['code'] not in codes
 codes.add(q['code'])
 assert q['module_slug'] in slugs and q['lesson_slug'] in lessons[q['module_slug']],q
 assert len(q['stem'])>10 and len(q['explanation'])>20
 assert len(q['options'])==4 and len({o.lower().strip() for o in q['options']})==4,q
 assert 0<=q['correct_index']<4
 assert q['difficulty'] in ['easy','medium','hard']
 assert q['options'][q['correct_index']].strip()
assert len(translation)>=70
assert len({x['code'] for x in translation})==len(translation)
for q in translation:
 assert len(q['indonesian'])>8 and len(q['model_answer'])>10
 assert q['accepted_answers'] and q['model_answer'] in q['accepted_answers']
 assert q['grammar_focus'] in slugs or q['grammar_focus']=='simple-present'
assert len(listening)==8
n=0
for t in listening:
 assert len(t['questions'])==4
 audio=root/'src/public/audio'/t['filename'];assert audio.exists() and audio.stat().st_size>20000
 assert audio.read_bytes()[:3]==b'ID3' or audio.read_bytes()[:2]==b'\xff\xfb'
 if shutil.which('ffprobe'):
  p=subprocess.run(['ffprobe','-v','error','-show_entries','format=duration','-of','default=nw=1:nk=1',str(audio)],capture_output=True,text=True,check=True)
  assert float(p.stdout.strip())>15
 for q in t['questions']:
  assert len(q['options'])==4 and len(set(q['options']))==4
  assert 0<=q['correct_index']<4
  assert len(q['explanation'])>12
  n+=1
print('PASS v1.2:',len(modules),'new modules;',sum(map(len,lessons.values())),'new lessons;',len(mcq),'new MCQs;',len(translation),'translation prompts;',len(listening),'original audio recordings;',n,'listening questions')
print('Note: structural QA does NOT prove linguistic correctness or PostgreSQL runtime integration.')
