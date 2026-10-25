-- Additive extension for EnglishLab 1.2; does not delete/overwrite prior student answers.
BEGIN;
ALTER TABLE translation_run_items
  ADD COLUMN IF NOT EXISTS ai_grade_status VARCHAR(12) NOT NULL DEFAULT 'none',
  ADD COLUMN IF NOT EXISTS ai_grade_attempts SMALLINT NOT NULL DEFAULT 0,
  ADD COLUMN IF NOT EXISTS ai_grade_json JSONB,
  ADD COLUMN IF NOT EXISTS ai_grade_model TEXT,
  ADD COLUMN IF NOT EXISTS ai_grade_checked_at TIMESTAMPTZ;
DO $$ BEGIN
  IF NOT EXISTS (SELECT 1 FROM pg_constraint WHERE conname='translation_run_items_ai_status_check') THEN
    ALTER TABLE translation_run_items ADD CONSTRAINT translation_run_items_ai_status_check
    CHECK(ai_grade_status IN ('none','processing','ready','failed'));
  END IF;
END $$;
CREATE INDEX IF NOT EXISTS idx_translation_ai_status ON translation_run_items(ai_grade_status);
COMMIT;
