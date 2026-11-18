import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/l10n/app_localizations.dart';
import '../../core/net/connection.dart';
import '../../core/providers.dart';

/// Sprint 1 placeholder: proves the account works. The chat list is Sprint 2.
class ChatsScreen extends ConsumerWidget {
  const ChatsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = AppLocalizations.of(context);
    final conn = ref.watch(connectionProvider);
    return Scaffold(
      appBar: AppBar(
        title: ValueListenableBuilder(
          valueListenable: conn.state,
          builder: (_, s, _) => Text(s == ConnState.connected ? l.chatsTitle : l.connecting),
        ),
        actions: [
          IconButton(
            tooltip: l.activeSessions,
            icon: const Icon(Icons.devices_outlined),
            onPressed: () => context.push('/settings/sessions'),
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsetsDirectional.all(32),
          child: Text(l.chatsEmpty, textAlign: TextAlign.center),
        ),
      ),
    );
  }
}
