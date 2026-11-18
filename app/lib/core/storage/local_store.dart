import 'package:fixnum/fixnum.dart';

import '../../gen/proto/wasla/v1/chats.pb.dart';
import '../../gen/proto/wasla/v1/messages.pb.dart';
import '../../gen/proto/wasla/v1/users.pb.dart';
import 'local_store_stub.dart' if (dart.library.ffi) 'sqlite_store.dart' as impl;

/// A message waiting to be sent, as stored across app restarts.
class StoredOutgoing {
  const StoredOutgoing({
    required this.chatId,
    required this.randomId,
    required this.text,
    required this.createdAt,
    this.replyTo,
    this.failed = false,
  });
  final Int64 chatId;
  final Int64 randomId;
  final String text;
  final Int64? replyTo;
  final DateTime createdAt;
  final bool failed;
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
  @override
  void wipe() {}
  @override
  void close() {}
}
