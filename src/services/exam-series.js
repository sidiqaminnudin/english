import {pool} from '../db.js';
import {statSync} from 'node:fs';
import {shuffle} from './question-selection.js';
export const tenses=['simple-present','simple-past','simple-future','present-continuous','past-continuous','future-continuous','present-perfect'];
export function selectModules(rows,modules,count){
 if(modules.length!==13||count<26)throw Error('Konfigurasi harus mencakup 13 modul dan minimal 26 soal.');
 const groups=modules.map(m=>({...m,rows:shuffle(rows.filter(q=>String(q.module_id)===String(m.module_id))),used:0}));
 if(groups.some(g=>g.rows.length<2)||rows.length<count)throw Error('Bank soal aktif tidak mencukupi.');
 const result=[];for(const g of groups){result.push(...g.rows.splice(0,2));}
 while(result.length<count){const g=groups.filter(g=>g.rows.length).sort((a,b)=>a.used/a.weight-b.used/b.weight)[0];if(!g)throw Error('Bank soal tidak mencukupi.');result.push(g.rows.shift());g.used++;}
 return shuffle(result);
}
export function audioAvailable(url){
 const path=String(url||'').split('?')[0];
 if(!/^\/audio\/[a-zA-Z0-9_./-]+\.mp3$/.test(path)||path.includes('..'))return false;
 try{return statSync(new URL('../public'+path,import.meta.url)).size>0;}catch{return false;}
}
export async function buildItems(c,s){
 if(s.kind==='fundamentals'){
 const mods=(await c.query('SELECT * FROM exam_series_modules WHERE series_id=$1 ORDER BY module_id',[s.id])).rows;
 const rows=(await c.query(`SELECT q.*,jsonb_agg(jsonb_build_object('id',o.id::text,'body',o.body,'correct',o.is_correct)) options FROM questions q JOIN question_options o ON o.question_id=q.id JOIN modules m ON m.id=q.module_id JOIN courses c ON c.id=m.course_id WHERE q.is_active AND m.is_published AND c.is_published AND q.module_id=ANY($1::bigint[]) GROUP BY q.id HAVING COUNT(*)=4 AND COUNT(*) FILTER(WHERE o.is_correct)=1`,[mods.map(m=>m.module_id)])).rows;
 return selectModules(rows,mods,s.question_count).map(q=>({kind:'mcq',source_id:q.id,snapshot:{stem:q.stem,module_id:q.module_id,options:shuffle(q.options).map(o=>({id:o.id,body:o.body})),correct:q.options.find(o=>o.correct).id,explanation:q.explanation}}));
 }
 const prompts=(await c.query('SELECT * FROM translation_prompts WHERE is_active AND grammar_focus=ANY($1::text[]) ORDER BY random()',[tenses])).rows;
 const chosen=[];for(const tense of tenses){const group=prompts.filter(p=>p.grammar_focus===tense);if(group.length<2)throw Error('Minimal dua prompt aktif untuk setiap tense diperlukan.');chosen.push(...group.slice(0,2));}
 const extra=prompts.find(p=>!chosen.some(q=>q.id===p.id));if(!extra)throw Error('Minimal 15 prompt diperlukan.');chosen.push(extra);
 const listening=(await c.query(`SELECT q.*,t.audio_path,t.transcript,t.source_type,t.source_credit,t.title FROM listening_questions q JOIN listening_tracks t ON t.id=q.track_id WHERE q.is_active AND t.is_active ORDER BY random()`)).rows.filter(q=>audioAvailable(q.audio_path)&&q.transcript.trim()&&q.options.length===4);
 if(listening.length<10)throw Error('Minimal 10 soal listening dengan audio tersedia diperlukan.');
 return [...shuffle(chosen).map(p=>({kind:'writing',source_id:p.id,snapshot:{stem:p.indonesian,accepted_focus:p.accepted_focus||[p.grammar_focus],focus:p.grammar_focus,model:p.model_answer,accepted:p.accepted_answers,explanation:p.explanation}})),...listening.slice(0,10).map(q=>({kind:'listening',source_id:q.id,snapshot:{stem:q.stem,options:shuffle(q.options.map((body,i)=>({id:String(i),body}))),correct:String(q.correct_index),explanation:q.explanation,audio:q.audio_path,transcript:q.transcript,source_type:q.source_type,credit:q.source_credit}}))];
}
export async function transaction(fn){const c=await pool.connect();try{await c.query('BEGIN');const value=await fn(c);await c.query('COMMIT');return value;}catch(e){await c.query('ROLLBACK');throw e;}finally{c.release();}}
export async function startRun(userId,slug,preview=false){return transaction(async c=>{
 const s=(await c.query('SELECT * FROM exam_series WHERE slug=$1 FOR SHARE',[slug])).rows[0];if(!s||(!preview&&!s.is_published))throw Error('Ujian belum diterbitkan.');
 const items=await buildItems(c,s);
 const run=(await c.query(`INSERT INTO exam_series_runs(user_id,series_id,config,deadline_at,is_preview) VALUES($1,$2,$3,NOW()+$4*INTERVAL '1 minute',$5) RETURNING id`,[userId,s.id,JSON.stringify(s),s.duration_minutes,preview])).rows[0];
 for(const [i,item] of items.entries())await c.query('INSERT INTO exam_series_items(run_id,ordinal,kind,source_id,snapshot) VALUES($1,$2,$3,$4,$5)',[run.id,i+1,item.kind,item.source_id,JSON.stringify(item.snapshot)]);
 return run.id;
 });}
export async function saveRun(id,userId,body,submit=false){return transaction(async c=>{
 const r=(await c.query('SELECT *,NOW()>=deadline_at timed_out FROM exam_series_runs WHERE id=$1 AND user_id=$2 FOR UPDATE',[id,userId])).rows[0];if(!r)throw Error('Sesi tidak ditemukan.');if(r.status!=='in_progress')return;
 const items=(await c.query('SELECT * FROM exam_series_items WHERE run_id=$1 ORDER BY ordinal',[id])).rows;
 if(!r.timed_out){for(const item of items){
 const answer=item.kind==='writing'?{focus:String(body['focus_'+item.id]||''),text:String(body['text_'+item.id]||'').trim()}:{option:String(body['option_'+item.id]||'')};
 if(item.kind==='writing'){if(answer.text.length>2000|| (answer.focus&&!tenses.includes(answer.focus)))throw Error('Jawaban writing tidak valid.');}
 else if(answer.option&&!item.snapshot.options.some(o=>o.id===answer.option))throw Error('Opsi tidak valid.');
 item.answer=answer;await c.query('UPDATE exam_series_items SET answer=$2 WHERE id=$1',[item.id,JSON.stringify(answer)]);
 }}
 if(submit||r.timed_out){for(const item of items){await c.query(`UPDATE exam_series_items SET objective_points=$2,writing_points=$3,review_status=$4 WHERE id=$1`,[item.id,objective(item,item.answer,items.length),item.kind==='writing'?null:0,item.kind==='writing'?'pending':'none']);}
 await c.query(`UPDATE exam_series_runs SET status=$2,submitted_at=NOW(),expired=$3 WHERE id=$1`,[id,items.some(i=>i.kind==='writing')?'pending_review':'final',r.timed_out]);}
 });}
export async function reviewItem(itemId,adminId,points,reason,tensePoints=null){
 if(!Number.isFinite(points)||points<0||points>3||!String(reason||'').trim()||reason.length>2000||!([null,0,1].includes(tensePoints)))throw Error('Review tidak valid.');
 return transaction(async c=>{
 const row=(await c.query('SELECT run_id FROM exam_series_items WHERE id=$1',[itemId])).rows[0];if(!row)throw Error('Soal tidak ditemukan.');
 const run=(await c.query('SELECT * FROM exam_series_runs WHERE id=$1 FOR UPDATE',[row.run_id])).rows[0];if(run.status==='in_progress')throw Error('Ujian belum dikumpulkan.');
 const result=await c.query(`UPDATE exam_series_items SET writing_points=$2,review_status='reviewed',reviewed_by=$3,reviewed_at=NOW(),review_reason=$4 WHERE id=$1 AND kind='writing'`,[itemId,points,adminId,reason]);if(!result.rowCount)throw Error('Bukan soal writing.');
 if(tensePoints!==null)await c.query('UPDATE exam_series_items SET objective_points=$2 WHERE id=$1',[itemId,tensePoints]);
 await c.query('INSERT INTO exam_series_reviews(item_id,reviewer_id,points,reason) VALUES($1,$2,$3,$4)',[itemId,adminId,points,reason]);
 await c.query(`UPDATE exam_series_runs SET status=CASE WHEN EXISTS(SELECT 1 FROM exam_series_items WHERE run_id=$1 AND review_status='pending') THEN 'pending_review' ELSE 'final' END WHERE id=$1`,[row.run_id]);
 });}
export const owned=async(id,userId)=>(await pool.query('SELECT *,NOW()>=deadline_at timed_out FROM exam_series_runs WHERE id=$1 AND user_id=$2',[id,userId])).rows[0];
export function objective(item,answer,count){return item.kind==='writing'?(item.snapshot.accepted_focus.includes(answer.focus)?1:0):(answer.option===item.snapshot.correct?(item.kind==='listening'?4:100/count):0);}
