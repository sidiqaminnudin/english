-- Seed bank soal Pronouns (105 pertanyaan, 7 subtopik, 3 level).
-- Jalankan sesudah db:init dan seed course/modul/lesson.
BEGIN;
WITH inserted AS (
  INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
  SELECT 'PRO-SUBJ-001',m.id,l.id,'___ am learning English today.','easy','I adalah subject pronoun orang pertama tunggal.'
  FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='subject-pronouns' WHERE m.slug='pronouns'
  ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, opts.body, opts.correct, opts.idx FROM inserted
CROSS JOIN (VALUES ('Mine',FALSE,0),('I',TRUE,1),('Me',FALSE,2),('My',FALSE,3)) AS opts(body,correct,idx);
WITH inserted AS (
  INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
  SELECT 'PRO-SUBJ-002',m.id,l.id,'___ is my brother, Alex.','easy','He dipakai sebagai subjek laki-laki tunggal.'
  FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='subject-pronouns' WHERE m.slug='pronouns'
  ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, opts.body, opts.correct, opts.idx FROM inserted
CROSS JOIN (VALUES ('His',FALSE,0),('Himself',FALSE,1),('He',TRUE,2),('Him',FALSE,3)) AS opts(body,correct,idx);
WITH inserted AS (
  INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
  SELECT 'PRO-SUBJ-003',m.id,l.id,'Anna is a nurse. ___ works at a hospital.','easy','She menggantikan Anna sebagai subjek.'
  FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='subject-pronouns' WHERE m.slug='pronouns'
  ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, opts.body, opts.correct, opts.idx FROM inserted
CROSS JOIN (VALUES ('Her',FALSE,0),('Hers',FALSE,1),('They',FALSE,2),('She',TRUE,3)) AS opts(body,correct,idx);
WITH inserted AS (
  INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
  SELECT 'PRO-SUBJ-004',m.id,l.id,'My friends are here. ___ are waiting outside.','easy','They menggantikan friends (jamak) sebagai subjek.'
  FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='subject-pronouns' WHERE m.slug='pronouns'
  ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, opts.body, opts.correct, opts.idx FROM inserted
CROSS JOIN (VALUES ('They',TRUE,0),('Them',FALSE,1),('Their',FALSE,2),('It',FALSE,3)) AS opts(body,correct,idx);
WITH inserted AS (
  INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
  SELECT 'PRO-SUBJ-005',m.id,l.id,'My sister and I are ready. ___ can start now.','easy','We mencakup pembicara dan orang lain sebagai subjek.'
  FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='subject-pronouns' WHERE m.slug='pronouns'
  ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, opts.body, opts.correct, opts.idx FROM inserted
CROSS JOIN (VALUES ('Them',FALSE,0),('We',TRUE,1),('Us',FALSE,2),('Our',FALSE,3)) AS opts(body,correct,idx);
WITH inserted AS (
  INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
  SELECT 'PRO-SUBJ-006',m.id,l.id,'The laptop is new. ___ works very well.','medium','It adalah pronoun untuk satu benda.'
  FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='subject-pronouns' WHERE m.slug='pronouns'
  ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, opts.body, opts.correct, opts.idx FROM inserted
CROSS JOIN (VALUES ('Him',FALSE,0),('They',FALSE,1),('It',TRUE,2),('He',FALSE,3)) AS opts(body,correct,idx);
WITH inserted AS (
  INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
  SELECT 'PRO-SUBJ-007',m.id,l.id,'___ are my English teacher, Mr. David.','medium','You berfungsi sebagai subjek orang yang diajak bicara.'
  FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='subject-pronouns' WHERE m.slug='pronouns'
  ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, opts.body, opts.correct, opts.idx FROM inserted
CROSS JOIN (VALUES ('Your',FALSE,0),('Yours',FALSE,1),('Me',FALSE,2),('You',TRUE,3)) AS opts(body,correct,idx);
WITH inserted AS (
  INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
  SELECT 'PRO-SUBJ-008',m.id,l.id,'Mr. Lee drives to work. ___ leaves at seven.','medium','Mr. Lee menjadi subjek he.'
  FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='subject-pronouns' WHERE m.slug='pronouns'
  ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, opts.body, opts.correct, opts.idx FROM inserted
CROSS JOIN (VALUES ('He',TRUE,0),('Him',FALSE,1),('His',FALSE,2),('Them',FALSE,3)) AS opts(body,correct,idx);
WITH inserted AS (
  INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
  SELECT 'PRO-SUBJ-009',m.id,l.id,'The children look excited. ___ are going on a trip.','medium','Children bentuk jamak, gunakan they.'
  FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='subject-pronouns' WHERE m.slug='pronouns'
  ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, opts.body, opts.correct, opts.idx FROM inserted
CROSS JOIN (VALUES ('We',FALSE,0),('They',TRUE,1),('Their',FALSE,2),('Them',FALSE,3)) AS opts(body,correct,idx);
WITH inserted AS (
  INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
  SELECT 'PRO-SUBJ-010',m.id,l.id,'My mother and father are home. ___ are cooking dinner.','medium','Dua orang menjadi subject pronoun they.'
  FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='subject-pronouns' WHERE m.slug='pronouns'
  ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, opts.body, opts.correct, opts.idx FROM inserted
CROSS JOIN (VALUES ('He',FALSE,0),('Her',FALSE,1),('They',TRUE,2),('Them',FALSE,3)) AS opts(body,correct,idx);
WITH inserted AS (
  INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
  SELECT 'PRO-SUBJ-011',m.id,l.id,'The weather is beautiful. ___ is sunny today.','hard','It bisa menjadi subjek untuk weather.'
  FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='subject-pronouns' WHERE m.slug='pronouns'
  ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, opts.body, opts.correct, opts.idx FROM inserted
CROSS JOIN (VALUES ('They',FALSE,0),('He',FALSE,1),('We',FALSE,2),('It',TRUE,3)) AS opts(body,correct,idx);
WITH inserted AS (
  INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
  SELECT 'PRO-SUBJ-012',m.id,l.id,'___ are responsible for this assignment, Lisa and I.','hard','Lisa and I adalah we sebagai subjek.'
  FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='subject-pronouns' WHERE m.slug='pronouns'
  ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, opts.body, opts.correct, opts.idx FROM inserted
CROSS JOIN (VALUES ('We',TRUE,0),('Us',FALSE,1),('Them',FALSE,2),('Her',FALSE,3)) AS opts(body,correct,idx);
WITH inserted AS (
  INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
  SELECT 'PRO-SUBJ-013',m.id,l.id,'This is my friend Tim. ___ speaks three languages.','hard','He menjadi subjek yang menggantikan Tim.'
  FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='subject-pronouns' WHERE m.slug='pronouns'
  ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, opts.body, opts.correct, opts.idx FROM inserted
CROSS JOIN (VALUES ('His',FALSE,0),('He',TRUE,1),('Him',FALSE,2),('They',FALSE,3)) AS opts(body,correct,idx);
WITH inserted AS (
  INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
  SELECT 'PRO-SUBJ-014',m.id,l.id,'My uncle and aunt live nearby. ___ visit us often.','hard','Subjek untuk dua orang adalah they.'
  FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='subject-pronouns' WHERE m.slug='pronouns'
  ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, opts.body, opts.correct, opts.idx FROM inserted
CROSS JOIN (VALUES ('Their',FALSE,0),('It',FALSE,1),('They',TRUE,2),('Them',FALSE,3)) AS opts(body,correct,idx);
WITH inserted AS (
  INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
  SELECT 'PRO-SUBJ-015',m.id,l.id,'___ is the correct form: ''She runs'', not ''Her runs''.','hard','Sebelum kata kerja runs diperlukan subject pronoun she.'
  FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='subject-pronouns' WHERE m.slug='pronouns'
  ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, opts.body, opts.correct, opts.idx FROM inserted
CROSS JOIN (VALUES ('Her',FALSE,0),('Hers',FALSE,1),('Herself',FALSE,2),('She',TRUE,3)) AS opts(body,correct,idx);
WITH inserted AS (
  INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
  SELECT 'PRO-OBJE-001',m.id,l.id,'Please call ___ when you arrive.','easy','Setelah kata kerja call diperlukan object pronoun me.'
  FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='object-pronouns' WHERE m.slug='pronouns'
  ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, opts.body, opts.correct, opts.idx FROM inserted
CROSS JOIN (VALUES ('my',FALSE,0),('mine',FALSE,1),('me',TRUE,2),('I',FALSE,3)) AS opts(body,correct,idx);
WITH inserted AS (
  INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
  SELECT 'PRO-OBJE-002',m.id,l.id,'I saw Daniel yesterday. I greeted ___.','easy','Him sebagai objek dari greeted.'
  FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='object-pronouns' WHERE m.slug='pronouns'
  ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, opts.body, opts.correct, opts.idx FROM inserted
CROSS JOIN (VALUES ('he',FALSE,0),('his',FALSE,1),('himself',FALSE,2),('him',TRUE,3)) AS opts(body,correct,idx);
WITH inserted AS (
  INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
  SELECT 'PRO-OBJE-003',m.id,l.id,'Our teacher helped ___ with the lesson.','easy','Us adalah objek untuk we.'
  FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='object-pronouns' WHERE m.slug='pronouns'
  ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, opts.body, opts.correct, opts.idx FROM inserted
CROSS JOIN (VALUES ('us',TRUE,0),('we',FALSE,1),('our',FALSE,2),('ours',FALSE,3)) AS opts(body,correct,idx);
WITH inserted AS (
  INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
  SELECT 'PRO-OBJE-004',m.id,l.id,'Sarah is kind. Everyone likes ___.','easy','Her adalah objek kata kerja likes.'
  FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='object-pronouns' WHERE m.slug='pronouns'
  ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, opts.body, opts.correct, opts.idx FROM inserted
CROSS JOIN (VALUES ('herself',FALSE,0),('her',TRUE,1),('she',FALSE,2),('hers',FALSE,3)) AS opts(body,correct,idx);
WITH inserted AS (
  INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
  SELECT 'PRO-OBJE-005',m.id,l.id,'The dogs are hungry. Please feed ___.','easy','Them adalah objek untuk dogs.'
  FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='object-pronouns' WHERE m.slug='pronouns'
  ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, opts.body, opts.correct, opts.idx FROM inserted
CROSS JOIN (VALUES ('their',FALSE,0),('theirs',FALSE,1),('them',TRUE,2),('they',FALSE,3)) AS opts(body,correct,idx);
WITH inserted AS (
  INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
  SELECT 'PRO-OBJE-006',m.id,l.id,'Could you explain the rule to ___?','medium','Setelah preposition to gunakan me.'
  FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='object-pronouns' WHERE m.slug='pronouns'
  ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, opts.body, opts.correct, opts.idx FROM inserted
CROSS JOIN (VALUES ('I',FALSE,0),('my',FALSE,1),('mine',FALSE,2),('me',TRUE,3)) AS opts(body,correct,idx);
WITH inserted AS (
  INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
  SELECT 'PRO-OBJE-007',m.id,l.id,'I bought this book for ___.','medium','You dapat berfungsi sebagai objek.'
  FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='object-pronouns' WHERE m.slug='pronouns'
  ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, opts.body, opts.correct, opts.idx FROM inserted
CROSS JOIN (VALUES ('you',TRUE,0),('your',FALSE,1),('yours',FALSE,2),('yourself',FALSE,3)) AS opts(body,correct,idx);
WITH inserted AS (
  INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
  SELECT 'PRO-OBJE-008',m.id,l.id,'My father invited my brother and ___.','medium','Setelah invited gunakan me, bukan I.'
  FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='object-pronouns' WHERE m.slug='pronouns'
  ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, opts.body, opts.correct, opts.idx FROM inserted
CROSS JOIN (VALUES ('mine',FALSE,0),('me',TRUE,1),('I',FALSE,2),('my',FALSE,3)) AS opts(body,correct,idx);
WITH inserted AS (
  INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
  SELECT 'PRO-OBJE-009',m.id,l.id,'The manager spoke to Emma and ___.','medium','Setelah spoke to memerlukan him sebagai object pronoun.'
  FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='object-pronouns' WHERE m.slug='pronouns'
  ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, opts.body, opts.correct, opts.idx FROM inserted
CROSS JOIN (VALUES ('his',FALSE,0),('himself',FALSE,1),('him',TRUE,2),('he',FALSE,3)) AS opts(body,correct,idx);
WITH inserted AS (
  INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
  SELECT 'PRO-OBJE-010',m.id,l.id,'Please put the keys on the table. Do not lose ___.','medium','Keys jamak, objeknya them.'
  FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='object-pronouns' WHERE m.slug='pronouns'
  ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, opts.body, opts.correct, opts.idx FROM inserted
CROSS JOIN (VALUES ('they',FALSE,0),('their',FALSE,1),('theirs',FALSE,2),('them',TRUE,3)) AS opts(body,correct,idx);
WITH inserted AS (
  INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
  SELECT 'PRO-OBJE-011',m.id,l.id,'I do not know the answer. Can you tell ___?','hard','Tell me memerlukan object pronoun.'
  FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='object-pronouns' WHERE m.slug='pronouns'
  ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, opts.body, opts.correct, opts.idx FROM inserted
CROSS JOIN (VALUES ('me',TRUE,0),('I',FALSE,1),('mine',FALSE,2),('my',FALSE,3)) AS opts(body,correct,idx);
WITH inserted AS (
  INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
  SELECT 'PRO-OBJE-012',m.id,l.id,'Lucy is waiting for ___.','hard','Setelah for gunakan us.'
  FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='object-pronouns' WHERE m.slug='pronouns'
  ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, opts.body, opts.correct, opts.idx FROM inserted
CROSS JOIN (VALUES ('ours',FALSE,0),('us',TRUE,1),('we',FALSE,2),('our',FALSE,3)) AS opts(body,correct,idx);
WITH inserted AS (
  INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
  SELECT 'PRO-OBJE-013',m.id,l.id,'The cat looks tired. Let''s leave ___ alone.','hard','It sebagai objek untuk cat tunggal.'
  FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='object-pronouns' WHERE m.slug='pronouns'
  ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, opts.body, opts.correct, opts.idx FROM inserted
CROSS JOIN (VALUES ('they',FALSE,0),('their',FALSE,1),('it',TRUE,2),('its',FALSE,3)) AS opts(body,correct,idx);
WITH inserted AS (
  INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
  SELECT 'PRO-OBJE-014',m.id,l.id,'The teacher asked Tom and ___ to stay.','hard','Her dipakai sebagai objek ask.'
  FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='object-pronouns' WHERE m.slug='pronouns'
  ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, opts.body, opts.correct, opts.idx FROM inserted
CROSS JOIN (VALUES ('she',FALSE,0),('hers',FALSE,1),('herself',FALSE,2),('her',TRUE,3)) AS opts(body,correct,idx);
WITH inserted AS (
  INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
  SELECT 'PRO-OBJE-015',m.id,l.id,'Between you and ___, this is difficult.','hard','Setelah preposition between, gunakan me.'
  FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='object-pronouns' WHERE m.slug='pronouns'
  ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, opts.body, opts.correct, opts.idx FROM inserted
CROSS JOIN (VALUES ('me',TRUE,0),('I',FALSE,1),('my',FALSE,2),('mine',FALSE,3)) AS opts(body,correct,idx);
WITH inserted AS (
  INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
  SELECT 'PRO-POSS-001',m.id,l.id,'This is ___ pencil. (I)','easy','My adalah possessive adjective sebelum noun pencil.'
  FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='possessive-pronouns' WHERE m.slug='pronouns'
  ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, opts.body, opts.correct, opts.idx FROM inserted
CROSS JOIN (VALUES ('me',FALSE,0),('myself',FALSE,1),('my',TRUE,2),('mine',FALSE,3)) AS opts(body,correct,idx);
WITH inserted AS (
  INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
  SELECT 'PRO-POSS-002',m.id,l.id,'The red backpack is ___. (she)','easy','Hers adalah possessive pronoun tanpa noun setelahnya.'
  FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='possessive-pronouns' WHERE m.slug='pronouns'
  ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, opts.body, opts.correct, opts.idx FROM inserted
CROSS JOIN (VALUES ('her',FALSE,0),('she',FALSE,1),('herself',FALSE,2),('hers',TRUE,3)) AS opts(body,correct,idx);
WITH inserted AS (
  INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
  SELECT 'PRO-POSS-003',m.id,l.id,'Is this ___ notebook? (you)','easy','Your dipakai tepat sebelum notebook.'
  FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='possessive-pronouns' WHERE m.slug='pronouns'
  ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, opts.body, opts.correct, opts.idx FROM inserted
CROSS JOIN (VALUES ('your',TRUE,0),('yours',FALSE,1),('you',FALSE,2),('yourself',FALSE,3)) AS opts(body,correct,idx);
WITH inserted AS (
  INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
  SELECT 'PRO-POSS-004',m.id,l.id,'Those seats are ___. (we)','easy','Ours berdiri sendiri tanpa noun.'
  FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='possessive-pronouns' WHERE m.slug='pronouns'
  ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, opts.body, opts.correct, opts.idx FROM inserted
CROSS JOIN (VALUES ('we',FALSE,0),('ours',TRUE,1),('our',FALSE,2),('us',FALSE,3)) AS opts(body,correct,idx);
WITH inserted AS (
  INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
  SELECT 'PRO-POSS-005',m.id,l.id,'I like ___ new shoes. (they)','easy','Their sebelum noun shoes.'
  FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='possessive-pronouns' WHERE m.slug='pronouns'
  ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, opts.body, opts.correct, opts.idx FROM inserted
CROSS JOIN (VALUES ('them',FALSE,0),('they',FALSE,1),('their',TRUE,2),('theirs',FALSE,3)) AS opts(body,correct,idx);
WITH inserted AS (
  INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
  SELECT 'PRO-POSS-006',m.id,l.id,'This house belongs to John. It is ___.','medium','His bisa berdiri sendiri sebagai possessive pronoun.'
  FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='possessive-pronouns' WHERE m.slug='pronouns'
  ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, opts.body, opts.correct, opts.idx FROM inserted
CROSS JOIN (VALUES ('him',FALSE,0),('he',FALSE,1),('himself',FALSE,2),('his',TRUE,3)) AS opts(body,correct,idx);
WITH inserted AS (
  INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
  SELECT 'PRO-POSS-007',m.id,l.id,'My phone is black, but ___ is white. (you)','medium','Yours menggantikan your phone.'
  FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='possessive-pronouns' WHERE m.slug='pronouns'
  ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, opts.body, opts.correct, opts.idx FROM inserted
CROSS JOIN (VALUES ('yours',TRUE,0),('your',FALSE,1),('you',FALSE,2),('yourself',FALSE,3)) AS opts(body,correct,idx);
WITH inserted AS (
  INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
  SELECT 'PRO-POSS-008',m.id,l.id,'The children are doing ___ homework.','medium','Their adalah possessive adjective sebelum homework.'
  FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='possessive-pronouns' WHERE m.slug='pronouns'
  ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, opts.body, opts.correct, opts.idx FROM inserted
CROSS JOIN (VALUES ('they',FALSE,0),('their',TRUE,1),('theirs',FALSE,2),('them',FALSE,3)) AS opts(body,correct,idx);
WITH inserted AS (
  INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
  SELECT 'PRO-POSS-009',m.id,l.id,'This is Anna''s jacket. The jacket is ___.','medium','Hers menggantikan Anna''s jacket.'
  FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='possessive-pronouns' WHERE m.slug='pronouns'
  ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, opts.body, opts.correct, opts.idx FROM inserted
CROSS JOIN (VALUES ('she',FALSE,0),('herself',FALSE,1),('hers',TRUE,2),('her',FALSE,3)) AS opts(body,correct,idx);
WITH inserted AS (
  INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
  SELECT 'PRO-POSS-010',m.id,l.id,'The company changed ___ policy.','medium','Its adalah possessive determiner; it''s berarti it is/it has.'
  FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='possessive-pronouns' WHERE m.slug='pronouns'
  ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, opts.body, opts.correct, opts.idx FROM inserted
CROSS JOIN (VALUES ('it''s',FALSE,0),('it',FALSE,1),('itself',FALSE,2),('its',TRUE,3)) AS opts(body,correct,idx);
WITH inserted AS (
  INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
  SELECT 'PRO-POSS-011',m.id,l.id,'The bicycle is not mine. It is ___. (he)','hard','His adalah possessive pronoun untuk he.'
  FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='possessive-pronouns' WHERE m.slug='pronouns'
  ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, opts.body, opts.correct, opts.idx FROM inserted
CROSS JOIN (VALUES ('his',TRUE,0),('him',FALSE,1),('he',FALSE,2),('himself',FALSE,3)) AS opts(body,correct,idx);
WITH inserted AS (
  INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
  SELECT 'PRO-POSS-012',m.id,l.id,'We cleaned ___ classroom before leaving.','hard','Our sebelum noun classroom.'
  FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='possessive-pronouns' WHERE m.slug='pronouns'
  ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, opts.body, opts.correct, opts.idx FROM inserted
CROSS JOIN (VALUES ('we',FALSE,0),('our',TRUE,1),('ours',FALSE,2),('us',FALSE,3)) AS opts(body,correct,idx);
WITH inserted AS (
  INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
  SELECT 'PRO-POSS-013',m.id,l.id,'The final decision is ___. (they)','hard','Theirs berdiri sendiri setelah is.'
  FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='possessive-pronouns' WHERE m.slug='pronouns'
  ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, opts.body, opts.correct, opts.idx FROM inserted
CROSS JOIN (VALUES ('them',FALSE,0),('they',FALSE,1),('theirs',TRUE,2),('their',FALSE,3)) AS opts(body,correct,idx);
WITH inserted AS (
  INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
  SELECT 'PRO-POSS-014',m.id,l.id,'___ idea sounds interesting. (you)','hard','Your sebelum noun idea.'
  FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='possessive-pronouns' WHERE m.slug='pronouns'
  ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, opts.body, opts.correct, opts.idx FROM inserted
CROSS JOIN (VALUES ('Yours',FALSE,0),('You',FALSE,1),('Yourself',FALSE,2),('Your',TRUE,3)) AS opts(body,correct,idx);
WITH inserted AS (
  INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
  SELECT 'PRO-POSS-015',m.id,l.id,'I have my ticket. Does Maya have ___?','hard','Hers mewakili her ticket sehingga noun tidak diulang.'
  FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='possessive-pronouns' WHERE m.slug='pronouns'
  ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, opts.body, opts.correct, opts.idx FROM inserted
CROSS JOIN (VALUES ('hers',TRUE,0),('her',FALSE,1),('she',FALSE,2),('herself',FALSE,3)) AS opts(body,correct,idx);
WITH inserted AS (
  INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
  SELECT 'PRO-REFL-001',m.id,l.id,'I made this cake by ___.','easy','By myself berarti melakukannya sendiri.'
  FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='reflexive-pronouns' WHERE m.slug='pronouns'
  ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, opts.body, opts.correct, opts.idx FROM inserted
CROSS JOIN (VALUES ('me',FALSE,0),('mine',FALSE,1),('my',FALSE,2),('myself',TRUE,3)) AS opts(body,correct,idx);
WITH inserted AS (
  INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
  SELECT 'PRO-REFL-002',m.id,l.id,'He hurt ___ while playing football.','easy','He dan objek merujuk orang sama: himself.'
  FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='reflexive-pronouns' WHERE m.slug='pronouns'
  ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, opts.body, opts.correct, opts.idx FROM inserted
CROSS JOIN (VALUES ('himself',TRUE,0),('him',FALSE,1),('his',FALSE,2),('he',FALSE,3)) AS opts(body,correct,idx);
WITH inserted AS (
  INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
  SELECT 'PRO-REFL-003',m.id,l.id,'She taught ___ to play the guitar.','easy','Subject she dan objek orang sama memakai herself.'
  FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='reflexive-pronouns' WHERE m.slug='pronouns'
  ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, opts.body, opts.correct, opts.idx FROM inserted
CROSS JOIN (VALUES ('she',FALSE,0),('herself',TRUE,1),('her',FALSE,2),('hers',FALSE,3)) AS opts(body,correct,idx);
WITH inserted AS (
  INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
  SELECT 'PRO-REFL-004',m.id,l.id,'We prepared the food ___.','easy','We sebagai pelaku dan penegasan memakai ourselves.'
  FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='reflexive-pronouns' WHERE m.slug='pronouns'
  ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, opts.body, opts.correct, opts.idx FROM inserted
CROSS JOIN (VALUES ('our',FALSE,0),('ours',FALSE,1),('ourselves',TRUE,2),('us',FALSE,3)) AS opts(body,correct,idx);
WITH inserted AS (
  INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
  SELECT 'PRO-REFL-005',m.id,l.id,'Please help ___ to some cake, everyone.','easy','Everyone diajak bicara sebagai kelompok: help yourselves.'
  FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='reflexive-pronouns' WHERE m.slug='pronouns'
  ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, opts.body, opts.correct, opts.idx FROM inserted
CROSS JOIN (VALUES ('yourself',FALSE,0),('your',FALSE,1),('yours',FALSE,2),('yourselves',TRUE,3)) AS opts(body,correct,idx);
WITH inserted AS (
  INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
  SELECT 'PRO-REFL-006',m.id,l.id,'The robot turned ___ off automatically.','medium','Itself dipakai untuk benda tunggal.'
  FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='reflexive-pronouns' WHERE m.slug='pronouns'
  ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, opts.body, opts.correct, opts.idx FROM inserted
CROSS JOIN (VALUES ('itself',TRUE,0),('its',FALSE,1),('it',FALSE,2),('itselfs',FALSE,3)) AS opts(body,correct,idx);
WITH inserted AS (
  INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
  SELECT 'PRO-REFL-007',m.id,l.id,'The children dressed ___ before school.','medium','Children jamak dan objek diri sendiri: themselves.'
  FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='reflexive-pronouns' WHERE m.slug='pronouns'
  ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, opts.body, opts.correct, opts.idx FROM inserted
CROSS JOIN (VALUES ('theirs',FALSE,0),('themselves',TRUE,1),('them',FALSE,2),('their',FALSE,3)) AS opts(body,correct,idx);
WITH inserted AS (
  INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
  SELECT 'PRO-REFL-008',m.id,l.id,'You should be proud of ___.','medium','Proud of yourself mengacu diri lawan bicara tunggal.'
  FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='reflexive-pronouns' WHERE m.slug='pronouns'
  ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, opts.body, opts.correct, opts.idx FROM inserted
CROSS JOIN (VALUES ('your',FALSE,0),('you',FALSE,1),('yourself',TRUE,2),('yours',FALSE,3)) AS opts(body,correct,idx);
WITH inserted AS (
  INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
  SELECT 'PRO-REFL-009',m.id,l.id,'My friend and I fixed the bicycle ___.','medium','My friend and I = we, jadi ourselves.'
  FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='reflexive-pronouns' WHERE m.slug='pronouns'
  ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, opts.body, opts.correct, opts.idx FROM inserted
CROSS JOIN (VALUES ('myself',FALSE,0),('themselves',FALSE,1),('us',FALSE,2),('ourselves',TRUE,3)) AS opts(body,correct,idx);
WITH inserted AS (
  INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
  SELECT 'PRO-REFL-010',m.id,l.id,'Tom looked at ___ in the mirror.','medium','Tom melihat dirinya sendiri: himself.'
  FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='reflexive-pronouns' WHERE m.slug='pronouns'
  ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, opts.body, opts.correct, opts.idx FROM inserted
CROSS JOIN (VALUES ('himself',TRUE,0),('him',FALSE,1),('his',FALSE,2),('he',FALSE,3)) AS opts(body,correct,idx);
WITH inserted AS (
  INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
  SELECT 'PRO-REFL-011',m.id,l.id,'They built the shelter by ___.','hard','By themselves berarti mereka membangunnya sendiri.'
  FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='reflexive-pronouns' WHERE m.slug='pronouns'
  ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, opts.body, opts.correct, opts.idx FROM inserted
CROSS JOIN (VALUES ('their',FALSE,0),('themselves',TRUE,1),('them',FALSE,2),('theirs',FALSE,3)) AS opts(body,correct,idx);
WITH inserted AS (
  INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
  SELECT 'PRO-REFL-012',m.id,l.id,'Be careful! Don''t cut ___ with that knife.','hard','Cut yourself untuk lawan bicara tunggal.'
  FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='reflexive-pronouns' WHERE m.slug='pronouns'
  ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, opts.body, opts.correct, opts.idx FROM inserted
CROSS JOIN (VALUES ('your',FALSE,0),('you',FALSE,1),('yourself',TRUE,2),('yours',FALSE,3)) AS opts(body,correct,idx);
WITH inserted AS (
  INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
  SELECT 'PRO-REFL-013',m.id,l.id,'The actress introduced ___ to the audience.','hard','Pelaku she memperkenalkan dirinya: herself.'
  FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='reflexive-pronouns' WHERE m.slug='pronouns'
  ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, opts.body, opts.correct, opts.idx FROM inserted
CROSS JOIN (VALUES ('her',FALSE,0),('she',FALSE,1),('hers',FALSE,2),('herself',TRUE,3)) AS opts(body,correct,idx);
WITH inserted AS (
  INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
  SELECT 'PRO-REFL-014',m.id,l.id,'We enjoyed ___ at the party.','hard','Enjoy ourselves berarti bersenang-senang.'
  FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='reflexive-pronouns' WHERE m.slug='pronouns'
  ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, opts.body, opts.correct, opts.idx FROM inserted
CROSS JOIN (VALUES ('ourselves',TRUE,0),('us',FALSE,1),('our',FALSE,2),('ours',FALSE,3)) AS opts(body,correct,idx);
WITH inserted AS (
  INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
  SELECT 'PRO-REFL-015',m.id,l.id,'The machine restarts ___ after an update.','hard','Machine tunggal menggunakan itself.'
  FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='reflexive-pronouns' WHERE m.slug='pronouns'
  ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, opts.body, opts.correct, opts.idx FROM inserted
CROSS JOIN (VALUES ('themselves',FALSE,0),('itself',TRUE,1),('it',FALSE,2),('its',FALSE,3)) AS opts(body,correct,idx);
WITH inserted AS (
  INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
  SELECT 'PRO-DEMO-001',m.id,l.id,'___ is my pen here in my hand.','easy','This tunggal dekat pembicara.'
  FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='demonstrative-pronouns' WHERE m.slug='pronouns'
  ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, opts.body, opts.correct, opts.idx FROM inserted
CROSS JOIN (VALUES ('These',FALSE,0),('Those',FALSE,1),('They',FALSE,2),('This',TRUE,3)) AS opts(body,correct,idx);
WITH inserted AS (
  INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
  SELECT 'PRO-DEMO-002',m.id,l.id,'___ are my books here on the desk.','easy','These untuk benda jamak dekat pembicara.'
  FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='demonstrative-pronouns' WHERE m.slug='pronouns'
  ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, opts.body, opts.correct, opts.idx FROM inserted
CROSS JOIN (VALUES ('These',TRUE,0),('This',FALSE,1),('That',FALSE,2),('It',FALSE,3)) AS opts(body,correct,idx);
WITH inserted AS (
  INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
  SELECT 'PRO-DEMO-003',m.id,l.id,'___ is the mountain over there.','easy','That untuk satu benda jauh.'
  FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='demonstrative-pronouns' WHERE m.slug='pronouns'
  ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, opts.body, opts.correct, opts.idx FROM inserted
CROSS JOIN (VALUES ('They',FALSE,0),('That',TRUE,1),('This',FALSE,2),('These',FALSE,3)) AS opts(body,correct,idx);
WITH inserted AS (
  INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
  SELECT 'PRO-DEMO-004',m.id,l.id,'___ are the stars far away.','easy','Those untuk banyak benda jauh.'
  FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='demonstrative-pronouns' WHERE m.slug='pronouns'
  ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, opts.body, opts.correct, opts.idx FROM inserted
CROSS JOIN (VALUES ('This',FALSE,0),('It',FALSE,1),('Those',TRUE,2),('That',FALSE,3)) AS opts(body,correct,idx);
WITH inserted AS (
  INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
  SELECT 'PRO-DEMO-005',m.id,l.id,'Look at these two keys. ___ are mine.','easy','These merujuk dua kunci dekat.'
  FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='demonstrative-pronouns' WHERE m.slug='pronouns'
  ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, opts.body, opts.correct, opts.idx FROM inserted
CROSS JOIN (VALUES ('This',FALSE,0),('That',FALSE,1),('It',FALSE,2),('These',TRUE,3)) AS opts(body,correct,idx);
WITH inserted AS (
  INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
  SELECT 'PRO-DEMO-006',m.id,l.id,'___ is a beautiful painting on the opposite wall.','medium','Painting tunggal jauh: that.'
  FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='demonstrative-pronouns' WHERE m.slug='pronouns'
  ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, opts.body, opts.correct, opts.idx FROM inserted
CROSS JOIN (VALUES ('That',TRUE,0),('These',FALSE,1),('Those',FALSE,2),('They',FALSE,3)) AS opts(body,correct,idx);
WITH inserted AS (
  INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
  SELECT 'PRO-DEMO-007',m.id,l.id,'I prefer ___, not those, pointing to these shoes beside me.','medium','These untuk shoes yang jamak dan dekat.'
  FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='demonstrative-pronouns' WHERE m.slug='pronouns'
  ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, opts.body, opts.correct, opts.idx FROM inserted
CROSS JOIN (VALUES ('it',FALSE,0),('these',TRUE,1),('this',FALSE,2),('that',FALSE,3)) AS opts(body,correct,idx);
WITH inserted AS (
  INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
  SELECT 'PRO-DEMO-008',m.id,l.id,'___ is my favorite mug, right here.','medium','Mug tunggal dekat: this.'
  FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='demonstrative-pronouns' WHERE m.slug='pronouns'
  ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, opts.body, opts.correct, opts.idx FROM inserted
CROSS JOIN (VALUES ('These',FALSE,0),('They',FALSE,1),('This',TRUE,2),('Those',FALSE,3)) AS opts(body,correct,idx);
WITH inserted AS (
  INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
  SELECT 'PRO-DEMO-009',m.id,l.id,'Can you see ___ birds in that distant tree?','medium','Those adalah determiner jamak jauh sebelum birds.'
  FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='demonstrative-pronouns' WHERE m.slug='pronouns'
  ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, opts.body, opts.correct, opts.idx FROM inserted
CROSS JOIN (VALUES ('this',FALSE,0),('that',FALSE,1),('it',FALSE,2),('those',TRUE,3)) AS opts(body,correct,idx);
WITH inserted AS (
  INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
  SELECT 'PRO-DEMO-010',m.id,l.id,'___ apples in this basket are fresh.','medium','These adalah determiner jamak dekat sebelum apples.'
  FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='demonstrative-pronouns' WHERE m.slug='pronouns'
  ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, opts.body, opts.correct, opts.idx FROM inserted
CROSS JOIN (VALUES ('These',TRUE,0),('This',FALSE,1),('That',FALSE,2),('It',FALSE,3)) AS opts(body,correct,idx);
WITH inserted AS (
  INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
  SELECT 'PRO-DEMO-011',m.id,l.id,'___ chair beside you is broken.','hard','That dipakai sebelum chair tunggal di dekat lawan bicara (lebih jauh dari pembicara).'
  FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='demonstrative-pronouns' WHERE m.slug='pronouns'
  ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, opts.body, opts.correct, opts.idx FROM inserted
CROSS JOIN (VALUES ('They',FALSE,0),('That',TRUE,1),('These',FALSE,2),('Those',FALSE,3)) AS opts(body,correct,idx);
WITH inserted AS (
  INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
  SELECT 'PRO-DEMO-012',m.id,l.id,'___ is the answer I was looking for, right here.','hard','This untuk jawaban tunggal yang ditunjuk dekat.'
  FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='demonstrative-pronouns' WHERE m.slug='pronouns'
  ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, opts.body, opts.correct, opts.idx FROM inserted
CROSS JOIN (VALUES ('Those',FALSE,0),('They',FALSE,1),('This',TRUE,2),('These',FALSE,3)) AS opts(body,correct,idx);
WITH inserted AS (
  INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
  SELECT 'PRO-DEMO-013',m.id,l.id,'___ people across the street are waving.','hard','Those untuk people jamak jauh.'
  FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='demonstrative-pronouns' WHERE m.slug='pronouns'
  ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, opts.body, opts.correct, opts.idx FROM inserted
CROSS JOIN (VALUES ('That',FALSE,0),('This',FALSE,1),('It',FALSE,2),('Those',TRUE,3)) AS opts(body,correct,idx);
WITH inserted AS (
  INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
  SELECT 'PRO-DEMO-014',m.id,l.id,'I don''t want this sandwich. I want ___ one over there.','hard','That digunakan sebagai determiner tunggal sebelum one di lokasi jauh.'
  FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='demonstrative-pronouns' WHERE m.slug='pronouns'
  ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, opts.body, opts.correct, opts.idx FROM inserted
CROSS JOIN (VALUES ('that',TRUE,0),('these',FALSE,1),('those',FALSE,2),('it',FALSE,3)) AS opts(body,correct,idx);
WITH inserted AS (
  INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
  SELECT 'PRO-DEMO-015',m.id,l.id,'___ are not my gloves here; they belong to Mia.','hard','Gloves berbentuk jamak dan dekat: these.'
  FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='demonstrative-pronouns' WHERE m.slug='pronouns'
  ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, opts.body, opts.correct, opts.idx FROM inserted
CROSS JOIN (VALUES ('It',FALSE,0),('These',TRUE,1),('This',FALSE,2),('That',FALSE,3)) AS opts(body,correct,idx);
WITH inserted AS (
  INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
  SELECT 'PRO-RELA-001',m.id,l.id,'The woman ___ teaches us is very patient.','easy','Who merujuk orang sebagai subjek klausa relatif.'
  FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='relative-pronouns' WHERE m.slug='pronouns'
  ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, opts.body, opts.correct, opts.idx FROM inserted
CROSS JOIN (VALUES ('who',TRUE,0),('whose',FALSE,1),('which',FALSE,2),('where',FALSE,3)) AS opts(body,correct,idx);
WITH inserted AS (
  INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
  SELECT 'PRO-RELA-002',m.id,l.id,'The book ___ I borrowed is fascinating.','easy','That dapat merujuk benda dalam klausa relatif pembatas.'
  FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='relative-pronouns' WHERE m.slug='pronouns'
  ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, opts.body, opts.correct, opts.idx FROM inserted
CROSS JOIN (VALUES ('whom',FALSE,0),('that',TRUE,1),('who',FALSE,2),('whose',FALSE,3)) AS opts(body,correct,idx);
WITH inserted AS (
  INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
  SELECT 'PRO-RELA-003',m.id,l.id,'The student ___ bag is missing looks worried.','easy','Whose menunjukkan kepemilikan bag.'
  FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='relative-pronouns' WHERE m.slug='pronouns'
  ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, opts.body, opts.correct, opts.idx FROM inserted
CROSS JOIN (VALUES ('whom',FALSE,0),('which',FALSE,1),('whose',TRUE,2),('who',FALSE,3)) AS opts(body,correct,idx);
WITH inserted AS (
  INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
  SELECT 'PRO-RELA-004',m.id,l.id,'The machine ___ broke yesterday is working again.','easy','That untuk benda dalam defining relative clause.'
  FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='relative-pronouns' WHERE m.slug='pronouns'
  ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, opts.body, opts.correct, opts.idx FROM inserted
CROSS JOIN (VALUES ('who',FALSE,0),('whose',FALSE,1),('whom',FALSE,2),('that',TRUE,3)) AS opts(body,correct,idx);
WITH inserted AS (
  INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
  SELECT 'PRO-RELA-005',m.id,l.id,'The man to ___ I spoke was polite.','easy','Setelah preposition to formal, gunakan whom untuk orang.'
  FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='relative-pronouns' WHERE m.slug='pronouns'
  ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, opts.body, opts.correct, opts.idx FROM inserted
CROSS JOIN (VALUES ('whom',TRUE,0),('whose',FALSE,1),('which',FALSE,2),('that',FALSE,3)) AS opts(body,correct,idx);
WITH inserted AS (
  INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
  SELECT 'PRO-RELA-006',m.id,l.id,'The teacher ___ explained the rule was helpful.','medium','Who bertindak sebagai subjek explained.'
  FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='relative-pronouns' WHERE m.slug='pronouns'
  ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, opts.body, opts.correct, opts.idx FROM inserted
CROSS JOIN (VALUES ('which',FALSE,0),('who',TRUE,1),('whom',FALSE,2),('whose',FALSE,3)) AS opts(body,correct,idx);
WITH inserted AS (
  INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
  SELECT 'PRO-RELA-007',m.id,l.id,'I met a scientist ___ research won an award.','medium','Whose menunjukkan research milik scientist.'
  FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='relative-pronouns' WHERE m.slug='pronouns'
  ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, opts.body, opts.correct, opts.idx FROM inserted
CROSS JOIN (VALUES ('who',FALSE,0),('which',FALSE,1),('whose',TRUE,2),('whom',FALSE,3)) AS opts(body,correct,idx);
WITH inserted AS (
  INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
  SELECT 'PRO-RELA-008',m.id,l.id,'The bike ___ has a red frame belongs to Liam.','medium','Which merujuk benda (bike) sebagai subjek.'
  FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='relative-pronouns' WHERE m.slug='pronouns'
  ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, opts.body, opts.correct, opts.idx FROM inserted
CROSS JOIN (VALUES ('whom',FALSE,0),('who',FALSE,1),('whose',FALSE,2),('which',TRUE,3)) AS opts(body,correct,idx);
WITH inserted AS (
  INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
  SELECT 'PRO-RELA-009',m.id,l.id,'The person ___ you called is my cousin.','medium','Whom dapat digunakan sebagai objek person yang dipanggil dalam formal English.'
  FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='relative-pronouns' WHERE m.slug='pronouns'
  ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, opts.body, opts.correct, opts.idx FROM inserted
CROSS JOIN (VALUES ('whom',TRUE,0),('whose',FALSE,1),('which',FALSE,2),('where',FALSE,3)) AS opts(body,correct,idx);
WITH inserted AS (
  INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
  SELECT 'PRO-RELA-010',m.id,l.id,'The dog ___ tail is fluffy is friendly.','medium','Whose dapat dipakai pada kepemilikan hewan.'
  FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='relative-pronouns' WHERE m.slug='pronouns'
  ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, opts.body, opts.correct, opts.idx FROM inserted
CROSS JOIN (VALUES ('where',FALSE,0),('whose',TRUE,1),('whom',FALSE,2),('who',FALSE,3)) AS opts(body,correct,idx);
WITH inserted AS (
  INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
  SELECT 'PRO-RELA-011',m.id,l.id,'The house ___ stands on the hill is old.','hard','That cocok untuk house dalam defining relative clause.'
  FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='relative-pronouns' WHERE m.slug='pronouns'
  ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, opts.body, opts.correct, opts.idx FROM inserted
CROSS JOIN (VALUES ('who',FALSE,0),('whose',FALSE,1),('that',TRUE,2),('whom',FALSE,3)) AS opts(body,correct,idx);
WITH inserted AS (
  INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
  SELECT 'PRO-RELA-012',m.id,l.id,'The writer ___ books you love is visiting.','hard','Whose menentukan buku milik writer.'
  FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='relative-pronouns' WHERE m.slug='pronouns'
  ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, opts.body, opts.correct, opts.idx FROM inserted
CROSS JOIN (VALUES ('who',FALSE,0),('whom',FALSE,1),('which',FALSE,2),('whose',TRUE,3)) AS opts(body,correct,idx);
WITH inserted AS (
  INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
  SELECT 'PRO-RELA-013',m.id,l.id,'The laptop, ___ I bought last year, still works.','hard','Dalam non-defining relative clause berkomma, gunakan which, bukan that.'
  FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='relative-pronouns' WHERE m.slug='pronouns'
  ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, opts.body, opts.correct, opts.idx FROM inserted
CROSS JOIN (VALUES ('which',TRUE,0),('that',FALSE,1),('who',FALSE,2),('whose',FALSE,3)) AS opts(body,correct,idx);
WITH inserted AS (
  INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
  SELECT 'PRO-RELA-014',m.id,l.id,'My uncle, ___ lives in Bandung, is an engineer.','hard','Non-defining clause untuk orang sebagai subjek memakai who.'
  FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='relative-pronouns' WHERE m.slug='pronouns'
  ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, opts.body, opts.correct, opts.idx FROM inserted
CROSS JOIN (VALUES ('whom',FALSE,0),('who',TRUE,1),('that',FALSE,2),('which',FALSE,3)) AS opts(body,correct,idx);
WITH inserted AS (
  INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
  SELECT 'PRO-RELA-015',m.id,l.id,'The woman with ___ he worked has retired.','hard','Setelah with sebagai preposition formal untuk orang gunakan whom.'
  FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='relative-pronouns' WHERE m.slug='pronouns'
  ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, opts.body, opts.correct, opts.idx FROM inserted
CROSS JOIN (VALUES ('which',FALSE,0),('that',FALSE,1),('whom',TRUE,2),('whose',FALSE,3)) AS opts(body,correct,idx);
WITH inserted AS (
  INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
  SELECT 'PRO-INTE-001',m.id,l.id,'___ is knocking at the door?','easy','Who menanyakan identitas orang yang menjadi subjek.'
  FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='interrogative-pronouns' WHERE m.slug='pronouns'
  ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, opts.body, opts.correct, opts.idx FROM inserted
CROSS JOIN (VALUES ('Whose',FALSE,0),('Which',FALSE,1),('Whom''s',FALSE,2),('Who',TRUE,3)) AS opts(body,correct,idx);
WITH inserted AS (
  INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
  SELECT 'PRO-INTE-002',m.id,l.id,'___ bag is this?','easy','Whose menanyakan kepemilikan bag.'
  FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='interrogative-pronouns' WHERE m.slug='pronouns'
  ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, opts.body, opts.correct, opts.idx FROM inserted
CROSS JOIN (VALUES ('Whose',TRUE,0),('Who',FALSE,1),('Whom',FALSE,2),('What',FALSE,3)) AS opts(body,correct,idx);
WITH inserted AS (
  INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
  SELECT 'PRO-INTE-003',m.id,l.id,'___ do you prefer, tea or coffee?','easy','Which cocok untuk pilihan yang disebutkan.'
  FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='interrogative-pronouns' WHERE m.slug='pronouns'
  ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, opts.body, opts.correct, opts.idx FROM inserted
CROSS JOIN (VALUES ('Whom',FALSE,0),('Which',TRUE,1),('Who',FALSE,2),('Whose',FALSE,3)) AS opts(body,correct,idx);
WITH inserted AS (
  INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
  SELECT 'PRO-INTE-004',m.id,l.id,'___ is your name?','easy','What menanyakan informasi nama.'
  FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='interrogative-pronouns' WHERE m.slug='pronouns'
  ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, opts.body, opts.correct, opts.idx FROM inserted
CROSS JOIN (VALUES ('Whose',FALSE,0),('Whom',FALSE,1),('What',TRUE,2),('Who',FALSE,3)) AS opts(body,correct,idx);
WITH inserted AS (
  INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
  SELECT 'PRO-INTE-005',m.id,l.id,'To ___ did you send the email? (formal)','easy','To whom dipakai secara formal setelah preposition to.'
  FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='interrogative-pronouns' WHERE m.slug='pronouns'
  ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, opts.body, opts.correct, opts.idx FROM inserted
CROSS JOIN (VALUES ('who''s',FALSE,0),('whose',FALSE,1),('which',FALSE,2),('whom',TRUE,3)) AS opts(body,correct,idx);
WITH inserted AS (
  INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
  SELECT 'PRO-INTE-006',m.id,l.id,'___ made this delicious cake?','medium','Who menanyakan subjek manusia yang membuat cake.'
  FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='interrogative-pronouns' WHERE m.slug='pronouns'
  ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, opts.body, opts.correct, opts.idx FROM inserted
CROSS JOIN (VALUES ('Who',TRUE,0),('Whom',FALSE,1),('Whose',FALSE,2),('Which''s',FALSE,3)) AS opts(body,correct,idx);
WITH inserted AS (
  INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
  SELECT 'PRO-INTE-007',m.id,l.id,'___ is the best answer from these three options?','medium','Which memilih satu dari pilihan terbatas.'
  FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='interrogative-pronouns' WHERE m.slug='pronouns'
  ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, opts.body, opts.correct, opts.idx FROM inserted
CROSS JOIN (VALUES ('Whom',FALSE,0),('Which',TRUE,1),('Whose',FALSE,2),('Who',FALSE,3)) AS opts(body,correct,idx);
WITH inserted AS (
  INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
  SELECT 'PRO-INTE-008',m.id,l.id,'___ are these keys?','medium','Whose dapat berdiri sendiri menanyakan pemilik keys.'
  FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='interrogative-pronouns' WHERE m.slug='pronouns'
  ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, opts.body, opts.correct, opts.idx FROM inserted
CROSS JOIN (VALUES ('What',FALSE,0),('Whom',FALSE,1),('Whose',TRUE,2),('Who',FALSE,3)) AS opts(body,correct,idx);
WITH inserted AS (
  INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
  SELECT 'PRO-INTE-009',m.id,l.id,'___ do you want to eat for lunch?','medium','What menanyakan sesuatu (makanan).'
  FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='interrogative-pronouns' WHERE m.slug='pronouns'
  ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, opts.body, opts.correct, opts.idx FROM inserted
CROSS JOIN (VALUES ('Who',FALSE,0),('Whose',FALSE,1),('Whom',FALSE,2),('What',TRUE,3)) AS opts(body,correct,idx);
WITH inserted AS (
  INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
  SELECT 'PRO-INTE-010',m.id,l.id,'With ___ are you speaking? (formal)','medium','With whom digunakan untuk objek orang dalam register formal.'
  FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='interrogative-pronouns' WHERE m.slug='pronouns'
  ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, opts.body, opts.correct, opts.idx FROM inserted
CROSS JOIN (VALUES ('whom',TRUE,0),('whose',FALSE,1),('what',FALSE,2),('which',FALSE,3)) AS opts(body,correct,idx);
WITH inserted AS (
  INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
  SELECT 'PRO-INTE-011',m.id,l.id,'___ of these jackets belongs to you?','hard','Which of ... menanyakan pemilihan dari kumpulan yang jelas.'
  FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='interrogative-pronouns' WHERE m.slug='pronouns'
  ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, opts.body, opts.correct, opts.idx FROM inserted
CROSS JOIN (VALUES ('Whom',FALSE,0),('Which',TRUE,1),('Who',FALSE,2),('Whose',FALSE,3)) AS opts(body,correct,idx);
WITH inserted AS (
  INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
  SELECT 'PRO-INTE-012',m.id,l.id,'___ is responsible for opening the office?','hard','Who subjek orang yang bertanggung jawab.'
  FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='interrogative-pronouns' WHERE m.slug='pronouns'
  ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, opts.body, opts.correct, opts.idx FROM inserted
CROSS JOIN (VALUES ('Whose',FALSE,0),('What',FALSE,1),('Who',TRUE,2),('Whom',FALSE,3)) AS opts(body,correct,idx);
WITH inserted AS (
  INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
  SELECT 'PRO-INTE-013',m.id,l.id,'___ did the teacher invite? (formal)','hard','Whom menanyakan objek manusia yang diundang (bahasa formal).'
  FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='interrogative-pronouns' WHERE m.slug='pronouns'
  ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, opts.body, opts.correct, opts.idx FROM inserted
CROSS JOIN (VALUES ('Whose',FALSE,0),('Which''s',FALSE,1),('What',FALSE,2),('Whom',TRUE,3)) AS opts(body,correct,idx);
WITH inserted AS (
  INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
  SELECT 'PRO-INTE-014',m.id,l.id,'___ is inside this box?','hard','What menanyakan benda/isi kotak.'
  FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='interrogative-pronouns' WHERE m.slug='pronouns'
  ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, opts.body, opts.correct, opts.idx FROM inserted
CROSS JOIN (VALUES ('What',TRUE,0),('Who',FALSE,1),('Whom',FALSE,2),('Whose',FALSE,3)) AS opts(body,correct,idx);
WITH inserted AS (
  INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
  SELECT 'PRO-INTE-015',m.id,l.id,'___ notebook is on the table, yours or mine?','hard','Whose menanyakan siapa pemilik notebook.'
  FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='interrogative-pronouns' WHERE m.slug='pronouns'
  ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, opts.body, opts.correct, opts.idx FROM inserted
CROSS JOIN (VALUES ('What',FALSE,0),('Whose',TRUE,1),('Who',FALSE,2),('Whom',FALSE,3)) AS opts(body,correct,idx);
COMMIT;
