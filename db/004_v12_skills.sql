-- EnglishLab v1.2 additive migration. Never truncate legacy tables.
BEGIN;
CREATE TABLE IF NOT EXISTS translation_prompts (
 id BIGSERIAL PRIMARY KEY,
 code VARCHAR(64) NOT NULL UNIQUE,
 grammar_focus VARCHAR(32) NOT NULL CHECK(grammar_focus IN ('simple-present','simple-past','present-continuous','past-continuous','present-perfect','simple-future','future-continuous','modal-verbs','passive-voice')),
 indonesian TEXT NOT NULL, model_answer TEXT NOT NULL, accepted_answers JSONB NOT NULL,
 explanation TEXT NOT NULL DEFAULT '', difficulty VARCHAR(10) NOT NULL DEFAULT 'medium' CHECK(difficulty IN('easy','medium','hard')),
 is_active BOOLEAN NOT NULL DEFAULT TRUE, created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
 CONSTRAINT translation_accepted_array CHECK(jsonb_typeof(accepted_answers)='array')
);
CREATE INDEX IF NOT EXISTS idx_translation_pool ON translation_prompts(grammar_focus,difficulty,is_active);
CREATE TABLE IF NOT EXISTS translation_runs (
 id BIGSERIAL PRIMARY KEY, user_id BIGINT NOT NULL REFERENCES users(id),
 focus_filter VARCHAR(32) NOT NULL DEFAULT 'all',
 status VARCHAR(12) NOT NULL DEFAULT 'in_progress' CHECK(status IN('in_progress','submitted')),
 started_at TIMESTAMPTZ NOT NULL DEFAULT NOW(), submitted_at TIMESTAMPTZ
);
CREATE INDEX IF NOT EXISTS idx_translation_runs_user ON translation_runs(user_id,started_at DESC);
CREATE TABLE IF NOT EXISTS translation_run_items (
 id BIGSERIAL PRIMARY KEY, run_id BIGINT NOT NULL REFERENCES translation_runs(id) ON DELETE CASCADE,
 ordinal INT NOT NULL CHECK(ordinal>0), prompt_id BIGINT REFERENCES translation_prompts(id) ON DELETE SET NULL,
 prompt_snapshot TEXT NOT NULL, focus_snapshot VARCHAR(32) NOT NULL,
 model_snapshot TEXT NOT NULL, accepted_snapshot JSONB NOT NULL,
 explanation_snapshot TEXT NOT NULL,
 chosen_focus VARCHAR(32), answer_text TEXT,
 tense_correct BOOLEAN, sentence_verdict VARCHAR(10) CHECK(sentence_verdict IN('accepted','pending','rejected')),
 reviewed_by BIGINT REFERENCES users(id), reviewed_at TIMESTAMPTZ,
 answered_at TIMESTAMPTZ,
 UNIQUE(run_id,ordinal)
);
CREATE INDEX IF NOT EXISTS idx_translation_pending ON translation_run_items(sentence_verdict) WHERE sentence_verdict='pending';
CREATE TABLE IF NOT EXISTS listening_tracks (
 id BIGSERIAL PRIMARY KEY, slug VARCHAR(100) NOT NULL UNIQUE, title VARCHAR(160) NOT NULL,
 level VARCHAR(3) NOT NULL CHECK(level IN('A1','A2','B1','B2','C1','C2')),
 topic VARCHAR(120) NOT NULL, audio_path TEXT NOT NULL, transcript TEXT NOT NULL,
 source_type VARCHAR(80) NOT NULL, source_credit TEXT NOT NULL DEFAULT '',
 is_active BOOLEAN NOT NULL DEFAULT TRUE, created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);
CREATE TABLE IF NOT EXISTS listening_questions (
 id BIGSERIAL PRIMARY KEY, code VARCHAR(64) NOT NULL UNIQUE,
 track_id BIGINT NOT NULL REFERENCES listening_tracks(id) ON DELETE CASCADE,
 stem TEXT NOT NULL, options JSONB NOT NULL, correct_index SMALLINT NOT NULL CHECK(correct_index BETWEEN 0 AND 3),
 explanation TEXT NOT NULL, is_active BOOLEAN NOT NULL DEFAULT TRUE,
 CHECK(jsonb_typeof(options)='array')
);
CREATE INDEX IF NOT EXISTS idx_listening_questions_track ON listening_questions(track_id,is_active);
CREATE TABLE IF NOT EXISTS listening_runs (
 id BIGSERIAL PRIMARY KEY, user_id BIGINT NOT NULL REFERENCES users(id), track_id BIGINT NOT NULL REFERENCES listening_tracks(id),
 status VARCHAR(12) NOT NULL DEFAULT 'in_progress' CHECK(status IN('in_progress','submitted')),
 started_at TIMESTAMPTZ NOT NULL DEFAULT NOW(), submitted_at TIMESTAMPTZ,
 score NUMERIC(5,2), correct_count INT
);
CREATE INDEX IF NOT EXISTS idx_listening_runs_user ON listening_runs(user_id,started_at DESC);
CREATE TABLE IF NOT EXISTS listening_run_items (
 id BIGSERIAL PRIMARY KEY, run_id BIGINT NOT NULL REFERENCES listening_runs(id) ON DELETE CASCADE,
 ordinal INT NOT NULL CHECK(ordinal>0), question_snapshot TEXT NOT NULL,
 options_snapshot JSONB NOT NULL, correct_index SMALLINT NOT NULL,
 explanation_snapshot TEXT NOT NULL, chosen_index SMALLINT CHECK(chosen_index BETWEEN 0 AND 3),
 is_correct BOOLEAN,
 UNIQUE(run_id,ordinal)
);
COMMIT;
