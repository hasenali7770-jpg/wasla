import 'dart:io';
import 'dart:math';

import 'package:fixnum/fixnum.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqlite3/sqlite3.dart';

import '../../gen/proto/wasla/v1/chats.pb.dart';
import '../../gen/proto/wasla/v1/messages.pb.dart';
import '../../gen/proto/wasla/v1/users.pb.dart';
import 'local_store.dart';

Future<LocalStore> openPlatformStore() async {
  final dir = await getApplicationSupportDirectory();
  await dir.create(recursive: true);
  final key = await DatabaseKey().load();
  return SqliteStore(openEncrypted('${dir.path}${Platform.pathSeparator}wasla.db', key));
}

/// The database key: 32 random bytes made on first use and kept in the
/// Android Keystore / iOS Keychain (flutter_secure_storage), never in the
/// app's files. Uninstalling the app removes both the key and the database.
class DatabaseKey {
  DatabaseKey([FlutterSecureStorage? storage]) : _s = storage ?? const FlutterSecureStorage();
  final FlutterSecureStorage _s;
  static const _name = 'wasla.db_key.v1';

  Future<String> load() async {
    final existing = await _s.read(key: _name);
    if (existing != null && RegExp(r'^[0-9a-f]{64}$').hasMatch(existing)) return existing;
    final key = newHexKey();
    await _s.write(key: _name, value: key);
    return key;
  }
}

/// 256 random bits as 64 hex characters.
String newHexKey() {
  final r = Random.secure();
  return [for (var i = 0; i < 32; i++) r.nextInt(256).toRadixString(16).padLeft(2, '0')].join();
}

/// How [openEncrypted] found the file (for logs and tests).
enum OpenOutcome { opened, encryptedExisting, recreated }

/// Opens the encrypted database at [path] with [hexKey] (ADR-011,
/// SQLite3MultipleCiphers, ChaCha20-Poly1305).
///
/// - A new or already encrypted file opens normally.
/// - An unencrypted file from an older app version is encrypted in place, so
///   nothing is lost.
/// - A file that can't be opened with this key (key lost, file damaged) is
///   deleted and started fresh. It is only a cache: chats come back from the
///   server; only unsent messages are lost.
Database openEncrypted(String path, String hexKey, {void Function(OpenOutcome)? onOutcome}) {
  if (!RegExp(r'^[0-9a-f]{64}$').hasMatch(hexKey)) throw ArgumentError('key must be 64 hex characters');
  Database keyed() => sqlite3.open(path)..execute("PRAGMA hexkey = '$hexKey'");
  bool readable(Database db) {
    try {
      db.select('SELECT count(*) FROM sqlite_master');
      return true;
    } on SqliteException {
      return false;
    }
  }

  var db = keyed();
  if (readable(db)) {
    onOutcome?.call(OpenOutcome.opened);
    return db;
  }
  db.close();

  // An unencrypted database from before ADR-011?
  db = sqlite3.open(path);
  if (readable(db)) {
    db.execute('PRAGMA journal_mode = DELETE'); // folds the WAL in; rekey needs it
    db.execute("PRAGMA hexrekey = '$hexKey'");
    db.close();
    db = keyed();
    if (readable(db)) {
      onOutcome?.call(OpenOutcome.encryptedExisting);
      return db;
    }
  }
  db.close();

  debugPrint('local store: database unreadable with this key; starting fresh');
  for (final suffix in ['', '-wal', '-shm', '-journal']) {
    final f = File('$path$suffix');
    if (f.existsSync()) f.deleteSync();
  }
  onOutcome?.call(OpenOutcome.recreated);
  return keyed();
}

/// SQLite implementation. Writes are small and synchronous; WAL mode keeps
/// them fast (no fsync per statement). The file is encrypted; see
/// [openEncrypted].
class SqliteStore implements LocalStore {
  SqliteStore(this.db) {
    db.execute('PRAGMA journal_mode = WAL');
    db.execute('PRAGMA synchronous = NORMAL');
    _migrate();
  }

  final Database db;
  static const schemaVersion = 2;

  void _migrate() {
    final v = db.select('PRAGMA user_version').first.columnAt(0) as int;
    if (v >= schemaVersion) return;
    if (v < 1) {
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
    ''');
    }
    if (v < 2) {
      // v2: photos and files waiting to be sent (OutMedia as JSON).
      db.execute('ALTER TABLE outbox ADD COLUMN media TEXT');
    }
    db.execute('PRAGMA user_version = $schemaVersion');
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
          media: OutMedia.fromJson(r['media'] as String?),
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
        'INSERT OR REPLACE INTO outbox (random_id, chat_id, text, reply_to, created_at, failed, media) VALUES (?, ?, ?, ?, ?, ?, ?)',
        [o.randomId.toInt(), o.chatId.toInt(), o.text, o.replyTo?.toInt(), o.createdAt.millisecondsSinceEpoch, o.failed ? 1 : 0, o.media?.toJson()],
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
