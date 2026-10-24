/** Update listening metadata and cache-bust audio URLs AFTER neural MP3 files are generated.
 * This deliberately does not edit questions, runs, answers, scores or transcripts.
 */
import 'dotenv/config';
import { readFile, stat } from 'node:fs/promises';
import { join } from 'node:path';
import { createHash } from 'node:crypto';
import { pool } from '../src/db.js';

const fileURL = new URL('../db/listening_audio_report.json', import.meta.url);
let client;
try {
  const report = JSON.parse(await readFile(fileURL,'utf8'));
  if (!['edge','azure'].includes(report.provider) || report.tracks?.length !== 8 ||
      new Set(report.tracks.map(t => t.slug)).size !== 8) {
    throw new Error('Invalid generation report; generate and verify all eight tracks first.');
  }
  for (const track of report.tracks) {
    if (track.filename !== track.slug + '.mp3') throw new Error('Unexpected filename: '+track.filename);
    const path = new URL('../src/public/audio/'+track.filename, import.meta.url);
    const bytes = await readFile(path);
    if (bytes.length < 16000 || createHash('sha256').update(bytes).digest('hex') !== track.sha256) {
      throw new Error('File hash mismatch for '+track.slug+'; aborting database update.');
    }
  }
  client = await pool.connect();
  await client.query('BEGIN');
  let updated=0;
  for (const track of report.tracks) {
    const provider = report.provider === 'azure' ? 'Azure Speech Neural TTS' : 'Microsoft Edge neural TTS via edge-tts';
    const result=await client.query(`UPDATE listening_tracks
      SET audio_path=$1, source_type=$2, source_credit=$3
      WHERE slug=$4`,[
        '/audio/'+track.filename+'?v='+track.sha256.slice(0,12),
        'original-neural-tts-'+report.provider,
        'Original EnglishLab dialogue; neural voice synthesized with '+provider+'.',
        track.slug
      ]);
    if(result.rowCount!==1)throw new Error('Listening track not found in DB: '+track.slug);
    updated+=result.rowCount;
  }
  await client.query('COMMIT');
  console.log(`Updated metadata for ${updated} listening tracks. MCQ, listening questions and exam history unchanged.`);
} catch(err) {
  if(client)await client.query('ROLLBACK').catch(()=>{});
  console.error(err.message);
  process.exitCode=1;
} finally {
  client?.release();
  await pool.end();
}
