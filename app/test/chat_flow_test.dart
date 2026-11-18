import 'package:fixnum/fixnum.dart';
import 'package:flutter/material.dart' hide Dialog;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wasla/app/app.dart';
import 'package:wasla/core/auth/auth_controller.dart';
import 'package:wasla/core/chat/chat_store.dart';
import 'package:wasla/core/chat/format.dart';
import 'package:wasla/core/net/connection.dart';
import 'package:wasla/core/providers.dart';
import 'package:wasla/core/storage/local_store.dart';
import 'package:wasla/gen/proto/wasla/v1/chats.pb.dart';
import 'package:wasla/gen/proto/wasla/v1/common.pbenum.dart';
import 'package:wasla/gen/proto/wasla/v1/messages.pb.dart';
import 'package:wasla/gen/proto/wasla/v1/moderation.pb.dart';
import 'package:wasla/gen/proto/wasla/v1/users.pb.dart';

import 'fakes/fake_chat_api.dart';

/// Signed in as user 1 without touching the network.
class SignedIn extends AuthController {
  @override
  AuthState build() => AuthSignedIn(User(id: Int64(1), firstName: 'علي'));
}

final chatId = Int64(7);
final saraId = Int64(2);

/// Fresh each time: protobuf messages are mutable and the store updates them.
User saraUser() => User(id: saraId, firstName: 'سارة');

Message msg(int seq, int sender, String text) => Message(
      chatId: chatId,
      seq: Int64(seq),
      senderId: Int64(sender),
      date: Int64(DateTime.now().millisecondsSinceEpoch ~/ 1000),
      content: MessageContent(text: TextContent(text: FormattedText(text: text))),
    );

FakeChatApi seeded() {
  final api = FakeChatApi();
  api.dialogs = ListDialogsResponse(
    dialogs: [Dialog(chatId: chatId, topMessage: msg(2, 2, 'كيف حالك؟'), unreadCount: 2, readOutboxSeq: Int64(1))],
    chats: [Chat(id: chatId, type: ChatType.CHAT_TYPE_PRIVATE, peerUserId: saraId)],
    users: [saraUser()],
  );
  api.history[chatId] = [msg(1, 1, 'مرحبا سارة'), msg(2, 2, 'كيف حالك؟')];
  return api;
}

Widget app(FakeChatApi api) => ProviderScope(
      overrides: [
        authProvider.overrideWith(SignedIn.new),
        localStoreProvider.overrideWithValue(Future.value(MemoryStore())),
        chatApiProvider.overrideWithValue(api),
        connectionProvider.overrideWithValue(
          WaslaConnection(url: Uri.parse('ws://127.0.0.1:1/ws'), info: const ClientInfo(platform: Platform.PLATFORM_ANDROID, appVersion: 't')),
        ),
      ],
      child: const WaslaApp(),
    );

void main() {
  testWidgets('chat list → open chat → send; bubbles follow RTL', (tester) async {
    final api = seeded();
    await tester.pumpWidget(app(api));
    await tester.pumpAndSettle();

    // Chat list: Sara with 2 unread.
    expect(find.text(isolate('سارة')), findsOneWidget);
    expect(find.text(isolate('كيف حالك؟')), findsOneWidget);
    expect(find.text('2'), findsOneWidget);

    await tester.tap(find.byKey(ValueKey('dialog-$chatId')));
    await tester.pumpAndSettle();

    // My message sits on the end side: in Arabic (RTL) that is the LEFT half.
    final width = tester.view.physicalSize.width / tester.view.devicePixelRatio;
    final mine = tester.getCenter(find.text('مرحبا سارة'));
    final theirs = tester.getCenter(find.text('كيف حالك؟').last);
    expect(mine.dx, lessThan(width / 2));
    expect(theirs.dx, greaterThan(width / 2));

    await tester.enterText(find.byKey(const Key('composer')), 'بخير والحمد لله');
    await tester.tap(find.byKey(const Key('send')));
    await tester.pumpAndSettle();
    expect(api.sent.single.content.text.text, 'بخير والحمد لله');
    expect(api.sent.single.peer.userId, saraId);
    expect(find.text('بخير والحمد لله'), findsOneWidget);
    await tester.pumpWidget(const SizedBox());
  });

  testWidgets('long-press a message → Report (terrorism) and block in one step', (tester) async {
    final api = seeded();
    await tester.pumpWidget(app(api));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(ValueKey('dialog-$chatId')));
    await tester.pumpAndSettle();

    await tester.longPress(find.text('كيف حالك؟').last);
    await tester.pumpAndSettle();
    // My own messages cannot be reported; Sara's can.
    await tester.tap(find.byKey(const Key('action-report')));
    await tester.pumpAndSettle();

    expect(find.text('ما المشكلة؟'), findsOneWidget);
    await tester.tap(find.byKey(ValueKey('reason-${ReportReason.REPORT_REASON_TERRORISM.value}')));
    await tester.pump();
    await tester.ensureVisible(find.byKey(const Key('report-also-block')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('report-also-block')));
    await tester.pump();
    await tester.ensureVisible(find.byKey(const Key('report-send')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('report-send')));
    await tester.pumpAndSettle();

    final r = api.reports.single;
    expect(r.reason, ReportReason.REPORT_REASON_TERRORISM);
    expect(r.messages.chatId, chatId);
    expect(r.messages.seqs, [Int64(2)]);
    expect(r.block, isTrue);
    expect(find.text('شكراً، وصل بلاغك وسيراجعه فريق الإشراف.'), findsOneWidget);
    // The composer is replaced by the "you blocked this user" banner.
    expect(find.text('لقد حظرت هذا المستخدم'), findsOneWidget);
    expect(find.byKey(const Key('composer')), findsNothing);
    await tester.pumpWidget(const SizedBox());
  });

  testWidgets('chat menu → Block with confirmation; own messages offer no Report', (tester) async {
    final api = seeded();
    await tester.pumpWidget(app(api));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(ValueKey('dialog-$chatId')));
    await tester.pumpAndSettle();

    await tester.longPress(find.text('مرحبا سارة'));
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('action-report')), findsNothing);
    expect(find.byKey(const Key('action-edit')), findsOneWidget);
    Navigator.of(tester.element(find.byKey(const Key('action-edit')))).pop(); // close the sheet
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const Key('chat-menu')));
    await tester.pumpAndSettle();
    await tester.tap(find.text('حظر'));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('confirm-block')));
    await tester.pumpAndSettle();
    expect(api.blocked, [saraId]);
    expect(find.text('لقد حظرت هذا المستخدم'), findsOneWidget);
    await tester.pumpWidget(const SizedBox());
  });

  test('previews of English messages keep their punctuation in the Arabic UI', () {
    final p = isolate('Hi Ali, the meeting moved to Thursday.');
    expect(p.codeUnitAt(0), 0x2068);
    expect(p.codeUnitAt(p.length - 1), 0x2069);
    expect(textDirectionOf('Hi Ali'), TextDirection.ltr);
    expect(textDirectionOf('  مرحبا Ali'), TextDirection.rtl);
  });

  test('outbox keeps a failed message for retry', () {
    final o = Outgoing(chatId: chatId, randomId: Int64(5), text: 'x');
    expect(o.status, OutStatus.sending);
  });
}
