import 'dart:io';

import 'package:fixnum/fixnum.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sqlite3/sqlite3.dart';
import 'package:wasla/core/storage/local_store.dart';
import 'package:wasla/core/storage/sqlite_store.dart';
import 'package:wasla/gen/proto/wasla/v1/messages.pb.dart';

Message msg(String t) => Message(
      chatId: Int64(7),
      seq: Int64(1),
      senderId: Int64(2),
      content: MessageContent(text: TextContent(text: FormattedText(text: t))),
    );

bool fileContains(String path, String needle) {
  final bytes = File(path).readAsBytesSync();
  return String.fromCharCodes(bytes).contains(needle);
}

void main() {
  late Directory dir;
  late String path;
  final keyA = newHexKey();
  final keyB = newHexKey();

  setUp(() {
    dir = Directory.systemTemp.createTempSync('wasla-db');
    path = '${dir.path}/wasla.db';
  });
  tearDown(() => dir.deleteSync(recursive: true));

  test('keys are 256 random bits', () {
    expect(keyA, matches(RegExp(r'^[0-9a-f]{64}$')));
    expect(keyA, isNot(keyB));
  });

  test('messages are unreadable on disk and come back with the key', () {
    var outcome = <OpenOutcome>[];
    var store = SqliteStore(openEncrypted(path, keyA, onOutcome: outcome.add));
    store.saveMessages([msg('secret-marker-123')]);
    store.close();
    expect(outcome, [OpenOutcome.opened]);
    for (final f in dir.listSync().whereType<File>()) {
      expect(fileContains(f.path, 'secret-marker-123'), isFalse, reason: f.path);
    }

    // Plain SQLite (no key) can't read it at all.
    final raw = sqlite3.open(path);
    expect(() => raw.select('SELECT * FROM messages'), throwsA(isA<SqliteException>()));
    raw.close();

    store = SqliteStore(openEncrypted(path, keyA));
    final snap = store.load(Int64.ZERO);
    expect(snap.messages[Int64(7)]!.single.content.text.text.text, 'secret-marker-123');
    store.close();
  });

  test('an unencrypted database from an older version is encrypted in place, keeping everything', () {
    final old = sqlite3.open(path);
    final plain = SqliteStore(old);
    plain.saveMessages([msg('old-plain-marker')]);
    plain.saveOutgoing(StoredOutgoing(chatId: Int64(7), randomId: Int64(9), text: 'unsent', createdAt: DateTime(2026, 11, 22)));
    plain.close();
    expect(fileContains(path, 'old-plain-marker'), isTrue);

    final outcome = <OpenOutcome>[];
    final store = SqliteStore(openEncrypted(path, keyA, onOutcome: outcome.add));
    expect(outcome, [OpenOutcome.encryptedExisting]);
    final snap = store.load(Int64.ZERO);
    expect(snap.messages[Int64(7)]!.single.content.text.text.text, 'old-plain-marker');
    expect(snap.outbox.single.text, 'unsent');
    store.close();
    for (final f in dir.listSync().whereType<File>()) {
      expect(fileContains(f.path, 'old-plain-marker'), isFalse, reason: f.path);
    }
  });

  test('with a different key (key lost) the cache starts fresh instead of crashing', () {
    var store = SqliteStore(openEncrypted(path, keyA));
    store.saveMessages([msg('under-key-a')]);
    store.close();

    final outcome = <OpenOutcome>[];
    store = SqliteStore(openEncrypted(path, keyB, onOutcome: outcome.add));
    expect(outcome, [OpenOutcome.recreated]);
    expect(store.load(Int64.ZERO).messages, isEmpty);
    store.saveMessages([msg('under-key-b')]);
    store.close();

    store = SqliteStore(openEncrypted(path, keyB));
    expect(store.load(Int64.ZERO).messages[Int64(7)]!.single.content.text.text.text, 'under-key-b');
    store.close();
  });

  test('the key is made once, kept in secure storage, and replaced if damaged', () async {
    FlutterSecureStorage.setMockInitialValues({});
    final k1 = await DatabaseKey().load();
    final k2 = await DatabaseKey().load();
    expect(k1, matches(RegExp(r'^[0-9a-f]{64}$')));
    expect(k2, k1);
    FlutterSecureStorage.setMockInitialValues({'wasla.db_key.v1': 'not-a-key'});
    expect(await DatabaseKey().load(), matches(RegExp(r'^[0-9a-f]{64}$')));
  });

  test('bad keys are refused', () {
    expect(() => openEncrypted(path, "x'; DROP TABLE"), throwsArgumentError);
  });
}
