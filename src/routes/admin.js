import {Router} from 'express';
import bcrypt from 'bcryptjs';
import {randomBytes} from 'node:crypto';
import {pool,query} from '../db.js';
import {requireAdmin,asyncRoute} from '../middleware/core.js';
const router=Router();router.use(requireAdmin);
router.use((req,res,next)=>{res.set('Cache-Control','no-store');next();});
const studentId=v=>typeof v==='string'&&/^[1-9]\d{0,17}$/.test(v);

function errorView(res,title,message,status=400){return res.status(status).render('message',{title,message});}
function int(v){const n=Number(v);return Number.isSafeInteger(n)&&n>0?n:null;}
const fetchAllModules=async()=>(await query('SELECT id,slug,title,is_published FROM modules ORDER BY sort_order')).rows;
const lessonOptions=async()=>(await query('SELECT id,module_id,title FROM lessons ORDER BY module_id,sort_order')).rows;
const studentExamResults=async(limit,offset=0,search='')=>(await query(`SELECT a.*,u.username,u.full_name,
 COALESCE(m.title,'Final Exam - Semua Materi') module_title
 FROM attempts a JOIN users u ON u.id=a.user_id LEFT JOIN modules m ON m.id=a.module_id
 WHERE u.role='student' AND a.mode='exam' AND a.status<>'in_progress'
 AND ($3='' OR u.username ILIKE '%' || $3 || '%' OR u.full_name ILIKE '%' || $3 || '%')
 ORDER BY a.submitted_at DESC NULLS LAST,a.id DESC LIMIT $1 OFFSET $2`,[limit,offset,search])).rows;
router.get('/',asyncRoute(async(req,res)=>{
 const stats=(await query(`SELECT
  (SELECT COUNT(*)::int FROM users) AS users,
  (SELECT COUNT(*)::int FROM questions WHERE is_active) AS questions,
  (SELECT COUNT(*)::int FROM attempts WHERE status<>'in_progress') AS attempts,
  (SELECT COUNT(*)::int FROM modules WHERE is_published) AS published_modules`)).rows[0];
 const recentResults=await studentExamResults(10);
 res.render('admin/index',{title:'Admin Dashboard',stats,recentResults});
}));

router.get('/accounts',asyncRoute(async(req,res)=>{
 const search=String(req.query.search||'').trim().slice(0,80);
 const students=(await query(`SELECT u.id,u.username,u.full_name,u.is_active,u.created_at,u.updated_at,
 (SELECT COUNT(*)::int FROM attempts a WHERE a.user_id=u.id) attempt_count,
 (SELECT MAX(a.submitted_at) FROM attempts a WHERE a.user_id=u.id AND a.status<>'in_progress') last_activity
 FROM users u WHERE u.role='student' AND ($1='' OR u.username ILIKE '%' || $1 || '%' OR u.full_name ILIKE '%' || $1 || '%')
 ORDER BY u.created_at DESC`,[search])).rows;
 res.render('admin/accounts',{title:'Akun Siswa',students,search,resetPassword:null});
}));
router.post('/accounts/:id/reset-password',asyncRoute(async(req,res)=>{
 if(!studentId(req.params.id))return errorView(res,'Akun tidak ditemukan','Siswa tidak ditemukan.',404);
 const password=String(req.body.password||'');
 if(password.length<10||password.length>128)return errorView(res,'Password tidak valid','Password baru harus berisi 10–128 karakter.');
 const user=(await query("SELECT id,username FROM users WHERE id=$1 AND role='student'",[req.params.id])).rows[0];
 if(!user)return errorView(res,'Akun tidak ditemukan','Siswa tidak ditemukan.',404);
 await query('UPDATE users SET password_hash=$1,updated_at=NOW() WHERE id=$2',[await bcrypt.hash(password,12),user.id]);
 const students=(await query(`SELECT u.id,u.username,u.full_name,u.is_active,u.created_at,u.updated_at,
 (SELECT COUNT(*)::int FROM attempts a WHERE a.user_id=u.id) attempt_count,
 (SELECT MAX(a.submitted_at) FROM attempts a WHERE a.user_id=u.id AND a.status<>'in_progress') last_activity
 FROM users u WHERE u.role='student' ORDER BY u.created_at DESC`)).rows;
 res.render('admin/accounts',{title:'Akun Siswa',students,search:'',resetPassword:{username:user.username,password}});
}));
router.get('/results',asyncRoute(async(req,res)=>{
 const search=String(req.query.search||'').trim().slice(0,80),page=Math.min(100000,int(req.query.page)||1),limit=50;
 const results=await studentExamResults(limit,(page-1)*limit,search);
 res.render('admin/results',{title:'Hasil Ujian Siswa',results,search,page});
}));
router.get('/results/:id',asyncRoute(async(req,res)=>{
 if(!/^\d+$/.test(req.params.id))return errorView(res,'Hasil tidak ditemukan','Hasil ujian tidak ditemukan.',404);
 const result=(await query(`SELECT a.*,u.username,u.full_name,COALESCE(m.title,'Final Exam - Semua Materi') module_title
 FROM attempts a JOIN users u ON u.id=a.user_id LEFT JOIN modules m ON m.id=a.module_id
 WHERE a.id=$1 AND u.role='student' AND a.mode='exam' AND a.status<>'in_progress'`,[req.params.id])).rows[0];
 if(!result)return errorView(res,'Hasil tidak ditemukan','Hasil ujian tidak ditemukan.',404);
 const items=(await query(`SELECT ordinal,stem_snapshot,options_snapshot,chosen_option_id,correct_option_id,is_correct
 FROM attempt_items WHERE attempt_id=$1 ORDER BY ordinal`,[result.id])).rows;
 res.render('admin/result_detail',{title:'Detail Hasil Ujian',result,items});
}));
router.get('/modules',asyncRoute(async(req,res)=>{
 const mods=(await query(`SELECT m.*,c.title course_title,(SELECT COUNT(*)::int FROM lessons l WHERE l.module_id=m.id AND l.is_published) published_lessons
 FROM modules m JOIN courses c ON c.id=m.course_id ORDER BY m.sort_order`)).rows;
 res.render('admin/modules',{title:'Kelola Modul',mods,error:null});
}));
router.post('/modules/new',asyncRoute(async(req,res)=>{
 const slug=String(req.body.slug||'').trim().toLowerCase(),title=String(req.body.title||'').trim(),description=String(req.body.description||'').trim();
 if(!/^[a-z0-9-]{3,80}$/.test(slug)||title.length<3||title.length>160||description.length>1000)return errorView(res,'Modul tidak valid','Slug 3–80 huruf kecil, angka atau -, judul 3–160 karakter.');
 const course=(await query("SELECT id FROM courses WHERE slug='english-foundations'")).rows[0];
 try{await query(`INSERT INTO modules(course_id,slug,title,description,sort_order,is_published)
  VALUES($1,$2,$3,$4,(SELECT COALESCE(MAX(sort_order),0)+1 FROM modules),false)`,[course.id,slug,title,description]);}
 catch(e){if(e.code==='23505')return errorView(res,'Slug sudah digunakan','Gunakan slug yang berbeda.');throw e;}
 res.redirect('/admin/modules');
}));
router.post('/modules/:id/toggle',asyncRoute(async(req,res)=>{
 const mod=(await query(`SELECT m.id,m.is_published,(SELECT COUNT(*)::int FROM lessons l WHERE l.module_id=m.id AND l.is_published) published_lessons FROM modules m WHERE m.id=$1`,[req.params.id])).rows[0];
 if(!mod)return errorView(res,'Tidak ditemukan','Modul tidak ada.',404);
 if(!mod.is_published&&mod.published_lessons===0)return errorView(res,'Modul belum siap','Publikasikan minimal satu materi terlebih dahulu.');
 await query('UPDATE modules SET is_published=NOT is_published WHERE id=$1',[mod.id]);res.redirect('/admin/modules');
}));
router.get('/lessons/new',asyncRoute(async(req,res)=>{
 const modules=await fetchAllModules();res.render('admin/lesson_new',{title:'Tambah Materi',modules,error:null});
}));
router.post('/lessons/new',asyncRoute(async(req,res)=>{
 const moduleId=int(req.body.module_id),slug=String(req.body.slug||'').trim().toLowerCase(),title=String(req.body.title||'').trim(),summary=String(req.body.summary||'').trim(),body_md=String(req.body.body_md||'');
 if(!moduleId||!/^[a-z0-9-]{3,100}$/.test(slug)||title.length<3||title.length>160||body_md.length>100000)return errorView(res,'Materi tidak valid','Pilih modul; slug 3–100 karakter; judul 3–160 karakter.');
 try{await query(`INSERT INTO lessons(module_id,slug,title,summary,body_md,sort_order,is_published) VALUES($1,$2,$3,$4,$5,(SELECT COALESCE(MAX(sort_order),0)+1 FROM lessons WHERE module_id=$1),$6)`,[moduleId,slug,title,summary,body_md,req.body.is_published==='on']);}
 catch(e){if(e.code==='23505')return errorView(res,'Slug sudah digunakan','Slug materi harus unik di dalam modul yang sama.');throw e;}
 res.redirect('/admin/lessons');
}));
router.get('/lessons',asyncRoute(async(req,res)=>{
 const lessons=(await query(`SELECT l.id,l.title,l.slug,l.is_published,m.title AS module_title,m.slug AS module_slug
 FROM lessons l JOIN modules m ON m.id=l.module_id ORDER BY m.sort_order,l.sort_order`)).rows;
 res.render('admin/lessons',{title:'Kelola Materi',lessons});
}));
router.get('/lessons/:id/edit',asyncRoute(async(req,res)=>{
 const lesson=(await query(`SELECT l.*,m.title module_title FROM lessons l JOIN modules m ON m.id=l.module_id WHERE l.id=$1`,[req.params.id])).rows[0];
 if(!lesson)return errorView(res,'Tidak ditemukan','Materi tidak ada.',404);
 res.render('admin/lesson_edit',{title:'Edit Materi',lesson,error:null});
}));
router.post('/lessons/:id/edit',asyncRoute(async(req,res)=>{
 const lesson=(await query(`SELECT l.*,m.title module_title FROM lessons l JOIN modules m ON m.id=l.module_id WHERE l.id=$1`,[req.params.id])).rows[0];
 if(!lesson)return errorView(res,'Tidak ditemukan','Materi tidak ada.',404);
 const title=String(req.body.title||'').trim(),summary=String(req.body.summary||'').trim(),body_md=String(req.body.body_md||'');
 if(title.length<3||title.length>160||body_md.length>100000)return res.status(400).render('admin/lesson_edit',{title:'Edit Materi',lesson:{...lesson,title,summary,body_md},error:'Judul 3–160 karakter, Markdown maksimal 100 ribu karakter.'});
 await query('UPDATE lessons SET title=$1,summary=$2,body_md=$3,is_published=$4,updated_at=NOW() WHERE id=$5',[title,summary,body_md,req.body.is_published==='on',lesson.id]);
 res.redirect('/admin/lessons');
}));
router.get('/questions',asyncRoute(async(req,res)=>{
 const modules=await fetchAllModules();const moduleId=int(req.query.module_id);
 const questions=(await query(`SELECT q.id,q.code,q.stem,q.difficulty,q.is_active,m.title module_title,l.title lesson_title
 FROM questions q JOIN modules m ON m.id=q.module_id LEFT JOIN lessons l ON l.id=q.lesson_id
 WHERE ($1::bigint IS NULL OR q.module_id=$1) ORDER BY q.id DESC LIMIT 300`,[moduleId])).rows;
 res.render('admin/questions',{title:'Bank Soal',questions,modules,selected:moduleId});
}));
const emptyQuestion={module_id:null,lesson_id:null,stem:'',difficulty:'easy',explanation:'',is_active:true,options:['','','',''],correct_index:0};
router.get('/questions/new',asyncRoute(async(req,res)=>res.render('admin/question_form',{title:'Tambah Soal',question:{...emptyQuestion,module_id:int(req.query.module_id)},modules:await fetchAllModules(),lessons:await lessonOptions(),error:null,editing:false})));
router.get('/questions/:id/edit',asyncRoute(async(req,res)=>{
 const question=(await query('SELECT * FROM questions WHERE id=$1',[req.params.id])).rows[0];
 if(!question)return errorView(res,'Tidak ditemukan','Soal tidak ada.',404);
 const opts=(await query('SELECT id,body,is_correct FROM question_options WHERE question_id=$1 ORDER BY sort_order',[question.id])).rows;
 res.render('admin/question_form',{title:'Edit Soal',question:{...question,options:opts.map(o=>o.body),correct_index:opts.findIndex(o=>o.is_correct)},modules:await fetchAllModules(),lessons:await lessonOptions(),error:null,editing:true});
}));
async function saveQuestion(req,res,editing){
 const module_id=int(req.body.module_id), lesson_id=req.body.lesson_id?int(req.body.lesson_id):null;
 const stem=String(req.body.stem||'').trim(),explanation=String(req.body.explanation||'').trim();
 const difficulty=String(req.body.difficulty||'easy'),correct_index=Number(req.body.correct_index);
 const options=Array.from({length:4},(_,i)=>String(req.body[`option_${i}`]||'').trim());
 const question={id:req.params.id,module_id,lesson_id,stem,explanation,difficulty,options,correct_index,is_active:req.body.is_active==='on'};
 const invalid=!module_id||stem.length<10||stem.length>1500||explanation.length<8||explanation.length>5000||!['easy','medium','hard'].includes(difficulty)||!Number.isInteger(correct_index)||correct_index<0||correct_index>3||options.some(o=>!o||o.length>500)||new Set(options.map(o=>o.toLowerCase())).size!==4;
 const validModule=(await query('SELECT id FROM modules WHERE id=$1',[module_id])).rows[0];
 const validLesson=lesson_id?(await query('SELECT id FROM lessons WHERE id=$1 AND module_id=$2',[lesson_id,module_id])).rows[0]:true;
 if(invalid||!validModule||!validLesson)return res.status(400).render('admin/question_form',{title:editing?'Edit Soal':'Tambah Soal',question,modules:await fetchAllModules(),lessons:await lessonOptions(),error:'Pastikan modul benar, soal minimal 10 karakter, pembahasan minimal 8 karakter, 4 opsi unik, dan 1 pilihan benar.',editing});
 const client=await pool.connect();try{
  await client.query('BEGIN');let id;
  if(editing){const r=await client.query('UPDATE questions SET module_id=$1,lesson_id=$2,stem=$3,explanation=$4,difficulty=$5,is_active=$6,updated_at=NOW() WHERE id=$7 RETURNING id',[module_id,lesson_id,stem,explanation,difficulty,question.is_active,req.params.id]);if(!r.rowCount)throw Error('Soal tidak ditemukan');id=r.rows[0].id;await client.query('DELETE FROM question_options WHERE question_id=$1',[id]);}
  else {const code='ADM-'+randomBytes(8).toString('hex').toUpperCase();id=(await client.query('INSERT INTO questions(code,module_id,lesson_id,stem,explanation,difficulty,is_active) VALUES($1,$2,$3,$4,$5,$6,$7) RETURNING id',[code,module_id,lesson_id,stem,explanation,difficulty,question.is_active])).rows[0].id;}
  for(let i=0;i<4;i++)await client.query('INSERT INTO question_options(question_id,body,is_correct,sort_order) VALUES($1,$2,$3,$4)',[id,options[i],i===correct_index,i]);
  await client.query('COMMIT');res.redirect('/admin/questions?module_id='+module_id);
 }catch(err){await client.query('ROLLBACK').catch(()=>{});throw err;}finally{client.release();}
}
router.post('/questions/new',asyncRoute(async(req,res)=>saveQuestion(req,res,false)));
router.post('/questions/:id/edit',asyncRoute(async(req,res)=>saveQuestion(req,res,true)));
router.post('/questions/:id/toggle',asyncRoute(async(req,res)=>{
 await query('UPDATE questions SET is_active=NOT is_active,updated_at=NOW() WHERE id=$1',[req.params.id]);res.redirect('/admin/questions');
}));
router.get('/exams',asyncRoute(async(req,res)=>{
 const rows=(await query(`SELECT m.id,m.title,m.slug,COALESCE(e.question_count,20) question_count,
 COALESCE(e.duration_minutes,30) duration_minutes,COALESCE(e.passing_score,75) passing_score,m.is_published
 FROM modules m LEFT JOIN exam_configs e ON e.module_id=m.id ORDER BY m.sort_order`)).rows;
 res.render('admin/exams',{title:'Pengaturan Exam',rows});
}));
router.post('/exams/:id',asyncRoute(async(req,res)=>{
 const moduleId=int(req.params.id),count=int(req.body.question_count),minutes=int(req.body.duration_minutes),score=Number(req.body.passing_score);
 if(!moduleId||!count||count>200||!minutes||minutes>240||!Number.isInteger(score)||score<0||score>100)return errorView(res,'Pengaturan tidak valid','Soal 1–200, durasi 1–240 menit, KKM 0–100.');
 await query(`INSERT INTO exam_configs(module_id,question_count,duration_minutes,passing_score) VALUES($1,$2,$3,$4)
  ON CONFLICT(module_id) DO UPDATE SET question_count=$2,duration_minutes=$3,passing_score=$4,updated_at=NOW()`,[moduleId,count,minutes,score]);
 res.redirect('/admin/exams');
}));
export default router;
