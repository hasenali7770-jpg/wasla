import 'dart:typed_data';

import 'source_io_stub.dart' if (dart.library.io) 'source_io.dart' as io;

/// Bytes to upload. Large files are read part by part, never all at once.
abstract interface class UploadSource {
  int get length;
  Future<Uint8List> read(int start, int end);
}

class BytesSource implements UploadSource {
  BytesSource(this.bytes);
  final Uint8List bytes;
  @override
  int get length => bytes.length;
  @override
  Future<Uint8List> read(int start, int end) async => Uint8List.sublistView(bytes, start, end);
}

/// A file on disk (Android/iOS/desktop). Not available on the web.
Future<UploadSource> fileSource(String path) => io.fileSource(path);

/// Writes bytes to a cache file and returns its path (null on the web).
/// [dir] is `media` (downloads, may be cleared by the OS) or `outbox`
/// (files waiting to be sent; removed once sent).
Future<String?> saveToCache(String dir, String name, List<int> bytes) => io.saveToCache(dir, name, bytes);

/// Streams a picked file into the outbox folder (no full copy in memory).
Future<String?> streamToCache(String dir, String name, Stream<List<int>> data) => io.streamToCache(dir, name, data);

/// Reads a cached file, or null if it is not there.
Future<Uint8List?> readCache(String dir, String name) => io.readCache(dir, name);

/// Path of a cached file if it exists.
Future<String?> cachedPath(String dir, String name) => io.cachedPath(dir, name);

Future<void> deleteFile(String path) => io.deleteFile(path);
