import assert from 'node:assert/strict';
import {readFile,readdir} from 'node:fs/promises';
import {pool} from '../src/db.js';
try{
 const files=(await readdir(new URL('../backups/',import.meta.url))).filter(x=>x.endsWith('.baseline.json')).sort();
 assert(files.length,'No backup baseline');
 const baseline=JSON.parse(await readFile(new URL('../backups/'+files.at(-1),import.meta.url),'utf8'));
 for(const [table,rows] of Object.entries(baseline)){
  const current=new Map((await pool.query(`SELECT id,md5(row_to_json(t)::text) hash FROM ${table} t ORDER BY id`)).rows.map(r=>[r.id,r.hash]));
  for(const row of rows)assert.equal(current.get(row.id),row.hash,`${table} legacy row ${row.id} changed`);
  console.log(`PASS unchanged legacy ${table}: ${rows.length}; current: ${current.size}`);
 }
 for(const table of ['translation_prompts','listening_tracks','listening_questions'])console.log(table,(await pool.query(`SELECT count(*) FROM ${table}`)).rows[0].count);
}finally{await pool.end();}
