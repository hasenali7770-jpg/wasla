import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/l10n/app_localizations.dart';
import '../../core/net/rpc_exception.dart';
import '../../core/providers.dart';
import '../../gen/proto/wasla/v1/auth.pb.dart';

/// Active sessions with remote logout, plus logging out of this device.
class SessionsScreen extends ConsumerStatefulWidget {
  const SessionsScreen({super.key});
  @override
  ConsumerState<SessionsScreen> createState() => _SessionsScreenState();
}

class _SessionsScreenState extends ConsumerState<SessionsScreen> {
  late Future<List<Session>> _sessions = ref.read(authApiProvider).listSessions();

  Future<void> _revoke(Session s) async {
    final l = AppLocalizations.of(context);
    try {
      await ref.read(authApiProvider).revokeSession(s);
      setState(() => _sessions = ref.read(authApiProvider).listSessions());
    } on RpcException catch (e) {
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.message(l))));
    }
  }

  Future<void> _logout() async {
    final l = AppLocalizations.of(context);
    final ok = await showDialog<bool>(
      context: context,
      builder: (c) => AlertDialog(
        content: Text(l.logoutConfirm),
        actions: [
          TextButton(onPressed: () => Navigator.pop(c, false), child: Text(l.cancel)),
          TextButton(onPressed: () => Navigator.pop(c, true), child: Text(l.logout)),
        ],
      ),
    );
    if (ok == true) await ref.read(authProvider.notifier).logOut();
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(l.activeSessions)),
      body: FutureBuilder<List<Session>>(
        future: _sessions,
        builder: (context, snap) {
          if (snap.hasError) {
            final err = snap.error;
            return Center(child: Text(err is RpcException ? err.message(l) : l.errGeneric));
          }
          if (!snap.hasData) return const Center(child: CircularProgressIndicator());
          return ListView(
            children: [
              for (final s in snap.data!)
                ListTile(
                  leading: const Icon(Icons.smartphone_outlined),
                  title: Text(s.deviceModel.isEmpty ? s.platform.name : s.deviceModel),
                  subtitle: Text(s.current ? l.thisDevice : 'Wasla ${s.appVersion}'),
                  trailing: s.current
                      ? null
                      : IconButton(
                          tooltip: l.endSession,
                          icon: const Icon(Icons.logout),
                          onPressed: () => _revoke(s),
                        ),
                ),
              const Divider(),
              ListTile(
                leading: Icon(Icons.logout, color: Theme.of(context).colorScheme.error),
                title: Text(l.logout, style: TextStyle(color: Theme.of(context).colorScheme.error)),
                onTap: _logout,
              ),
            ],
          );
        },
      ),
    );
  }
}
