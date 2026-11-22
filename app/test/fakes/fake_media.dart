import 'dart:typed_data';

import 'package:fixnum/fixnum.dart';
import 'package:image/image.dart' as img;
import 'package:wasla/core/media/media.dart';
import 'package:wasla/core/media/picker.dart';
import 'package:wasla/core/net/rpc_exception.dart';
import 'package:wasla/core/storage/local_store.dart';
import 'package:wasla/gen/proto/wasla/v1/media.pb.dart';

import 'fake_chat_api.dart';

/// A small real PNG so Image.memory can decode it.
final Uint8List tinyPng = img.encodePng(img.Image(width: 8, height: 6)..clear(img.ColorRgb8(15, 110, 53)));

/// Uploads "succeed" instantly (or fail [failNext] times) and register the
/// media with the fake API, so sending it works.
class FakeMediaTransfer extends MediaTransfer {
  FakeMediaTransfer(FakeChatApi super.api);
  FakeChatApi get fake => api as FakeChatApi;
  int _id = 500;
  int failNext = 0;
  final uploads = <OutMedia>[];
  final fileDownloads = <GetDownloadUrlRequest>[];

  @override
  Future<Media> upload(OutMedia m, {void Function(double)? onProgress}) async {
    if (failNext > 0) {
      failNext--;
      throw RpcException.network();
    }
    onProgress?.call(0.5);
    uploads.add(m);
    final media = Media(
      id: Int64(++_id),
      kind: MediaKind.valueOf(m.kind),
      mimeType: m.mime,
      sizeBytes: Int64(m.size),
      fileName: m.fileName,
      width: m.width,
      height: m.height,
      status: MediaStatus.MEDIA_STATUS_READY,
    );
    fake.media[media.id] = media;
    return media;
  }

  @override
  Future<Uint8List> download(GetDownloadUrlRequest req) async {
    await api.downloadUrl(req);
    return tinyPng;
  }

  @override
  Future<String?> downloadedFile(String name) async => null;

  @override
  Future<String?> downloadToFile(GetDownloadUrlRequest req, String name, {void Function(double)? onProgress}) async {
    fileDownloads.add(req);
    return null;
  }
}

class FakePicker implements MediaPicker {
  OutMedia? nextPhoto;
  OutMedia? nextFile;
  @override
  Future<OutMedia?> photo({required bool camera}) async => nextPhoto;
  @override
  Future<OutMedia?> file() async => nextFile;
}

OutMedia testPhoto() =>
    OutMedia(kind: 1, fileName: 'photo.jpg', mime: 'image/jpeg', size: tinyPng.length, bytes: tinyPng, width: 8, height: 6);

OutMedia testDoc() => OutMedia(
    kind: 3, fileName: 'تقرير.pdf', mime: 'application/pdf', size: 3 * 1024 * 1024 + 200, bytes: Uint8List(10));
