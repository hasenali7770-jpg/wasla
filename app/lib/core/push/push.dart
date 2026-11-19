import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:fixnum/fixnum.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// The phone's push service. The server sends a push only when no device of
/// the user is connected; it carries just the chat ID, never message text.
abstract interface class PushPlatform {
  /// Sets up push and returns this device's token, or null if push is not
  /// available (no Firebase config in this build, web, permission denied).
  Future<String?> start();

  /// New tokens issued later by the platform.
  Stream<String> get tokenRefresh;

  /// The chat whose notification launched the app, if any.
  Future<Int64?> launchChat();

  /// Chats whose notification was tapped while the app was in the background.
  Stream<Int64> get openedChats;
}

Int64? _chatOf(RemoteMessage m) {
  final id = m.data['chat_id'];
  return id is String && id.isNotEmpty ? Int64.parseInt(id) : null;
}

/// Firebase Cloud Messaging. Firebase reads its config from Android
/// resources generated in CI (tool/firebase_config.py); builds without it
/// simply have no push.
class FirebasePush implements PushPlatform {
  bool _ready = false;

  @override
  Future<String?> start() async {
    try {
      if (Firebase.apps.isEmpty) await Firebase.initializeApp();
      final fm = FirebaseMessaging.instance;
      final perm = await fm.requestPermission();
      if (perm.authorizationStatus == AuthorizationStatus.denied) return null;
      _ready = true;
      // The classic registration token, which the server's FCM HTTP v1 sender
      // targets. firebase_messaging 17 also offers FID registration
      // (register/onRegistered); moving to it is tracked in docs/sprint-plan.md.
      // ignore: deprecated_member_use
      return await fm.getToken();
    } catch (e) {
      debugPrint('push: unavailable ($e)');
      return null;
    }
  }

  @override
  // ignore: deprecated_member_use
  Stream<String> get tokenRefresh => _ready ? FirebaseMessaging.instance.onTokenRefresh : const Stream.empty();

  @override
  Future<Int64?> launchChat() async {
    if (!_ready) return null;
    final m = await FirebaseMessaging.instance.getInitialMessage();
    return m == null ? null : _chatOf(m);
  }

  @override
  Stream<Int64> get openedChats => _ready
      ? FirebaseMessaging.onMessageOpenedApp.map(_chatOf).where((c) => c != null).cast<Int64>()
      : const Stream.empty();
}

/// No push (web, tests).
class NoPush implements PushPlatform {
  @override
  Future<String?> start() async => null;
  @override
  Stream<String> get tokenRefresh => const Stream.empty();
  @override
  Future<Int64?> launchChat() async => null;
  @override
  Stream<Int64> get openedChats => const Stream.empty();
}

final pushPlatformProvider = Provider<PushPlatform>(
  (ref) => kIsWeb || defaultTargetPlatform != TargetPlatform.android ? NoPush() : FirebasePush(),
);
