import 'package:fixnum/fixnum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/chat/chat_store.dart';
import '../../core/chat/format.dart';
import '../../core/l10n/app_localizations.dart';
import '../../core/net/connection.dart';
import '../../core/net/rpc_exception.dart';
import '../../core/providers.dart';
import '../chat/avatar.dart';

class ChatsScreen extends ConsumerStatefulWidget {
  const ChatsScreen({super.key});
  @override
  ConsumerState<ChatsScreen> createState() => _ChatsScreenState();
}

class _ChatsScreenState extends ConsumerState<ChatsScreen> {
  bool _archived = false;

  Future<void> _openSaved() async {
    final store = ref.read(chatStoreProvider.notifier);
    try {
      final id = await store.openPrivateChat(store.myId);
      if (mounted) context.push('/chat/$id');
    } on RpcException catch (e) {
      if (mounted) _snack(e.message(AppLocalizations.of(context)));
    }
  }

  void _snack(String text) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));

  Future<void> _dialogMenu(ChatEntry e) async {
    final l = AppLocalizations.of(context);
    final store = ref.read(chatStoreProvider.notifier);
    final pinned = e.dialog.pinnedRank != 0;
    final muted = e.dialog.mutedUntil != Int64.ZERO;
    final action = await showModalBottomSheet<String>(
      context: context,
      builder: (c) => SafeArea(
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          ListTile(
            leading: Icon(pinned ? Icons.push_pin_outlined : Icons.push_pin),
            title: Text(pinned ? l.unpinChat : l.pinChat),
            onTap: () => Navigator.pop(c, 'pin'),
          ),
          ListTile(
            leading: Icon(muted ? Icons.notifications_active_outlined : Icons.notifications_off_outlined),
            title: Text(muted ? l.unmute : l.mute),
            onTap: () => Navigator.pop(c, 'mute'),
          ),
          ListTile(
            leading: Icon(e.dialog.archived ? Icons.unarchive_outlined : Icons.archive_outlined),
            title: Text(e.dialog.archived ? l.unarchive : l.archive),
            onTap: () => Navigator.pop(c, 'archive'),
          ),
        ]),
      ),
    );
    try {
      switch (action) {
        case 'pin':
          await store.updateDialog(e.chat.id, pinned: !pinned);
        case 'mute':
          await store.updateDialog(e.chat.id, muted: !muted);
        case 'archive':
          await store.updateDialog(e.chat.id, archived: !e.dialog.archived);
      }
    } on RpcException catch (err) {
      if (mounted) _snack(err.message(l));
    }
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    ref.watch(chatStoreProvider);
    final store = ref.read(chatStoreProvider.notifier);
    final conn = ref.watch(connectionProvider);
    final list = store.dialogs(archived: _archived);
    return Scaffold(
      appBar: AppBar(
        leading: _archived ? BackButton(onPressed: () => setState(() => _archived = false)) : null,
        title: ValueListenableBuilder(
          valueListenable: conn.state,
          builder: (_, s, _) => Text(
            s != ConnState.connected ? l.connecting : (_archived ? l.archived : l.chatsTitle),
          ),
        ),
        actions: [
          if (!_archived)
            IconButton(
              tooltip: l.archived,
              icon: const Icon(Icons.archive_outlined),
              onPressed: () => setState(() => _archived = true),
            ),
          PopupMenuButton<String>(
            onSelected: (v) => v == 'saved' ? _openSaved() : context.push('/settings/sessions'),
            itemBuilder: (_) => [
              PopupMenuItem(value: 'saved', child: Text(l.savedMessages)),
              PopupMenuItem(value: 'devices', child: Text(l.activeSessions)),
            ],
          ),
        ],
      ),
      floatingActionButton: _archived
          ? null
          : FloatingActionButton(
              tooltip: l.newChat,
              onPressed: () => context.push('/new-chat'),
              child: const Icon(Icons.edit_outlined),
            ),
      body: !store.loaded
          ? Center(
              child: store.loadError == null
                  ? const CircularProgressIndicator()
                  : TextButton(onPressed: store.reload, child: Text(l.loadError)),
            )
          : list.isEmpty
              ? Center(
                  child: Padding(
                    padding: const EdgeInsetsDirectional.all(32),
                    child: Text(l.noChatsYet, textAlign: TextAlign.center),
                  ),
                )
              : RefreshIndicator(
                  onRefresh: store.reload,
                  child: ListView.builder(
                    itemCount: list.length,
                    itemBuilder: (_, i) => _DialogTile(
                      entry: list[i],
                      store: store,
                      onTap: () => context.push('/chat/${list[i].chat.id}'),
                      onLongPress: () => _dialogMenu(list[i]),
                    ),
                  ),
                ),
    );
  }
}

class _DialogTile extends StatelessWidget {
  const _DialogTile({required this.entry, required this.store, required this.onTap, required this.onLongPress});
  final ChatEntry entry;
  final ChatStore store;
  final VoidCallback onTap;
  final VoidCallback onLongPress;

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final d = entry.dialog;
    final title = chatTitle(entry, store, l);
    final top = d.hasTopMessage() ? d.topMessage : null;
    final pending = entry.outbox.isNotEmpty ? entry.outbox.last : null;
    final typing = entry.typing.isNotEmpty;
    final mine = pending != null || (top != null && top.senderId == store.myId);
    String sub = '';
    if (typing) {
      sub = l.typing;
    } else if (pending != null) {
      sub = pending.text;
    } else if (top != null) {
      sub = preview(top, l);
    }
    final muted = d.mutedUntil != Int64.ZERO;
    return ListTile(
      key: ValueKey('dialog-${entry.chat.id}'),
      onTap: onTap,
      onLongPress: onLongPress,
      leading: Avatar(name: title, saved: entry.chat.type.value == 2),
      title: Row(children: [
        Expanded(child: Text(isolate(title), maxLines: 1, overflow: TextOverflow.ellipsis)),
        if (muted) Icon(Icons.volume_off, size: 16, color: theme.hintColor),
        if (d.pinnedRank != 0) Icon(Icons.push_pin, size: 16, color: theme.hintColor),
      ]),
      subtitle: Text(
        isolate(sub),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: typing ? TextStyle(color: theme.colorScheme.primary) : null,
      ),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(mainAxisSize: MainAxisSize.min, children: [
            if (mine && pending != null)
              Icon(pending.status == OutStatus.failed ? Icons.error_outline : Icons.schedule, size: 14)
            else if (mine && top != null)
              Icon(top.seq <= d.readOutboxSeq ? Icons.done_all : Icons.done, size: 14, color: theme.colorScheme.primary),
            const SizedBox(width: 4),
            if (top != null) Text(timeLabel(top.date, l), style: theme.textTheme.bodySmall),
          ]),
          const SizedBox(height: 4),
          if (d.unreadCount > 0)
            Badge(
              label: Text('${d.unreadCount}'),
              backgroundColor: muted ? theme.disabledColor : theme.colorScheme.primary,
            ),
        ],
      ),
    );
  }
}
