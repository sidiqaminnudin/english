import {pool} from '../db.js';
import {shuffle,selectFinalQuestions} from './question-selection.js';
export async function startAttempt({userId,moduleId=null,lessonId=null,mode,requestedCount,passingScore=75,durationMinutes=null,finalExam=false}){
 const client=await pool.connect();
 try{
  await client.query('BEGIN');
  const lessonIds=finalExam?(await client.query(`SELECT l.id FROM lessons l JOIN modules m ON m.id=l.module_id JOIN courses c ON c.id=m.course_id WHERE l.is_published AND m.is_published AND c.is_published`)).rows.map(l=>l.id):[];
  const poolRows=(await client.query(`SELECT q.id,q.lesson_id,q.stem,q.explanation,q.difficulty,
   (SELECT COUNT(*)::int FROM attempt_items ai JOIN attempts a ON a.id=ai.attempt_id WHERE ai.question_id=q.id AND a.user_id=$2 AND a.started_at>NOW()-INTERVAL '30 days') AS seen
   FROM questions q WHERE (($4::boolean AND q.lesson_id=ANY($5::bigint[]) AND EXISTS(SELECT 1 FROM lessons l WHERE l.id=q.lesson_id AND l.module_id=q.module_id)) OR (NOT $4::boolean AND q.module_id=$1)) AND ($3::bigint IS NULL OR q.lesson_id=$3)
   AND q.is_active=true AND (SELECT COUNT(*) FROM question_options o WHERE o.question_id=q.id)=4
   AND (SELECT COUNT(*) FROM question_options o WHERE o.question_id=q.id AND o.is_correct)=1
   ORDER BY seen ASC, RANDOM()`,[moduleId,userId,lessonId,finalExam,lessonIds])).rows;
  if(!poolRows.length){await client.query('ROLLBACK');return null;}
  // Round-robin by difficulty; preserves seen-count preference within each group.
  const groups={easy:[],medium:[],hard:[]};for(const q of poolRows)groups[q.difficulty].push(q);
  const selected=finalExam?selectFinalQuestions(poolRows,lessonIds,requestedCount):[];const levels=shuffle(['easy','medium','hard']);
  if(finalExam&&!selected.length){await client.query('ROLLBACK');return null;}
  while(selected.length<requestedCount){let added=0;for(const level of levels){if(selected.length>=requestedCount)break;if(groups[level].length){selected.push(groups[level].shift());added++;}}if(!added)break;}
  const attempt=(await client.query(`INSERT INTO attempts(user_id,module_id,lesson_id,mode,question_count,duration_minutes,passing_score)
   VALUES($1,$2,$3,$4,$5,$6,$7) RETURNING id`,[userId,moduleId,lessonId,mode,selected.length,durationMinutes,passingScore])).rows[0];
  const ids=selected.map(q=>q.id);
  const optRows=(await client.query('SELECT id,question_id,body,is_correct FROM question_options WHERE question_id=ANY($1::bigint[]) ORDER BY sort_order',[ids])).rows;
  const byQuestion=new Map(); for(const option of optRows){const key=String(option.question_id);if(!byQuestion.has(key))byQuestion.set(key,[]);byQuestion.get(key).push(option);}
  for(let i=0;i<selected.length;i++){
   const q=selected[i],opts=shuffle(byQuestion.get(String(q.id))),correct=opts.find(o=>o.is_correct);
   const snapshot=opts.map(o=>({id:String(o.id),body:o.body}));
   await client.query(`INSERT INTO attempt_items(attempt_id,question_id,ordinal,stem_snapshot,options_snapshot,correct_option_id,explanation_snapshot)
     VALUES($1,$2,$3,$4,$5::jsonb,$6,$7)`,[attempt.id,q.id,i+1,q.stem,JSON.stringify(snapshot),correct.id,q.explanation]);
  }
  await client.query('COMMIT');return attempt.id;
 }catch(err){await client.query('ROLLBACK').catch(()=>{});throw err;}finally{client.release();}
}
export async function finalizeAttempt(attemptId,userId){
 const client=await pool.connect();
 try{
  await client.query('BEGIN');
  const row=(await client.query('SELECT * FROM attempts WHERE id=$1 AND user_id=$2 FOR UPDATE',[attemptId,userId])).rows[0];
  if(!row){await client.query('ROLLBACK');return null;}
  if(row.status!=='in_progress'){await client.query('COMMIT');return row;}
  const expired=isExpired(row);
  await client.query('UPDATE attempt_items SET is_correct=COALESCE(chosen_option_id=correct_option_id,false) WHERE attempt_id=$1',[attemptId]);
  const stats=(await client.query('SELECT COUNT(*) FILTER(WHERE is_correct)::int AS correct FROM attempt_items WHERE attempt_id=$1',[attemptId])).rows[0];
  const score=Math.round(stats.correct/row.question_count*10000)/100;
  const result=(await client.query(`UPDATE attempts SET status=$2,submitted_at=NOW(),score=$3,correct_count=$4 WHERE id=$1 RETURNING *`,
  [attemptId,expired?'expired':'submitted',score,stats.correct])).rows[0];
  await client.query('COMMIT');return result;
 }catch(err){await client.query('ROLLBACK').catch(()=>{});throw err;}finally{client.release();}
}
export function isExpired(row){return row.mode==='exam'&&Date.now()>=new Date(row.started_at).getTime()+Number(row.duration_minutes)*60000;}
export async function saveAnswer({attemptId,itemId,optionId,userId}){
 const client=await pool.connect();
 try{
  await client.query('BEGIN');
  const attempt=(await client.query('SELECT * FROM attempts WHERE id=$1 AND user_id=$2 FOR UPDATE',[attemptId,userId])).rows[0];
  if(!attempt){await client.query('ROLLBACK');return {error:'Sesi tidak ditemukan',status:404};}
  if(attempt.status!=='in_progress'||isExpired(attempt)){await client.query('ROLLBACK');return {error:'Sesi sudah berakhir',status:409};}
  const item=(await client.query('SELECT * FROM attempt_items WHERE id=$1 AND attempt_id=$2 FOR UPDATE',[itemId,attemptId])).rows[0];
  if(!item){await client.query('ROLLBACK');return {error:'Soal tidak ditemukan',status:404};}
  if(!Array.isArray(item.options_snapshot)||!item.options_snapshot.some(o=>String(o.id)===String(optionId))){await client.query('ROLLBACK');return {error:'Opsi tidak valid',status:400};}
  const correct=String(item.correct_option_id)===String(optionId);
  await client.query(`UPDATE attempt_items SET chosen_option_id=$1,answered_at=NOW(),is_correct=$2 WHERE id=$3`,[optionId,correct,itemId]);
  await client.query('COMMIT');
  return attempt.mode==='practice'?{saved:true,correct,explanation:item.explanation_snapshot,correctOptionId:String(item.correct_option_id)}:{saved:true};
 }catch(err){await client.query('ROLLBACK').catch(()=>{});throw err;}finally{client.release();}
}
