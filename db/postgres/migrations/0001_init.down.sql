BEGIN;

DROP TABLE IF EXISTS
    moderation_actions,
    reports,
    staff_users,
    user_updates,
    chat_pins,
    message_hides,
    messages,
    chat_invites,
    chat_members,
    private_chat_pairs,
    chats,
    profile_photos,
    contacts,
    user_blocks,
    privacy_exceptions,
    privacy_rules,
    otp_requests,
    sessions,
    account_passwords,
    user_update_state
CASCADE;

ALTER TABLE IF EXISTS users DROP CONSTRAINT IF EXISTS users_photo_fk;
DROP TABLE IF EXISTS media_files CASCADE;
DROP TABLE IF EXISTS users CASCADE;

COMMIT;
