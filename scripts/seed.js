import 'dotenv/config';
import {Pool} from 'pg';
import bcrypt from 'bcryptjs';
import {readFile} from 'node:fs/promises';
import {modules,lessons} from '../src/data/curriculum.js';
if (!process.env.DATABASE_URL) throw Error('Set DATABASE_URL in .env');
const pool=new Pool({connectionString:process.env.DATABASE_URL});
const client=await pool.connect();
try {
 await client.query('BEGIN');
 const c=await client.query(`INSERT INTO courses(slug,title,description,is_published) VALUES('english-foundations','English Foundations','Materi Bahasa Inggris dari dasar hingga grammar dan komunikasi',true) ON CONFLICT(slug) DO UPDATE SET title=EXCLUDED.title RETURNING id`);
 const courseId=c.rows[0].id;
 for(let i=0;i<modules.length;i++){
  const [slug,title,description]=modules[i];
  await client.query(`INSERT INTO modules(course_id,slug,title,description,sort_order,is_published) VALUES($1,$2,$3,$4,$5,$6) ON CONFLICT(slug) DO NOTHING`,[courseId,slug,title,description,i+1,slug==='pronouns']);
 }
 const m=(await client.query(`SELECT id FROM modules WHERE slug='pronouns'`)).rows[0];
 for(let i=0;i<lessons.length;i++){
  const l=lessons[i];
  await client.query(`INSERT INTO lessons(module_id,slug,title,summary,body_md,sort_order,is_published) VALUES($1,$2,$3,$4,$5,$6,true) ON CONFLICT(module_id,slug) DO NOTHING`,[m.id,l.slug,l.title,l.summary,l.body,i+1]);
 }
 await client.query(`INSERT INTO exam_configs(module_id,question_count,duration_minutes,passing_score) VALUES($1,25,30,75) ON CONFLICT(module_id) DO NOTHING`,[m.id]);
 if (process.env.ADMIN_USERNAME && process.env.ADMIN_PASSWORD) {
  const username=process.env.ADMIN_USERNAME.toLowerCase();
  if(process.env.ADMIN_PASSWORD.length<12 || username.length<3) throw Error('ADMIN_PASSWORD minimal 12 karakter dan ADMIN_USERNAME minimal 3');
  const hash=await bcrypt.hash(process.env.ADMIN_PASSWORD,12);
  await client.query(`INSERT INTO users(username,full_name,password_hash,role) VALUES($1,$2,$3,'admin') ON CONFLICT(username) DO NOTHING`,[username,process.env.ADMIN_NAME||'Administrator',hash]);
 }
 await client.query('COMMIT');
 const sql=await readFile(new URL('../db/002_pronouns.sql',import.meta.url),'utf8');
 await client.query(sql);
 const count=(await client.query("SELECT COUNT(*)::int AS total FROM questions q JOIN modules m ON q.module_id=m.id WHERE m.slug='pronouns'")).rows[0].total;
 console.log(`Seed OK — ${modules.length} modules, ${lessons.length} Pronouns lessons, ${count} questions. Idempotent.`);
} catch(err){await client.query('ROLLBACK').catch(()=>{});throw err;} finally{client.release();await pool.end();}
