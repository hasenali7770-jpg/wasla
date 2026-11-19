import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image/image.dart' as img;
import 'package:image_picker/image_picker.dart';

import '../storage/local_store.dart';
import 'source.dart';

/// Picks photos and files and prepares them for sending. Tests replace it.
abstract interface class MediaPicker {
  /// A photo from the gallery or camera, already compressed; null if cancelled.
  Future<OutMedia?> photo({required bool camera});

  /// Any file; null if cancelled.
  Future<OutMedia?> file();
}

/// Largest side of a sent photo, and JPEG quality (protocol §7).
const photoMaxSide = 1280;
const photoQuality = 80;

class DeviceMediaPicker implements MediaPicker {
  final _images = ImagePicker();
  int _n = 0;

  String _uniq(String name) => '${DateTime.now().microsecondsSinceEpoch}_${_n++}_$name';

  @override
  Future<OutMedia?> photo({required bool camera}) async {
    final x = await _images.pickImage(source: camera ? ImageSource.camera : ImageSource.gallery);
    if (x == null) return null;
    final p = await compute(compressPhoto, await x.readAsBytes());
    if (p == null) return null;
    final name = _uniq('photo.jpg');
    return OutMedia(
      kind: 1,
      fileName: 'photo.jpg',
      mime: 'image/jpeg',
      size: p.bytes.length,
      path: await saveToCache('outbox', name, p.bytes),
      bytes: p.bytes,
      width: p.width,
      height: p.height,
    );
  }

  @override
  Future<OutMedia?> file() async {
    final picked = await FilePicker.pickFiles();
    if (picked.isEmpty) return null;
    final f = picked.first;
    final size = f.lengthSync() ?? await f.length() ?? 0;
    // Copied into the app's own folder: the picker's file may be temporary,
    // and the copy lets sending resume after a restart.
    final path = await streamToCache('outbox', _uniq(f.name), f.readAsByteStream());
    return OutMedia(
      kind: 3,
      fileName: f.name,
      mime: mimeFromName(f.name),
      size: size,
      path: path,
      bytes: path == null ? await f.readAsBytes() : null,
    );
  }
}

final mediaPickerProvider = Provider<MediaPicker>((ref) => DeviceMediaPicker());

class PreparedPhoto {
  PreparedPhoto(this.bytes, this.width, this.height);
  final Uint8List bytes;
  final int width;
  final int height;
}

/// Turns the camera's orientation flag into real pixels, shrinks the photo
/// to [photoMaxSide] and re-encodes it as JPEG. This also strips EXIF data
/// such as the GPS location. Runs in a background isolate.
PreparedPhoto? compressPhoto(Uint8List input) {
  var image = img.decodeImage(input);
  if (image == null) return null;
  image = img.bakeOrientation(image);
  final side = image.width > image.height ? image.width : image.height;
  if (side > photoMaxSide) {
    image = image.width >= image.height
        ? img.copyResize(image, width: photoMaxSide, interpolation: img.Interpolation.average)
        : img.copyResize(image, height: photoMaxSide, interpolation: img.Interpolation.average);
  }
  image.exif.clear();
  return PreparedPhoto(img.encodeJpg(image, quality: photoQuality), image.width, image.height);
}

String mimeFromName(String name) {
  final ext = name.contains('.') ? name.split('.').last.toLowerCase() : '';
  return const {
        'pdf': 'application/pdf',
        'doc': 'application/msword',
        'docx': 'application/vnd.openxmlformats-officedocument.wordprocessingml.document',
        'xls': 'application/vnd.ms-excel',
        'xlsx': 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet',
        'ppt': 'application/vnd.ms-powerpoint',
        'pptx': 'application/vnd.openxmlformats-officedocument.presentationml.presentation',
        'txt': 'text/plain',
        'zip': 'application/zip',
        'rar': 'application/vnd.rar',
        'jpg': 'image/jpeg',
        'jpeg': 'image/jpeg',
        'png': 'image/png',
        'webp': 'image/webp',
        'mp3': 'audio/mpeg',
        'mp4': 'video/mp4',
        'apk': 'application/vnd.android.package-archive',
      }[ext] ??
      'application/octet-stream';
}
