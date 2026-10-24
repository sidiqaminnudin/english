import {Router} from 'express';
import {pool,query} from '../db.js';
import {asyncRoute,requireAuth,requireAdmin} from '../middleware/core.js';
const router=Router();
const focusLabels={
 'simple-present':'Simple Present','simple-past':'Simple Past','present-perfect':'Present Perfect',
 'present-continuous':'Present Continuous','past-continuous':'Past Continuous',
 'simple-future':'Simple Future','future-continuous':'Future Continuous',
 'modal-verbs':'Modal Verbs','passive-voice':'Passive Voice'
};
const focusNames=Object.keys(focusLabels);
const int=v=>typeof v==='string'&&/^[1-9]\d{0,17}$/.test(v)?v:null;
router.param('id',(req,res,next,value)=>int(value)?next():message(res,400,'ID tidak valid','Gunakan ID sesi yang valid.'));
router.param('ordinal',(req,res,next,value)=>int(value)?next():message(res,400,'Nomor tidak valid','Gunakan nomor soal yang valid.'));
router.use(['/translation','/listening'],requireAuth,(req,res,next)=>{res.set('Cache-Control','no-store');next();});
const norm=s=>String(s||'').normalize('NFKC').toLowerCase().replace(/[’‘]/g,"'").replace(/\b(won't)\b/g,'will not').replace(/\b(can't)\b/g,'cannot').replace(/\b(don't)\b/g,'do not').replace(/\b(doesn't)\b/g,'does not').replace(/\b(didn't)\b/g,'did not').replace(/\b(isn't)\b/g,'is not').replace(/\b(aren't)\b/g,'are not').replace(/\b(wasn't)\b/g,'was not').replace(/\b(weren't)\b/g,'were not').replace(/\b(haven't)\b/g,'have not').replace(/\b(hasn't)\b/g,'has not').replace(/\b(mustn't)\b/g,'must not').replace(/[^\p{L}\p{N}\s']/gu,' ').replace(/\s+/g,' ').trim();
function message(res,code,title,detail){return res.status(code).render('message',{title,message:detail});}
function shuffled(a){const x=[...a];for(let i=x.length-1;i>0;i--){const j=Math.floor(Math.random()*(i+1));[x[i],x[j]]=[x[j],x[i]];}return x;}
router.get('/translation',asyncRoute(async(req,res)=>{
 const counts=(await query(`SELECT grammar_focus,COUNT(*)::int total FROM translation_prompts WHERE is_active GROUP BY grammar_focus`)).rows;
 res.render('translation/index',{title:'Latihan Terjemahan',counts,focusLabels});
}));
router.post('/translation/start',requireAuth,asyncRoute(async(req,res)=>{
 const focus=String(req.body.focus||'all');if(focus!=='all'&&!focusNames.includes(focus))return message(res,400,'Kategori tidak dikenal','Pilih fokus dari daftar.');
 const amount=Number(req.body.count||10);if(!Number.isInteger(amount)||amount<5||amount>20)return message(res,400,'Jumlah tidak valid','Pilih 5–20 soal.');
 const client=await pool.connect();let id;
 try{await client.query('BEGIN');
  const prompts=(await client.query(`SELECT id,indonesian,grammar_focus,model_answer,accepted_answers,explanation
   FROM translation_prompts WHERE is_active AND ($1='all' OR grammar_focus=$1) ORDER BY random() LIMIT $2`,[focus,amount])).rows;
  if(!prompts.length){await client.query('ROLLBACK');return message(res,400,'Bank soal kosong','Prompt untuk kategori ini belum tersedia.');}
  id=(await client.query('INSERT INTO translation_runs(user_id,focus_filter) VALUES($1,$2) RETURNING id',[req.session.user.id,focus])).rows[0].id;
  for(const [i,p] of prompts.entries())await client.query(`INSERT INTO translation_run_items
   (run_id,ordinal,prompt_id,prompt_snapshot,focus_snapshot,model_snapshot,accepted_snapshot,explanation_snapshot)
   VALUES($1,$2,$3,$4,$5,$6,$7::jsonb,$8)`,[id,i+1,p.id,p.indonesian,p.grammar_focus,p.model_answer,JSON.stringify(p.accepted_answers),p.explanation]);
  await client.query('COMMIT');
 }catch(e){await client.query('ROLLBACK').catch(()=>{});throw e;}finally{client.release();}
 res.redirect('/translation/run/'+id);
}));
async function ownedTranslation(id,userId){return (await query('SELECT * FROM translation_runs WHERE id=$1 AND user_id=$2',[id,userId])).rows[0];}
router.get('/translation/run/:id',requireAuth,asyncRoute(async(req,res)=>{
 const run=await ownedTranslation(req.params.id,req.session.user.id);if(!run)return message(res,404,'Tidak ditemukan','Sesi ini bukan milik akun Anda.');
 if(run.status==='submitted')return res.redirect('/translation/run/'+run.id+'/result');
 const item=(await query('SELECT id,ordinal,prompt_snapshot FROM translation_run_items WHERE run_id=$1 AND answer_text IS NULL ORDER BY ordinal LIMIT 1',[run.id])).rows[0];
 if(!item){await query("UPDATE translation_runs SET status='submitted',submitted_at=NOW() WHERE id=$1 AND status='in_progress'",[run.id]);return res.redirect('/translation/run/'+run.id+'/result');}
 const stats=(await query('SELECT COUNT(*)::int total,COUNT(answer_text)::int done FROM translation_run_items WHERE run_id=$1',[run.id])).rows[0];
 res.render('translation/take',{title:'Latihan Terjemahan',run,item,stats,focusLabels});
}));
router.post('/translation/run/:id/answer',requireAuth,asyncRoute(async(req,res)=>{
 const itemId=int(req.body.item_id),chosen=String(req.body.chosen_focus||''),answer=String(req.body.english_answer||'').trim();
 if(!itemId||!focusNames.includes(chosen)||answer.length<3||answer.length>600)return message(res,400,'Jawaban tidak valid','Pilih tense/struktur dan ketik kalimat 3–600 karakter.');
 const client=await pool.connect();let ordinal;
 try{await client.query('BEGIN');
  const run=(await client.query('SELECT * FROM translation_runs WHERE id=$1 AND user_id=$2 FOR UPDATE',[req.params.id,req.session.user.id])).rows[0];
  if(!run||run.status!=='in_progress'){await client.query('ROLLBACK');return message(res,409,'Sesi telah selesai','Buka hasil atau mulai latihan baru.');}
  const next=(await client.query('SELECT * FROM translation_run_items WHERE run_id=$1 AND answer_text IS NULL ORDER BY ordinal LIMIT 1 FOR UPDATE',[run.id])).rows[0];
  if(!next||next.id!==itemId){await client.query('ROLLBACK');return message(res,409,'Urutan berubah','Muat ulang halaman untuk pertanyaan berikutnya.');}
  ordinal=next.ordinal;
  const accepted=Array.isArray(next.accepted_snapshot)?next.accepted_snapshot:[];
  const exact=accepted.some(a=>norm(a)===norm(answer));
  await client.query(`UPDATE translation_run_items SET chosen_focus=$1,answer_text=$2,
   tense_correct=$3,sentence_verdict=$4,answered_at=NOW() WHERE id=$5`,[chosen,answer,chosen===next.focus_snapshot,exact?'accepted':'pending',next.id]);
  const remaining=(await client.query('SELECT COUNT(*)::int n FROM translation_run_items WHERE run_id=$1 AND answer_text IS NULL',[run.id])).rows[0].n;
  if(remaining===0)await client.query("UPDATE translation_runs SET status='submitted',submitted_at=NOW() WHERE id=$1",[run.id]);
  await client.query('COMMIT');
 }catch(e){await client.query('ROLLBACK').catch(()=>{});throw e;}finally{client.release();}
 res.redirect(`/translation/run/${req.params.id}/feedback/${ordinal}`);
}));
router.get('/translation/run/:id/feedback/:ordinal',requireAuth,asyncRoute(async(req,res)=>{
 const run=await ownedTranslation(req.params.id,req.session.user.id);if(!run)return message(res,404,'Tidak ditemukan','Sesi bukan milik Anda.');
 const item=(await query(`SELECT ordinal,prompt_snapshot,focus_snapshot,model_snapshot,explanation_snapshot,chosen_focus,answer_text,tense_correct,sentence_verdict
  FROM translation_run_items WHERE run_id=$1 AND ordinal=$2 AND answer_text IS NOT NULL`,[run.id,req.params.ordinal])).rows[0];
 if(!item)return message(res,404,'Belum dijawab','Selesaikan pertanyaan dahulu.');
 res.render('translation/feedback',{title:'Pembahasan Terjemahan',run,item,focusLabels});
}));
router.get('/translation/run/:id/result',requireAuth,asyncRoute(async(req,res)=>{
 const run=await ownedTranslation(req.params.id,req.session.user.id);if(!run)return message(res,404,'Tidak ditemukan','Sesi bukan milik akun Anda.');
 if(run.status!=='submitted')return res.redirect('/translation/run/'+run.id);
 const items=(await query(`SELECT ordinal,prompt_snapshot,focus_snapshot,model_snapshot,explanation_snapshot,chosen_focus,answer_text,tense_correct,sentence_verdict
  FROM translation_run_items WHERE run_id=$1 ORDER BY ordinal`,[run.id])).rows;
 res.render('translation/result',{title:'Hasil Terjemahan',run,items,focusLabels});
}));
router.get('/translation/history',requireAuth,asyncRoute(async(req,res)=>{
 const runs=(await query(`SELECT r.id,r.started_at,r.submitted_at,r.status,r.focus_filter,COUNT(i.id)::int total,
 COUNT(i.id) FILTER (WHERE i.tense_correct)::int focus_correct, COUNT(i.id) FILTER (WHERE i.sentence_verdict='pending')::int pending
 FROM translation_runs r JOIN translation_run_items i ON i.run_id=r.id WHERE r.user_id=$1 GROUP BY r.id ORDER BY r.started_at DESC LIMIT 100`,[req.session.user.id])).rows;
 res.render('translation/history',{title:'Riwayat Terjemahan',runs,focusLabels});
}));
router.get('/listening',asyncRoute(async(req,res)=>{
 const tracks=(await query(`SELECT t.id,t.slug,t.title,t.level,t.topic,t.source_credit,COUNT(q.id)::int question_count FROM listening_tracks t
 LEFT JOIN listening_questions q ON q.track_id=t.id AND q.is_active
 WHERE t.is_active GROUP BY t.id ORDER BY t.level,t.title`)).rows;
 res.render('listening/index',{title:'Listening Sessions',tracks});
}));
router.post('/listening/:slug/start',requireAuth,asyncRoute(async(req,res)=>{
 const client=await pool.connect();let id;
 try{await client.query('BEGIN');
  const track=(await client.query('SELECT id FROM listening_tracks WHERE slug=$1 AND is_active',[req.params.slug])).rows[0];
  if(!track){await client.query('ROLLBACK');return message(res,404,'Audio tidak ditemukan','Pilih audio yang tersedia.');}
  const questions=(await client.query('SELECT * FROM listening_questions WHERE track_id=$1 AND is_active ORDER BY random() LIMIT 10',[track.id])).rows;
  if(!questions.length){await client.query('ROLLBACK');return message(res,400,'Soal belum ada','Audio ini belum memiliki soal aktif.');}
  id=(await client.query('INSERT INTO listening_runs(user_id,track_id) VALUES($1,$2) RETURNING id',[req.session.user.id,track.id])).rows[0].id;
  for(const [i,q] of questions.entries()){
   const slots=shuffled(q.options.map((label,index)=>({label,correct:index===q.correct_index})));
   await client.query(`INSERT INTO listening_run_items(run_id,ordinal,question_snapshot,options_snapshot,correct_index,explanation_snapshot)
    VALUES($1,$2,$3,$4::jsonb,$5,$6)`,[id,i+1,q.stem,JSON.stringify(slots.map(x=>x.label)),slots.findIndex(x=>x.correct),q.explanation]);
  }
  await client.query('COMMIT');
 }catch(e){await client.query('ROLLBACK').catch(()=>{});throw e;}finally{client.release();}
 res.redirect('/listening/run/'+id);
}));
async function ownedListening(id,userId){return (await query(`SELECT r.*,t.title track_title,t.level,t.audio_path,t.transcript,t.source_credit FROM listening_runs r JOIN listening_tracks t ON t.id=r.track_id WHERE r.id=$1 AND r.user_id=$2`,[id,userId])).rows[0];}
router.get('/listening/run/:id',requireAuth,asyncRoute(async(req,res)=>{
 const run=await ownedListening(req.params.id,req.session.user.id);if(!run)return message(res,404,'Tidak ditemukan','Sesi bukan milik akun ini.');
 if(run.status==='submitted')return res.redirect('/listening/run/'+run.id+'/result');
 const items=(await query(`SELECT ordinal,question_snapshot,options_snapshot FROM listening_run_items WHERE run_id=$1 ORDER BY ordinal`,[run.id])).rows;
 res.render('listening/take',{title:'Listening: '+run.track_title,run:{...run,transcript:undefined},items});
}));
router.post('/listening/run/:id/submit',requireAuth,asyncRoute(async(req,res)=>{
 const client=await pool.connect();
 try{await client.query('BEGIN');
  const r=(await client.query(`SELECT id,status FROM listening_runs WHERE id=$1 AND user_id=$2 FOR UPDATE`,[req.params.id,req.session.user.id])).rows[0];
  if(!r){await client.query('ROLLBACK');return message(res,404,'Tidak ditemukan','Sesi bukan milik akun ini.');}
  if(r.status==='submitted'){await client.query('ROLLBACK');return res.redirect('/listening/run/'+r.id+'/result');}
  const items=(await client.query('SELECT id,ordinal,correct_index FROM listening_run_items WHERE run_id=$1 FOR UPDATE',[r.id])).rows;
  let correct=0;
  for(const item of items){
   const raw=req.body['q'+item.ordinal];
   if(typeof raw!=='string'||! /^[0-3]$/.test(raw)){await client.query('ROLLBACK');return message(res,400,'Jawaban tidak valid','Jawab seluruh soal dengan pilihan A–D.');}
   const selected=Number(raw);
   if(selected!==null&&(!Number.isInteger(selected)||selected<0||selected>3)){await client.query('ROLLBACK');return message(res,400,'Jawaban tidak valid','Setiap jawaban harus berupa pilihan A–D.');}
   const good=selected!==null&&selected===item.correct_index;if(good)correct++;
   await client.query(`UPDATE listening_run_items SET chosen_index=$1,is_correct=$2 WHERE id=$3`,[selected,good,item.id]);
  }
  await client.query("UPDATE listening_runs SET status='submitted',submitted_at=NOW(),correct_count=$2,score=$3 WHERE id=$1",[r.id,correct,items.length?Math.round(10000*correct/items.length)/100:0]);
  await client.query('COMMIT');res.redirect('/listening/run/'+r.id+'/result');
 }catch(e){await client.query('ROLLBACK').catch(()=>{});throw e;}finally{client.release();}
}));
router.get('/listening/run/:id/result',requireAuth,asyncRoute(async(req,res)=>{
 const run=await ownedListening(req.params.id,req.session.user.id);if(!run)return message(res,404,'Tidak ditemukan','Sesi bukan milik akun ini.');
 if(run.status!=='submitted')return res.redirect('/listening/run/'+run.id);
 const items=(await query('SELECT * FROM listening_run_items WHERE run_id=$1 ORDER BY ordinal',[run.id])).rows;
 res.render('listening/result',{title:'Hasil Listening',run,items});
}));
router.get('/admin/translation-review',requireAdmin,asyncRoute(async(req,res)=>{
 const rows=(await query(`SELECT i.*,r.user_id,u.username FROM translation_run_items i
 JOIN translation_runs r ON r.id=i.run_id JOIN users u ON u.id=r.user_id
 WHERE i.sentence_verdict='pending' AND i.answer_text IS NOT NULL ORDER BY i.answered_at ASC LIMIT 100`)).rows;
 res.render('translation/admin_review',{title:'Review Terjemahan',rows,focusLabels});
}));
router.post('/admin/translation-review/:id',requireAdmin,asyncRoute(async(req,res)=>{
 if(!['accepted','rejected'].includes(req.body.verdict))return message(res,400,'Status tidak valid','Gunakan accepted atau rejected.');
 const client=await pool.connect();
 try{await client.query('BEGIN');
  const updated=await client.query(`UPDATE translation_run_items SET sentence_verdict=$1,reviewed_by=$2,reviewed_at=NOW()
   WHERE id=$3 AND sentence_verdict='pending' AND answer_text IS NOT NULL RETURNING id`,[req.body.verdict,req.session.user.id,req.params.id]);
  if(!updated.rowCount){await client.query('ROLLBACK');return message(res,409,'Review berubah','Jawaban sudah direview atau tidak ditemukan.');}
  await client.query('COMMIT');
 }catch(e){await client.query('ROLLBACK').catch(()=>{});throw e;}finally{client.release();}
 res.redirect('/admin/translation-review');
}));
export default router;
