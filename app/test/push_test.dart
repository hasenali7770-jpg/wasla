import 'dart:async';

import 'package:fixnum/fixnum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wasla/app/app.dart';
import 'package:wasla/app/lifecycle.dart';
import 'package:wasla/core/chat/chat_store.dart';
import 'package:wasla/core/net/connection.dart';
import 'package:wasla/core/providers.dart';
import 'package:wasla/core/push/push.dart';
import 'package:wasla/core/storage/local_store.dart';
import 'package:wasla/gen/proto/wasla/v1/common.pbenum.dart';
import 'package:wasla/gen/proto/wasla/v1/frame.pb.dart';

import 'auth_flow_test.dart' show FakeAuthApi;
import 'chat_flow_test.dart' show SignedIn, chatId, seeded;

class FakePush implements PushPlatform {
  String? token = 'phone-token-1';
  Int64? launch;
  final refresh = StreamController<String>.broadcast();
  final opened = StreamController<Int64>.broadcast();
  @override
  Future<String?> start() async => token;
  @override
  Stream<String> get tokenRefresh => refresh.stream;
  @override
  Future<Int64?> launchChat() async => launch;
  @override
  Stream<Int64> get openedChats => opened.stream;
}

/// Counts connect/close instead of using the network.
class CountingConnection extends WaslaConnection {
  CountingConnection()
      : super(url: Uri.parse('ws://127.0.0.1:1/ws'), info: const ClientInfo(platform: Platform.PLATFORM_ANDROID, appVersion: 't'));
  int connects = 0;
  int closes = 0;
  @override
  Future<HelloAck> connect() async {
    connects++;
    state.value = ConnState.connected;
    return HelloAck(authenticated: true);
  }

  @override
  Future<void> close() async {
    closes++;
    state.value = ConnState.disconnected;
  }
}

Widget pushApp(FakePush push, FakeAuthApi auth, CountingConnection conn) => ProviderScope(
      overrides: [
        authProvider.overrideWith(SignedIn.new),
        authApiProvider.overrideWithValue(auth),
        pushPlatformProvider.overrideWithValue(push),
        localStoreProvider.overrideWithValue(Future.value(MemoryStore())),
        chatApiProvider.overrideWithValue(seeded()),
        connectionProvider.overrideWithValue(conn),
      ],
      child: const WaslaApp(),
    );

void main() {
  testWidgets('signed in: the phone registers for pushes, and again on a new token', (tester) async {
    final push = FakePush();
    final auth = FakeAuthApi();
    await tester.pumpWidget(pushApp(push, auth, CountingConnection()));
    await tester.pumpAndSettle();
    expect(auth.pushTokens, ['phone-token-1']);

    push.refresh.add('phone-token-2');
    await tester.pumpAndSettle();
    expect(auth.pushTokens, ['phone-token-1', 'phone-token-2']);
    await tester.pumpWidget(const SizedBox());
  });

  testWidgets('no push available (no Firebase config, permission denied): nothing registered', (tester) async {
    final push = FakePush()..token = null;
    final auth = FakeAuthApi();
    await tester.pumpWidget(pushApp(push, auth, CountingConnection()));
    await tester.pumpAndSettle();
    expect(auth.pushTokens, isEmpty);
    await tester.pumpWidget(const SizedBox());
  });

  testWidgets('tapping a notification opens its chat', (tester) async {
    final push = FakePush();
    await tester.pumpWidget(pushApp(push, FakeAuthApi(), CountingConnection()));
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('composer')), findsNothing);

    push.opened.add(chatId);
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('composer')), findsOneWidget);
    await tester.pumpWidget(const SizedBox());
  });

  testWidgets('a notification that launched the app opens its chat', (tester) async {
    final push = FakePush()..launch = chatId;
    await tester.pumpWidget(pushApp(push, FakeAuthApi(), CountingConnection()));
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('composer')), findsOneWidget);
    await tester.pumpWidget(const SizedBox());
  });

  testWidgets('in the background the app disconnects (so pushes flow); back in front it reconnects', (tester) async {
    final conn = CountingConnection();
    await tester.pumpWidget(pushApp(FakePush(), FakeAuthApi(), conn));
    await tester.pumpAndSettle();
    final binding = tester.binding;

    // A short trip away (e.g. to copy a code) keeps the connection.
    binding.handleAppLifecycleStateChanged(AppLifecycleState.inactive);
    binding.handleAppLifecycleStateChanged(AppLifecycleState.hidden);
    binding.handleAppLifecycleStateChanged(AppLifecycleState.paused);
    await tester.pump(const Duration(seconds: 5));
    binding.handleAppLifecycleStateChanged(AppLifecycleState.hidden);
    binding.handleAppLifecycleStateChanged(AppLifecycleState.inactive);
    binding.handleAppLifecycleStateChanged(AppLifecycleState.resumed);
    await tester.pump(backgroundGrace);
    expect(conn.closes, 0);
    expect(conn.connects, 0);

    // Longer: disconnects; returning reconnects (and the store catches up).
    binding.handleAppLifecycleStateChanged(AppLifecycleState.inactive);
    binding.handleAppLifecycleStateChanged(AppLifecycleState.hidden);
    binding.handleAppLifecycleStateChanged(AppLifecycleState.paused);
    await tester.pump(backgroundGrace + const Duration(seconds: 1));
    expect(conn.closes, 1);
    binding.handleAppLifecycleStateChanged(AppLifecycleState.hidden);
    binding.handleAppLifecycleStateChanged(AppLifecycleState.inactive);
    binding.handleAppLifecycleStateChanged(AppLifecycleState.resumed);
    await tester.pumpAndSettle();
    expect(conn.connects, 1);
    await tester.pumpWidget(const SizedBox());
  });
}
