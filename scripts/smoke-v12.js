import assert from 'node:assert/strict';
import {spawn} from 'node:child_process';
const port=3198,base=`http://127.0.0.1:${port}`;
const server=spawn(process.execPath,['src/server.js'],{env:{...process.env,PORT:String(port),BIND_HOST:'127.0.0.1'},stdio:'pipe'});
try{
 let ready=false;
 for(let i=0;i<60;i++){try{if((await fetch(base+'/healthz')).ok){ready=true;break;}}catch{}await new Promise(r=>setTimeout(r,200));}
 assert(ready,'Server unavailable');
 for(const path of ['/courses','/learn/pronouns','/learn/simple-past']){assert.equal((await fetch(base+path)).status,200);console.log('PASS public',path);}
 for(const path of ['/practice/pronouns','/exam/pronouns','/translation','/listening','/translation/history','/translation/run/1','/listening/run/1','/admin/translation-review']){
 const response=await fetch(base+path,{redirect:'manual'});assert.equal(response.status,302);assert(response.headers.get('location').startsWith('/login'));console.log('PASS anonymous denied',path);
 }
 const csrf=await fetch(base+'/translation/start',{method:'POST',headers:{'Content-Type':'application/x-www-form-urlencoded'},body:'count=5'});assert.equal(csrf.status,403);console.log('PASS missing CSRF denied');
 const audio=await fetch(base+'/audio/at-the-library.mp3',{headers:{Range:'bytes=0-99'}});assert.equal(audio.status,206);assert.match(audio.headers.get('content-type'),/audio\/mpeg/);assert.equal((await audio.arrayBuffer()).byteLength,100);console.log('PASS MP3 range streaming');
}finally{server.kill();}
