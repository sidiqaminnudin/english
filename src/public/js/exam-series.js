const form=document.querySelector('[data-exam-deadline]');
if(form){
 const deadline=new Date(form.dataset.examDeadline).getTime();
 const timer=document.createElement('p');timer.setAttribute('role','timer');form.prepend(timer);
 let sent=false;
 setInterval(()=>{const seconds=Math.max(0,Math.ceil((deadline-Date.now())/1000));timer.textContent=`Sisa waktu: ${Math.floor(seconds/60)}:${String(seconds%60).padStart(2,'0')}`;if(!seconds&&!sent){sent=true;form.requestSubmit(form.querySelector('[value="submit"]'));}},1000);
 for(const select of form.querySelectorAll('select')){const text=document.getElementById(select.id.replace('focus-','text-'));const update=()=>{text.readOnly=!select.value;};select.addEventListener('change',update);update();}
}
