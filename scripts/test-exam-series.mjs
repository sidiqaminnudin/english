import assert from 'node:assert/strict';
import ejs from 'ejs';
import {pool,query} from '../src/db.js';
import {buildItems,startRun,saveRun,reviewItem,owned,audioAvailable,selectModules} from '../src/services/exam-series.js';
import {gradeExamRun} from '../src/services/exam-series-ai.js';
const runs=[];
try{
 const users=(await query('SELECT id,role FROM users ORDER BY id')).rows;
 const user=users[0],admin=users.find(u=>u.role==='admin');assert(admin);
 const series=(await query('SELECT * FROM exam_series ORDER BY id')).rows;assert.equal(series.length,2);
 for(const s of series){
  const id=await startRun(user.id,s.slug,true);runs.push(id);
  const items=(await query('SELECT * FROM exam_series_items WHERE run_id=$1 ORDER BY ordinal',[id])).rows;
  assert.equal(items.length,s.question_count);assert.equal(new Set(items.map(i=>i.kind+':'+i.source_id)).size,items.length);
  const initial=JSON.stringify(items.map(i=>i.snapshot));assert.equal(JSON.stringify((await query('SELECT snapshot FROM exam_series_items WHERE run_id=$1 ORDER BY ordinal',[id])).rows.map(i=>i.snapshot)),initial);
  assert.equal(await owned(id,'9223372036854775807'),undefined);
  await assert.rejects(saveRun(id,'9223372036854775807',{},true));
  const run=await owned(id,user.id);assert(Math.abs((new Date(run.deadline_at)-new Date(run.started_at))/60000-s.duration_minutes)<0.01);
  const body={};for(const i of items){if(i.kind==='writing'){body['focus_'+i.id]=i.snapshot.focus;body['text_'+i.id]=i.snapshot.model;}else body['option_'+i.id]=i.snapshot.correct;}
  const locals={title:'Test',user:null,path:'/exams',year:2026,csrfToken:'test',run,items,series,pending:[],modules:[],runs:[]};
  const html=await ejs.renderFile('src/views/exam_run.ejs',locals);assert(!html.includes('correct_option'));assert(!html.includes('transcript'));assert(html.includes('_csrf'));
  await saveRun(id,user.id,body,false);assert.equal((await owned(id,user.id)).status,'in_progress');
  await saveRun(id,user.id,body,true);const before=(await query('SELECT answer FROM exam_series_items WHERE run_id=$1 ORDER BY ordinal',[id])).rows;
  await saveRun(id,user.id,{},true);assert.deepEqual((await query('SELECT answer FROM exam_series_items WHERE run_id=$1 ORDER BY ordinal',[id])).rows,before);
  if(s.kind==='integrated'){
   assert.equal((await owned(id,user.id)).status,'pending_review');
   const previous=process.env.AI_PROVIDER;process.env.AI_PROVIDER='invalid';await gradeExamRun(id);process.env.AI_PROVIDER=previous;
   assert.equal((await owned(id,user.id)).status,'pending_review');
   for(const i of items.filter(i=>i.kind==='writing'))await reviewItem(i.id,admin.id,3,'Automated test',1);
   assert.equal((await owned(id,user.id)).status,'final');
  }else{const counts={};for(const i of items)counts[i.snapshot.module_id]=(counts[i.snapshot.module_id]||0)+1;assert.equal(Object.keys(counts).length,13);assert(Object.values(counts).every(n=>n>=2));}
  const total=(await query('SELECT SUM(objective_points+COALESCE(writing_points,0)) score FROM exam_series_items WHERE run_id=$1',[id])).rows[0].score;assert(Math.abs(Number(total)-100)<0.000001);
  locals.run=await owned(id,user.id);locals.items=(await query('SELECT * FROM exam_series_items WHERE run_id=$1 ORDER BY ordinal',[id])).rows;
  await ejs.renderFile('src/views/exam_result.ejs',locals);await ejs.renderFile('src/views/admin/exam-series.ejs',locals);
  console.log('PASS',s.slug,'selection, snapshots, ownership, duration, save, idempotence, scoring, review, EJS');
 }
 const id=await startRun(user.id,series[0].slug,true);runs.push(id);await query("UPDATE exam_series_runs SET deadline_at=NOW()-INTERVAL '1 second' WHERE id=$1",[id]);await saveRun(id,user.id,{},true);assert((await owned(id,user.id)).expired);
 assert(!audioAvailable('/audio/missing-file.mp3'));assert(!audioAvailable('/audio/../server.mp3'));
 assert.throws(()=>selectModules([],[],50));console.log('PASS timeout, missing audio, insufficient pool');
}finally{
 for(const id of runs){await query('DELETE FROM exam_series_reviews WHERE item_id IN(SELECT id FROM exam_series_items WHERE run_id=$1)',[id]);await query('DELETE FROM exam_series_items WHERE run_id=$1',[id]);await query('DELETE FROM exam_series_runs WHERE id=$1',[id]);}
 await pool.end();
}
