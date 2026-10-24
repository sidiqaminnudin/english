import 'dotenv/config';
import {mkdirSync,statSync,writeFileSync} from 'node:fs';
import {spawnSync} from 'node:child_process';
import path from 'node:path';
import {pool} from '../src/db.js';
const directory=path.resolve('backups');mkdirSync(directory,{recursive:true});
const file=path.join(directory,`before-v12-${Date.now()}.dump`);
const url=new URL(process.env.DATABASE_URL);
const env={...process.env,PGPASSWORD:decodeURIComponent(url.password)};
try{
 const args=['--no-password','-Fc','-h',url.hostname,'-p',url.port||'5432','-U',decodeURIComponent(url.username),'-d',url.pathname.slice(1),'-f',file];
 const dump=spawnSync('pg_dump',args,{env,encoding:'utf8'});
 if(dump.status!==0)throw Error('pg_dump failed; migration must not proceed.');
 const verify=spawnSync('pg_restore',['--list',file],{encoding:'utf8'});
 if(verify.status!==0||statSync(file).size===0)throw Error('Backup verification failed.');
 const baseline={};
 for(const table of ['users','courses','modules','lessons','questions','question_options','attempts','attempt_items']){
  baseline[table]=(await pool.query(`SELECT id,md5(row_to_json(t)::text) hash FROM ${table} t ORDER BY id`)).rows;
 }
 writeFileSync(file+'.baseline.json',JSON.stringify(baseline));
 console.log('Verified backup:',file);
 console.log('Baseline counts:',Object.fromEntries(Object.entries(baseline).map(([k,v])=>[k,v.length])));
}finally{await pool.end();}
