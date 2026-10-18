import 'dotenv/config';
import {Pool} from 'pg';
import {readFile} from 'node:fs/promises';
const pool=new Pool({connectionString:process.env.DATABASE_URL});
try { const sql=await readFile(new URL('../db/001_schema.sql',import.meta.url),'utf8'); await pool.query(sql); console.log('Schema created.'); }
finally { await pool.end(); }
