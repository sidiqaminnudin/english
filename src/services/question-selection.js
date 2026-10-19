export function shuffle(values){const a=[...values];for(let i=a.length-1;i>0;i--){const j=Math.floor(Math.random()*(i+1));[a[i],a[j]]=[a[j],a[i]];}return a;}
export function selectFinalQuestions(rows,lessonIds,count=60){
 if(!lessonIds.length||lessonIds.length>count)return [];
 const groups=shuffle(lessonIds).map(id=>rows.filter(q=>String(q.lesson_id)===String(id)));
 if(groups.some(group=>!group.length))return [];
 const selected=[];
 while(selected.length<count){let added=false;for(const group of groups){if(selected.length===count)break;if(group.length){selected.push(group.shift());added=true;}}if(!added)return [];}
 return shuffle(selected);
}
