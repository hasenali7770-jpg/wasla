import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sqlite3/sqlite3.dart';
import 'package:wasla/core/chat/chat_store.dart';
import 'package:wasla/core/l10n/app_localizations.dart';
import 'package:wasla/core/media/media.dart';
import 'package:wasla/core/media/media_dir.dart';
import 'package:wasla/core/media/media_storage.dart';
import 'package:wasla/core/storage/local_store.dart';
import 'package:wasla/core/storage/sqlite_store.dart';
import 'package:wasla/features/settings/storage_screen.dart';

import 'fakes/fake_chat_api.dart';
import 'fakes/fake_media.dart';

/// Disk work in memory, so widget tests don't touch real files.
class FakeMediaStorage extends MediaStorage {
  FakeMediaStorage(super.ref);
  CacheUsage current = const CacheUsage(12, 34 * 1024 * 1024);
  int clears = 0;
  final sweeps = <int>[];
  @override
  Future<CacheUsage> usage() async => current;
  @override
  Future<int> clear() async {
    clears++;
    final freed = current.bytes;
    current = CacheUsage.empty;
    return freed;
  }

  @override
  Future<int> sweep({bool force = false, DateTime? now}) async {
    sweeps.add(await keepDays());
    return 0;
  }
}

void main() {
  group('media folder', () {
    late Directory dir;
    setUp(() => dir = Directory.systemTemp.createTempSync('wasla-media'));
    tearDown(() => dir.deleteSync(recursive: true));

    File put(String name, int bytes, DateTime lastUsed) =>
        File('${dir.path}/$name')
          ..writeAsBytesSync(Uint8List(bytes))
          ..setLastModifiedSync(lastUsed);

    test('sweep removes only files not opened within the period', () {
      final now = DateTime(2026, 11, 22, 12);
      final old = put('old.jpg', 1000, now.subtract(const Duration(days: 31)));
      final recent = put('recent.jpg', 500, now.subtract(const Duration(days: 2)));
      expect(usageOf(dir).files, 2);
      expect(usageOf(dir).bytes, 1500);

      final freed = sweepDirectory(dir, now.subtract(const Duration(days: 30)));
      expect(freed, 1000);
      expect(old.existsSync(), isFalse);
      expect(recent.existsSync(), isTrue);
    });

    test('opening a file restarts its period', () {
      final f = put('a.pdf', 10, DateTime(2020));
      touchFile(f);
      expect(DateTime.now().difference(f.lastModifiedSync()).inMinutes, lessThan(1));
      expect(sweepDirectory(dir, DateTime.now().subtract(const Duration(days: 3))), 0);
    });

    test('clear removes everything; a missing folder is fine', () {
      put('a', 10, DateTime.now());
      put('b', 20, DateTime.now());
      expect(clearDirectory(dir), 30);
      expect(usageOf(dir), isA<CacheUsage>().having((u) => u.files, 'files', 0));
      expect(usageOf(Directory('${dir.path}/nope')).bytes, 0);
    });
  });

  test('the chosen period is kept in the encrypted database and survives logout', () async {
    final store = SqliteStore(openEncrypted('${Directory.systemTemp.createTempSync('wasla-s').path}/w.db', newHexKey()));
    final c = ProviderContainer(overrides: [localStoreProvider.overrideWithValue(Future.value(store))]);
    addTearDown(c.dispose);
    final m = c.read(mediaStorageProvider);
    expect(await m.keepDays(), 30, reason: 'default');
    await m.setKeepDays(7);
    store.wipe(); // logout
    expect(await m.keepDays(), 7);
    expect(() => m.setKeepDays(5), throwsArgumentError);
    store.setSetting('media_keep_days', 'junk');
    expect(await m.keepDays(), 30);
    store.close();
  });

  test('a stored setting is not visible without the right key', () {
    final path = '${Directory.systemTemp.createTempSync('wasla-s').path}/w.db';
    final key = newHexKey();
    var s = SqliteStore(openEncrypted(path, key))..setSetting('media_keep_days', '3');
    s.close();
    s = SqliteStore(openEncrypted(path, key));
    expect(s.setting('media_keep_days'), '3');
    s.close();
    final raw = sqlite3.open(path);
    expect(() => raw.select('SELECT * FROM kv'), throwsA(isA<SqliteException>()));
    raw.close();
  });

  testWidgets('settings: shows usage, changes the period, clears media', (tester) async {
    late FakeMediaStorage fake;
    final api = FakeChatApi();
    await tester.pumpWidget(ProviderScope(
      overrides: [
        localStoreProvider.overrideWithValue(Future.value(MemoryStore())),
        mediaStorageProvider.overrideWith((ref) => fake = FakeMediaStorage(ref)),
        mediaCacheProvider.overrideWithValue(MediaCache(FakeMediaTransfer(api), disk: const NoDisk())),
      ],
      child: const MaterialApp(
        locale: Locale('ar'),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: StorageScreen(),
      ),
    ));
    await tester.pumpAndSettle();

    expect(find.text('البيانات والتخزين'), findsOneWidget);
    expect(find.text('12 ملفاً · 34 م.ب'), findsOneWidget);
    final radio30 = tester.widget<RadioListTile<int>>(find.byKey(const Key('keep-30')));
    expect(radio30.value, 30);
    expect(find.text('30 يوماً (الافتراضي)'), findsOneWidget);

    await tester.tap(find.byKey(const Key('keep-7')));
    await tester.pumpAndSettle();
    expect(await fake.keepDays(), 7);
    expect(fake.sweeps, [7], reason: 'a shorter period applies at once');

    await tester.tap(find.byKey(const Key('clear-media')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('confirm-clear-media')));
    await tester.pumpAndSettle();
    expect(fake.clears, 1);
    expect(find.text('تم تحرير 34 م.ب'), findsOneWidget);
    expect(find.text('لا شيء · 0 ك.ب'), findsOneWidget);
  });
}
