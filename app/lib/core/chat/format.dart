import 'package:fixnum/fixnum.dart';
import 'package:flutter/widgets.dart';

import '../../gen/proto/wasla/v1/chats.pb.dart';
import '../../gen/proto/wasla/v1/messages.pb.dart';
import '../../gen/proto/wasla/v1/users.pb.dart';
import '../l10n/app_localizations.dart';
import 'chat_store.dart';

String userName(User? u, AppLocalizations l) {
  if (u == null) return '…';
  if (u.isDeleted) return l.deletedAccount;
  return '${u.firstName} ${u.lastName}'.trim();
}

String chatTitle(ChatEntry e, ChatStore store, AppLocalizations l) {
  switch (e.chat.type) {
    case ChatType.CHAT_TYPE_SAVED:
      return l.savedMessages;
    case ChatType.CHAT_TYPE_PRIVATE:
      return userName(store.users[e.chat.peerUserId], l);
    default:
      return e.chat.title.isEmpty ? '…' : e.chat.title;
  }
}

/// One-line preview for the chat list.
String preview(Message m, AppLocalizations l) {
  final c = m.content;
  if (c.hasText()) return c.text.text.text.replaceAll('\n', ' ');
  if (c.hasPhoto()) {
    final cap = c.photo.caption.text;
    return cap.isEmpty ? l.photoMsg : '${l.photoMsg} · ${cap.replaceAll('\n', ' ')}';
  }
  if (c.hasDocument()) return l.fileMsg(c.document.media.fileName);
  if (c.hasLocation()) return l.locationMsg;
  if (c.hasContact()) return l.contactMsg;
  return l.unsupportedMsg;
}

/// "14:05" today, "Yesterday", else "18/11/2026". Western digits (Iraqi
/// default); Eastern Arabic digits become a setting later.
String timeLabel(Int64 unix, AppLocalizations l, {bool timeOnly = false}) {
  final t = DateTime.fromMillisecondsSinceEpoch(unix.toInt() * 1000);
  final now = DateTime.now();
  String two(int v) => v.toString().padLeft(2, '0');
  final hm = '${two(t.hour)}:${two(t.minute)}';
  if (timeOnly) return hm;
  final today = DateTime(now.year, now.month, now.day);
  final day = DateTime(t.year, t.month, t.day);
  if (day == today) return hm;
  if (day == today.subtract(const Duration(days: 1))) return l.yesterday;
  return '${two(t.day)}/${two(t.month)}/${t.year}';
}

final _rtlChars = RegExp(r'[֐-ࣿיִ-﷿ﹰ-﻿]');
final _ltrChars = RegExp(r'[A-Za-zÀ-ɏ]');

/// Direction of a message from its first strong character, so an English
/// reply inside an Arabic chat (or the reverse) lays out correctly.
TextDirection textDirectionOf(String s) {
  for (final ch in s.characters) {
    if (_rtlChars.hasMatch(ch)) return TextDirection.rtl;
    if (_ltrChars.hasMatch(ch)) return TextDirection.ltr;
  }
  return TextDirection.rtl;
}

final _fsi = String.fromCharCode(0x2068);
final _pdi = String.fromCharCode(0x2069);

/// Wraps text in a Unicode first-strong isolate: an English snippet inside
/// the Arabic UI (or the reverse) keeps its own punctuation order
/// ("Thursday." not ".Thursday") while the line stays aligned with the UI.
String isolate(String s) => '$_fsi$s$_pdi';

String initials(String name) {
  final parts = name.trim().split(RegExp(r'\s+')).where((p) => p.isNotEmpty).toList();
  if (parts.isEmpty) return '؟';
  return parts.take(2).map((p) => p.characters.first).join();
}

/// "820 KB", "3.4 MB" (localised units).
String fileSize(int bytes, AppLocalizations l) {
  if (bytes < 1024 * 1024) return l.sizeKb((bytes / 1024).ceil().toString());
  final mb = bytes / (1024 * 1024);
  return l.sizeMb(mb >= 10 ? mb.round().toString() : mb.toStringAsFixed(1));
}

/// Caption (or text) of a message, empty for media without one.
String bodyText(Message m) {
  final c = m.content;
  if (c.hasText()) return c.text.text.text;
  if (c.hasPhoto()) return c.photo.caption.text;
  if (c.hasDocument()) return c.document.caption.text;
  return '';
}
