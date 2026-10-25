import {Router} from 'express';
import rateLimit from 'express-rate-limit';
import {pool,query} from '../db.js';
import {asyncRoute,requireAuth} from '../middleware/core.js';
import {gradeWriting,isWritingAIConfigured} from '../services/ai-writing.js';
const router=Router();
const limit=rateLimit({windowMs:60*60*1000,limit:12,keyGenerator:req=>String(req.session.user.id),standardHeaders:'draft-7',legacyHeaders:false,message:'Batas koreksi AI per jam tercapai. Coba lagi nanti.'});
const validId=x=>typeof x==='string'&&/^[1-9]\d{0,17}$/.test(x);
async function owned(id,userId){return (await query(`SELECT i.*,r.user_id,r.status run_status
 FROM translation_run_items i JOIN translation_runs r ON r.id=i.run_id
 WHERE i.id=$1 AND r.user_id=$2`,[id,userId])).rows[0];}
router.get('/translation/ai/item/:id',requireAuth,asyncRoute(async(req,res)=>{
 if(!validId(req.params.id))return res.sendStatus(404);
 const item=await owned(req.params.id,req.session.user.id);if(!item)return res.sendStatus(404);
 res.render('translation/ai_feedback',{title:'Koreksi Writing dengan AI',item,enabled:isWritingAIConfigured()});
}));
router.post('/translation/ai/item/:id',requireAuth,limit,asyncRoute(async(req,res)=>{
 if(!validId(req.params.id))return res.sendStatus(404);
 const id=req.params.id,user=req.session.user.id;
 const item=await owned(id,user);if(!item)return res.sendStatus(404);
 if(typeof item.answer_text!=='string'||!item.answer_text.trim()||item.answer_text.length>2000)return res.sendStatus(400);
 if(!isWritingAIConfigured())return res.status(503).render('message',{title:'Koreksi AI belum aktif',message:'Admin belum melengkapi konfigurasi provider AI. Jawaban tetap tersimpan dan bisa ditinjau admin.'});
 // Atomic claim prevents charging twice on double clicks or concurrent requests.
 const claimed=(await query(`UPDATE translation_run_items i SET ai_grade_status='processing',ai_grade_attempts=i.ai_grade_attempts+1,ai_grade_checked_at=NOW()
 FROM translation_runs r WHERE i.run_id=r.id AND r.user_id=$2 AND i.id=$1 AND i.answer_text IS NOT NULL
 AND i.ai_grade_attempts<2 AND (i.ai_grade_status IN ('none','failed') OR (i.ai_grade_status='processing' AND i.ai_grade_checked_at < NOW()-INTERVAL '2 minutes')) RETURNING i.*`,[id,user])).rows[0];
 if(!claimed)return res.redirect('/translation/ai/item/'+id);
 try{
  const grade=await gradeWriting(claimed);
  await query(`UPDATE translation_run_items i SET ai_grade_json=$2::jsonb,ai_grade_model=$3,ai_grade_status='ready',ai_grade_checked_at=NOW(),
   sentence_verdict=CASE WHEN i.sentence_verdict='pending' AND i.reviewed_by IS NULL THEN CASE WHEN ($2::jsonb->>'suggested_acceptance')::boolean THEN 'accepted' ELSE 'rejected' END ELSE i.sentence_verdict END
   FROM translation_runs r WHERE i.id=$1 AND i.run_id=r.id AND r.user_id=$4 AND i.ai_grade_attempts=$5 AND i.ai_grade_status='processing'`,[id,JSON.stringify(grade.feedback),grade.model,user,claimed.ai_grade_attempts]);
 }catch(e){
  // Keep the human-review workflow available when API is down or times out.
  console.error('Writing AI feedback failed');
  await query(`UPDATE translation_run_items i SET ai_grade_status='failed',ai_grade_checked_at=NOW() FROM translation_runs r WHERE i.id=$1 AND i.run_id=r.id AND r.user_id=$2 AND i.ai_grade_attempts=$3 AND i.ai_grade_status='processing'`,[id,user,claimed.ai_grade_attempts]);
 }
 res.redirect('/translation/ai/item/'+id);
}));
export default router;
