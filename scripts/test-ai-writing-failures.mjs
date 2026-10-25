import assert from 'node:assert/strict';
import {gradeWriting} from '../src/services/ai-writing.js';
const previousProvider=process.env.AI_PROVIDER;
process.env.AI_PROVIDER='openai';
const previousFetch=globalThis.fetch,previousKey=process.env.OPENAI_API_KEY;
const item={prompt_snapshot:'Saya belajar bahasa Inggris.',focus_snapshot:'simple-present',chosen_focus:'simple-present',model_snapshot:'I study English.',answer_text:'I study English.'};
try{
 delete process.env.OPENAI_API_KEY;
 await assert.rejects(gradeWriting(item),/AI_NOT_CONFIGURED/);
 process.env.OPENAI_API_KEY='mock-only';
 for(const status of [429,500]){
  globalThis.fetch=async()=>({ok:false,status});
  await assert.rejects(gradeWriting(item),new RegExp('HTTP '+status));
 }
 globalThis.fetch=async()=>{throw new DOMException('timeout','TimeoutError');};
 await assert.rejects(gradeWriting(item),{name:'TimeoutError'});
 globalThis.fetch=async()=>({ok:true,json:async()=>({output:[]})});
 await assert.rejects(gradeWriting(item),/incomplete or empty/);
 globalThis.fetch=async()=>({ok:true,json:async()=>({output_text:JSON.stringify({overall_score:101})})});
 await assert.rejects(gradeWriting(item),/AI_INVALID_SCORE/);
 await assert.rejects(gradeWriting({...item,answer_text:'x'.repeat(2001)}),/AI_INPUT_INVALID/);
 console.log('PASS missing key, provider 429/500, timeout, empty output, invalid score, bounded input (mock; no paid requests)');
}finally{
 globalThis.fetch=previousFetch;
 if(previousProvider===undefined)delete process.env.AI_PROVIDER;else process.env.AI_PROVIDER=previousProvider;
 if(previousKey===undefined)delete process.env.OPENAI_API_KEY;else process.env.OPENAI_API_KEY=previousKey;
}
