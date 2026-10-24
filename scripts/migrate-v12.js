import 'dotenv/config';
import {readFile} from 'node:fs/promises';
import {pool} from '../src/db.js';
try {
 if(!process.env.DATABASE_URL) throw Error('DATABASE_URL wajib tersedia di .env');
 const sql=await readFile(new URL('../db/004_v12_skills.sql',import.meta.url),'utf8');
 await pool.query(sql);
 console.log('EnglishLab v1.2 additive database migration OK');
} finally {await pool.end();}
