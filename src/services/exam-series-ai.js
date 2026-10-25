import {query} from '../db.js';
import {gradeWriting,isWritingAIConfigured} from './ai-writing.js';
export async function gradeExamRun(runId){
 if(!isWritingAIConfigured())return;
 const items=(await query(`SELECT i.id FROM exam_series_items i JOIN exam_series_runs r ON r.id=i.run_id WHERE r.id=$1 AND r.status='pending_review' AND i.kind='writing' ORDER BY i.ordinal`,[runId])).rows;
 for(const {id} of items){
  const i=(await query(`UPDATE exam_series_items SET ai_status='processing',ai_attempts=ai_attempts+1 WHERE id=$1 AND review_status='pending' AND ai_status IN('none','failed') AND ai_attempts<2 AND length(answer->>'text')>0 RETURNING *`,[id])).rows[0];
  if(!i)continue;
  try{
   const result=await gradeWriting({prompt_snapshot:i.snapshot.stem,focus_snapshot:i.snapshot.focus,chosen_focus:i.answer.focus,model_snapshot:i.snapshot.model,answer_text:i.answer.text});
   await query(`UPDATE exam_series_items SET ai_status='ready',ai_json=$2,ai_model=$3 WHERE id=$1 AND ai_status='processing'`,[id,JSON.stringify(result.feedback),result.model]);
  }catch{
   await query(`UPDATE exam_series_items SET ai_status='failed' WHERE id=$1 AND ai_status='processing'`,[id]);
  }
 }
}

