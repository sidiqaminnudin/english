# Local v1.2 integration report

## Applied
Selective integration of the additive migration, four v1.2 datasets, seed/migration scripts, skills router, translation/listening templates and JavaScript, and eight MP3 files. Existing navigation and CSS were merged, not replaced. Existing MCQ routes, accounts, datasets, autosave, and history table fixes were not overwritten.

Patch corrections: keep PostgreSQL BIGINT identifiers as strings; validate route identifiers; require authentication for translation/listening; disable caching on skill pages; validate every listening selection strictly; make admin review transactional with conflict detection. QA Python launcher supports Windows and Linux with UTF-8.

## Executed locally
- `node scripts/backup-v12.js`: pg_dump custom archive created and pg_restore --list succeeded. This verifies archive readability, not a full restore rehearsal.
- Backup: `D:\He3x\english\backups\before-v12-1792822900964.dump` (ignored by Git).
- `npm run db:migrate:v12`: passed.
- `npm run db:seed:v12` twice: first added 198 MCQs, 74 translations, 32 listening questions; second added zero for all three.
- `node scripts/verify-v12.js`: hashes of every baseline record in users, courses, modules, lessons, questions, question_options, attempts and attempt_items unchanged.
- Counts: users 3, courses 1, modules 21, lessons 79, questions 1503, question_options 6012, attempts 4, attempt_items 55, translation_prompts 74, listening_tracks 8, listening_questions 32.
- `npm run check`, `npm run qa:all`, `npm run qa:v12`, `node scripts/test-attempt-autosave.js`: passed.
- `node scripts/smoke-v12.js`: public courses/old and new lessons returned 200; anonymous practice/exam/skills/history/admin-review redirected to login; missing CSRF rejected with 403; local MP3 byte range returned 206 and audio/mpeg.

## Outstanding acceptance work — not production certified
No real-browser/mobile visual or keyboard smoke test performed. Authenticated student flow, cross-student IDOR, accepted variants, admin review result changes, concurrent submissions and forced rollback tests have NOT been executed. Seed idempotency logs were checked, but full-table snapshots between the two seed runs were not captured. No Nginx or systemd deployment was changed or tested. No production database was migrated. CRUD and CSV/XLSX imports remain a separate phase, not implemented.

Before deployment run authenticated acceptance tests on isolated staging, including intentional failures and concurrent requests. Verify full restore from backup there. Confirm real service name before restarting; do not assume english-lms.service. Audio contains synthetic eSpeak voices, not native-speaker recordings.
