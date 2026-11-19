-- Sprint 3: photos and files.
BEGIN;

-- Uploads in progress. upload_token is the opaque handle given to the
-- client (never the S3 id), so one user can't touch another's upload.
ALTER TABLE media_files
    ADD COLUMN upload_token text,
    ADD COLUMN s3_upload_id text;              -- NULL for single-PUT uploads
CREATE UNIQUE INDEX media_files_upload_token_uq ON media_files (upload_token) WHERE upload_token IS NOT NULL;

-- Finding every message that carries a file (takedown of blocklisted media).
CREATE INDEX messages_media_idx ON messages (media_id) WHERE media_id IS NOT NULL;

-- Automatic reports (e.g. a blocklisted file was uploaded) have no human reporter.
ALTER TABLE reports
    ALTER COLUMN reporter_id DROP NOT NULL,
    ADD COLUMN source smallint NOT NULL DEFAULT 1,      -- 1 user report, 2 automatic
    ADD CONSTRAINT reports_reporter_or_auto CHECK (reporter_id IS NOT NULL OR source = 2);

COMMIT;
