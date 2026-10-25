import {pool} from '../db.js';
import {shuffle} from './question-selection.js';
export async function startSeriesRun({userId,slug}){
 const c=await pool.connect();try{await c.query('BEGIN');
  const s=(await c.query(`SELECT * FROM exam_series WHERE slug=$1 AND is_published FOR UPDATE`,[slug])).rows[0];if(!s){await c.query('ROLLBACK');return null;}
  const mods=(await c.query(`SELECT sm.module_id,m.title,m.slug,sm.weight FROM exam_series_modules sm JOIN modules m ON m.id=sm.module_id WHERE sm.series_id=$1 ORDER BY m.sort_order`,[s.id])).rows;
  const counts=(await c.query(`SELECT module_id,COUNT(*)::int n FROM questions q WHERE q.module_id=ANY($1::bigint[]) AND q.is_active AND (SELECT COUNT(*) FROM question_options o WHERE o.question_id=q.id)=4 AND (SELECT COUNT(*) FROM question_options o WHERE o.question_id=q.id AND o.is_correct)=1 GROUP BY module_id`,[mods.map(x=>x.module_id)])).rows;
  if(s.kind==='fundamentals' && (mods.length!==13||mods.some(m=>(counts.find(x=>String(x.module_id)===String(m.module_id))?.n||0)<2))){await c.query('ROLLBACK');return null;}
  const rows=(await c.query(`SELECT q.id,q.module_id,q.stem,q.explanation FROM questions q WHERE q.module_id=ANY($1::bigint[]) AND q.is_active AND (SELECT COUNT(*) FROM question_options o WHERE o.question_id=q.id)=4 AND (SELECT COUNT(*) FROM question_options o WHERE o.question_id=q.id AND o.is_correct)=1 ORDER BY random()`,[mods.map(x=>x.module_id)])).rows;
  const selected=[];if(s.kind==='fundamentals'){for(const m of mods)selected.push(...rows.filter(q=>String(q.module_id)===String(m.module_id)).slice(0,2));const rest=shuffle(rows.filter(q=>!selected.some(x=>x.id===q.id))).slice(0,s.question_count-selected.length);selected.push(...rest);}
  if(selected.length!==s.question_count){await c.query('ROLLBACK');return null;}
  const deadline=new Date(Date.now()+s.duration_minutes*60000);const run=(await c.query(`INSERT INTO exam_series_runs(user_id,series_id,title_snapshot,config_snapshot,deadline_at) VALUES($1,$2,$3,$4,$5) RETURNING id`,[userId,s.id,s.title,JSON.stringify({question_count:s.question_count,duration_minutes:s.duration_minutes,passing_score:s.passing_score}),deadline])).rows[0];
  const opts=(await c.query('SELECT id,question_id,body,is_correct FROM question_options WHERE question_id=ANY($1::bigint[]) ORDER BY question_id,sort_order',[selected.map(q=>q.id)])).rows;
  for(let i=0;i<selected.length;i++){const q=selected[i],os=shuffle(opts.filter(o=>String(o.question_id)===String(q.id))),correct=os.find(o=>o.is_correct);await c.query(`INSERT INTO exam_series_items(run_id,ordinal,question_id,module_id,stem_snapshot,options_snapshot,correct_option_id,explanation_snapshot) VALUES($1,$2,$3,$4,$5,$6::jsonb,$7,$8)`,[run.id,i+1,q.id,q.module_id,q.stem,JSON.stringify(os.map(o=>({id:String(o.id),body:o.body}))),String(correct.id),q.explanation]);}
  await c.query('COMMIT');return run.id;
 }catch(e){await c.query('ROLLBACK').catch(()=>{});throw e;}finally{c.release();}}
export const seriesOwned=(id,userId)=>pool.query('SELECT r.*,s.slug,s.title,s.passing_score FROM exam_series_runs r JOIN exam_series s ON s.id=r.series_id WHERE r.id=$1 AND r.user_id=$2',[id,userId]).then(x=>x.rows[0]);
export function seriesExpired(run){return Date.now()>=new Date(run.deadline_at).getTime();}
