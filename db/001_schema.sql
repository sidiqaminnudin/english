BEGIN;
CREATE TABLE IF NOT EXISTS users (
  id BIGSERIAL PRIMARY KEY,
  username VARCHAR(40) NOT NULL UNIQUE,
  full_name VARCHAR(120) NOT NULL,
  password_hash TEXT NOT NULL,
  role VARCHAR(12) NOT NULL DEFAULT 'student' CHECK (role IN ('student','admin')),
  is_active BOOLEAN NOT NULL DEFAULT TRUE,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  CONSTRAINT username_format CHECK (username ~ '^[a-z0-9_]{3,40}$')
);
CREATE TABLE IF NOT EXISTS courses (
  id BIGSERIAL PRIMARY KEY, slug VARCHAR(80) NOT NULL UNIQUE, title VARCHAR(160) NOT NULL,
  description TEXT NOT NULL DEFAULT '', is_published BOOLEAN NOT NULL DEFAULT FALSE,
  sort_order INT NOT NULL DEFAULT 0, created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);
CREATE TABLE IF NOT EXISTS modules (
  id BIGSERIAL PRIMARY KEY, course_id BIGINT NOT NULL REFERENCES courses(id),
  slug VARCHAR(80) NOT NULL UNIQUE, title VARCHAR(160) NOT NULL, description TEXT NOT NULL DEFAULT '',
  level VARCHAR(20) NOT NULL DEFAULT 'beginner', sort_order INT NOT NULL DEFAULT 0,
  is_published BOOLEAN NOT NULL DEFAULT FALSE,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);
CREATE INDEX IF NOT EXISTS idx_modules_course ON modules(course_id,sort_order);
CREATE TABLE IF NOT EXISTS lessons (
  id BIGSERIAL PRIMARY KEY, module_id BIGINT NOT NULL REFERENCES modules(id) ON DELETE CASCADE,
  slug VARCHAR(100) NOT NULL, title VARCHAR(160) NOT NULL, summary TEXT NOT NULL DEFAULT '',
  body_md TEXT NOT NULL DEFAULT '', sort_order INT NOT NULL DEFAULT 0,
  is_published BOOLEAN NOT NULL DEFAULT FALSE, updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  UNIQUE(module_id,slug)
);
CREATE INDEX IF NOT EXISTS idx_lessons_module ON lessons(module_id,sort_order);
CREATE TABLE IF NOT EXISTS questions (
  id BIGSERIAL PRIMARY KEY, code VARCHAR(40) NOT NULL UNIQUE,
  module_id BIGINT NOT NULL REFERENCES modules(id), lesson_id BIGINT REFERENCES lessons(id) ON DELETE SET NULL,
  stem TEXT NOT NULL, kind VARCHAR(12) NOT NULL DEFAULT 'mcq' CHECK (kind IN ('mcq')),
  difficulty VARCHAR(10) NOT NULL CHECK (difficulty IN ('easy','medium','hard')),
  explanation TEXT NOT NULL, is_active BOOLEAN NOT NULL DEFAULT TRUE,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(), updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);
CREATE INDEX IF NOT EXISTS idx_questions_pool ON questions(module_id,lesson_id,difficulty,is_active);
CREATE TABLE IF NOT EXISTS question_options (
  id BIGSERIAL PRIMARY KEY, question_id BIGINT NOT NULL REFERENCES questions(id) ON DELETE CASCADE,
  body TEXT NOT NULL, is_correct BOOLEAN NOT NULL DEFAULT FALSE, sort_order SMALLINT NOT NULL DEFAULT 0,
  UNIQUE(question_id,sort_order)
);
CREATE UNIQUE INDEX IF NOT EXISTS idx_one_correct_option ON question_options(question_id) WHERE is_correct;
CREATE TABLE IF NOT EXISTS exam_configs (
  module_id BIGINT PRIMARY KEY REFERENCES modules(id) ON DELETE CASCADE,
  question_count INT NOT NULL DEFAULT 20 CHECK (question_count BETWEEN 1 AND 200),
  duration_minutes INT NOT NULL DEFAULT 30 CHECK (duration_minutes BETWEEN 1 AND 240),
  passing_score INT NOT NULL DEFAULT 75 CHECK (passing_score BETWEEN 0 AND 100),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);
CREATE TABLE IF NOT EXISTS attempts (
  id BIGSERIAL PRIMARY KEY, user_id BIGINT NOT NULL REFERENCES users(id),
  module_id BIGINT NOT NULL REFERENCES modules(id), lesson_id BIGINT REFERENCES lessons(id),
  mode VARCHAR(10) NOT NULL CHECK (mode IN ('practice','exam')),
  status VARCHAR(14) NOT NULL DEFAULT 'in_progress' CHECK (status IN ('in_progress','submitted','expired')),
  question_count INT NOT NULL CHECK (question_count>0), duration_minutes INT,
  passing_score INT NOT NULL DEFAULT 75,
  started_at TIMESTAMPTZ NOT NULL DEFAULT NOW(), submitted_at TIMESTAMPTZ,
  score NUMERIC(5,2), correct_count INT,
  CHECK (mode <> 'exam' OR duration_minutes IS NOT NULL)
);
CREATE INDEX IF NOT EXISTS idx_attempts_user ON attempts(user_id,started_at DESC);
CREATE TABLE IF NOT EXISTS attempt_items (
  id BIGSERIAL PRIMARY KEY, attempt_id BIGINT NOT NULL REFERENCES attempts(id) ON DELETE CASCADE,
  question_id BIGINT REFERENCES questions(id) ON DELETE SET NULL,
  ordinal INT NOT NULL, stem_snapshot TEXT NOT NULL, options_snapshot JSONB NOT NULL,
  correct_option_id BIGINT NOT NULL, explanation_snapshot TEXT NOT NULL,
  chosen_option_id BIGINT, answered_at TIMESTAMPTZ, is_correct BOOLEAN,
  UNIQUE(attempt_id,ordinal), UNIQUE(attempt_id,question_id)
);
CREATE TABLE IF NOT EXISTS lesson_progress (
  user_id BIGINT NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  lesson_id BIGINT NOT NULL REFERENCES lessons(id) ON DELETE CASCADE,
  first_viewed_at TIMESTAMPTZ NOT NULL DEFAULT NOW(), last_viewed_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  PRIMARY KEY(user_id,lesson_id)
);
COMMIT;
