-- Smoke test of the core write path, run in CI after migrations.
-- Exercises: private chat + group creation, per-chat seq allocation,
-- fan-out of updates with deadlock-safe pts allocation, idempotent retry
-- via random_id, and read receipts. Everything is rolled back.
\set ON_ERROR_STOP on
BEGIN;

INSERT INTO users (id, phone, first_name, username) VALUES
    (1001, '+9647700000001', 'علي',  'ali_iq'),
    (1002, '+9647800000002', 'سارة', NULL),
    (1003, '+9647500000003', 'Omar', 'omar_dev');
INSERT INTO user_update_state (user_id) VALUES (1001), (1002), (1003);

-- Private chat Ali ↔ Sara
INSERT INTO chats (id, type, member_count) VALUES (5001, 1, 2);
INSERT INTO private_chat_pairs (user_low, user_high, chat_id) VALUES (1001, 1002, 5001);
INSERT INTO chat_members (chat_id, user_id) VALUES (5001, 1001), (5001, 1002);

-- Group with all three
INSERT INTO chats (id, type, title, creator_id, member_count) VALUES (5002, 3, 'العائلة', 1001, 3);
INSERT INTO chat_members (chat_id, user_id, role) VALUES (5002, 1001, 3), (5002, 1002, 1), (5002, 1003, 1);

-- === SendMessage, as the server runs it (one transaction) ===
-- 1. allocate seq
WITH s AS (
    UPDATE chats SET last_seq = last_seq + 1, last_message_at = now()
    WHERE id = 5002 RETURNING last_seq
)
-- 2. insert message (idempotent on random_id)
INSERT INTO messages (chat_id, seq, sender_id, random_id, kind, text)
SELECT 5002, last_seq, 1001, 777, 1, 'مرحبا بالجميع' FROM s
ON CONFLICT (chat_id, sender_id, random_id) DO NOTHING;

-- 3. lock member pts rows in user_id order (deadlock-safe), bump, log updates
WITH locked AS (
    SELECT s.user_id FROM user_update_state s
    JOIN chat_members m ON m.user_id = s.user_id AND m.chat_id = 5002
    ORDER BY s.user_id FOR UPDATE OF s
), bumped AS (
    UPDATE user_update_state s SET pts = s.pts + 1
    FROM locked WHERE s.user_id = locked.user_id
    RETURNING s.user_id, s.pts
)
INSERT INTO user_updates (user_id, pts, kind, chat_id, payload)
SELECT user_id, pts, 10, 5002, '\x00'::bytea FROM bumped;

-- 4. sender has read their own message
UPDATE chat_members SET read_inbox_seq = 1 WHERE chat_id = 5002 AND user_id = 1001;

-- Retry with the same random_id must not create a second message
WITH s AS (SELECT last_seq + 1 AS next FROM chats WHERE id = 5002)
INSERT INTO messages (chat_id, seq, sender_id, random_id, kind, text)
SELECT 5002, next, 1001, 777, 1, 'مرحبا بالجميع' FROM s
ON CONFLICT (chat_id, sender_id, random_id) DO NOTHING;

-- Sara reads → Ali's outbox becomes read (✓✓)
UPDATE chat_members SET read_inbox_seq = 1 WHERE chat_id = 5002 AND user_id = 1002;
UPDATE chat_members SET read_outbox_seq = GREATEST(read_outbox_seq, 1)
WHERE chat_id = 5002 AND user_id <> 1002;

DO $$
DECLARE n int; p bigint; unread int;
BEGIN
    SELECT count(*) INTO n FROM messages WHERE chat_id = 5002;
    IF n <> 1 THEN RAISE EXCEPTION 'expected 1 message, got %', n; END IF;

    SELECT count(*) INTO n FROM user_updates WHERE chat_id = 5002;
    IF n <> 3 THEN RAISE EXCEPTION 'expected 3 fan-out updates, got %', n; END IF;

    SELECT pts INTO p FROM user_update_state WHERE user_id = 1003;
    IF p <> 1 THEN RAISE EXCEPTION 'expected pts 1 for user 1003, got %', p; END IF;

    SELECT read_outbox_seq INTO p FROM chat_members WHERE chat_id = 5002 AND user_id = 1001;
    IF p <> 1 THEN RAISE EXCEPTION 'expected Ali read_outbox_seq 1, got %', p; END IF;

    -- Omar's unread count (exact form used by ListDialogs)
    SELECT count(*) INTO unread FROM messages msg
    JOIN chat_members m ON m.chat_id = msg.chat_id AND m.user_id = 1003
    WHERE msg.chat_id = 5002 AND msg.seq > m.read_inbox_seq
      AND msg.sender_id <> 1003 AND msg.deleted_at IS NULL;
    IF unread <> 1 THEN RAISE EXCEPTION 'expected 1 unread for Omar, got %', unread; END IF;

    -- Username uniqueness is case-insensitive
    BEGIN
        INSERT INTO users (id, phone, first_name, username) VALUES (1004, '+9647700000004', 'X', 'ALI_IQ');
        RAISE EXCEPTION 'case-insensitive username uniqueness not enforced';
    EXCEPTION WHEN unique_violation THEN NULL;
    END;

    RAISE NOTICE 'smoke test passed';
END $$;

ROLLBACK;
