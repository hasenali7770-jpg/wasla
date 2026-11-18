
import 'package:fixnum/fixnum.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:open_filex/open_filex.dart';

import '../../core/chat/format.dart';
import '../../core/l10n/app_localizations.dart';
import '../../core/media/media.dart';
import '../../core/media/source.dart' show fileSource;
import '../../core/storage/local_store.dart';
import '../../gen/proto/wasla/v1/media.pb.dart';

/// Photo size inside a bubble: keeps the aspect ratio, at most 260 wide
/// and 320 tall.
Size bubblePhotoSize(int w, int h) {
  if (w <= 0 || h <= 0) return const Size(240, 240);
  const maxW = 260.0, maxH = 320.0;
  final s = [maxW / w, maxH / h].reduce((a, b) => a < b ? a : b);
  return Size(w * s, h * s);
}

/// A received or sent photo, loaded through the media cache (thumb_m).
class PhotoThumb extends ConsumerStatefulWidget {
  const PhotoThumb({super.key, required this.media, required this.where, this.onOpen});
  final Media media;
  final MediaContext where;
  final VoidCallback? onOpen;
  @override
  ConsumerState<PhotoThumb> createState() => _PhotoThumbState();
}

class _PhotoThumbState extends ConsumerState<PhotoThumb> {
  late Future<Uint8List> _bytes;

  @override
  void initState() {
    super.initState();
    _load();
  }

  void _load() => _bytes = ref.read(mediaCacheProvider).get(widget.media.id, 'thumb_m', widget.where);

  @override
  Widget build(BuildContext context) {
    final size = bubblePhotoSize(widget.media.width, widget.media.height);
    final cached = ref.read(mediaCacheProvider).peek(widget.media.id, 'thumb_m');
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: SizedBox.fromSize(
        size: size,
        child: cached != null
            ? _image(cached)
            : FutureBuilder<Uint8List>(
                future: _bytes,
                builder: (_, s) {
                  if (s.hasData) return _image(s.data!);
                  final scheme = Theme.of(context).colorScheme;
                  return ColoredBox(
                    color: scheme.surfaceContainerHigh,
                    child: Center(
                      child: s.hasError
                          ? IconButton(
                              icon: const Icon(Icons.refresh),
                              onPressed: () => setState(_load),
                            )
                          : const CircularProgressIndicator(strokeWidth: 2),
                    ),
                  );
                },
              ),
      ),
    );
  }

  Widget _image(Uint8List b) => GestureDetector(
        onTap: widget.onOpen,
        child: Image.memory(b, fit: BoxFit.cover, gaplessPlayback: true),
      );
}

/// A photo still being uploaded, with progress.
class OutgoingPhoto extends StatefulWidget {
  const OutgoingPhoto({super.key, required this.media, required this.progress, required this.failed});
  final OutMedia media;
  final double progress;
  final bool failed;
  @override
  State<OutgoingPhoto> createState() => _OutgoingPhotoState();
}

class _OutgoingPhotoState extends State<OutgoingPhoto> {
  Future<Uint8List?>? _read;

  @override
  void initState() {
    super.initState();
    final m = widget.media;
    if (m.bytes == null && m.path != null) {
      // After a restart the preview is read back from the outbox file.
      _read = fileSource(m.path!).then((s) => s.read(0, s.length)).then<Uint8List?>((b) => m.bytes = b, onError: (_) => null);
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = bubblePhotoSize(widget.media.width, widget.media.height);
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: SizedBox.fromSize(
        size: size,
        child: Stack(fit: StackFit.expand, children: [
          FutureBuilder<Uint8List?>(
            future: _read,
            initialData: widget.media.bytes,
            builder: (_, s) => s.data == null
                ? ColoredBox(color: Theme.of(context).colorScheme.surfaceContainerHigh)
                : Image.memory(s.data!, fit: BoxFit.cover, gaplessPlayback: true),
          ),
          if (!widget.failed)
            Center(
              child: CircleAvatar(
                radius: 22,
                backgroundColor: Colors.black54,
                child: CircularProgressIndicator(
                  value: widget.progress > 0 && widget.progress < 1 ? widget.progress : null,
                  strokeWidth: 2.5,
                  color: Colors.white,
                ),
              ),
            ),
        ]),
      ),
    );
  }
}

/// A file in a bubble: icon, name, size. Tap downloads (once) and opens it
/// with an app on the phone.
class DocumentTile extends ConsumerStatefulWidget {
  const DocumentTile({super.key, required this.media, this.where, this.progress, this.color});

  /// The stored file; null while our own upload is still running.
  final Media? media;
  final MediaContext? where;

  /// Upload progress for our own file still being sent.
  final double? progress;
  final Color? color;

  /// Builds a tile for a file we are still sending.
  static Widget outgoing(OutMedia m, double progress, bool failed, Color color) => DocumentTile(
        media: Media(fileName: m.fileName, sizeBytes: Int64(m.size), mimeType: m.mime),
        progress: failed ? null : progress,
        color: color,
      );

  @override
  ConsumerState<DocumentTile> createState() => _DocumentTileState();
}

class _DocumentTileState extends ConsumerState<DocumentTile> {
  double? _download;

  String get _cacheName => '${widget.media!.id}_${widget.media!.fileName.replaceAll(RegExp(r'[/\\]'), '_')}';

  Future<void> _open() async {
    final m = widget.media;
    final where = widget.where;
    if (m == null || where == null || _download != null) return;
    final l = AppLocalizations.of(context);
    final messenger = ScaffoldMessenger.of(context);
    try {
      final transfer = ref.read(mediaTransferProvider);
      var path = await transfer.downloadedFile(_cacheName);
      if (path == null) {
        setState(() => _download = 0);
        final req = GetDownloadUrlRequest(mediaId: m.id);
        where.apply(req);
        path = await transfer.downloadToFile(req, _cacheName,
            onProgress: (p) => mounted ? setState(() => _download = p) : null);
      }
      if (path == null || kIsWeb) return;
      final r = await OpenFilex.open(path, type: m.mimeType.isEmpty ? null : m.mimeType);
      if (r.type != ResultType.done) messenger.showSnackBar(SnackBar(content: Text(l.openFailed)));
    } catch (_) {
      messenger.showSnackBar(SnackBar(content: Text(l.mediaUnavailable)));
    } finally {
      if (mounted) setState(() => _download = null);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final m = widget.media!;
    final color = widget.color ?? Theme.of(context).colorScheme.onSurface;
    final busy = widget.progress ?? _download;
    return InkWell(
      key: Key('doc-${m.id}'),
      onTap: _open,
      child: Padding(
        padding: const EdgeInsetsDirectional.symmetric(vertical: 4),
        child: Row(mainAxisSize: MainAxisSize.min, children: [
          SizedBox.square(
            dimension: 44,
            child: Stack(alignment: Alignment.center, children: [
              CircleAvatar(
                radius: 22,
                backgroundColor: Theme.of(context).colorScheme.primary,
                child: Icon(busy == null ? Icons.insert_drive_file_outlined : Icons.downloading, color: Colors.white),
              ),
              if (busy != null)
                CircularProgressIndicator(value: busy > 0 && busy < 1 ? busy : null, strokeWidth: 2.5, color: color),
            ]),
          ),
          const SizedBox(width: 10),
          Flexible(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisSize: MainAxisSize.min, children: [
              Text(isolate(m.fileName), maxLines: 2, overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: color, fontWeight: FontWeight.w600)),
              Text(fileSize(m.sizeBytes.toInt(), l), style: TextStyle(color: color.withValues(alpha: 0.7), fontSize: 12)),
            ]),
          ),
        ]),
      ),
    );
  }
}

/// Full-screen photo with pinch-zoom. Shows the thumbnail at once and the
/// full photo when it arrives.
class PhotoViewer extends ConsumerWidget {
  const PhotoViewer({super.key, required this.media, required this.where});
  final Media media;
  final MediaContext where;

  static Future<void> open(BuildContext context, Media media, MediaContext where) =>
      Navigator.of(context).push(MaterialPageRoute(builder: (_) => PhotoViewer(media: media, where: where)));

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cache = ref.read(mediaCacheProvider);
    final thumb = cache.peek(media.id, 'thumb_m');
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(backgroundColor: Colors.black, foregroundColor: Colors.white),
      body: FutureBuilder<Uint8List>(
        future: cache.get(media.id, '', where),
        builder: (_, s) {
          final b = s.data ?? thumb;
          if (b == null) {
            return Center(
              child: s.hasError
                  ? Text(AppLocalizations.of(context).mediaUnavailable, style: const TextStyle(color: Colors.white))
                  : const CircularProgressIndicator(color: Colors.white),
            );
          }
          return InteractiveViewer(
            maxScale: 5,
            child: Center(child: Image.memory(b, gaplessPlayback: true)),
          );
        },
      ),
    );
  }
}
