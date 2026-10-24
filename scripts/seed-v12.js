import 'dotenv/config';
import {readFile} from 'node:fs/promises';
import {pool} from '../src/db.js';
async function read(name){return JSON.parse(await readFile(new URL('../db/'+name,import.meta.url),'utf8'));}
const client=await pool.connect();
try {
 const modules=await read('v12_modules.json'),mcqs=await read('v12_mcq.json');
 const translations=await read('v12_translation.json'),listening=await read('v12_listening.json');
 await client.query('BEGIN');
 const course=(await client.query("SELECT id FROM courses WHERE slug='english-foundations'")).rows[0];
 if(!course)throw Error('Course dasar belum ada: jalankan npm run db:seed:all terlebih dahulu.');
 let max=(await client.query('SELECT COALESCE(MAX(sort_order),0) AS n FROM modules')).rows[0].n;
 const moduleIds=new Map(), lessonIds=new Map();
 for(const m of modules){
  const inserted=await client.query(`INSERT INTO modules(course_id,slug,title,description,level,sort_order,is_published)
   VALUES($1,$2,$3,$4,'beginner',$5,true) ON CONFLICT(slug) DO NOTHING`,[course.id,m.slug,m.title,m.description,++max]);
  const mod=(await client.query('SELECT id FROM modules WHERE slug=$1',[m.slug])).rows[0];
  moduleIds.set(m.slug,mod.id);
  for(const [i,l] of m.lessons.entries()){
   await client.query(`INSERT INTO lessons(module_id,slug,title,summary,body_md,sort_order,is_published)
    VALUES($1,$2,$3,$4,$5,$6,true) ON CONFLICT(module_id,slug) DO NOTHING`,[mod.id,l.slug,l.title,l.title,l.body,i+1]);
   const found=(await client.query('SELECT id FROM lessons WHERE module_id=$1 AND slug=$2',[mod.id,l.slug])).rows[0];
   lessonIds.set(m.slug+':'+l.slug,found.id);
  }
  await client.query(`INSERT INTO exam_configs(module_id,question_count,duration_minutes,passing_score) VALUES($1,20,30,75) ON CONFLICT(module_id) DO NOTHING`,[mod.id]);
 }
 let insertedMCQ=0;
 for(const q of mcqs){
  const ins=await client.query(`INSERT INTO questions(code,module_id,lesson_id,stem,kind,difficulty,explanation,is_active)
   VALUES($1,$2,$3,$4,'mcq',$5,$6,true) ON CONFLICT(code) DO NOTHING RETURNING id`,
   [q.code,moduleIds.get(q.module_slug),lessonIds.get(q.module_slug+':'+q.lesson_slug),q.stem,q.difficulty,q.explanation]);
  if(ins.rowCount){insertedMCQ++;for(let i=0;i<q.options.length;i++)await client.query(`INSERT INTO question_options(question_id,body,is_correct,sort_order) VALUES($1,$2,$3,$4)`,[ins.rows[0].id,q.options[i],i===q.correct_index,i]);}
 }
 let insertedTranslation=0;
 for(const q of translations){const r=await client.query(`INSERT INTO translation_prompts(code,grammar_focus,indonesian,model_answer,accepted_answers,explanation,difficulty)
  VALUES($1,$2,$3,$4,$5::jsonb,$6,$7) ON CONFLICT(code) DO NOTHING`,[q.code,q.grammar_focus,q.indonesian,q.model_answer,JSON.stringify(q.accepted_answers),q.explanation,q.difficulty]); insertedTranslation+=r.rowCount;}
 let insertedListening=0;
 for(const track of listening){
  await client.query(`INSERT INTO listening_tracks(slug,title,level,topic,audio_path,transcript,source_type,source_credit)
   VALUES($1,$2,$3,$4,$5,$6,$7,$8) ON CONFLICT(slug) DO NOTHING`,[track.slug,track.title,track.level,track.topic,'/audio/'+track.filename,track.transcript,track.source_type,'Original EnglishLab script and offline eSpeak voice']);
  const id=(await client.query('SELECT id FROM listening_tracks WHERE slug=$1',[track.slug])).rows[0].id;
  for(const [i,q] of track.questions.entries()){
   const code='LS26-'+track.slug.toUpperCase().replaceAll('-','')+'-'+String(i+1).padStart(2,'0');
   const r=await client.query(`INSERT INTO listening_questions(code,track_id,stem,options,correct_index,explanation)
    VALUES($1,$2,$3,$4::jsonb,$5,$6) ON CONFLICT(code) DO NOTHING`,[code,id,q.stem,JSON.stringify(q.options),q.correct_index,q.explanation]);insertedListening+=r.rowCount;
  }
 }
 await client.query('COMMIT');
 console.log(`v1.2 seeding done. Added ${insertedMCQ} MCQ, ${insertedTranslation} translations, ${insertedListening} listening questions. Existing codes unchanged.`);
} catch(err){await client.query('ROLLBACK').catch(()=>{});throw err;}finally{client.release();await pool.end();}
