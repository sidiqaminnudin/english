import {query} from '../db.js';
import {gradeWriting,isWritingAIConfigured} from './ai-writing.js';
// Only called after the final answer transaction commits; never from a GET.
export async function gradeWritingRun(runId,userId){
 if(!isWritingAIConfigured())return;
 const items=(await query(`SELECT i.id FROM translation_run_items i JOIN translation_runs r ON r.id=i.run_id
 WHERE r.id=$1 AND r.user_id=$2 AND r.status='submitted' ORDER BY i.ordinal LIMIT 20`,[runId,userId])).rows;
 for(const item of items){
  const claimed=(await query(`UPDATE translation_run_items i SET ai_grade_status='processing',ai_grade_attempts=ai_grade_attempts+1,ai_grade_checked_at=NOW()
   FROM translation_runs r WHERE i.run_id=r.id AND r.id=$1 AND r.user_id=$2 AND r.status='submitted'
   AND i.id=$3 AND i.answer_text IS NOT NULL AND i.ai_grade_status='none' AND i.ai_grade_attempts=0 RETURNING i.*`,[runId,userId,item.id])).rows[0];
  if(!claimed)continue;
  try{
   const grade=await gradeWriting(claimed);
   await query(`UPDATE translation_run_items SET ai_grade_status='ready',ai_grade_json=$2::jsonb,ai_grade_model=$3,ai_grade_checked_at=NOW(),
    sentence_verdict=CASE WHEN sentence_verdict='pending' AND reviewed_by IS NULL THEN CASE WHEN ($2::jsonb->>'suggested_acceptance')::boolean THEN 'accepted' ELSE 'rejected' END ELSE sentence_verdict END
    WHERE id=$1 AND run_id=$4 AND ai_grade_status='processing' AND ai_grade_attempts=$5`,[claimed.id,JSON.stringify(grade.feedback),grade.model,runId,claimed.ai_grade_attempts]);
  }catch{
   await query(`UPDATE translation_run_items SET ai_grade_status='failed',ai_grade_checked_at=NOW()
    WHERE id=$1 AND run_id=$2 AND ai_grade_status='processing' AND ai_grade_attempts=$3`,[claimed.id,runId,claimed.ai_grade_attempts]);
  }
 }
}
