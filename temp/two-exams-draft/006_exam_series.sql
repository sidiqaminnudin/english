-- Additive: existing attempts and question banks are not modified.
BEGIN;
CREATE TABLE IF NOT EXISTS exam_series (
 id BIGSERIAL PRIMARY KEY,slug TEXT NOT NULL UNIQUE,title TEXT NOT NULL,
 kind TEXT NOT NULL CHECK(kind IN('fundamentals','integrated')),
 is_published BOOLEAN NOT NULL DEFAULT FALSE,
 question_count INT NOT NULL CHECK(question_count BETWEEN 26 AND 200),
 duration_minutes INT NOT NULL CHECK(duration_minutes BETWEEN 1 AND 240),
 passing_score INT NOT NULL CHECK(passing_score BETWEEN 0 AND 100),
 updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);
CREATE TABLE IF NOT EXISTS exam_series_modules (
 series_id BIGINT NOT NULL REFERENCES exam_series(id),module_id BIGINT NOT NULL REFERENCES modules(id),
 weight INT NOT NULL DEFAULT 1 CHECK(weight BETWEEN 1 AND 100),PRIMARY KEY(series_id,module_id)
);
CREATE TABLE IF NOT EXISTS exam_series_runs (
 id BIGSERIAL PRIMARY KEY,user_id BIGINT NOT NULL REFERENCES users(id),series_id BIGINT NOT NULL REFERENCES exam_series(id),
 title_snapshot TEXT NOT NULL,config_snapshot JSONB NOT NULL,
 status TEXT NOT NULL DEFAULT 'in_progress' CHECK(status IN('in_progress','submitted','expired')),
 started_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),deadline_at TIMESTAMPTZ NOT NULL,
 submitted_at TIMESTAMPTZ,score NUMERIC(5,2),correct_count INT
);
CREATE INDEX IF NOT EXISTS idx_series_runs_user ON exam_series_runs(user_id,started_at DESC);
CREATE TABLE IF NOT EXISTS exam_series_items (
 id BIGSERIAL PRIMARY KEY,run_id BIGINT NOT NULL REFERENCES exam_series_runs(id),ordinal INT NOT NULL CHECK(ordinal>0),
 question_id BIGINT REFERENCES questions(id),module_id BIGINT REFERENCES modules(id),stem_snapshot TEXT NOT NULL,
 options_snapshot JSONB NOT NULL,correct_option_id TEXT NOT NULL,explanation_snapshot TEXT NOT NULL,
 chosen_option_id TEXT,is_correct BOOLEAN,
 UNIQUE(run_id,ordinal),UNIQUE(run_id,question_id)
);
INSERT INTO exam_series(slug,title,kind,question_count,duration_minutes,passing_score) VALUES
 ('english-fundamentals','Ujian 1 — English Fundamentals','fundamentals',50,60,75),
 ('tenses-writing-listening','Ujian 2 — Tenses, Writing & Listening','integrated',26,90,75)
 ON CONFLICT(slug) DO NOTHING;
INSERT INTO exam_series_modules(series_id,module_id)
 SELECT s.id,m.id FROM exam_series s CROSS JOIN modules m
 WHERE s.slug='english-fundamentals' AND m.slug IN
 ('alphabet-spelling','family-vocabulary','cardinal-ordinal','telling-time-dates','countable-uncountable','singular-plural','pronouns','simple-present','prepositions','conjunctions','adjective-adverb','degrees-comparison','giving-directions')
 ON CONFLICT DO NOTHING;
COMMIT;
