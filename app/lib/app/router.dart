import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../core/auth/auth_controller.dart';
import 'theme.dart';
import '../core/providers.dart';
import '../features/auth/code_screen.dart';
import '../features/auth/password_screen.dart';
import '../features/auth/phone_screen.dart';
import '../features/auth/signup_screen.dart';
import '../features/chat/chat_screen.dart';
import '../features/chats/chats_screen.dart';
import '../features/chats/new_chat_screen.dart';
import '../features/settings/sessions_screen.dart';
import '../features/settings/storage_screen.dart';

/// The login state decides the screen; the router only follows it.
String? authRedirect(AuthState auth, String location) {
  final target = switch (auth) {
    AuthRestoring() => '/splash',
    AuthSignedOut() => '/login',
    AuthCodeSent() => '/login/code',
    AuthNeedsSignUp() => '/login/signup',
    AuthNeedsPassword() => '/login/password',
    AuthSignedIn() => null,
  };
  if (target != null) return location == target ? null : target;
  // Signed in: leave the login/splash screens.
  if (location == '/splash' || location.startsWith('/login')) return '/chats';
  return null;
}

final routerProvider = Provider<GoRouter>((ref) {
  final refresh = ValueNotifier<AuthState>(ref.read(authProvider));
  ref.listen(authProvider, (_, next) => refresh.value = next);
  ref.onDispose(refresh.dispose);
  return GoRouter(
    initialLocation: '/splash',
    refreshListenable: refresh,
    redirect: (context, state) => authRedirect(ref.read(authProvider), state.matchedLocation),
    routes: [
      GoRoute(path: '/splash', builder: (_, _) => const _Splash()),
      GoRoute(path: '/login', builder: (_, _) => const PhoneScreen()),
      GoRoute(path: '/login/code', builder: (_, _) => const CodeScreen()),
      GoRoute(path: '/login/signup', builder: (_, _) => const SignUpScreen()),
      GoRoute(path: '/login/password', builder: (_, _) => const PasswordScreen()),
      GoRoute(path: '/chats', builder: (_, _) => const ChatsScreen()),
      GoRoute(path: '/new-chat', builder: (_, _) => const NewChatScreen()),
      GoRoute(path: '/chat/:id', builder: (_, s) => chatRoute(s)),
      GoRoute(path: '/settings/sessions', builder: (_, _) => const SessionsScreen()),
      GoRoute(path: '/settings/storage', builder: (_, _) => const StorageScreen()),
    ],
  );
});

class _Splash extends StatelessWidget {
  const _Splash();
  @override
  Widget build(BuildContext context) => const Scaffold(body: Center(child: BrandMark(size: 112)));
}
