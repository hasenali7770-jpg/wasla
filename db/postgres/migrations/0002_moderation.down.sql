BEGIN;

ALTER TABLE moderation_actions
    DROP COLUMN IF EXISTS legal_request_id,
    DROP COLUMN IF EXISTS message_seqs;
DROP TABLE IF EXISTS legal_requests;
DROP TABLE IF EXISTS media_blocklist;
ALTER TABLE chats DROP COLUMN IF EXISTS banned_at, DROP COLUMN IF EXISTS ban_reason;
DROP TABLE IF EXISTS banned_phones;
ALTER TABLE users DROP COLUMN IF EXISTS ban_expires_at;

DROP INDEX IF EXISTS reports_queue_idx;
DROP INDEX IF EXISTS reports_chat_idx;
ALTER TABLE reports
    DROP CONSTRAINT IF EXISTS reports_priority_valid,
    DROP CONSTRAINT IF EXISTS reports_status_valid,
    DROP COLUMN IF EXISTS priority,
    DROP COLUMN IF EXISTS due_at,
    DROP COLUMN IF EXISTS assigned_to,
    DROP COLUMN IF EXISTS assigned_at;
CREATE INDEX reports_open_idx ON reports (created_at) WHERE status = 1;

COMMIT;
