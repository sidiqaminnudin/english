document.addEventListener('DOMContentLoaded',()=>{
 const audio=document.getElementById('trackAudio');if(!audio)return;
 document.querySelectorAll('[data-audio-speed]').forEach(btn=>btn.addEventListener('click',()=>{audio.playbackRate=Number(btn.dataset.audioSpeed);document.querySelectorAll('[data-audio-speed]').forEach(b=>b.classList.toggle('active',b===btn));}));
 document.querySelectorAll('.answer-option input').forEach(input=>input.addEventListener('change',()=>{document.querySelectorAll('input[name="'+input.name+'"]').forEach(r=>r.closest('label').classList.toggle('is-selected',r.checked));}));
});
