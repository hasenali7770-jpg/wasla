import 'dart:async';
import 'dart:math';

import 'package:fixnum/fixnum.dart';
import 'package:http/http.dart' as http;

import '../../gen/proto/wasla/v1/media.pb.dart';
import '../chat/chat_api.dart';
import '../net/rpc_exception.dart';
import 'source.dart';

/// Uploads a file through the MediaService protocol (docs/03-protocol.md §7):
/// parts go straight to storage with signed URLs, three at a time, each
/// retried with backoff. The server never handles the bytes.
class Uploader {
  Uploader(this.api, {http.Client? client, this.parallel = 3}) : _http = client ?? http.Client();
  final ChatApi api;
  final http.Client _http;
  final int parallel;

  Future<Media> upload({
    required UploadSource source,
    required MediaKind kind,
    required String mime,
    required String fileName,
    int width = 0,
    int height = 0,
    void Function(double progress)? onProgress,
  }) async {
    final plan = await api.createUpload(CreateUploadRequest(
      kind: kind,
      mimeType: mime,
      sizeBytes: Int64(source.length),
      fileName: fileName,
      width: width,
      height: height,
    ));
    final urls = {for (final u in plan.urls) u.partNumber: u.url};
    final missing = [for (var n = 1; n <= plan.partCount; n++) if (!urls.containsKey(n)) n];
    for (var i = 0; i < missing.length; i += 100) {
      final r = await api.uploadPartUrls(plan.uploadId, missing.sublist(i, min(i + 100, missing.length)));
      for (final u in r.urls) {
        urls[u.partNumber] = u.url;
      }
    }
    final parts = <CompletedPart>[];
    var done = 0;
    final queue = [for (var n = 1; n <= plan.partCount; n++) n];
    Future<void> worker() async {
      while (queue.isNotEmpty) {
        final n = queue.removeAt(0);
        final start = (n - 1) * plan.partSizeBytes;
        final end = min(start + plan.partSizeBytes, source.length);
        final etag = await _put(urls[n]!, await source.read(start, end));
        parts.add(CompletedPart(partNumber: n, etag: etag));
        done += end - start;
        onProgress?.call(done / source.length);
      }
    }

    await Future.wait([for (var i = 0; i < min(parallel, plan.partCount); i++) worker()]);
    return api.completeUpload(CompleteUploadRequest(uploadId: plan.uploadId, parts: parts));
  }

  Future<String> _put(String url, List<int> body) async {
    for (var attempt = 0;; attempt++) {
      try {
        final r = await _http.put(Uri.parse(url), body: body).timeout(const Duration(minutes: 2));
        if (r.statusCode == 200) return r.headers['etag'] ?? '';
        if (r.statusCode < 500 && r.statusCode != 429) throw RpcException.network();
      } on TimeoutException {
        // retried below
      } on http.ClientException {
        // retried below
      }
      if (attempt == 4) throw RpcException.network();
      await Future<void>.delayed(Duration(seconds: 1 << attempt));
    }
  }
}
