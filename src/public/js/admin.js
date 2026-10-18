(()=>{
const moduleSel=document.querySelector('#module_id'),lessonSel=document.querySelector('#lesson_id');if(!moduleSel||!lessonSel)return;
function filter(){const moduleId=moduleSel.value;[...lessonSel.options].forEach(o=>{if(o.value)o.hidden=o.dataset.moduleId!==moduleId;});const selected=lessonSel.selectedOptions[0];if(selected&&selected.hidden)lessonSel.value='';}
moduleSel.addEventListener('change',filter);filter();
})();
