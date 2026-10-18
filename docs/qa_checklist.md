# Preproduction QA checklist

## Database (must pass on Debian/PostgreSQL)
- [ ] `npm run db:init` succeeds (tables exist, foreign keys work)
- [ ] `npm run db:seed` prints 13 modules, 7 Pronouns lessons, 105 questions
- [ ] Running `npm run db:seed` a second time does **not** duplicate questions
- [ ] Run `npm run db:seed:extra`; 12 more modules, 48 lessons and 1,200 new questions appear
- [ ] Run `npm run db:seed:extra` again and confirm no duplicates, no overwritten admin edits
- [ ] Run the SQL checks below and verify 1,305 total, 55 lessons, one correct choice per question

```sql
SELECT COUNT(*) AS total_questions FROM questions; -- expected 1,305 on clean installation
SELECT COUNT(*) AS total_lessons FROM lessons; -- expected 55 on clean installation
SELECT m.slug,COUNT(DISTINCT l.id) lessons,COUNT(DISTINCT q.id) questions
FROM modules m LEFT JOIN lessons l ON l.module_id=m.id
LEFT JOIN questions q ON q.module_id=m.id GROUP BY m.id ORDER BY m.sort_order;
SELECT l.title,COUNT(q.id) AS question_count FROM lessons l LEFT JOIN questions q ON q.lesson_id=l.id
JOIN modules m ON m.id=l.module_id WHERE m.slug='pronouns' GROUP BY l.title ORDER BY l.title;
SELECT q.code,COUNT(*) FILTER(WHERE o.is_correct) AS correct_options
FROM questions q JOIN question_options o ON q.id=o.question_id
GROUP BY q.id HAVING COUNT(*)<>4 OR COUNT(*) FILTER(WHERE o.is_correct)<>1;
-- Last query should return 0 rows.
```

## Access & security
- [ ] Guest can see public course and each Pronouns lesson, not dashboard/exam.
- [ ] Registration creates student only (not admin) and rejects duplicate usernames.
- [ ] Login rejects incorrect credentials; logout invalidates session.
- [ ] GET /admin and admin POST endpoints are blocked for students.
- [ ] CSRF missing/incorrect on form & AJAX POST returns 403.
- [ ] Attempt URLs are owned by user; users cannot open another student's result.
- [ ] Admin Markdown with raw HTML is escaped, not executed.

## Practice
- [ ] 10 MCQ from bank per new session, options shuffled.
- [ ] One lesson practice picks ONLY corresponding lesson questions (15 Pronouns; 25 others).
- [ ] Feedback gives correctness and Indonesian explanation immediately.
- [ ] Score shown only when session submitted, answers retained after refresh.
- [ ] Refresh does not create new attempt or new options.

## Exam
- [ ] Exam takes configured number, time, and passing score.
- [ ] Correct option is absent from HTML and from JSON response before completion.
- [ ] Timer continues after refresh; expired exam cannot be answered.
- [ ] All answers are checked on server; score is correct/total*100.
- [ ] Exam result shows correct answer plus explanation **after** submit.
- [ ] Editing/deactivating a question does not retroactively change older result.

## Responsive and accessibility
- [ ] Check desktop at 1440×900, laptop 1024×768, mobile 390×844 and narrow 320×700.
- [ ] Mobile navbar toggles correctly, question options are touch-friendly.
- [ ] Sidebar lessons stacks above article on mobile.
- [ ] Admin tables horizontal-scroll without the page being broken.
- [ ] Contrast, keyboard tab order, form labels, and error text are usable.

## Expansion editorial quality
- [ ] Spot-check randomly selected questions from each of the 12 additional modules, including intended answer and distractors.
- [ ] Check alternatives and variations (e.g. British/American usage), particularly wording of grammar questions.
- [ ] Confirm sample exam results from all 13 modules under a real PostgreSQL-backed login.
- [ ] Confirm accessibility and responsive design when module titles are long.
