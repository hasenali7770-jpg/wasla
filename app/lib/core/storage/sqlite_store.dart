import 'dart:io';

import 'package:fixnum/fixnum.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqlite3/sqlite3.dart';

import '../../gen/proto/wasla/v1/chats.pb.dart';
import '../../gen/proto/wasla/v1/messages.pb.dart';
import '../../gen/proto/wasla/v1/users.pb.dart';
import 'local_store.dart';

Future<LocalStore> openPlatformStore() async {
  final dir = await getApplicationSupportDirectory();
  await dir.create(recursive: true);
  return SqliteStore(sqlite3.open('${dir.path}${Platform.pathSeparator}wasla.db'));
}

/// SQLite implementation. Writes are small and synchronous; WAL mode keeps
/// them fast (no fsync per statement).
///
/// TODO(launch-checklist): encrypt with SQLCipher, key in Keystore/Keychain.
class SqliteStore implements LocalStore {
  SqliteStore(this.db) {
    db.execute('PRAGMA journal_mode = WAL');
    db.execute('PRAGMA synchronous = NORMAL');
    _migrate();
  }

  final Database db;
  static const schemaVersion = 1;

  void _migrate() {
    final v = db.select('PRAGMA user_version').first.columnAt(0) as int;
    if (v >= schemaVersion) return;
    db.execute('''
      CREATE TABLE IF NOT EXISTS kv (key TEXT PRIMARY KEY, value TEXT NOT NULL);
      CREATE TABLE IF NOT EXISTS chats (id INTEGER PRIMARY KEY, chat BLOB NOT NULL, dialog BLOB NOT NULL);
      CREATE TABLE IF NOT EXISTS users (id INTEGER PRIMARY KEY, user BLOB NOT NULL);
      CREATE TABLE IF NOT EXISTS messages (
        chat_id INTEGER NOT NULL, seq INTEGER NOT NULL, msg BLOB NOT NULL,
        PRIMARY KEY (chat_id, seq)) WITHOUT ROWID;
      CREATE TABLE IF NOT EXISTS outbox (
        random_id INTEGER PRIMARY KEY, chat_id INTEGER NOT NULL, text TEXT NOT NULL,
        reply_to INTEGER, created_at INTEGER NOT NULL, failed INTEGER NOT NULL DEFAULT 0);
      PRAGMA user_version = $schemaVersion;
    ''');
  }

  String? _kv(String key) {
    final r = db.select('SELECT value FROM kv WHERE key = ?', [key]);
    return r.isEmpty ? null : r.first['value'] as String;
  }

  void _setKv(String key, String value) =>
      db.execute('INSERT INTO kv (key, value) VALUES (?, ?) ON CONFLICT (key) DO UPDATE SET value = excluded.value', [key, value]);

  @override
  Snapshot load(Int64 userId) {
    final owner = Int64.parseInt(_kv('owner') ?? '0');
    if (userId != Int64.ZERO && owner != Int64.ZERO && owner != userId) {
      wipe(); // a different account signed in on this device
      return Snapshot(ownerId: userId);
    }
    final chats = <Int64, (Chat, Dialog)>{};
    for (final r in db.select('SELECT chat, dialog FROM chats')) {
      final c = Chat.fromBuffer(r['chat'] as List<int>);
      chats[c.id] = (c, Dialog.fromBuffer(r['dialog'] as List<int>));
    }
    final users = <Int64, User>{};
    for (final r in db.select('SELECT user FROM users')) {
      final u = User.fromBuffer(r['user'] as List<int>);
      users[u.id] = u;
    }
    final messages = <Int64, List<Message>>{};
    // The newest 200 per chat are enough to open any chat instantly; older
    // ones load from the server when scrolled to.
    for (final r in db.select('''
        SELECT msg FROM (SELECT msg, chat_id, seq, ROW_NUMBER() OVER (PARTITION BY chat_id ORDER BY seq DESC) AS n FROM messages)
        WHERE n <= 200 ORDER BY chat_id, seq''')) {
      final m = Message.fromBuffer(r['msg'] as List<int>);
      (messages[m.chatId] ??= []).add(m);
    }
    final outbox = [
      for (final r in db.select('SELECT * FROM outbox ORDER BY created_at'))
        StoredOutgoing(
          chatId: Int64(r['chat_id'] as int),
          randomId: Int64(r['random_id'] as int),
          text: r['text'] as String,
          replyTo: r['reply_to'] == null ? null : Int64(r['reply_to'] as int),
          createdAt: DateTime.fromMillisecondsSinceEpoch(r['created_at'] as int),
          failed: (r['failed'] as int) == 1,
        ),
    ];
    return Snapshot(
      ownerId: owner,
      pts: Int64.parseInt(_kv('pts') ?? '0'),
      chats: chats,
      users: users,
      messages: messages,
      outbox: outbox,
    );
  }

  @override
  void setOwner(Int64 userId) {
    if (userId != Int64.ZERO) _setKv('owner', userId.toString());
  }

  @override
  void savePts(Int64 pts) => _setKv('pts', pts.toString());

  @override
  void saveChat(Chat chat, Dialog dialog) => db.execute(
        'INSERT OR REPLACE INTO chats (id, chat, dialog) VALUES (?, ?, ?)',
        [chat.id.toInt(), chat.writeToBuffer(), dialog.writeToBuffer()],
      );

  @override
  void deleteChat(Int64 chatId) {
    db.execute('DELETE FROM chats WHERE id = ?', [chatId.toInt()]);
    db.execute('DELETE FROM messages WHERE chat_id = ?', [chatId.toInt()]);
  }

  @override
  void saveUser(User user) =>
      db.execute('INSERT OR REPLACE INTO users (id, user) VALUES (?, ?)', [user.id.toInt(), user.writeToBuffer()]);

  @override
  void saveMessages(Iterable<Message> messages) {
    final stmt = db.prepare('INSERT OR REPLACE INTO messages (chat_id, seq, msg) VALUES (?, ?, ?)');
    db.execute('BEGIN');
    try {
      for (final m in messages) {
        stmt.execute([m.chatId.toInt(), m.seq.toInt(), m.writeToBuffer()]);
      }
      db.execute('COMMIT');
    } catch (_) {
      db.execute('ROLLBACK');
      rethrow;
    } finally {
      stmt.close();
    }
  }

  @override
  void deleteMessages(Int64 chatId, Iterable<Int64> seqs) {
    for (final s in seqs) {
      db.execute('DELETE FROM messages WHERE chat_id = ? AND seq = ?', [chatId.toInt(), s.toInt()]);
    }
  }

  @override
  void deleteMessagesUpTo(Int64 chatId, Int64 maxSeq) =>
      db.execute('DELETE FROM messages WHERE chat_id = ? AND seq <= ?', [chatId.toInt(), maxSeq.toInt()]);

  @override
  void deleteAllMessages() => db.execute('DELETE FROM messages');

  @override
  void saveOutgoing(StoredOutgoing o) => db.execute(
        'INSERT OR REPLACE INTO outbox (random_id, chat_id, text, reply_to, created_at, failed) VALUES (?, ?, ?, ?, ?, ?)',
        [o.randomId.toInt(), o.chatId.toInt(), o.text, o.replyTo?.toInt(), o.createdAt.millisecondsSinceEpoch, o.failed ? 1 : 0],
      );

  @override
  void deleteOutgoing(Int64 randomId) => db.execute('DELETE FROM outbox WHERE random_id = ?', [randomId.toInt()]);

  @override
  void wipe() {
    db.execute('DELETE FROM kv; DELETE FROM chats; DELETE FROM users; DELETE FROM messages; DELETE FROM outbox;');
  }

  @override
  void close() => db.close();
}
