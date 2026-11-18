import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../gen/proto/wasla/v1/common.pbenum.dart';
import 'auth/auth_api.dart';
import 'auth/auth_controller.dart';
import 'auth/session_store.dart';
import 'net/connection.dart';

/// Gateway URL. Override at build time:
///   flutter run --dart-define=WASLA_WS_URL=wss://edge.wasla.app/ws
/// The default reaches a backend on the host from the Android emulator.
const wsUrl = String.fromEnvironment('WASLA_WS_URL', defaultValue: 'ws://10.0.2.2:8080/ws');
const appVersion = '0.1.0';

/// The UI language. Arabic is the default for Iraqi users.
class LocaleController extends Notifier<Locale> {
  @override
  Locale build() => const Locale('ar');
  void set(Locale l) => state = l;
}

final localeProvider = NotifierProvider<LocaleController, Locale>(LocaleController.new);

final connectionProvider = Provider<WaslaConnection>((ref) {
  final conn = WaslaConnection(
    url: Uri.parse(wsUrl),
    info: ClientInfo(
      platform: _platform(),
      appVersion: appVersion,
      langCode: ref.read(localeProvider).languageCode,
    ),
  );
  ref.onDispose(conn.close);
  return conn;
});

final sessionStoreProvider = Provider<SessionStore>((ref) => SecureSessionStore());

final authApiProvider = Provider<AuthApi>((ref) => RemoteAuthApi(ref.watch(connectionProvider)));

/// Play Integrity / App Attest token. The native integration lands with the
/// release build; "dev" is accepted only by development servers.
final attestationProvider = Provider<String>((ref) => kReleaseMode ? '' : 'dev');

final authProvider = NotifierProvider<AuthController, AuthState>(AuthController.new);

Platform _platform() {
  if (kIsWeb) return Platform.PLATFORM_WEB;
  return switch (defaultTargetPlatform) {
    TargetPlatform.android => Platform.PLATFORM_ANDROID,
    TargetPlatform.iOS => Platform.PLATFORM_IOS,
    TargetPlatform.windows => Platform.PLATFORM_WINDOWS,
    TargetPlatform.macOS => Platform.PLATFORM_MACOS,
    TargetPlatform.linux => Platform.PLATFORM_LINUX,
    _ => Platform.PLATFORM_UNSPECIFIED,
  };
}
