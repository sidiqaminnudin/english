import 'dotenv/config';
import {Pool} from 'pg';
import {readFile} from 'node:fs/promises';
import bank from '../db/supplemental-bank.js';
if(!process.env.DATABASE_URL)throw Error('Set DATABASE_URL in .env');
const pool=new Pool({connectionString:process.env.DATABASE_URL});
const client=await pool.connect();
try{
 await client.query(await readFile(new URL('../db/004_final_exam.sql',import.meta.url),'utf8'));
 await client.query('BEGIN');
 let added=0;
 for(const q of bank){
  const lesson=(await client.query('SELECT l.id,l.module_id FROM lessons l JOIN modules m ON m.id=l.module_id WHERE m.slug=$1 AND l.slug=$2',[q.module_slug,q.lesson_slug])).rows[0];
  if(!lesson)throw Error(`Jalankan db:seed:all terlebih dahulu: ${q.module_slug}/${q.lesson_slug}`);
  const inserted=(await client.query(`INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation) VALUES($1,$2,$3,$4,$5,$6) ON CONFLICT(code) DO NOTHING RETURNING id`,[q.code,lesson.module_id,lesson.id,q.stem,q.difficulty,q.explanation])).rows[0];
  if(!inserted)continue;
  for(let i=0;i<4;i++)await client.query('INSERT INTO question_options(question_id,body,is_correct,sort_order) VALUES($1,$2,$3,$4)',[inserted.id,q.options[i],i===q.correct_index,i+1]);
  added++;
 }
 await client.query('COMMIT');
 console.log(`Final exam migration OK; ${added} soal baru. Data lama tidak ditimpa.`);
}catch(err){await client.query('ROLLBACK').catch(()=>{});throw err;}finally{client.release();await pool.end();}
