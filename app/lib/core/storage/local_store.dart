import 'dart:convert';
import 'dart:typed_data';

import 'package:fixnum/fixnum.dart';

import '../../gen/proto/wasla/v1/chats.pb.dart';
import '../../gen/proto/wasla/v1/messages.pb.dart';
import '../../gen/proto/wasla/v1/users.pb.dart';
import 'local_store_stub.dart' if (dart.library.ffi) 'sqlite_store.dart' as impl;

/// A photo or file attached to an unsent message. The prepared file stays
/// on the device until the server confirms the message, so sending resumes
/// after a restart. [mediaId] is set once the upload has completed.
class OutMedia {
  OutMedia({
    required this.kind,
    required this.fileName,
    required this.mime,
    required this.size,
    this.path,
    this.bytes,
    this.width = 0,
    this.height = 0,
    this.mediaId = Int64.ZERO,
  });

  /// MediaKind value (1 photo, 3 document).
  final int kind;
  final String fileName;
  final String mime;
  final int size;

  /// Local file (Android/iOS/desktop).
  final String? path;

  /// In-memory copy (web, and the photo preview). Never stored.
  Uint8List? bytes;
  final int width;
  final int height;
  Int64 mediaId;

  bool get isPhoto => kind == 1;

  String toJson() => jsonEncode({
        'k': kind,
        'n': fileName,
        'm': mime,
        's': size,
        'p': path,
        'w': width,
        'h': height,
        'id': mediaId.toString(),
      });

  static OutMedia? fromJson(String? s) {
    if (s == null || s.isEmpty) return null;
    final j = jsonDecode(s) as Map<String, dynamic>;
    return OutMedia(
      kind: j['k'] as int,
      fileName: j['n'] as String,
      mime: j['m'] as String,
      size: j['s'] as int,
      path: j['p'] as String?,
      width: j['w'] as int? ?? 0,
      height: j['h'] as int? ?? 0,
      mediaId: Int64.parseInt(j['id'] as String? ?? '0'),
    );
  }
}

/// A message waiting to be sent, as stored across app restarts.
class StoredOutgoing {
  const StoredOutgoing({
    required this.chatId,
    required this.randomId,
    required this.text,
    required this.createdAt,
    this.replyTo,
    this.failed = false,
    this.media,
  });
  final Int64 chatId;
  final Int64 randomId;
  final String text;
  final Int64? replyTo;
  final DateTime createdAt;
  final bool failed;
  final OutMedia? media;
}

/// Everything the app had on screen last time, loaded at startup.
class Snapshot {
  Snapshot({
    this.ownerId = Int64.ZERO,
    this.pts = Int64.ZERO,
    Map<Int64, (Chat, Dialog)>? chats,
    Map<Int64, User>? users,
    Map<Int64, List<Message>>? messages,
    List<StoredOutgoing>? outbox,
  })  : chats = chats ?? {},
        users = users ?? {},
        messages = messages ?? {},
        outbox = outbox ?? [];
  final Int64 ownerId;
  final Int64 pts;
  final Map<Int64, (Chat, Dialog)> chats;
  final Map<Int64, User> users;
  final Map<Int64, List<Message>> messages;
  final List<StoredOutgoing> outbox;

  bool get isEmpty => chats.isEmpty && outbox.isEmpty;
}

/// On-device cache of chats and messages (docs/01-architecture.md §10).
/// The UI renders from memory; this keeps that memory across restarts so
/// the app opens instantly and works offline. Messages are stored as their
/// protobuf bytes, so new fields need no migration.
abstract interface class LocalStore {
  /// Loads the snapshot. If it belongs to another account than [userId]
  /// (non-zero), it is wiped first.
  Snapshot load(Int64 userId);
  void setOwner(Int64 userId);
  void savePts(Int64 pts);
  void saveChat(Chat chat, Dialog dialog);
  void deleteChat(Int64 chatId);
  void saveUser(User user);
  void saveMessages(Iterable<Message> messages);
  void deleteMessages(Int64 chatId, Iterable<Int64> seqs);
  void deleteMessagesUpTo(Int64 chatId, Int64 maxSeq);
  void deleteAllMessages();
  void saveOutgoing(StoredOutgoing o);
  void deleteOutgoing(Int64 randomId);
  /// Device settings. They survive logout and account switches ([wipe]).
  String? setting(String key);
  void setSetting(String key, String value);

  void wipe();
  void close();
}

/// Opens the platform store: SQLite on Android/iOS/desktop, memory on web.
Future<LocalStore> openLocalStore() => impl.openPlatformStore();

/// Keeps nothing (web, and tests that don't care about persistence).
class MemoryStore implements LocalStore {
  @override
  Snapshot load(Int64 userId) => Snapshot();
  @override
  void setOwner(Int64 userId) {}
  @override
  void savePts(Int64 pts) {}
  @override
  void saveChat(Chat chat, Dialog dialog) {}
  @override
  void deleteChat(Int64 chatId) {}
  @override
  void saveUser(User user) {}
  @override
  void saveMessages(Iterable<Message> messages) {}
  @override
  void deleteMessages(Int64 chatId, Iterable<Int64> seqs) {}
  @override
  void deleteMessagesUpTo(Int64 chatId, Int64 maxSeq) {}
  @override
  void deleteAllMessages() {}
  @override
  void saveOutgoing(StoredOutgoing o) {}
  @override
  void deleteOutgoing(Int64 randomId) {}
  final _settings = <String, String>{};
  @override
  String? setting(String key) => _settings[key];
  @override
  void setSetting(String key, String value) => _settings[key] = value;
  @override
  void wipe() {}
  @override
  void close() {}
}
