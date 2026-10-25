import assert from 'node:assert/strict';
import {readFileSync} from 'node:fs';
import {spawn} from 'node:child_process';
const root=new URL('../',import.meta.url);
assert.equal(readFileSync(new URL('src/content/tenses_quick_reference.md',root),'utf8'),readFileSync(new URL('temp/tenses_quick_reference.md',root),'utf8'));
const server=spawn(process.execPath,['src/server.js'],{cwd:root,env:{...process.env,PORT:'3197',BIND_HOST:'127.0.0.1'},stdio:'ignore'});
try{
 let response;
 for(let i=0;i<60;i++){try{response=await fetch('http://127.0.0.1:3197/tenses-summary');break;}catch{await new Promise(r=>setTimeout(r,200));}}
 assert.equal(response?.status,200);
 const html=await response.text();
 for(const tense of ['Simple Present','Simple Past','Simple Future','Present Continuous','Past Continuous','Future Continuous','Present Perfect'])assert(html.includes(tense));
 assert(html.includes('Time signals'));assert(html.includes('Checklist'));assert(html.includes('name="viewport"'));assert(html.includes('lesson-content'));
 console.log('PASS public HTTP 200 without login, all seven tenses, complete source copy, mobile layout hooks');
}finally{server.kill();}
