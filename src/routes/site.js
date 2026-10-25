import {Router} from 'express';
import bcrypt from 'bcryptjs';
import {query} from '../db.js';
import {asyncRoute,requireAuth,safeNext} from '../middleware/core.js';
import {startAttempt,finalizeAttempt,saveAnswer,isExpired} from '../services/assessment.js';
import MarkdownIt from 'markdown-it';
import {readFileSync} from 'node:fs';
const tensesMarkdown=readFileSync(new URL('../content/tenses_quick_reference.md',import.meta.url),'utf8');
const router=Router();
const md=new MarkdownIt({html:false,linkify:true,typographer:true});
const fetchModules=()=>query(`SELECT m.*,COUNT(DISTINCT l.id) FILTER(WHERE l.is_published)::int AS lesson_count,
 COUNT(DISTINCT q.id) FILTER(WHERE q.is_active)::int AS question_count FROM modules m JOIN courses c ON c.id=m.course_id
 LEFT JOIN lessons l ON l.module_id=m.id LEFT JOIN questions q ON q.module_id=m.id
 WHERE m.is_published AND c.is_published GROUP BY m.id ORDER BY m.sort_order`);
const getModule=async slug=>(await query(`SELECT m.* FROM modules m JOIN courses c ON c.id=m.course_id WHERE m.slug=$1 AND m.is_published AND c.is_published`,[slug])).rows[0];
function showMessage(res,code,title,message){return res.status(code).render('message',{title,message});}
router.get('/',asyncRoute(async(req,res)=>{const modules=(await fetchModules()).rows;res.render('home',{title:'Belajar Bahasa Inggris',modules});}));
router.get('/courses',asyncRoute(async(req,res)=>{const modules=(await fetchModules()).rows;res.render('catalog',{title:'Kurikulum',modules});}));
router.get('/tenses-summary',(req,res)=>res.render('tenses-summary',{title:'Ringkasan Tenses',html:md.render(tensesMarkdown)}));
router.get('/courses/:slug',asyncRoute(async(req,res)=>{
 const course=(await query('SELECT * FROM courses WHERE slug=$1 AND is_published=true',[req.params.slug])).rows[0];
 if(!course)return showMessage(res,404,'Course tidak ditemukan','Course belum tersedia.');
 const modules=(await query(`SELECT m.*, (SELECT COUNT(*) FROM lessons l WHERE l.module_id=m.id AND l.is_published)::int lesson_count,
  (SELECT COUNT(*) FROM questions q WHERE q.module_id=m.id AND q.is_active)::int question_count
  FROM modules m WHERE m.course_id=$1 AND m.is_published ORDER BY sort_order`,[course.id])).rows;
 res.render('course',{title:course.title,course,modules});
}));
router.get('/learn/:moduleSlug',asyncRoute(async(req,res)=>{
 const module=await getModule(req.params.moduleSlug);if(!module)return showMessage(res,404,'Modul belum tersedia','Materi ini masih disiapkan.');
 const lessons=(await query(`SELECT l.*, (SELECT COUNT(*)::int FROM questions q WHERE q.lesson_id=l.id AND q.is_active) question_count FROM lessons l WHERE l.module_id=$1 AND l.is_published ORDER BY l.sort_order`,[module.id])).rows;
 res.render('module',{title:module.title,module,lessons});
}));
router.get('/learn/:moduleSlug/:lessonSlug',asyncRoute(async(req,res)=>{
 const module=await getModule(req.params.moduleSlug);if(!module)return showMessage(res,404,'Materi tidak ditemukan','Materi belum diterbitkan.');
 const lessons=(await query('SELECT * FROM lessons WHERE module_id=$1 AND is_published ORDER BY sort_order',[module.id])).rows;
 const i=lessons.findIndex(l=>l.slug===req.params.lessonSlug);if(i<0)return showMessage(res,404,'Materi tidak ditemukan','Submateri belum tersedia.');
 const lesson=lessons[i];
 if(req.session.user)await query(`INSERT INTO lesson_progress(user_id,lesson_id) VALUES($1,$2)
  ON CONFLICT(user_id,lesson_id) DO UPDATE SET last_viewed_at=NOW()`,[req.session.user.id,lesson.id]);
 res.render('lesson',{title:lesson.title,module,lesson,lessons,index:i,html:md.render(lesson.body_md)});
}));
router.get('/register',(req,res)=>res.render('auth',{title:'Daftar akun',mode:'register',error:null,next:safeNext(req.query.next)}));
router.post('/register',asyncRoute(async(req,res)=>{
 let {username,full_name,password}=req.body;username=String(username||'').trim().toLowerCase();full_name=String(full_name||'').trim();password=String(password||'');
 const next=safeNext(req.body.next);
 if(!/^[a-z0-9_]{3,40}$/.test(username)||full_name.length<2||full_name.length>120||password.length<10||password.length>128){return res.status(400).render('auth',{title:'Daftar akun',mode:'register',next,error:'Username 3–40 (huruf kecil, angka, _), nama 2–120, dan password 10–128 karakter.'});}
 const hash=await bcrypt.hash(password,12);
 try{const u=(await query(`INSERT INTO users(username,full_name,password_hash) VALUES($1,$2,$3) RETURNING id,username,full_name,role`,[username,full_name,hash])).rows[0];
 await new Promise((resolve,reject)=>req.session.regenerate(err=>err?reject(err):resolve()));req.session.user=u;req.session.save(err=>err?res.status(500).send('Session error'):res.redirect(next));
 }catch(e){if(e.code==='23505')return res.status(400).render('auth',{title:'Daftar akun',mode:'register',next,error:'Username sudah digunakan.'});throw e;}
}));
router.get('/login',(req,res)=>res.render('auth',{title:'Masuk',mode:'login',error:null,next:safeNext(req.query.next)}));
router.post('/login',asyncRoute(async(req,res)=>{
 const username=String(req.body.username||'').trim().toLowerCase(),password=String(req.body.password||'');const next=safeNext(req.body.next);
 const found=(await query('SELECT id,username,full_name,password_hash,role,is_active FROM users WHERE username=$1',[username])).rows[0];
 if(!found||!found.is_active||!await bcrypt.compare(password,found.password_hash))return res.status(401).render('auth',{title:'Masuk',mode:'login',next,error:'Username atau password tidak sesuai.'});
 await new Promise((resolve,reject)=>req.session.regenerate(err=>err?reject(err):resolve()));req.session.user={id:found.id,username:found.username,full_name:found.full_name,role:found.role};
 req.session.save(err=>err?res.status(500).send('Session error'):res.redirect(next));
}));
router.post('/logout',requireAuth,(req,res)=>req.session.destroy(()=>{res.clearCookie('english.sid');res.redirect('/');}));
router.get('/dashboard',requireAuth,asyncRoute(async(req,res)=>{
 const userId=req.session.user.id;
 const stats=(await query(`SELECT (SELECT COUNT(*)::int FROM lesson_progress WHERE user_id=$1) AS lessons,
  (SELECT COUNT(*)::int FROM attempts WHERE user_id=$1 AND status<>'in_progress') AS completed,
  (SELECT ROUND(COALESCE(AVG(score),0),1) FROM attempts WHERE user_id=$1 AND mode='exam' AND status<>'in_progress') AS avg_score`,[userId])).rows[0];
 const attempts=(await query(`SELECT a.*,COALESCE(m.title,'Final Exam - Semua Materi') module_title,COALESCE(m.slug,'final') module_slug FROM attempts a LEFT JOIN modules m ON m.id=a.module_id
  WHERE a.user_id=$1 ORDER BY a.started_at DESC LIMIT 8`,[userId])).rows;
 res.render('dashboard',{title:'Dashboard saya',stats,attempts});
}));
router.get('/history',requireAuth,asyncRoute(async(req,res)=>{
 const attempts=(await query(`SELECT a.*,COALESCE(m.title,'Final Exam - Semua Materi') module_title,COALESCE(m.slug,'final') module_slug FROM attempts a LEFT JOIN modules m ON m.id=a.module_id
 WHERE a.user_id=$1 ORDER BY a.started_at DESC LIMIT 100`,[req.session.user.id])).rows;
 res.render('history',{title:'Riwayat saya',attempts});
}));
router.get('/practice/:moduleSlug',requireAuth,asyncRoute(async(req,res)=>{
 const module=await getModule(req.params.moduleSlug);if(!module)return showMessage(res,404,'Modul tidak tersedia','Modul belum diterbitkan.');
 const lessons=(await query(`SELECT l.id,l.title,l.slug,COUNT(q.id) FILTER(WHERE q.is_active)::int AS count
 FROM lessons l LEFT JOIN questions q ON q.lesson_id=l.id WHERE l.module_id=$1 AND l.is_published GROUP BY l.id ORDER BY l.sort_order`,[module.id])).rows;
 const total=(await query(`SELECT COUNT(*)::int AS count FROM questions WHERE module_id=$1 AND is_active`,[module.id])).rows[0].count;
 res.render('practice_setup',{title:'Latihan '+module.title,module,lessons,total,error:null,selectedLesson:typeof req.query.lesson==='string'?req.query.lesson:''});
}));
router.post('/practice/:moduleSlug',requireAuth,asyncRoute(async(req,res)=>{
 const module=await getModule(req.params.moduleSlug);if(!module)return showMessage(res,404,'Modul tidak tersedia','Modul belum diterbitkan.');
 let lessonId=null;
 if(req.body.lesson_id&&req.body.lesson_id!=='all'){
   const found=(await query(`SELECT id FROM lessons WHERE id=$1 AND module_id=$2 AND is_published`,[req.body.lesson_id,module.id])).rows[0];
   if(!found)return showMessage(res,400,'Submateri tidak valid','Pilih topik yang tersedia.');lessonId=found.id;
 }
 const id=await startAttempt({userId:req.session.user.id,moduleId:module.id,lessonId,mode:'practice',requestedCount:10});
 if(!id)return showMessage(res,400,'Soal belum tersedia','Belum ada soal aktif pada topik yang dipilih.');
 res.redirect('/attempts/'+id+'/take');
}));
router.get('/exam/final',requireAuth,asyncRoute(async(req,res)=>{
 res.render('final_exam',{title:'Final Exam'});
}));
router.post('/exam/final',requireAuth,asyncRoute(async(req,res)=>{
 const id=await startAttempt({userId:req.session.user.id,mode:'exam',requestedCount:60,durationMinutes:60,passingScore:75,finalExam:true});
 if(!id)return showMessage(res,400,'Final exam belum tersedia','Diperlukan minimal 60 soal valid dan soal untuk setiap submateri publik. Maksimal 60 submateri dapat dicakup.');
 res.redirect('/attempts/'+id+'/take');
}));
router.get('/exam/:moduleSlug',requireAuth,asyncRoute(async(req,res)=>{
 const module=await getModule(req.params.moduleSlug);if(!module)return showMessage(res,404,'Modul tidak ditemukan','Modul belum tersedia.');
 const config=(await query('SELECT * FROM exam_configs WHERE module_id=$1',[module.id])).rows[0]||{question_count:20,duration_minutes:30,passing_score:75};
 const count=(await query('SELECT COUNT(*)::int AS count FROM questions WHERE module_id=$1 AND is_active',[module.id])).rows[0].count;
 res.render('exam_setup',{title:'Exam '+module.title,module,config,count});
}));
router.post('/exam/:moduleSlug',requireAuth,asyncRoute(async(req,res)=>{
 const module=await getModule(req.params.moduleSlug);if(!module)return showMessage(res,404,'Modul tidak ditemukan','Modul belum tersedia.');
 const cfg=(await query('SELECT * FROM exam_configs WHERE module_id=$1',[module.id])).rows[0]||{question_count:20,duration_minutes:30,passing_score:75};
 const id=await startAttempt({userId:req.session.user.id,moduleId:module.id,mode:'exam',requestedCount:cfg.question_count,durationMinutes:cfg.duration_minutes,passingScore:cfg.passing_score});
 if(!id)return showMessage(res,400,'Bank soal kosong','Exam belum tersedia untuk modul ini.');
 res.redirect('/attempts/'+id+'/take');
}));
const getOwned=async(id,userId)=>(await query(`SELECT a.*,COALESCE(m.title,'Final Exam - Semua Materi') module_title,COALESCE(m.slug,'final') module_slug FROM attempts a LEFT JOIN modules m ON a.module_id=m.id
 WHERE a.id=$1 AND a.user_id=$2`,[id,userId])).rows[0];
router.get('/attempts/:id/take',requireAuth,asyncRoute(async(req,res)=>{
 const attempt=await getOwned(req.params.id,req.session.user.id);if(!attempt)return showMessage(res,404,'Sesi tidak ditemukan','Periksa kembali tautan sesi.');
 if(attempt.status!=='in_progress')return res.redirect(`/attempts/${attempt.id}/result`);
 if(isExpired(attempt)){await finalizeAttempt(attempt.id,req.session.user.id);return res.redirect(`/attempts/${attempt.id}/result`);}
 const items=(await query(`SELECT id,ordinal,stem_snapshot,options_snapshot,chosen_option_id FROM attempt_items WHERE attempt_id=$1 ORDER BY ordinal`,[attempt.id])).rows;
 res.render('attempt_take',{title:attempt.mode==='exam'?'Exam':'Latihan',attempt,items});
}));
router.post('/attempts/:id/answer',requireAuth,asyncRoute(async(req,res)=>{
 const itemId=String(req.body.itemId||''),optionId=String(req.body.optionId||'');
 if(!/^\d+$/.test(itemId)||!/^\d+$/.test(optionId))return res.status(400).json({error:'Input tidak valid'});
 const result=await saveAnswer({attemptId:req.params.id,itemId,optionId,userId:req.session.user.id});
 res.status(result.status||200).json(result);
}));
router.post('/attempts/:id/submit',requireAuth,asyncRoute(async(req,res)=>{
 const result=await finalizeAttempt(req.params.id,req.session.user.id);
 if(!result)return showMessage(res,404,'Sesi tidak ditemukan','Sesi bukan milik akun ini.');
 res.redirect('/attempts/'+result.id+'/result');
}));
router.get('/attempts/:id/result',requireAuth,asyncRoute(async(req,res)=>{
 const attempt=await getOwned(req.params.id,req.session.user.id);if(!attempt)return showMessage(res,404,'Hasil tidak ditemukan','Sesi bukan milik akun ini.');
 if(attempt.status==='in_progress'){
  if(isExpired(attempt))await finalizeAttempt(attempt.id,req.session.user.id);
  else return res.redirect('/attempts/'+attempt.id+'/take');
 }
 const updated=await getOwned(req.params.id,req.session.user.id);
 const items=(await query(`SELECT ordinal,stem_snapshot,options_snapshot,chosen_option_id,correct_option_id,explanation_snapshot,is_correct
 FROM attempt_items WHERE attempt_id=$1 ORDER BY ordinal`,[attempt.id])).rows;
 res.render('result',{title:'Hasil '+updated.mode,attempt:updated,items});
}));
export default router;
