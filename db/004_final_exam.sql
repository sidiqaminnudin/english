BEGIN;
-- NULL module_id identifies a cross-module final exam; existing attempts stay intact.
ALTER TABLE attempts ALTER COLUMN module_id DROP NOT NULL;
COMMIT;
