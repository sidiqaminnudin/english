/** Idempotent installer for existing EnglishLab v1.2 files.
 * Run AFTER overlaying contents of ZIP onto project root.
 * Creates timestamped backups before replacing existing files.
 */
import {readFile,writeFile,mkdir,copyFile} from 'node:fs/promises';
import {join} from 'node:path';
import {fileURLToPath} from 'node:url';
const root=fileURLToPath(new URL('../',import.meta.url));
const backup=join(root,'.backups','writing-ai-'+new Date().toISOString().replace(/[:.]/g,'-'));
let writes=0;
async function edit(name,run){const path=join(root,name),old=await readFile(path,'utf8'),next=run(old);
 if(next===old)return;
 await mkdir(join(backup,name.slice(0,name.lastIndexOf('/'))),{recursive:true});
 await copyFile(path,join(backup,name));await writeFile(path,next,'utf8');writes++;
 console.log('Updated',name);
}
function ensureReplace(s,a,b,label){if(!s.includes(a))throw Error('Cannot find '+label+' in project; manual diff required.');return s.replace(a,b);}
await edit('src/server.js',s=>{
 if(s.includes("import aiWritingRouter from './routes/ai-writing.js'"))return s;
 s=ensureReplace(s,"import skillsRouter from './routes/skills.js';", "import skillsRouter from './routes/skills.js';\nimport aiWritingRouter from './routes/ai-writing.js';",'skills router import');
 s=ensureReplace(s,'app.use(skillsRouter);','app.use(skillsRouter);app.use(aiWritingRouter);','skills router mount');return s;
});
await edit('src/routes/skills.js',s=>{
 // Include DB row ID to build owned AI-feedback links safely.
 s=s.replaceAll('SELECT ordinal,prompt_snapshot,focus_snapshot,model_snapshot,explanation_snapshot,chosen_focus,answer_text,tense_correct,sentence_verdict','SELECT id,ordinal,prompt_snapshot,focus_snapshot,model_snapshot,explanation_snapshot,chosen_focus,answer_text,tense_correct,sentence_verdict');
 if(s.includes('const requestedListening=Number(req.body.question_count||10);'))return s;
 s=ensureReplace(s,"router.post('/listening/:slug/start',requireAuth,asyncRoute(async(req,res)=>{", "router.post('/listening/:slug/start',requireAuth,asyncRoute(async(req,res)=>{\n const requestedListening=Number(req.body.question_count||10);\n if(![4,8,12].includes(requestedListening))return message(res,400,'Jumlah soal tidak valid','Pilih 4, 8, atau 12 pertanyaan.');",'listening start');
 s=ensureReplace(s,'ORDER BY random() LIMIT 10\',[track.id]','ORDER BY random() LIMIT $2\',[track.id,requestedListening]','listening random question limit');
 return s;
});
await edit('src/views/translation/feedback.ejs',s=>{
 if(s.includes('Koreksi dengan AI'))return s;
 const marker='<div class="d-flex flex-wrap gap-2"><% if(run.status';
 return ensureReplace(s,marker,'<div class="d-flex flex-wrap gap-2 mb-3"><a class="btn btn-outline-primary" href="/translation/ai/item/<%= item.id %>">Koreksi dengan AI</a></div>\n '+marker,'translation feedback buttons');
});
await edit('src/views/translation/result.ejs',s=>{
 if(s.includes('/translation/ai/item/'))return s;
 const marker='<p class="mb-0"><span class="muted">Contoh:</span> <%= item.model_snapshot %></p>';
 return ensureReplace(s,marker,marker+'<p class="mt-2 mb-0"><a class="btn btn-sm btn-outline-primary" href="/translation/ai/item/<%= item.id %>">Lihat / minta koreksi AI</a></p>','translation result row');
});
await edit('src/views/listening/index.ejs',s=>{
 s=s.replace('Rekaman awal disintesis secara offline dari naskah orisinal; soal dan transkrip dapat dilihat setelah sesi selesai.','Dengarkan audio percakapan, lalu jawab pertanyaan. Transkrip tersedia setelah sesi selesai. Sumber rekaman ditampilkan pada hasil.');
 if(s.includes('name="question_count"'))return s;
 const marker='<% if(user){ %><button class="btn btn-brand w-100">';
 return ensureReplace(s,marker,'<% if(user){ %><label class="small fw-semibold" for="count-<%= t.id %>">Jumlah soal</label><select id="count-<%= t.id %>" name="question_count" class="form-select mb-2"><option value="4">4 soal</option><option value="8" <%= t.question_count>=8?\'selected\':\'disabled\' %>>8 soal</option><option value="12" <%= t.question_count>=12?\'selected\':\'disabled\' %>>12 soal</option></select><button class="btn btn-brand w-100">','listening select questions');
});
await edit('package.json',s=>{
 const p=JSON.parse(s);
 p.scripts['db:migrate:writing-ai']='node scripts/migrate-writing-ai.js';
 p.scripts['db:seed:writing-listening']='node scripts/seed-writing-listening.js';
 p.scripts['patch:writing-ai']='node scripts/apply-writing-ai-integration.js';
 p.scripts['qa:writing-listening']='python3 scripts/qa-writing-listening.py';
 if(!p.scripts.check.includes('src/routes/ai-writing.js'))p.scripts.check+=' && node --check src/routes/ai-writing.js && node --check src/services/ai-writing.js && node --check scripts/seed-writing-listening.js';
 return JSON.stringify(p,null,2)+'\n';
});
await edit('.env.example',s=>s.includes('AI_GRADING_MODEL=')?s:s+'\n# Optional OpenAI API writing feedback (never expose in frontend)\nOPENAI_API_KEY=\nAI_GRADING_MODEL=gpt-4.1-mini\n');
console.log(`Integration OK. Changed ${writes} file(s). Backups: ${backup}`);
