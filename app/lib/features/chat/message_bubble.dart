import 'package:fixnum/fixnum.dart';
import 'package:flutter/material.dart';

import '../../core/chat/chat_store.dart';
import '../../core/chat/format.dart';
import '../../core/l10n/app_localizations.dart';
import '../../gen/proto/wasla/v1/messages.pb.dart';

enum Tick { pending, failed, sent, read, none }

/// One chat bubble. Outgoing messages sit on the *end* side (left in Arabic,
/// right in English); text direction follows each message's own language.
class MessageBubble extends StatelessWidget {
  const MessageBubble({
    super.key,
    required this.text,
    required this.mine,
    required this.time,
    required this.tick,
    this.edited = false,
    this.pinned = false,
    this.forwardedFrom,
    this.replyPreview,
    this.onLongPress,
    this.onTap,
  });

  final String text;
  final bool mine;
  final String time;
  final Tick tick;
  final bool edited;
  final bool pinned;
  final String? forwardedFrom;
  final String? replyPreview;
  final VoidCallback? onLongPress;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final bg = mine ? theme.colorScheme.primaryContainer : theme.colorScheme.surfaceContainerHighest;
    final fg = mine ? theme.colorScheme.onPrimaryContainer : theme.colorScheme.onSurface;
    final small = theme.textTheme.bodySmall?.copyWith(color: fg.withValues(alpha: 0.7));
    const r = Radius.circular(16);
    return Align(
      alignment: mine ? AlignmentDirectional.centerEnd : AlignmentDirectional.centerStart,
      child: GestureDetector(
        onLongPress: onLongPress,
        onTap: onTap,
        child: Container(
          constraints: BoxConstraints(maxWidth: MediaQuery.sizeOf(context).width * 0.8),
          margin: const EdgeInsetsDirectional.symmetric(horizontal: 8, vertical: 2),
          padding: const EdgeInsetsDirectional.fromSTEB(12, 8, 12, 6),
          decoration: BoxDecoration(
            color: bg,
            borderRadius: BorderRadiusDirectional.only(
              topStart: r,
              topEnd: r,
              bottomStart: mine ? r : const Radius.circular(4),
              bottomEnd: mine ? const Radius.circular(4) : r,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (forwardedFrom != null)
                Text(l.forwardedFrom(forwardedFrom!), style: small?.copyWith(fontStyle: FontStyle.italic)),
              if (replyPreview != null)
                Container(
                  margin: const EdgeInsetsDirectional.only(bottom: 4),
                  padding: const EdgeInsetsDirectional.only(start: 8),
                  decoration: BoxDecoration(
                    border: BorderDirectional(start: BorderSide(color: theme.colorScheme.primary, width: 3)),
                  ),
                  child: Text(replyPreview!, maxLines: 2, overflow: TextOverflow.ellipsis, style: small),
                ),
              Text(text, textDirection: textDirectionOf(text), style: TextStyle(color: fg)),
              const SizedBox(height: 2),
              Row(mainAxisSize: MainAxisSize.min, children: [
                if (pinned) Icon(Icons.push_pin, size: 12, color: small?.color),
                if (edited) Text('${l.edited} ', style: small),
                Text(time, style: small),
                if (mine) ...[
                  const SizedBox(width: 4),
                  switch (tick) {
                    Tick.pending => Icon(Icons.schedule, size: 14, color: small?.color),
                    Tick.failed => Icon(Icons.error_outline, size: 14, color: theme.colorScheme.error),
                    Tick.sent => Icon(Icons.done, size: 14, color: small?.color),
                    Tick.read => Icon(Icons.done_all, size: 14, color: theme.colorScheme.primary),
                    Tick.none => const SizedBox.shrink(),
                  },
                ],
              ]),
            ],
          ),
        ),
      ),
    );
  }
}

/// Builds a bubble for a stored message.
MessageBubble bubbleFor(Message m, ChatEntry e, ChatStore store, AppLocalizations l,
    {VoidCallback? onLongPress}) {
  final mine = m.senderId == store.myId;
  final saved = e.chat.type.value == 2;
  String? reply;
  if (m.replyToSeq != Int64.ZERO) {
    final orig = e.messages[m.replyToSeq];
    reply = orig == null ? '…' : '${userName(store.users[orig.senderId], l)}: ${preview(orig, l)}';
  }
  String? fwd;
  if (m.hasForward()) {
    fwd = m.forward.fromUserId != Int64.ZERO && store.users.containsKey(m.forward.fromUserId)
        ? userName(store.users[m.forward.fromUserId], l)
        : m.forward.fromName;
  }
  return MessageBubble(
    key: ValueKey('msg-${m.seq}'),
    text: preview(m, l),
    mine: mine,
    time: timeLabel(m.date, l, timeOnly: true),
    tick: !mine ? Tick.none : (saved || m.seq <= e.dialog.readOutboxSeq ? Tick.read : Tick.sent),
    edited: m.editDate != Int64.ZERO,
    pinned: m.pinned,
    forwardedFrom: fwd,
    replyPreview: reply,
    onLongPress: onLongPress,
  );
}
