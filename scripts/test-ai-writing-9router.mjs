import assert from 'node:assert/strict';
import {gradeWriting,isWritingAIConfigured} from '../src/services/ai-writing.js';
const names=['AI_PROVIDER','NINE_ROUTER_API_KEY','NINE_ROUTER_BASE_URL','NINE_ROUTER_MODEL'];
const previous=Object.fromEntries(names.map(k=>[k,process.env[k]])),originalFetch=globalThis.fetch;
const item={prompt_snapshot:'Saya belajar.',answer_text:'I study.',model_snapshot:'I study.',focus_snapshot:'simple-present',chosen_focus:'simple-present'};
const valid={overall_score:90,grammar_score:90,meaning_score:90,naturalness_score:90,tense_assessment:'correct',suggested_acceptance:true,feedback_id:'Bagus.',corrected_english:'I study.',alternatives:[],issues:[]};
let outbound,reply;
try{
 process.env.AI_PROVIDER='9router';process.env.NINE_ROUTER_API_KEY='mock-router';process.env.NINE_ROUTER_BASE_URL='http://127.0.0.1:20128/v1/';process.env.NINE_ROUTER_MODEL='mock-model';
 globalThis.fetch=async(url,opts)=>{outbound={url,...opts,body:JSON.parse(opts.body)};return {ok:true,json:async()=>reply};};
 const chat=(value,fenced=false)=>({choices:[{finish_reason:'stop',message:{content:fenced?'```json\n'+JSON.stringify(value)+'\n```':JSON.stringify(value)}}]});
 for(const fenced of [false,true]){reply=chat(valid,fenced);assert.deepEqual((await gradeWriting(item)).feedback,valid);}
 assert.equal(outbound.url,'http://127.0.0.1:20128/v1/chat/completions');assert.equal(outbound.headers.Authorization,'Bearer mock-router');assert.equal(outbound.body.model,'mock-model');assert.equal(outbound.body.store,false);assert.equal(outbound.body.stream,false);assert.equal(outbound.redirect,'error');assert.equal(outbound.body.response_format.json_schema.strict,true);
 reply={output_text:JSON.stringify(valid)};assert.deepEqual((await gradeWriting(item)).feedback,valid);
 for(const value of [-1,101,2.5,'90',null]){reply=chat({...valid,overall_score:value});await assert.rejects(gradeWriting(item),/AI_INVALID_SCORE/);}
 for(const value of [null,[],{...valid,extra:true},{...valid,issues:[{}]},{...valid,suggested_acceptance:'yes'}]){reply=chat(value);await assert.rejects(gradeWriting(item));}
 reply=chat(valid);reply.choices[0].finish_reason='length';await assert.rejects(gradeWriting(item),/incomplete/);
 delete process.env.NINE_ROUTER_API_KEY;assert.equal(isWritingAIConfigured(),false);await assert.rejects(gradeWriting(item),/AI_NOT_CONFIGURED/);
 process.env.NINE_ROUTER_API_KEY='mock-router';process.env.NINE_ROUTER_BASE_URL='http://example.com/v1';assert.equal(isWritingAIConfigured(),false);await assert.rejects(gradeWriting(item),/AI_CONFIG_INVALID/);
 console.log('PASS 9router configuration, payload, fenced/raw JSON, Responses shape, invalid schema/scores, truncation, missing key and insecure remote URL');
}finally{globalThis.fetch=originalFetch;for(const k of names){if(previous[k]===undefined)delete process.env[k];else process.env[k]=previous[k];}}
