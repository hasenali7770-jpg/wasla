import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../gen/proto/wasla/v1/auth.pb.dart';
import '../../gen/proto/wasla/v1/frame.pbenum.dart';
import '../../gen/proto/wasla/v1/users.pb.dart';
import '../chat/chat_store.dart';
import '../net/connection.dart';
import '../net/rpc_exception.dart';
import '../providers.dart';
import 'auth_api.dart';
import 'session_store.dart';

/// Where the user is in the login flow. The router maps each state to a screen.
sealed class AuthState {
  const AuthState();
}

class AuthRestoring extends AuthState {
  const AuthRestoring();
}

class AuthSignedOut extends AuthState {
  const AuthSignedOut();
}

class AuthCodeSent extends AuthState {
  const AuthCodeSent({
    required this.phone,
    required this.codeHash,
    required this.codeLength,
    required this.delivery,
    required this.resendAt,
    this.devCode = '',
  });
  final String phone;
  final String codeHash;
  final int codeLength;
  final CodeDelivery delivery;
  final DateTime resendAt;

  /// Non-empty only on test servers (shown on screen for testers).
  final String devCode;
}

class AuthNeedsSignUp extends AuthState {
  const AuthNeedsSignUp({required this.phone, required this.codeHash, required this.termsVersion});
  final String phone;
  final String codeHash;
  final String termsVersion;
}

class AuthNeedsPassword extends AuthState {
  const AuthNeedsPassword({required this.hint, required this.loginToken});
  final String hint;
  final String loginToken;
}

class AuthSignedIn extends AuthState {
  const AuthSignedIn(this.user);
  final User user;
}

class AuthController extends Notifier<AuthState> {
  late AuthApi _api;
  late SessionStore _store;
  late WaslaConnection _conn;

  @override
  AuthState build() {
    _api = ref.watch(authApiProvider);
    _store = ref.watch(sessionStoreProvider);
    _conn = ref.watch(connectionProvider);
    _conn.onSessionRevoked = _onRevoked;
    Future.microtask(_restore);
    return const AuthRestoring();
  }

  Future<void> _restore() async {
    final token = await _store.read();
    if (token == null || token.isEmpty) {
      state = const AuthSignedOut();
      return;
    }
    _conn.token = token;
    try {
      final ack = await _conn.connect();
      if (ack.authenticated) {
        state = AuthSignedIn(await _api.getMe());
        return;
      }
      await _store.clear();
      _conn.token = '';
      state = const AuthSignedOut();
    } on RpcException {
      // Offline at launch: stay signed in with what we know; the connection
      // keeps retrying in the background. (Local profile cache: Sprint 2.)
      state = AuthSignedIn(User());
    }
  }

  /// Step 1. Throws [RpcException] for the UI to show.
  Future<void> sendCode(String phoneE164) async {
    final r = await _api.sendCode(phoneE164, ref.read(attestationProvider));
    state = AuthCodeSent(
      phone: phoneE164,
      codeHash: r.codeHash,
      codeLength: r.codeLength,
      delivery: r.delivery,
      resendAt: DateTime.now().add(Duration(seconds: r.resendAfterSeconds)),
      devCode: r.devCode,
    );
  }

  Future<void> resend() async {
    final s = state;
    if (s is! AuthCodeSent) return;
    final r = await _api.resendCode(s.phone, s.codeHash);
    state = AuthCodeSent(
      phone: s.phone,
      codeHash: r.codeHash,
      codeLength: r.codeLength,
      delivery: r.delivery,
      resendAt: DateTime.now().add(Duration(seconds: r.resendAfterSeconds)),
      devCode: r.devCode,
    );
  }

  /// Step 2.
  Future<void> submitCode(String code) async {
    final s = state;
    if (s is! AuthCodeSent) return;
    final r = await _api.signIn(s.phone, s.codeHash, code);
    switch (r.whichResult()) {
      case SignInResponse_Result.authorization:
        await _signedIn(r.authorization);
      case SignInResponse_Result.signUpRequired:
        state = AuthNeedsSignUp(phone: s.phone, codeHash: s.codeHash, termsVersion: r.signUpRequired.termsVersion);
      case SignInResponse_Result.passwordRequired:
        state = AuthNeedsPassword(hint: r.passwordRequired.hint, loginToken: r.passwordRequired.loginToken);
      case SignInResponse_Result.notSet:
        throw const RpcException(ErrorCode.ERROR_CODE_INTERNAL);
    }
  }

  /// Step 3a (new account).
  Future<void> signUp(String firstName, String lastName) async {
    final s = state;
    if (s is! AuthNeedsSignUp) return;
    final r = await _api.signUp(SignUpRequest(
      phone: s.phone,
      codeHash: s.codeHash,
      firstName: firstName.trim(),
      lastName: lastName.trim(),
      termsVersion: s.termsVersion,
    ));
    await _signedIn(r.authorization);
  }

  /// Step 3b (two-step verification).
  Future<void> checkPassword(String password) async {
    final s = state;
    if (s is! AuthNeedsPassword) return;
    final r = await _api.checkPassword(s.loginToken, password);
    await _signedIn(r.authorization);
  }

  void changeNumber() => state = const AuthSignedOut();

  Future<void> logOut() async {
    try {
      await _api.logOut();
    } on RpcException {
      // Logged out locally regardless; the server session expires on its own.
    }
    await _clearLocal();
  }

  Future<void> _signedIn(Authorization a) async {
    await _store.write(a.sessionToken);
    _conn.token = a.sessionToken;
    state = AuthSignedIn(a.user);
  }

  void _onRevoked() => _clearLocal();

  Future<void> _clearLocal() async {
    // Nothing from this account may remain on the device after logout.
    try {
      (await ref.read(localStoreProvider)).wipe();
    } catch (_) {}
    ref.invalidate(chatStoreProvider);
    await _store.clear();
    _conn.token = '';
    await _conn.close();
    state = const AuthSignedOut();
  }
}
