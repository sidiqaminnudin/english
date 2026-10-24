document.addEventListener('DOMContentLoaded',()=>{
 const focus=document.getElementById('grammarFocus'),tense=document.getElementById('stepTense'),write=document.getElementById('stepEnglish'),next=document.getElementById('nextWriting'),change=document.getElementById('changeFocus'),label=document.getElementById('chosenFocusLabel'),answer=document.getElementById('englishAnswer');
 if(!focus)return;
 next.addEventListener('click',()=>{if(!focus.value){focus.reportValidity();return;}label.textContent=focus.options[focus.selectedIndex].text;tense.classList.add('d-none');write.classList.remove('d-none');answer.focus();});
 change.addEventListener('click',()=>{write.classList.add('d-none');tense.classList.remove('d-none');focus.focus();});
});
