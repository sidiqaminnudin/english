import 'dotenv/config';
import {Pool} from 'pg';
import {readFile} from 'node:fs/promises';

if (!process.env.DATABASE_URL) throw new Error('DATABASE_URL wajib diatur di .env');
const pool = new Pool({connectionString:process.env.DATABASE_URL});
try {
  const {rows} = await pool.query(`SELECT COUNT(*)::int AS n FROM modules WHERE slug <> 'pronouns'`);
  if (rows[0].n < 12) {
    throw new Error('Modul dasar belum ada. Jalankan npm run db:init dan npm run db:seed terlebih dahulu.');
  }
  const sql = await readFile(new URL('../db/003_expanded_curriculum.sql',import.meta.url),'utf8');
  // SQL seed owns its BEGIN / COMMIT. Existing admin revisions are left unchanged.
  await pool.query(sql);
  const stats=await pool.query(`SELECT m.slug,m.is_published,COUNT(DISTINCT l.id)::int AS lessons,
   COUNT(DISTINCT q.id)::int AS questions
   FROM modules m LEFT JOIN lessons l ON l.module_id=m.id
   LEFT JOIN questions q ON q.module_id=m.id
   WHERE m.slug <> 'pronouns' GROUP BY m.id ORDER BY m.sort_order`);
  for (const row of stats.rows) {
    console.log(`${row.is_published?'PUBLIC':'DRAFT '} ${row.slug.padEnd(24)} ${row.lessons} lessons / ${row.questions} questions`);
  }
  console.log('Seed lanjutan selesai. Soal dan materi yang sudah ada tidak ditimpa.');
} finally {
  await pool.end();
}
