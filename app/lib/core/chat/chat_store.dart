import 'dart:async';
import 'dart:math';

import 'package:fixnum/fixnum.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../gen/proto/wasla/v1/chats.pb.dart';
import '../../gen/proto/wasla/v1/common.pb.dart';
import '../../gen/proto/wasla/v1/frame.pbenum.dart';
import '../../gen/proto/wasla/v1/messages.pb.dart';
import '../../gen/proto/wasla/v1/updates.pb.dart';
import '../../gen/proto/wasla/v1/users.pb.dart';
import '../auth/auth_controller.dart';
import '../net/connection.dart';
import '../net/rpc_exception.dart';
import '../providers.dart';
import 'chat_api.dart';
import 'update_engine.dart';

enum OutStatus { sending, failed }

/// A message the user sent that the server has not confirmed yet.
class Outgoing {
  Outgoing({required this.chatId, required this.randomId, required this.text, this.replyTo});
  final Int64 chatId;
  final Int64 randomId;
  final String text;
  final Int64? replyTo;
  final DateTime createdAt = DateTime.now();
  OutStatus status = OutStatus.sending;
  int attempts = 0;
  RpcException? error;
}

/// One chat as the UI sees it.
class ChatEntry {
  ChatEntry(this.chat, this.dialog);
  Chat chat;
  Dialog dialog;

  /// Loaded messages by seq (ascending).
  final messages = <Int64, Message>{};
  bool historyLoaded = false;
  bool hasMoreHistory = true;
  final outbox = <Outgoing>[];

  /// userId → typing expiry.
  final typing = <Int64, DateTime>{};

  List<Message> get sortedMessages {
    final keys = messages.keys.toList()..sort();
    return [for (final k in keys) messages[k]!];
  }
}

/// In-memory chat state fed by the update engine. Widgets watch the
/// revision number and read data from the notifier.
/// (On-device persistence with SQLite/Drift replaces the maps next sprint.)
class ChatStore extends Notifier<int> {
  late ChatApi _api;
  late WaslaConnection _conn;
  late UpdateEngine _engine;
  StreamSubscription<UpdatesPush>? _sub;
  final _rand = Random.secure();
  Timer? _typingSweep;

  final chats = <Int64, ChatEntry>{};
  final users = <Int64, User>{};
  bool loaded = false;
  RpcException? loadError;

  /// The chat currently on screen (its messages are marked read on arrival).
  Int64? openChatId;

  Int64 get myId {
    final a = ref.read(authProvider);
    if (a is AuthSignedIn && a.user.id != Int64.ZERO) return a.user.id;
    return _conn.ack?.userId ?? Int64.ZERO;
  }

  @override
  int build() {
    _api = ref.watch(chatApiProvider);
    _conn = ref.watch(connectionProvider);
    _engine = UpdateEngine(api: _api, apply: _apply, onTooLong: reload);
    _sub = _conn.updates.listen(_engine.onPush);
    _conn.state.addListener(_onConnState);
    _typingSweep = Timer.periodic(const Duration(seconds: 2), (_) => _sweepTyping());
    ref.onDispose(() {
      _sub?.cancel();
      _conn.state.removeListener(_onConnState);
      _engine.dispose();
      _typingSweep?.cancel();
    });
    Future.microtask(reload);
    return 0;
  }

  void _changed() => state = state + 1;

  void _onConnState() {
    if (_conn.state.value == ConnState.connected && loaded) {
      _engine.sync().catchError((_) {});
      _flushOutbox();
    }
  }

  /// (Re)loads the chat list and sets the sync starting point.
  Future<void> reload() async {
    try {
      final r = await _api.listDialogs();
      for (final u in r.users) {
        users[u.id] = u;
      }
      final keep = <Int64>{};
      for (var i = 0; i < r.dialogs.length; i++) {
        final d = r.dialogs[i];
        final c = r.chats.firstWhere((c) => c.id == d.chatId, orElse: () => Chat(id: d.chatId));
        keep.add(d.chatId);
        final e = chats[d.chatId];
        if (e == null) {
          chats[d.chatId] = ChatEntry(c, d);
        } else {
          e.chat = c;
          e.dialog = d;
        }
        if (d.hasTopMessage()) chats[d.chatId]!.messages[d.topMessage.seq] = d.topMessage;
      }
      chats.removeWhere((id, e) => !keep.contains(id) && e.outbox.isEmpty && id != openChatId);
      _engine.reset(r.pts);
      loaded = true;
      loadError = null;
    } on RpcException catch (e) {
      loadError = e;
    }
    _changed();
  }

  /// Chats sorted for the list: pinned first, then newest activity.
  List<ChatEntry> dialogs({bool archived = false}) {
    final list = chats.values.where((e) => e.dialog.archived == archived && _visible(e)).toList();
    int rank(ChatEntry e) => e.dialog.pinnedRank == 0 ? 1 << 30 : e.dialog.pinnedRank;
    list.sort((a, b) {
      final r = rank(a).compareTo(rank(b));
      if (r != 0) return r;
      return _lastActivity(b).compareTo(_lastActivity(a));
    });
    return list;
  }

  bool _visible(ChatEntry e) => e.dialog.hasTopMessage() || e.outbox.isNotEmpty || e.messages.isNotEmpty;

  Int64 _lastActivity(ChatEntry e) {
    if (e.outbox.isNotEmpty) return Int64(e.outbox.last.createdAt.millisecondsSinceEpoch ~/ 1000);
    return e.dialog.hasTopMessage() ? e.dialog.topMessage.date : Int64.ZERO;
  }

  /// Opens (creating if needed) the private chat with a user.
  Future<Int64> openPrivateChat(Int64 userId) async {
    final r = await _api.getPrivateChat(userId);
    users[r.user.id] = r.user;
    chats.putIfAbsent(r.chat.id, () => ChatEntry(r.chat, Dialog(chatId: r.chat.id)));
    chats[r.chat.id]!.chat = r.chat;
    _changed();
    return r.chat.id;
  }

  Future<void> loadHistory(Int64 chatId, {bool older = false}) async {
    final e = chats[chatId];
    if (e == null || (older && !e.hasMoreHistory)) return;
    Int64? before;
    if (older && e.messages.isNotEmpty) {
      before = (e.messages.keys.toList()..sort()).first;
    }
    final r = await _api.getHistory(chatId, beforeSeq: before);
    for (final u in r.users) {
      users[u.id] = u;
    }
    for (final m in r.messages) {
      e.messages[m.seq] = m;
    }
    e.historyLoaded = true;
    e.hasMoreHistory = r.hasMore;
    _changed();
  }

  /// Marks everything loaded in the chat as read.
  Future<void> markRead(Int64 chatId) async {
    final e = chats[chatId];
    if (e == null || e.messages.isEmpty) return;
    final top = (e.messages.keys.toList()..sort()).last;
    if (top <= e.dialog.readInboxSeq && e.dialog.unreadCount == 0) return;
    e.dialog
      ..readInboxSeq = top
      ..unreadCount = 0;
    _changed();
    try {
      await _api.readHistory(chatId, top);
    } on RpcException {
      // Retried next time the chat is opened.
    }
  }

  // ---------------------------------------------------------------------------
  // Sending (outbox with retry)
  // ---------------------------------------------------------------------------

  Int64 _randomId() => Int64(_rand.nextInt(1 << 32)) << 31 ^ Int64(_rand.nextInt(1 << 31)) | Int64.ONE;

  void sendText(Int64 chatId, String text, {Int64? replyTo}) {
    final t = text.trim();
    if (t.isEmpty) return;
    final e = chats[chatId];
    if (e == null) return;
    final o = Outgoing(chatId: chatId, randomId: _randomId(), text: t, replyTo: replyTo);
    e.outbox.add(o);
    _changed();
    _deliver(o);
  }

  Future<void> _deliver(Outgoing o) async {
    final e = chats[o.chatId];
    if (e == null) return;
    o.status = OutStatus.sending;
    o.attempts++;
    try {
      final r = await _api.send(SendMessageRequest(
        peer: e.chat.type == ChatType.CHAT_TYPE_GROUP ? null : _peerOf(e),
        randomId: o.randomId,
        content: InputContent(text: FormattedText(text: o.text)),
        replyToSeq: o.replyTo,
      ));
      e.outbox.remove(o);
      _putMessage(e, r.message);
      e.dialog.readInboxSeq = r.message.seq;
    } on RpcException catch (err) {
      final transient = err.code == ErrorCode.ERROR_CODE_UNAVAILABLE ||
          err.code == ErrorCode.ERROR_CODE_INTERNAL ||
          err.code == ErrorCode.ERROR_CODE_RATE_LIMITED;
      if (transient && o.attempts < 8) {
        // Backoff 1, 2, 4 … 60 s; also retried immediately on reconnect.
        final wait = Duration(seconds: min(60, 1 << (o.attempts - 1)));
        Timer(wait, () {
          if (e.outbox.contains(o) && o.status == OutStatus.sending) _deliver(o);
        });
      } else {
        o
          ..status = OutStatus.failed
          ..error = err;
      }
    }
    _changed();
  }

  Peer _peerOf(ChatEntry e) =>
      e.chat.peerUserId != Int64.ZERO ? userPeer(e.chat.peerUserId) : Peer(chatId: e.chat.id);

  void _flushOutbox() {
    for (final e in chats.values) {
      for (final o in List.of(e.outbox)) {
        if (o.status == OutStatus.sending) _deliver(o);
      }
    }
  }

  void retry(Outgoing o) => _deliver(o);

  void discard(Outgoing o) {
    chats[o.chatId]?.outbox.remove(o);
    _changed();
  }

  // ---------------------------------------------------------------------------
  // Other actions
  // ---------------------------------------------------------------------------

  Future<void> edit(Int64 chatId, Int64 seq, String text) async {
    final r = await _api.edit(chatId, seq, text.trim());
    final e = chats[chatId];
    if (e != null) _putMessage(e, r.message);
    _changed();
  }

  Future<void> delete(Int64 chatId, List<Int64> seqs, {required bool forEveryone}) async {
    await _api.delete(chatId, seqs, forEveryone: forEveryone);
    _removeMessages(chatId, seqs);
  }

  Future<void> forwardToSaved(Int64 fromChatId, List<Int64> seqs) async {
    await _api.forward(ForwardMessagesRequest(
      fromChatId: fromChatId,
      seqs: seqs,
      toPeer: userPeer(myId),
      randomIds: [for (final _ in seqs) _randomId()],
    ));
  }

  Future<void> forwardTo(Int64 fromChatId, List<Int64> seqs, Int64 toChatId) async {
    final target = chats[toChatId];
    if (target == null) return;
    await _api.forward(ForwardMessagesRequest(
      fromChatId: fromChatId,
      seqs: seqs,
      toPeer: _peerOf(target),
      randomIds: [for (final _ in seqs) _randomId()],
    ));
  }

  Future<void> togglePin(Int64 chatId, Message m) => _api.pin(chatId, m.seq, unpin: m.pinned);

  Future<void> updateDialog(Int64 chatId, {bool? pinned, bool? archived, bool? muted}) async {
    final r = await _api.updateDialog(UpdateDialogRequest(
      chatId: chatId,
      pinned: pinned,
      archived: archived,
      mutedUntil: muted == null ? null : (muted ? Int64(DateTime(2100).millisecondsSinceEpoch ~/ 1000) : Int64.ZERO),
    ));
    chats[chatId]?.dialog = r.dialog;
    _changed();
  }

  Future<void> setBlocked(Int64 userId, bool blocked) async {
    blocked ? await _api.block(userId) : await _api.unblock(userId);
    final u = users[userId];
    if (u != null) u.isBlocked = blocked;
    _changed();
  }

  /// Records a block made elsewhere (e.g. "report and block").
  void markBlocked(Int64 userId) {
    users[userId]?.isBlocked = true;
    _changed();
  }

  DateTime _lastTypingSent = DateTime(2000);
  void typing(Int64 chatId) {
    final now = DateTime.now();
    if (now.difference(_lastTypingSent) < const Duration(seconds: 4)) return;
    _lastTypingSent = now;
    _api.setTyping(chatId).catchError((_) {});
  }

  /// Fetches profiles the UI needs but does not have yet.
  Future<void> ensureUsers(Iterable<Int64> ids) async {
    final missing = ids.where((id) => id != Int64.ZERO && !users.containsKey(id)).toSet().toList();
    if (missing.isEmpty) return;
    try {
      for (final u in await _api.getUsers(missing)) {
        users[u.id] = u;
      }
      _changed();
    } on RpcException {
      // Names fill in on the next update.
    }
  }

  // ---------------------------------------------------------------------------
  // Applying updates (idempotent)
  // ---------------------------------------------------------------------------

  void _putMessage(ChatEntry e, Message m) {
    e.messages[m.seq] = m;
    e.outbox.removeWhere((o) => o.randomId == m.randomId && m.randomId != Int64.ZERO);
    if (!e.dialog.hasTopMessage() || e.dialog.topMessage.seq <= m.seq) e.dialog.topMessage = m;
  }

  void _removeMessages(Int64 chatId, List<Int64> seqs) {
    final e = chats[chatId];
    if (e == null) return;
    for (final s in seqs) {
      e.messages.remove(s);
    }
    if (e.dialog.hasTopMessage() && seqs.contains(e.dialog.topMessage.seq)) {
      final rest = e.sortedMessages;
      if (rest.isEmpty) {
        e.dialog.clearTopMessage();
      } else {
        e.dialog.topMessage = rest.last;
      }
    }
    _changed();
  }

  void _apply(Update u) {
    switch (u.whichKind()) {
      case Update_Kind.newMessage:
        final m = u.newMessage.message;
        var e = chats[m.chatId];
        if (e == null) {
          // A new chat: fetch the list entry with names in the background.
          e = chats[m.chatId] = ChatEntry(Chat(id: m.chatId), Dialog(chatId: m.chatId));
          reload();
        }
        _putMessage(e, m);
        if (m.senderId != myId) {
          if (openChatId == m.chatId) {
            markRead(m.chatId);
          } else {
            e.dialog.unreadCount += 1;
          }
          e.typing.remove(m.senderId);
        }
        ensureUsers([m.senderId]);
      case Update_Kind.messageEdited:
        final m = u.messageEdited.message;
        final e = chats[m.chatId];
        if (e != null) _putMessage(e, m);
      case Update_Kind.messagesDeleted:
        _removeMessages(u.messagesDeleted.chatId, u.messagesDeleted.seqs);
      case Update_Kind.readInbox:
        final e = chats[u.readInbox.chatId];
        if (e != null) {
          e.dialog
            ..readInboxSeq = u.readInbox.maxSeq
            ..unreadCount = u.readInbox.stillUnreadCount;
        }
      case Update_Kind.readOutbox:
        final e = chats[u.readOutbox.chatId];
        if (e != null && u.readOutbox.maxSeq > e.dialog.readOutboxSeq) e.dialog.readOutboxSeq = u.readOutbox.maxSeq;
      case Update_Kind.dialogUpdated:
        final e = chats[u.dialogUpdated.dialog.chatId];
        if (e != null) {
          final top = e.dialog.hasTopMessage() ? e.dialog.topMessage : null;
          e.dialog = u.dialogUpdated.dialog;
          if (!e.dialog.hasTopMessage() && top != null) e.dialog.topMessage = top;
        }
      case Update_Kind.chatLeft:
        chats.remove(u.chatLeft.chatId);
      case Update_Kind.historyCleared:
        final e = chats[u.historyCleared.chatId];
        if (e != null) {
          e.messages.removeWhere((seq, _) => seq <= u.historyCleared.maxSeq);
          e.dialog
            ..clearTopMessage()
            ..unreadCount = 0;
        }
      case Update_Kind.messagePinned:
        final p = u.messagePinned;
        final m = chats[p.chatId]?.messages[p.seq];
        if (m != null) m.pinned = p.pinned;
      case Update_Kind.typing:
        final t = u.typing;
        chats[t.chatId]?.typing[t.userId] = DateTime.now().add(const Duration(seconds: 6));
      case Update_Kind.userUpdated:
        users[u.userUpdated.user.id] = u.userUpdated.user;
      default:
        break; // Newer update kinds are ignored by older apps (protocol §8).
    }
    _changed();
  }

  void _sweepTyping() {
    final now = DateTime.now();
    var changed = false;
    for (final e in chats.values) {
      final before = e.typing.length;
      e.typing.removeWhere((_, until) => until.isBefore(now));
      changed |= before != e.typing.length;
    }
    if (changed) _changed();
  }
}

final chatApiProvider = Provider<ChatApi>((ref) => RemoteChatApi(ref.watch(connectionProvider)));

final chatStoreProvider = NotifierProvider<ChatStore, int>(ChatStore.new);
