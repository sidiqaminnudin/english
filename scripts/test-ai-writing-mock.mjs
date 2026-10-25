import {strict as assert} from 'node:assert';
import {gradeWriting} from '../src/services/ai-writing.js';
const prev=globalThis.fetch;
const prevProvider=process.env.AI_PROVIDER;
process.env.AI_PROVIDER='openai';
const prevKey=process.env.OPENAI_API_KEY;
process.env.OPENAI_API_KEY='test-fake-key';
try{
 let outbound;
 globalThis.fetch=async (url,opts)=>{
  outbound={url,opts,body:JSON.parse(opts.body)};
  return {ok:true,json:async()=>({output:[{type:'message',content:[{type:'output_text',text:JSON.stringify({overall_score:91,grammar_score:95,meaning_score:97,naturalness_score:83,tense_assessment:'correct',suggested_acceptance:true,feedback_id:'Kalimat sudah tepat.',corrected_english:'I have lived here for five years.',alternatives:['I have been living here for five years.'],issues:['Bisa memakai bentuk continuous jika ingin menekankan durasi.']})}]}]})};
 };
 const out=await gradeWriting({prompt_snapshot:'Saya sudah tinggal di sini selama lima tahun.',focus_snapshot:'present-perfect',chosen_focus:'present-perfect',model_snapshot:'I have lived here for five years.',answer_text:'I have been living here for five years.'});
 assert.equal(out.feedback.overall_score,91);
 assert.equal(out.feedback.suggested_acceptance,true);
 assert.equal(outbound.body.store,false);
 assert.equal(outbound.body.text.format.type,'json_schema');
 assert.ok(outbound.body.input.includes('I have been living here'));
 assert.ok(!outbound.body.input.includes('fake-key'));
 assert.ok(!outbound.body.input.includes('user_id'));
 console.log('PASS: AI service mock parsing, schema request, no account metadata, storage disabled');
}finally{globalThis.fetch=prev;if(prevProvider===undefined)delete process.env.AI_PROVIDER;else process.env.AI_PROVIDER=prevProvider;if(prevKey===undefined)delete process.env.OPENAI_API_KEY;else process.env.OPENAI_API_KEY=prevKey;}
