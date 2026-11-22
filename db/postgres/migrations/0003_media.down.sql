BEGIN;
DELETE FROM reports WHERE reporter_id IS NULL;
ALTER TABLE reports
    DROP CONSTRAINT IF EXISTS reports_reporter_or_auto,
    DROP COLUMN IF EXISTS source,
    ALTER COLUMN reporter_id SET NOT NULL;
DROP INDEX IF EXISTS messages_media_idx;
DROP INDEX IF EXISTS media_files_upload_token_uq;
ALTER TABLE media_files DROP COLUMN IF EXISTS upload_token, DROP COLUMN IF EXISTS s3_upload_id;
COMMIT;
