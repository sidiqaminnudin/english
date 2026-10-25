import 'dotenv/config';
import {readFile} from 'node:fs/promises';
import {pool} from '../src/db.js';
const load=async file=>JSON.parse(await readFile(new URL(`../db/${file}`,import.meta.url),'utf8'));
const write=await load('writing_expansion.json'),listen=await load('listening_expansion.json');
const c=await pool.connect();
try{
 await c.query('BEGIN');
 let addedWrite=0,addedListen=0;
 for(const q of write){
  const res=await c.query(`INSERT INTO translation_prompts(code,grammar_focus,indonesian,model_answer,accepted_answers,explanation,difficulty)
   VALUES ($1,$2,$3,$4,$5::jsonb,$6,$7) ON CONFLICT (code) DO NOTHING`,
   [q.code,q.grammar_focus,q.indonesian,q.model_answer,JSON.stringify(q.accepted_answers),q.explanation,q.difficulty]);
  addedWrite+=res.rowCount;
 }
 const keys=[...new Set(listen.map(q=>q.slug))];
 const tracks=(await c.query('SELECT id,slug,source_type FROM listening_tracks WHERE slug=ANY($1::text[])',[keys])).rows;
 // Abort listening expansion until real human audio has been applied. Prevents unrelated answers from appearing on old robotic tracks.
 const bySlug=new Map(tracks.map(t=>[t.slug,t]));
 const notReady=keys.filter(s=>!bySlug.has(s)||bySlug.get(s).source_type!=='voa-human-voices');
 if(notReady.length){
  console.warn('Listening expansion skipped: apply real-human VOA overwrite patch and verify downloads first. Not ready: '+notReady.join(', '));
 } else {
  for(const q of listen){
   const result=await c.query(`INSERT INTO listening_questions(code,track_id,stem,options,correct_index,explanation,is_active)
    VALUES($1,$2,$3,$4::jsonb,$5,$6,TRUE) ON CONFLICT (code) DO NOTHING`,
    [q.code,bySlug.get(q.slug).id,q.stem,JSON.stringify(q.options),q.correct_index,q.explanation]);
   addedListen+=result.rowCount;
  }
 }
 await c.query('COMMIT');
 console.log(`Added Writing ${addedWrite}/${write.length}, Listening ${addedListen}/${listen.length}. Existing questions preserved.`);
} catch(e){await c.query('ROLLBACK').catch(()=>{});throw e;}
finally{c.release();await pool.end();}
