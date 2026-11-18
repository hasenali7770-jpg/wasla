import 'dart:async';

import 'package:fixnum/fixnum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/chat/chat_store.dart';
import '../../core/chat/format.dart';
import '../../core/l10n/app_localizations.dart';
import '../../core/net/rpc_exception.dart';
import '../../core/phone.dart';
import '../../gen/proto/wasla/v1/contacts.pb.dart';
import '../../gen/proto/wasla/v1/users.pb.dart';
import '../chat/avatar.dart';

/// Find someone by @username, name (among contacts) or phone number.
class NewChatScreen extends ConsumerStatefulWidget {
  const NewChatScreen({super.key});
  @override
  ConsumerState<NewChatScreen> createState() => _NewChatScreenState();
}

class _NewChatScreenState extends ConsumerState<NewChatScreen> {
  final _q = TextEditingController();
  Timer? _debounce;
  bool _busy = false;
  String? _message;
  List<User> _contacts = [];
  List<User> _global = [];

  @override
  void dispose() {
    _debounce?.cancel();
    _q.dispose();
    super.dispose();
  }

  void _onChanged(String _) {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 400), _search);
  }

  Future<void> _search() async {
    final l = AppLocalizations.of(context);
    final api = ref.read(chatApiProvider);
    final query = _q.text.trim();
    setState(() {
      _busy = true;
      _message = null;
    });
    try {
      final phone = normalizePhone(query);
      if (phone != null) {
        // Looking up a number saves it as a contact (subject to anti-scraping limits).
        final r = await api.importContacts([InputContact(clientId: Int64.ONE, phone: phone)]);
        _contacts = r.users;
        _global = [];
        if (r.users.isEmpty) _message = l.notOnWasla;
      } else if (query.isEmpty) {
        _contacts = _global = [];
      } else {
        final r = await api.searchUsers(query);
        _contacts = r.contacts;
        _global = r.global;
        if (_contacts.isEmpty && _global.isEmpty) _message = l.noResults;
      }
    } on RpcException catch (e) {
      _message = e.message(l);
    }
    if (mounted) setState(() => _busy = false);
  }

  Future<void> _open(User u) async {
    final store = ref.read(chatStoreProvider.notifier);
    try {
      final id = await store.openPrivateChat(u.id);
      if (mounted) context.pushReplacement('/chat/$id');
    } on RpcException catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.message(AppLocalizations.of(context)))));
      }
    }
  }

  Widget _tile(User u) {
    final l = AppLocalizations.of(context);
    final name = userName(u, l);
    return ListTile(
      leading: Avatar(name: name),
      title: Text(name),
      subtitle: u.username.isEmpty ? null : Text('@${u.username}', textDirection: TextDirection.ltr),
      onTap: () => _open(u),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(l.newChat)),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsetsDirectional.all(16),
            child: TextField(
              key: const Key('new-chat-search'),
              controller: _q,
              autofocus: true,
              decoration: InputDecoration(prefixIcon: const Icon(Icons.search), hintText: l.searchHint),
              onChanged: _onChanged,
              onSubmitted: (_) => _search(),
            ),
          ),
          if (_busy) const LinearProgressIndicator(),
          if (_message != null)
            Padding(padding: const EdgeInsetsDirectional.all(16), child: Text(_message!, textAlign: TextAlign.center)),
          if (_contacts.isNotEmpty) ListTile(dense: true, title: Text(l.contactsSection)),
          ..._contacts.map(_tile),
          if (_global.isNotEmpty) ListTile(dense: true, title: Text(l.globalSection)),
          ..._global.map(_tile),
        ],
      ),
    );
  }
}
