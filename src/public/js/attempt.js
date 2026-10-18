(()=>{
 const app=document.querySelector('#assessment');if(!app)return;
 const panels=[...app.querySelectorAll('.question-panel')],prev=document.querySelector('#prevQuestion'),next=document.querySelector('#nextQuestion'),finish=document.querySelector('#finishButton'),submit=document.querySelector('#submitAttempt');
 const counter=document.querySelector('#questionCounter'),answered=document.querySelector('#answeredCounter'),progress=document.querySelector('#questionProgress'),status=document.querySelector('#saveStatus');
 const csrf=app.dataset.csrf,mode=app.dataset.mode,id=app.dataset.attemptId;
 let current=0,submitting=false;const pending=new Set();
 function render(){panels.forEach((p,i)=>p.classList.toggle('d-none',i!==current));counter.textContent=`Question ${current+1} / ${panels.length}`;progress.style.width=`${(current+1)/panels.length*100}%`;prev.disabled=current===0;next.classList.toggle('d-none',current===panels.length-1);finish.classList.toggle('d-none',current!==panels.length-1);answered.textContent=`${panels.filter(p=>p.dataset.saved).length} / ${panels.length} terjawab`;}
 panels.forEach(p=>p.querySelectorAll('input[type=radio]').forEach(input=>input.addEventListener('change',()=>{
  p.querySelectorAll('.answer-option').forEach(label=>label.classList.toggle('is-selected',label.querySelector('input').checked));
  status.textContent='Menyimpan jawaban…';
  const request=fetch(`/attempts/${encodeURIComponent(id)}/answer`,{method:'POST',headers:{'Content-Type':'application/json','x-csrf-token':csrf},credentials:'same-origin',body:JSON.stringify({itemId:p.dataset.itemId,optionId:input.value})})
   .then(async r=>{const data=await r.json();if(!r.ok)throw Error(data.error||'Gagal menyimpan');p.dataset.saved=input.value;answered.textContent=`${panels.filter(x=>x.dataset.saved).length} / ${panels.length} terjawab`;status.textContent='Jawaban berhasil disimpan.';
    if(mode==='practice'){const feedback=p.querySelector('.answer-feedback');feedback.classList.toggle('bad',!data.correct);feedback.textContent=(data.correct?'✓ Benar. ':'✕ Belum tepat. ')+data.explanation;}
   }).catch(err=>{status.textContent=`Gagal menyimpan: ${err.message}. Pilih ulang jawaban atau segarkan halaman.`;});
  pending.add(request);request.finally(()=>pending.delete(request));
 })));
 prev.addEventListener('click',()=>{current=Math.max(current-1,0);render();window.scrollTo({top:100,behavior:'smooth'});});
 next.addEventListener('click',()=>{current=Math.min(current+1,panels.length-1);render();window.scrollTo({top:100,behavior:'smooth'});});
 submit.addEventListener('submit',async event=>{if(submitting)return;event.preventDefault();const unanswered=panels.filter(p=>!p.dataset.saved).length;if(unanswered&&!window.confirm(`${unanswered} soal belum dijawab. Yakin ingin selesai?`))return;submitting=true;finish.disabled=true;status.textContent='Memastikan semua jawaban telah disimpan…';await Promise.allSettled([...pending]);submit.submit();});
 const pill=document.querySelector('#examTimer'),timer=document.querySelector('#timerValue');
 if(mode==='exam'){
  const deadline=Date.parse(pill.dataset.deadline);
  function tick(){const remaining=Math.max(0,Math.ceil((deadline-Date.now())/1000)),m=Math.floor(remaining/60),s=remaining%60;timer.textContent=`${String(m).padStart(2,'0')}:${String(s).padStart(2,'0')}`;pill.classList.toggle('time-low',remaining<=120);if(remaining===0){if(!submitting){submitting=true;status.textContent='Waktu habis. Mengirim jawaban…';Promise.allSettled([...pending]).then(()=>submit.submit());}clearInterval(interval);}}
  const interval=setInterval(tick,1000);tick();
 }
 render();
})();
