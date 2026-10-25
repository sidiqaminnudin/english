import 'dotenv/config';
import {readFile} from 'node:fs/promises';
import {pool} from '../src/db.js';
try {
 const sql=await readFile(new URL('../db/005_writing_ai.sql',import.meta.url),'utf8');
 await pool.query(sql);
 console.log('Applied writing AI migration (additive/idempotent).');
} finally {await pool.end();}
