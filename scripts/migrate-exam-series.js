import {readFileSync} from 'node:fs';
import {pool} from '../src/db.js';
try{await pool.query(readFileSync(new URL('../db/006_exam_series.sql',import.meta.url),'utf8'));console.log('Exam series migration applied.');}finally{await pool.end();}
