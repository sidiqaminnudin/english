BEGIN;
CREATE TABLE IF NOT EXISTS exam_series (
 id BIGSERIAL PRIMARY KEY,slug TEXT NOT NULL UNIQUE,title TEXT NOT NULL,
 kind TEXT NOT NULL CHECK(kind IN('fundamentals','integrated')),
 is_published BOOLEAN NOT NULL DEFAULT FALSE,
 question_count INT NOT NULL CHECK(question_count BETWEEN 25 AND 200),
 duration_minutes INT NOT NULL CHECK(duration_minutes BETWEEN 1 AND 240),
 passing_score INT NOT NULL CHECK(passing_score BETWEEN 0 AND 100)
);
CREATE TABLE IF NOT EXISTS exam_series_modules (
 series_id BIGINT REFERENCES exam_series(id),module_id BIGINT REFERENCES modules(id),
 weight INT NOT NULL DEFAULT 1 CHECK(weight BETWEEN 1 AND 100),PRIMARY KEY(series_id,module_id)
);
CREATE TABLE IF NOT EXISTS exam_series_runs (
 id BIGSERIAL PRIMARY KEY,user_id BIGINT NOT NULL REFERENCES users(id),series_id BIGINT NOT NULL REFERENCES exam_series(id),
 config JSONB NOT NULL,status TEXT NOT NULL DEFAULT 'in_progress' CHECK(status IN('in_progress','pending_review','final')),
 started_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),deadline_at TIMESTAMPTZ NOT NULL,submitted_at TIMESTAMPTZ,
 expired BOOLEAN NOT NULL DEFAULT FALSE,is_preview BOOLEAN NOT NULL DEFAULT FALSE
);
CREATE INDEX IF NOT EXISTS idx_series_user ON exam_series_runs(user_id,started_at DESC);
CREATE TABLE IF NOT EXISTS exam_series_items (
 id BIGSERIAL PRIMARY KEY,run_id BIGINT NOT NULL REFERENCES exam_series_runs(id),ordinal INT NOT NULL,
 kind TEXT NOT NULL CHECK(kind IN('mcq','writing','listening')),source_id BIGINT NOT NULL,
 snapshot JSONB NOT NULL,answer JSONB NOT NULL DEFAULT '{}',objective_points NUMERIC NOT NULL DEFAULT 0,
 writing_points NUMERIC CHECK(writing_points BETWEEN 0 AND 3),
 review_status TEXT NOT NULL DEFAULT 'none' CHECK(review_status IN('none','pending','reviewed')),
 ai_json JSONB,ai_model TEXT,ai_status TEXT NOT NULL DEFAULT 'none',ai_attempts INT NOT NULL DEFAULT 0,
 reviewed_by BIGINT REFERENCES users(id),reviewed_at TIMESTAMPTZ,review_reason TEXT,
 UNIQUE(run_id,ordinal),UNIQUE(run_id,kind,source_id)
);
CREATE TABLE IF NOT EXISTS exam_series_reviews (
 id BIGSERIAL PRIMARY KEY,item_id BIGINT NOT NULL REFERENCES exam_series_items(id),
 reviewer_id BIGINT NOT NULL REFERENCES users(id),points NUMERIC NOT NULL CHECK(points BETWEEN 0 AND 3),
 reason TEXT NOT NULL,created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);
CREATE TABLE IF NOT EXISTS exam_series_ai_budget (
 day DATE PRIMARY KEY,calls INT NOT NULL CHECK(calls>=0)
);
INSERT INTO exam_series(slug,title,kind,question_count,duration_minutes,passing_score) VALUES
 ('english-fundamentals','Ujian 1 — English Fundamentals','fundamentals',50,60,75),
 ('tenses-writing-listening','Ujian 2 — Tenses, Writing & Listening','integrated',25,90,75)
 ON CONFLICT(slug) DO NOTHING;
INSERT INTO exam_series_modules(series_id,module_id)
 SELECT s.id,m.id FROM exam_series s CROSS JOIN modules m
 WHERE s.slug='english-fundamentals' AND m.slug IN
 ('alphabet-spelling','family-vocabulary','cardinal-ordinal','telling-time-dates','countable-uncountable','singular-plural','pronouns','simple-present','prepositions','conjunctions','adjective-adverb','degrees-comparison','giving-directions')
 ON CONFLICT DO NOTHING;
COMMIT;
