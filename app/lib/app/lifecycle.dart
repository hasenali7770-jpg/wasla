import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/auth/auth_controller.dart';
import '../core/net/connection.dart';
import '../core/providers.dart';
import '../core/push/push.dart';
import 'router.dart';

/// How long the app may sit in the background before it disconnects. After
/// that the server sees the user as offline and sends push notifications.
const backgroundGrace = Duration(seconds: 15);

/// Ties the connection and push notifications to the app's life:
/// - signed in: registers this phone for pushes (and again on new tokens);
/// - in the background: disconnects after [backgroundGrace], so new messages
///   arrive as notifications instead of silently into a hidden app;
/// - back in front: reconnects, which catches up on everything missed;
/// - a tapped notification opens its chat.
class AppLifecycle extends ConsumerStatefulWidget {
  const AppLifecycle({super.key, required this.child});
  final Widget child;
  @override
  ConsumerState<AppLifecycle> createState() => _AppLifecycleState();
}

class _AppLifecycleState extends ConsumerState<AppLifecycle> with WidgetsBindingObserver {
  Timer? _sleep;
  bool _asleep = false;
  bool _pushStarted = false;
  final _subs = <StreamSubscription<Object?>>[];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    ref.listenManual(authProvider, (_, next) {
      if (next is AuthSignedIn) {
        _startPush();
      } else {
        _pushStarted = false; // a new sign-in registers again
      }
    }, fireImmediately: true);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _sleep?.cancel();
    for (final s in _subs) {
      s.cancel();
    }
    super.dispose();
  }

  Future<void> _startPush() async {
    if (_pushStarted) return;
    _pushStarted = true;
    final push = ref.read(pushPlatformProvider);
    final token = await push.start();
    if (token == null || !mounted) return;
    _register(token);
    _subs
      ..add(push.tokenRefresh.listen(_register))
      ..add(push.openedChats.listen(_openChat));
    final launch = await push.launchChat();
    if (launch != null) _openChat(launch);
  }

  void _register(String token) {
    ref.read(authApiProvider).registerPushToken(token).catchError((Object e) {
      debugPrint('push: register failed ($e); retried on next start');
    });
  }

  void _openChat(Object chatId) {
    if (!mounted) return;
    ref.read(routerProvider).push('/chat/$chatId');
  }

  @override
  Widget build(BuildContext context) => widget.child;

  @override
  void didChangeAppLifecycleState(AppLifecycleState s) {
    final conn = ref.read(connectionProvider);
    switch (s) {
      case AppLifecycleState.paused:
      case AppLifecycleState.hidden:
        _sleep ??= Timer(backgroundGrace, () {
          _asleep = true;
          conn.close();
        });
      case AppLifecycleState.resumed:
        _sleep?.cancel();
        _sleep = null;
        if (_asleep) {
          _asleep = false;
          if (ref.read(authProvider) is AuthSignedIn && conn.state.value == ConnState.disconnected) {
            // Failures are retried by the connection itself.
            conn.connect().then((_) {}, onError: (Object _) {});
          }
        }
      default:
        break;
    }
  }
}
