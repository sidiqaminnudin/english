import assert from 'node:assert/strict';
import {readFileSync} from 'node:fs';
import bank from '../db/supplemental-bank.js';
import {selectFinalQuestions} from '../src/services/question-selection.js';
const load=name=>JSON.parse(readFileSync(new URL('../db/'+name,import.meta.url),'utf8'));
const old=[...load('pronouns_bank.json'),...load('expanded_bank.json')];
assert.equal(bank.length,100);
for(const module of ['pronouns','simple-present'])assert.equal(bank.filter(q=>q.module_slug===module).length,50);
const stems=new Set(old.map(q=>q.stem.trim().toLowerCase())),codes=new Set(old.map(q=>q.code));
const lessons=new Set(old.map(q=>q.lesson_slug));
for(const q of bank){
 assert(!codes.has(q.code));codes.add(q.code);
 assert(!stems.has(q.stem.trim().toLowerCase()),q.stem);stems.add(q.stem.trim().toLowerCase());
 assert(lessons.has(q.lesson_slug),q.lesson_slug);
 assert.equal(q.options.length,4);assert.equal(new Set(q.options).size,4);
 assert(Number.isInteger(q.correct_index)&&q.correct_index>=0&&q.correct_index<4);
 assert(q.explanation.length>10);
}
const ids=Array.from({length:55},(_,i)=>String(i+1));
const rows=ids.flatMap(lesson_id=>Array.from({length:3},(_,i)=>({id:`${lesson_id}-${i}`,lesson_id})));
for(let i=0;i<100;i++){
 const selected=selectFinalQuestions(rows,ids);
 assert.equal(selected.length,60);assert.equal(new Set(selected.map(q=>q.id)).size,60);
 assert.equal(new Set(selected.map(q=>q.lesson_id)).size,55);
 for(const id of ids)assert(selected.filter(q=>q.lesson_id===id).length<=2);
}
assert.deepEqual(selectFinalQuestions([],ids),[]);
assert.deepEqual(selectFinalQuestions(rows.slice(3),ids),[]);
assert.deepEqual(selectFinalQuestions(rows,[]),[]);
assert.deepEqual(selectFinalQuestions(rows,Array.from({length:61},(_,i)=>String(i))),[]);
assert.deepEqual(selectFinalQuestions(rows.filter(q=>q.id.endsWith('-0')),ids),[]);
console.log('PASS: 100 new questions; final exam 60 unique questions covering 55 lessons; insufficient pools rejected.');
