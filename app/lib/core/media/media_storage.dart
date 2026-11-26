import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../chat/chat_store.dart';
import '../storage/local_store.dart';
import 'media.dart';
import 'source.dart';

/// Downloaded photos and files on the phone: how long to keep them, how much
/// space they use, and clearing them. Files waiting to be sent are never
/// touched. Anything removed downloads again from the server when opened.
class MediaStorage {
  MediaStorage(this.ref);
  final Ref ref;

  /// Choices offered in settings, in days; 0 means keep forever.
  static const choices = [3, 7, 30, 0];
  static const defaultDays = 30;
  static const _key = 'media_keep_days';

  Future<LocalStore> get _store => ref.read(localStoreProvider);

  /// Days to keep a downloaded file after it was last opened; 0 = forever.
  Future<int> keepDays() async {
    try {
      final v = int.tryParse((await _store).setting(_key) ?? '');
      return v != null && choices.contains(v) ? v : defaultDays;
    } catch (_) {
      return defaultDays;
    }
  }

  Future<void> setKeepDays(int days) async {
    if (!choices.contains(days)) throw ArgumentError.value(days, 'days');
    (await _store).setSetting(_key, '$days');
  }

  Future<CacheUsage> usage() => cacheUsage('media');

  /// Deletes everything downloaded; returns bytes freed.
  Future<int> clear() async {
    ref.read(mediaCacheProvider).clearMemory();
    return clearCache('media');
  }

  DateTime? _lastSweep;

  /// Removes files not opened within the chosen period. Runs at most every
  /// 6 hours unless [force]. Returns bytes freed.
  Future<int> sweep({bool force = false, DateTime? now}) async {
    final t = now ?? DateTime.now();
    if (!force && _lastSweep != null && t.difference(_lastSweep!) < const Duration(hours: 6)) return 0;
    _lastSweep = t;
    final days = await keepDays();
    if (days == 0) return 0;
    return sweepCache('media', t.subtract(Duration(days: days)));
  }
}

final mediaStorageProvider = Provider<MediaStorage>(MediaStorage.new);
