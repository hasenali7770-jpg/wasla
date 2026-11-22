import 'dart:io';
import 'dart:typed_data';

import 'package:path_provider/path_provider.dart';

import 'source.dart';

class _FileSource implements UploadSource {
  _FileSource(this.file, this.length);
  final File file;
  @override
  final int length;
  @override
  Future<Uint8List> read(int start, int end) async {
    final raf = await file.open();
    try {
      await raf.setPosition(start);
      return await raf.read(end - start);
    } finally {
      await raf.close();
    }
  }
}

Future<UploadSource> fileSource(String path) async {
  final f = File(path);
  return _FileSource(f, await f.length());
}

Future<File> _file(String dir, String name) async {
  // Outbox files must survive until sent, so they live in app support, not
  // in the cache the OS may clear.
  final base = dir == 'outbox' ? await getApplicationSupportDirectory() : await getApplicationCacheDirectory();
  final d = Directory('${base.path}${Platform.pathSeparator}wasla_$dir');
  await d.create(recursive: true);
  return File('${d.path}${Platform.pathSeparator}$name');
}

Future<String?> saveToCache(String dir, String name, List<int> bytes) async {
  final f = await _file(dir, name);
  await f.writeAsBytes(bytes, flush: true);
  return f.path;
}

Future<String?> streamToCache(String dir, String name, Stream<List<int>> data) async {
  final f = await _file(dir, name);
  final sink = f.openWrite();
  try {
    await sink.addStream(data);
  } finally {
    await sink.close();
  }
  return f.path;
}

Future<Uint8List?> readCache(String dir, String name) async {
  final f = await _file(dir, name);
  return await f.exists() ? f.readAsBytes() : null;
}

Future<String?> cachedPath(String dir, String name) async {
  final f = await _file(dir, name);
  return await f.exists() ? f.path : null;
}

Future<void> deleteFile(String path) async {
  try {
    await File(path).delete();
  } on FileSystemException {
    // already gone
  }
}
