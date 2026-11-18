-- Sprint 1: moderation is a launch blocker (CMC enforcement against Telegram,
-- Nov 2026). Adds report triage (priority + SLA deadline + assignment), legal
-- requests from authorities, bans that survive account deletion, chat
-- takedowns, and a blocklist of known illegal media hashes.

BEGIN;

-- Report triage ------------------------------------------------------------
-- priority: 1 critical (child abuse, terrorism), 2 high (violence, illegal
-- goods, scam), 3 normal. due_at = created_at + SLA for that priority
-- (defaults 1 h / 4 h / 24 h, configurable in the server).
ALTER TABLE reports
    ADD COLUMN priority    smallint    NOT NULL DEFAULT 3,
    ADD COLUMN due_at      timestamptz NOT NULL DEFAULT now() + interval '24 hours',
    ADD COLUMN assigned_to bigint      REFERENCES staff_users (id),
    ADD COLUMN assigned_at timestamptz,
    ADD CONSTRAINT reports_priority_valid CHECK (priority BETWEEN 1 AND 3),
    ADD CONSTRAINT reports_status_valid   CHECK (status BETWEEN 1 AND 3);

DROP INDEX reports_open_idx;
-- The review queue: most urgent first, then oldest deadline.
CREATE INDEX reports_queue_idx ON reports (priority, due_at) WHERE status = 1;
CREATE INDEX reports_chat_idx  ON reports (chat_id) WHERE chat_id IS NOT NULL;

-- Bans ---------------------------------------------------------------------
ALTER TABLE users ADD COLUMN ban_expires_at timestamptz;   -- NULL with banned_at set = permanent

-- Phone numbers barred from (re-)registering. Stored as HMAC-SHA256(pepper,
-- phone) so the list is useless if leaked, and it survives account deletion.
CREATE TABLE banned_phones (
    phone_hash bytea       PRIMARY KEY,
    reason     text        NOT NULL,
    action_id  bigint      REFERENCES moderation_actions (id),
    expires_at timestamptz,
    created_at timestamptz NOT NULL DEFAULT now(),
    CONSTRAINT banned_phones_hash_len CHECK (octet_length(phone_hash) = 32)
);

-- Chat takedown: a banned chat rejects every read and write and disappears
-- from members' chat lists.
ALTER TABLE chats
    ADD COLUMN banned_at  timestamptz,
    ADD COLUMN ban_reason text;

-- Known illegal media ------------------------------------------------------
-- Checked on CompleteUpload; a match rejects the upload and opens a critical
-- report automatically. (Perceptual hashing, e.g. PhotoDNA, comes later.)
CREATE TABLE media_blocklist (
    sha256     bytea       PRIMARY KEY,
    reason     smallint    NOT NULL,                      -- wasla.v1.ReportReason
    note       text        NOT NULL DEFAULT '',
    added_by   bigint      REFERENCES staff_users (id),
    created_at timestamptz NOT NULL DEFAULT now(),
    CONSTRAINT media_blocklist_sha_len CHECK (octet_length(sha256) = 32)
);

-- Requests from authorities (CMC, courts, police) --------------------------
CREATE TABLE legal_requests (
    id            bigint      GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    authority     text        NOT NULL,                   -- e.g. "CMC", "Karkh Investigation Court"
    reference_no  text        NOT NULL DEFAULT '',
    request_type  smallint    NOT NULL,                   -- 1 content takedown, 2 account suspension, 3 user data
    description   text        NOT NULL,
    targets       jsonb       NOT NULL DEFAULT '[]',      -- [{"user_id":..}, {"chat_id":..,"seqs":[..]}]
    received_at   timestamptz NOT NULL DEFAULT now(),
    due_at        timestamptz,
    status        smallint    NOT NULL DEFAULT 1,         -- 1 open, 2 complied, 3 partially complied, 4 rejected (legal basis insufficient)
    legal_review  text        NOT NULL DEFAULT '',        -- counsel's notes on the legal basis
    response      text        NOT NULL DEFAULT '',
    created_by    bigint      NOT NULL REFERENCES staff_users (id),
    closed_by     bigint      REFERENCES staff_users (id),
    closed_at     timestamptz,
    CONSTRAINT legal_requests_type_valid   CHECK (request_type BETWEEN 1 AND 3),
    CONSTRAINT legal_requests_status_valid CHECK (status BETWEEN 1 AND 4)
);

CREATE INDEX legal_requests_open_idx ON legal_requests (due_at) WHERE status = 1;

ALTER TABLE moderation_actions
    ADD COLUMN legal_request_id bigint REFERENCES legal_requests (id),
    ADD COLUMN message_seqs     bigint[] NOT NULL DEFAULT '{}';

COMMIT;
