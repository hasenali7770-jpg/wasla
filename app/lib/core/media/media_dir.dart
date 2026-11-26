import 'dart:io';

import 'cache_usage.dart';

export 'cache_usage.dart';

CacheUsage usageOf(Directory d) {
  if (!d.existsSync()) return CacheUsage.empty;
  var files = 0, bytes = 0;
  for (final f in d.listSync(recursive: true).whereType<File>()) {
    files++;
    bytes += f.lengthSync();
  }
  return CacheUsage(files, bytes);
}

/// Deletes files last used (modified time, refreshed when opened) before
/// [cutoff]. Returns the bytes freed.
int sweepDirectory(Directory d, DateTime cutoff) {
  if (!d.existsSync()) return 0;
  var freed = 0;
  for (final f in d.listSync(recursive: true).whereType<File>()) {
    try {
      if (f.lastModifiedSync().isBefore(cutoff)) {
        final n = f.lengthSync();
        f.deleteSync();
        freed += n;
      }
    } on FileSystemException {
      // in use or already gone: try again next sweep
    }
  }
  return freed;
}

/// Deletes every file in [d]. Returns the bytes freed.
int clearDirectory(Directory d) => sweepDirectory(d, DateTime.now().add(const Duration(days: 1)));

/// Marks a cached file as just used, so retention counts from the last open.
void touchFile(File f) {
  try {
    f.setLastModifiedSync(DateTime.now());
  } on FileSystemException {
    // read-only or gone: harmless
  }
}
