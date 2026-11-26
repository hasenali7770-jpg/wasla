import 'dart:typed_data';

import 'source.dart';

Future<UploadSource> fileSource(String path) => throw UnsupportedError('files by path are not available on the web');

Future<String?> saveToCache(String dir, String name, List<int> bytes) async => null;

Future<String?> streamToCache(String dir, String name, Stream<List<int>> data) async => null;

Future<Uint8List?> readCache(String dir, String name) async => null;

Future<String?> cachedPath(String dir, String name) async => null;

Future<void> deleteFile(String path) async {}

Future<CacheUsage> cacheUsage(String dir) async => CacheUsage.empty;

Future<int> sweepCache(String dir, DateTime cutoff) async => 0;

Future<int> clearCache(String dir) async => 0;
