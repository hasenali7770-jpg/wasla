import 'package:fixnum/fixnum.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/chat/chat_store.dart';
import '../../core/chat/format.dart';
import '../../core/l10n/app_localizations.dart';
import '../../core/net/rpc_exception.dart';
import '../../gen/proto/wasla/v1/chats.pb.dart';
import '../../gen/proto/wasla/v1/messages.pb.dart';
import '../report/report_sheet.dart';
import 'avatar.dart';
import 'message_bubble.dart';

class ChatScreen extends ConsumerStatefulWidget {
  const ChatScreen({super.key, required this.chatId});
  final Int64 chatId;
  @override
  ConsumerState<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends ConsumerState<ChatScreen> {
  final _input = TextEditingController();
  final _scroll = ScrollController();
  Message? _replyTo;
  Message? _editing;
  late final ChatStore _store = ref.read(chatStoreProvider.notifier);

  @override
  void initState() {
    super.initState();
    _store.openChatId = widget.chatId;
    _scroll.addListener(_maybeLoadOlder);
    Future.microtask(() async {
      try {
        await _store.loadHistory(widget.chatId);
        await _store.markRead(widget.chatId);
      } on RpcException catch (e) {
        _snack(e);
      }
    });
  }

  @override
  void dispose() {
    if (_store.openChatId == widget.chatId) _store.openChatId = null;
    _input.dispose();
    _scroll.dispose();
    super.dispose();
  }

  void _maybeLoadOlder() {
    if (_scroll.position.pixels > _scroll.position.maxScrollExtent - 300) {
      _store.loadHistory(widget.chatId, older: true).catchError((_) {});
    }
  }

  void _snack(Object e) {
    if (!mounted) return;
    final l = AppLocalizations.of(context);
    final text = e is RpcException ? e.message(l) : e.toString();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
  }

  Future<void> _run(Future<void> Function() f) async {
    try {
      await f();
    } on RpcException catch (e) {
      _snack(e);
    }
  }

  void _send() {
    final text = _input.text;
    if (text.trim().isEmpty) return;
    final editing = _editing;
    if (editing != null) {
      _run(() => _store.edit(widget.chatId, editing.seq, text));
    } else {
      _store.sendText(widget.chatId, text, replyTo: _replyTo?.seq);
    }
    _input.clear();
    setState(() {
      _replyTo = null;
      _editing = null;
    });
  }

  Future<void> _messageMenu(ChatEntry e, Message m) async {
    final l = AppLocalizations.of(context);
    final mine = m.senderId == _store.myId;
    final canEdit = mine && m.content.hasText() &&
        DateTime.now().difference(DateTime.fromMillisecondsSinceEpoch(m.date.toInt() * 1000)).inHours < 48;
    final action = await showModalBottomSheet<String>(
      context: context,
      builder: (c) => SafeArea(
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          _item(c, 'reply', Icons.reply, l.reply),
          _item(c, 'copy', Icons.copy, l.copy),
          if (canEdit) _item(c, 'edit', Icons.edit_outlined, l.edit),
          _item(c, 'forward', Icons.forward, l.forward),
          _item(c, 'pin', Icons.push_pin_outlined, m.pinned ? l.unpin : l.pin),
          _item(c, 'delete', Icons.delete_outline, l.delete),
          if (!mine) _item(c, 'report', Icons.flag_outlined, l.report, danger: true),
        ]),
      ),
    );
    if (!mounted) return;
    switch (action) {
      case 'reply':
        setState(() {
          _replyTo = m;
          _editing = null;
        });
      case 'copy':
        await Clipboard.setData(ClipboardData(text: preview(m, l)));
        if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(l.copied)));
      case 'edit':
        setState(() {
          _editing = m;
          _replyTo = null;
          _input.text = m.content.text.text.text;
        });
      case 'forward':
        await _forward(m);
      case 'pin':
        await _run(() => _store.togglePin(widget.chatId, m));
      case 'delete':
        await _delete(e, m);
      case 'report':
        final t = ReportTarget.messages(widget.chatId, [m.seq],
            authorId: e.chat.type == ChatType.CHAT_TYPE_PRIVATE ? m.senderId : null);
        await showReportSheet(context, ref, t);
    }
  }

  Widget _item(BuildContext c, String value, IconData icon, String label, {bool danger = false}) {
    final color = danger ? Theme.of(c).colorScheme.error : null;
    return ListTile(
      key: Key('action-$value'),
      leading: Icon(icon, color: color),
      title: Text(label, style: TextStyle(color: color)),
      onTap: () => Navigator.pop(c, value),
    );
  }

  Future<void> _forward(Message m) async {
    final l = AppLocalizations.of(context);
    final targets = _store.dialogs().where((d) => d.chat.id != widget.chatId).toList();
    final choice = await showModalBottomSheet<Int64>(
      context: context,
      builder: (c) => SafeArea(
        child: ListView(shrinkWrap: true, children: [
          ListTile(title: Text(l.chooseChat), dense: true),
          ListTile(
            leading: const Avatar(name: '', saved: true, radius: 18),
            title: Text(l.forwardToSaved),
            onTap: () => Navigator.pop(c, Int64.ZERO),
          ),
          for (final d in targets)
            ListTile(
              leading: Avatar(name: chatTitle(d, _store, l), radius: 18),
              title: Text(chatTitle(d, _store, l)),
              onTap: () => Navigator.pop(c, d.chat.id),
            ),
        ]),
      ),
    );
    if (choice == null) return;
    await _run(() => choice == Int64.ZERO
        ? _store.forwardToSaved(widget.chatId, [m.seq])
        : _store.forwardTo(widget.chatId, [m.seq], choice));
  }

  Future<void> _delete(ChatEntry e, Message m) async {
    final l = AppLocalizations.of(context);
    final mine = m.senderId == _store.myId;
    final privateish = e.chat.type == ChatType.CHAT_TYPE_PRIVATE || e.chat.type == ChatType.CHAT_TYPE_SAVED;
    final forEveryone = await showDialog<bool>(
      context: context,
      builder: (c) => SimpleDialog(children: [
        SimpleDialogOption(onPressed: () => Navigator.pop(c, false), child: Text(l.deleteForMe)),
        if ((mine || privateish) && e.chat.type != ChatType.CHAT_TYPE_SAVED)
          SimpleDialogOption(onPressed: () => Navigator.pop(c, true), child: Text(l.deleteForEveryone)),
      ]),
    );
    if (forEveryone == null) return;
    await _run(() => _store.delete(widget.chatId, [m.seq], forEveryone: forEveryone));
  }

  Future<void> _chatMenu(String action, ChatEntry e) async {
    final l = AppLocalizations.of(context);
    final peer = e.chat.peerUserId;
    switch (action) {
      case 'report':
        await showReportSheet(context, ref, ReportTarget.user(peer));
      case 'block':
        final ok = await showDialog<bool>(
          context: context,
          builder: (c) => AlertDialog(
            content: Text(l.blockConfirm(userName(_store.users[peer], l))),
            actions: [
              TextButton(onPressed: () => Navigator.pop(c, false), child: Text(l.cancel)),
              TextButton(
                key: const Key('confirm-block'),
                onPressed: () => Navigator.pop(c, true),
                child: Text(l.block, style: TextStyle(color: Theme.of(c).colorScheme.error)),
              ),
            ],
          ),
        );
        if (ok == true) await _run(() => _store.setBlocked(peer, true));
      case 'unblock':
        await _run(() => _store.setBlocked(peer, false));
    }
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    ref.watch(chatStoreProvider);
    final e = _store.chats[widget.chatId];
    if (e == null) {
      return Scaffold(appBar: AppBar(), body: const Center(child: CircularProgressIndicator()));
    }
    final title = chatTitle(e, _store, l);
    final isPrivate = e.chat.type == ChatType.CHAT_TYPE_PRIVATE;
    final peer = _store.users[e.chat.peerUserId];
    final blocked = isPrivate && (peer?.isBlocked ?? false);
    final messages = e.sortedMessages.reversed.toList();
    final outbox = e.outbox.reversed.toList();

    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: Row(children: [
          Avatar(name: title, saved: e.chat.type == ChatType.CHAT_TYPE_SAVED, radius: 18),
          const SizedBox(width: 10),
          Expanded(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(isolate(title), maxLines: 1, overflow: TextOverflow.ellipsis),
              if (e.typing.isNotEmpty)
                Text(l.typing, style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Theme.of(context).colorScheme.primary)),
            ]),
          ),
        ]),
        actions: [
          if (isPrivate)
            PopupMenuButton<String>(
              key: const Key('chat-menu'),
              onSelected: (a) => _chatMenu(a, e),
              itemBuilder: (_) => [
                PopupMenuItem(value: blocked ? 'unblock' : 'block', child: Text(blocked ? l.unblock : l.block)),
                PopupMenuItem(value: 'report', child: Text(l.report)),
              ],
            ),
        ],
      ),
      body: Column(children: [
        Expanded(
          child: ListView.builder(
            controller: _scroll,
            reverse: true,
            padding: const EdgeInsetsDirectional.symmetric(vertical: 8),
            itemCount: outbox.length + messages.length,
            itemBuilder: (_, i) {
              if (i < outbox.length) {
                final o = outbox[i];
                return MessageBubble(
                  key: ValueKey('out-${o.randomId}'),
                  text: o.text,
                  mine: true,
                  time: timeLabel(Int64(o.createdAt.millisecondsSinceEpoch ~/ 1000), l, timeOnly: true),
                  tick: o.status == OutStatus.failed ? Tick.failed : Tick.pending,
                  onTap: o.status == OutStatus.failed ? () => _store.retry(o) : null,
                  onLongPress: o.status == OutStatus.failed ? () => _store.discard(o) : null,
                );
              }
              final m = messages[i - outbox.length];
              return bubbleFor(m, e, _store, l, onLongPress: () => _messageMenu(e, m));
            },
          ),
        ),
        if (e.outbox.any((o) => o.status == OutStatus.failed))
          Padding(
            padding: const EdgeInsetsDirectional.symmetric(horizontal: 16),
            child: Text(l.sendFailed, style: TextStyle(color: Theme.of(context).colorScheme.error)),
          ),
        if (blocked)
          Material(
            color: Theme.of(context).colorScheme.surfaceContainerHighest,
            child: ListTile(
              title: Text(l.youBlocked),
              trailing: TextButton(onPressed: () => _chatMenu('unblock', e), child: Text(l.unblock)),
            ),
          )
        else
          _composer(l),
      ]),
    );
  }

  Widget _composer(AppLocalizations l) {
    final banner = _editing != null
        ? l.editing
        : _replyTo != null
            ? l.replyingTo(userName(_store.users[_replyTo!.senderId], l))
            : null;
    return SafeArea(
      top: false,
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        if (banner != null)
          ListTile(
            dense: true,
            leading: Icon(_editing != null ? Icons.edit_outlined : Icons.reply),
            title: Text(banner),
            trailing: IconButton(
              icon: const Icon(Icons.close),
              onPressed: () => setState(() {
                if (_editing != null) _input.clear();
                _editing = null;
                _replyTo = null;
              }),
            ),
          ),
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(8, 4, 8, 8),
          child: Row(children: [
            Expanded(
              child: TextField(
                key: const Key('composer'),
                controller: _input,
                minLines: 1,
                maxLines: 5,
                maxLength: 4096,
                buildCounter: (_, {required currentLength, required isFocused, maxLength}) => null,
                textCapitalization: TextCapitalization.sentences,
                decoration: InputDecoration(
                  hintText: l.messageHint,
                  border: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(24))),
                  contentPadding: const EdgeInsetsDirectional.symmetric(horizontal: 16, vertical: 10),
                ),
                onChanged: (_) => _store.typing(widget.chatId),
              ),
            ),
            const SizedBox(width: 4),
            IconButton.filled(
              key: const Key('send'),
              icon: Icon(_editing != null ? Icons.check : Icons.send),
              onPressed: _send,
            ),
          ]),
        ),
      ]),
    );
  }
}

/// Router entry: /chat/:id
Widget chatRoute(GoRouterState s) => ChatScreen(chatId: Int64.parseInt(s.pathParameters['id']!));
