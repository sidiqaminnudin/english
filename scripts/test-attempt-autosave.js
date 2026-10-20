import assert from 'node:assert/strict';
import fs from 'node:fs';
import vm from 'node:vm';

const source=fs.readFileSync(new URL('../src/public/js/attempt.js',import.meta.url),'utf8');
function setup({stored={},online=true,fetcher=async()=>({ok:true,json:async()=>({saved:true})})}={}){
 const node=()=>({dataset:{},style:{},classList:{toggle(){}},handlers:{},addEventListener(name,fn){this.handlers[name]=fn;}});
 const inputs=['10','11'].map(value=>Object.assign(node(),{value,checked:false}));
 const labels=inputs.map(input=>Object.assign(node(),{querySelector:()=>input}));
 const panel=Object.assign(node(),{dataset:{itemId:'1',saved:''},querySelectorAll:s=>s==='.answer-option'?labels:inputs,querySelector:()=>node()});
 const nodes=Object.fromEntries(['assessment','prevQuestion','nextQuestion','finishButton','submitAttempt','questionCounter','answeredCounter','questionProgress','saveStatus','examTimer','timerValue'].map(id=>[id,node()]));
 nodes.assessment.dataset={attemptId:'5',mode:'practice',csrf:'token'};
 nodes.assessment.querySelectorAll=()=>[panel];
 let submitted=0;nodes.submitAttempt.submit=()=>submitted++;
 const storage=new Map(Object.entries(stored)),timers=[],events={};
 const navigator={onLine:online};
 vm.runInNewContext(source,{document:{querySelector:s=>nodes[s.slice(1)]},navigator,fetch:fetcher,localStorage:{getItem:k=>storage.get(k),setItem:(k,v)=>storage.set(k,v),removeItem:k=>storage.delete(k)},window:{addEventListener:(k,fn)=>events[k]=fn,confirm:()=>true,scrollTo(){}},setTimeout:fn=>{timers.push(fn);return timers.length;},clearTimeout(){}});
 return {nodes,inputs,panel,storage,timers,events,navigator,get submitted(){return submitted;},choose(i){inputs.forEach((input,j)=>input.checked=i===j);inputs[i].handlers.change();}};
}
const settle=async()=>{for(let i=0;i<20;i++)await Promise.resolve();};

const offline=setup({online:false});offline.choose(0);await settle();
assert.ok(offline.storage.has('assessment-pending:5'));
await offline.nodes.submitAttempt.handlers.submit({preventDefault(){}});
assert.equal(offline.submitted,0,'offline answers must block submission');
offline.navigator.onLine=true;offline.events.online();await settle();
assert.equal(offline.panel.dataset.saved,'10');assert.equal(offline.storage.size,0);
await offline.nodes.submitAttempt.handlers.submit({preventDefault(){}});assert.equal(offline.submitted,1);

let calls=0;
const retry=setup({fetcher:async()=>{if(++calls===1)throw Error('Network');return {ok:true,json:async()=>({saved:true})};}});
retry.choose(0);await settle();assert.equal(retry.panel.dataset.saved,'');assert.ok(retry.timers.length);
retry.timers.at(-1)();await settle();assert.equal(retry.panel.dataset.saved,'10');

const restored=setup({stored:{'assessment-pending:5':'{"1":"11"}'}});await settle();
assert.equal(restored.inputs[1].checked,true);assert.equal(restored.panel.dataset.saved,'11');

let release;const sent=[];
const rapid=setup({fetcher:async(url,options)=>{sent.push(JSON.parse(options.body).optionId);if(sent.length===1)await new Promise(resolve=>release=resolve);return {ok:true,json:async()=>({saved:true})};}});
rapid.choose(0);rapid.choose(1);release();await settle();
assert.deepEqual(sent,['10','11']);assert.equal(rapid.panel.dataset.saved,'11');assert.equal(rapid.storage.size,0);
console.log('PASS: offline submission blocked, reconnect, retry, reload recovery, latest choice serialization');
