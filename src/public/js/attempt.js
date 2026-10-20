(()=>{
 const app=document.querySelector('#assessment');if(!app)return;
 const panels=[...app.querySelectorAll('.question-panel')],prev=document.querySelector('#prevQuestion'),next=document.querySelector('#nextQuestion'),finish=document.querySelector('#finishButton'),submit=document.querySelector('#submitAttempt');
 const counter=document.querySelector('#questionCounter'),answered=document.querySelector('#answeredCounter'),progress=document.querySelector('#questionProgress'),status=document.querySelector('#saveStatus');
 const csrf=app.dataset.csrf,mode=app.dataset.mode,id=app.dataset.attemptId;
 let current=0,submitting=false,worker=null,retryTimer=null,failures=0,blocked='';
 const queue=new Map(),storageKey=`assessment-pending:${id}`;
 function persist(){try{if(queue.size)localStorage.setItem(storageKey,JSON.stringify(Object.fromEntries(queue)));else localStorage.removeItem(storageKey);}catch{}}
 function updateStatus(){
  answered.textContent=`${panels.filter(p=>p.dataset.saved).length} / ${panels.length} tersimpan di server`;
  status.textContent=blocked|| (queue.size?`${queue.size} jawaban belum tersimpan di server. ${navigator.onLine===false?'Koneksi terputus; akan dicoba saat online.':'Menyimpan / mencoba ulang otomatis…'}`:'Semua pilihan berhasil tersimpan di server.');
 }
 async function drain(){
  while(queue.size&&!blocked&&navigator.onLine!==false){
   const [itemId,optionId]=queue.entries().next().value;
   try{
    const response=await fetch(`/attempts/${encodeURIComponent(id)}/answer`,{method:'POST',headers:{'Content-Type':'application/json','x-csrf-token':csrf},credentials:'same-origin',body:JSON.stringify({itemId,optionId})});
    if(response.redirected||[400,401,403,404,409].includes(response.status)){
     blocked=response.status===409?'Sesi sudah berakhir. Jawaban tertunda tidak dapat diterima setelah batas waktu.':'Penyimpanan ditolak. Pastikan sesi login masih aktif lalu muat ulang halaman; pilihan tertunda tetap disimpan di browser.';
     break;
    }
    if(!response.ok)throw Error('Gagal menyimpan');
    const data=await response.json();if(data.saved!==true)throw Error('Server belum mengonfirmasi');
    const panel=panels.find(p=>p.dataset.itemId===itemId);
    panel.dataset.saved=optionId;failures=0;
    if(queue.get(itemId)===optionId){
     queue.delete(itemId);
     if(mode==='practice'){const feedback=panel.querySelector('.answer-feedback');feedback.classList.toggle('bad',!data.correct);feedback.textContent=(data.correct?'✓ Benar. ':'✕ Belum tepat. ')+data.explanation;}
    }
    persist();updateStatus();
   }catch{failures++;break;}
  }
 }
 function flush(){
  if(worker)return worker;
  clearTimeout(retryTimer);
  worker=drain().finally(()=>{
   worker=null;updateStatus();
   if(queue.size&&!blocked)retryTimer=setTimeout(flush,Math.min(30000,1000*2**Math.min(failures,5)));
  });
  return worker;
 }
 try{
  const restored=JSON.parse(localStorage.getItem(storageKey)||'{}');
  panels.forEach(p=>{const value=restored[p.dataset.itemId];if(typeof value!=='string')return;
   const input=[...p.querySelectorAll('input[type=radio]')].find(i=>i.value===value);
   if(input){input.checked=true;queue.set(p.dataset.itemId,value);p.querySelectorAll('.answer-option').forEach(label=>label.classList.toggle('is-selected',label.querySelector('input').checked));}
  });
 }catch{}
 window.addEventListener('online',()=>{failures=0;flush();});
 window.addEventListener('offline',updateStatus);
 window.addEventListener('beforeunload',event=>{if(queue.size){persist();event.preventDefault();event.returnValue='';}});
 function render(){panels.forEach((p,i)=>p.classList.toggle('d-none',i!==current));counter.textContent=`Question ${current+1} / ${panels.length}`;progress.style.width=`${(current+1)/panels.length*100}%`;prev.disabled=current===0;next.classList.toggle('d-none',current===panels.length-1);finish.classList.toggle('d-none',current!==panels.length-1);updateStatus();}
 panels.forEach(p=>p.querySelectorAll('input[type=radio]').forEach(input=>input.addEventListener('change',()=>{
  p.querySelectorAll('.answer-option').forEach(label=>label.classList.toggle('is-selected',label.querySelector('input').checked));
  queue.set(p.dataset.itemId,input.value);persist();flush();
 })));
 prev.addEventListener('click',()=>{current=Math.max(current-1,0);render();window.scrollTo({top:100,behavior:'smooth'});});
 next.addEventListener('click',()=>{current=Math.min(current+1,panels.length-1);render();window.scrollTo({top:100,behavior:'smooth'});});
 submit.addEventListener('submit',async event=>{event.preventDefault();if(submitting)return;const unanswered=panels.filter(p=>!p.dataset.saved&&!queue.has(p.dataset.itemId)).length;if(unanswered&&!window.confirm(`${unanswered} soal belum dijawab. Yakin ingin selesai?`))return;submitting=true;finish.disabled=true;status.textContent='Memastikan semua jawaban telah disimpan…';failures=0;await flush();if(queue.size){submitting=false;finish.disabled=false;status.textContent=`Masih ada ${queue.size} jawaban belum tersimpan. Periksa koneksi lalu tekan Selesaikan lagi.`;return;}try{localStorage.removeItem(storageKey);}catch{}submit.submit();});
 const pill=document.querySelector('#examTimer'),timer=document.querySelector('#timerValue');
 if(mode==='exam'){
  const deadline=Date.parse(pill.dataset.deadline);
  function tick(){const remaining=Math.max(0,Math.ceil((deadline-Date.now())/1000)),m=Math.floor(remaining/60),s=remaining%60;timer.textContent=`${String(m).padStart(2,'0')}:${String(s).padStart(2,'0')}`;pill.classList.toggle('time-low',remaining<=120);if(remaining===0){if(!submitting){submitting=true;status.textContent='Waktu habis. Mengirim jawaban…';flush().then(()=>submit.submit()); clearTimeout(retryTimer); blocked='Waktu ujian habis. Hanya jawaban yang sudah diterima server yang dapat dinilai.'; persist();updateStatus();}clearInterval(interval);}}
  const interval=setInterval(tick,1000);tick();
 }
 render();
 if(queue.size)flush();
})();
