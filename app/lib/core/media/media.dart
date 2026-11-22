import 'dart:async';
import 'dart:typed_data';

import 'package:fixnum/fixnum.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

import '../../gen/proto/wasla/v1/common.pb.dart';
import '../../gen/proto/wasla/v1/media.pb.dart';
import '../chat/chat_api.dart';
import '../chat/chat_store.dart';
import '../net/rpc_exception.dart';
import '../storage/local_store.dart';
import 'source.dart';
import 'uploader.dart';

/// Moves media bytes between the phone and storage. Tests replace it.
class MediaTransfer {
  MediaTransfer(this.api, {http.Client? client}) : _http = client ?? http.Client();
  final ChatApi api;
  final http.Client _http;

  /// Uploads an attachment and returns the stored media (status READY).
  Future<Media> upload(OutMedia m, {void Function(double)? onProgress}) async {
    final source = m.bytes != null ? BytesSource(m.bytes!) : await fileSource(m.path!);
    return Uploader(api, client: _http).upload(
      source: source,
      kind: MediaKind.valueOf(m.kind)!,
      mime: m.mime,
      fileName: m.fileName,
      width: m.width,
      height: m.height,
      onProgress: onProgress,
    );
  }

  /// Downloads into memory (thumbnails, photos).
  Future<Uint8List> download(GetDownloadUrlRequest req) async {
    final url = await api.downloadUrl(req);
    final r = await _http.get(Uri.parse(url)).timeout(const Duration(minutes: 2));
    if (r.statusCode != 200) throw RpcException.network();
    return r.bodyBytes;
  }

  /// Downloads a file to the device and returns its path (null on the web,
  /// where the bytes are returned through [download] instead).
  Future<String?> downloadToFile(GetDownloadUrlRequest req, String name, {void Function(double)? onProgress}) async {
    final url = await api.downloadUrl(req);
    final r = await _http.send(http.Request('GET', Uri.parse(url)));
    if (r.statusCode != 200) throw RpcException.network();
    final total = r.contentLength ?? 0;
    var got = 0;
    final counted = r.stream.map((chunk) {
      got += chunk.length;
      if (total > 0) onProgress?.call(got / total);
      return chunk;
    });
    return streamToCache('media', name, counted);
  }

  /// A file downloaded earlier, if still on the device.
  Future<String?> downloadedFile(String name) => cachedPath('media', name);
}

/// Disk layer of [MediaCache]. Tests use [NoDisk].
class MediaDisk {
  const MediaDisk();
  Future<Uint8List?> read(String name) => readCache('media', name);
  Future<void> save(String name, Uint8List bytes) => saveToCache('media', name, bytes);
}

class NoDisk extends MediaDisk {
  const NoDisk();
  @override
  Future<Uint8List?> read(String name) async => null;
  @override
  Future<void> save(String name, Uint8List bytes) async {}
}

final mediaTransferProvider = Provider<MediaTransfer>((ref) => MediaTransfer(ref.watch(chatApiProvider)));

/// Where a media file is seen; the server checks access in this context.
sealed class MediaContext {
  const MediaContext();
  void apply(GetDownloadUrlRequest r);
}

class InMessage extends MediaContext {
  const InMessage(this.chatId, this.seq);
  final Int64 chatId;
  final Int64 seq;
  @override
  void apply(GetDownloadUrlRequest r) => r.message = MessageRef(chatId: chatId, seq: seq);
}

class OfUser extends MediaContext {
  const OfUser(this.userId);
  final Int64 userId;
  @override
  void apply(GetDownloadUrlRequest r) => r.userId = userId;
}

/// Photos and thumbnails already seen: memory (recent 60) then disk, then
/// the network. Concurrent requests for the same image share one download.
class MediaCache {
  MediaCache(this.transfer, {this.disk = const MediaDisk()});
  final MediaTransfer transfer;
  final MediaDisk disk;
  final _mem = <String, Uint8List>{}; // insertion-ordered: oldest first
  final _inflight = <String, Future<Uint8List>>{};
  static const _memLimit = 60;

  static String keyOf(Int64 mediaId, String variant) => '${mediaId}_${variant.isEmpty ? 'orig' : variant}';

  Uint8List? peek(Int64 mediaId, String variant) => _mem[keyOf(mediaId, variant)];

  /// Forgets images held in memory (after "Clear downloaded media").
  void clearMemory() => _mem.clear();

  /// Puts bytes we already have (our own sent photo) so they are not
  /// downloaded again.
  void put(Int64 mediaId, String variant, Uint8List bytes) {
    final k = keyOf(mediaId, variant);
    _remember(k, bytes);
    disk.save(k, bytes).catchError((_) {});
  }

  Future<Uint8List> get(Int64 mediaId, String variant, MediaContext ctx) {
    final k = keyOf(mediaId, variant);
    final hit = _mem[k];
    if (hit != null) {
      _mem.remove(k);
      _mem[k] = hit; // most recent last
      return Future.value(hit);
    }
    // The block body matters: `=> _inflight.remove(k)` would return this very
    // future to whenComplete, which would then wait on itself forever.
    return _inflight[k] ??= _load(k, mediaId, variant, ctx).whenComplete(() {
      _inflight.remove(k);
    });
  }

  Future<Uint8List> _load(String k, Int64 mediaId, String variant, MediaContext ctx) async {
    Uint8List? bytes;
    try {
      bytes = await disk.read(k);
    } catch (_) {
      // no disk cache available; use the network
    }
    if (bytes == null) {
      final req = GetDownloadUrlRequest(mediaId: mediaId, variant: variant);
      ctx.apply(req);
      bytes = await transfer.download(req);
      disk.save(k, bytes).catchError((_) {});
    }
    _remember(k, bytes);
    return bytes;
  }

  void _remember(String k, Uint8List b) {
    _mem.remove(k);
    _mem[k] = b;
    while (_mem.length > _memLimit) {
      _mem.remove(_mem.keys.first);
    }
  }
}

final mediaCacheProvider = Provider<MediaCache>((ref) => MediaCache(ref.watch(mediaTransferProvider)));
