import 'package:fixnum/fixnum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wasla/app/app.dart';
import 'package:wasla/core/auth/auth_api.dart';
import 'package:wasla/core/auth/session_store.dart';
import 'package:wasla/core/chat/chat_store.dart';
import 'package:wasla/core/net/connection.dart';
import 'package:wasla/core/net/rpc_exception.dart';
import 'package:wasla/core/providers.dart';
import 'package:wasla/core/storage/local_store.dart';
import 'package:wasla/gen/proto/wasla/v1/auth.pb.dart';
import 'package:wasla/gen/proto/wasla/v1/common.pbenum.dart';
import 'package:wasla/gen/proto/wasla/v1/frame.pbenum.dart';
import 'package:wasla/gen/proto/wasla/v1/users.pb.dart';

import 'fakes/fake_chat_api.dart';

/// Scripted AuthService for UI tests.
class FakeAuthApi implements AuthApi {
  final calls = <String>[];
  final pushTokens = <String>[];

  @override
  Future<void> registerPushToken(String token) async => pushTokens.add(token);
  String? lastPhone;

  @override
  Future<SendCodeResponse> sendCode(String phone, String attestation) async {
    calls.add('sendCode');
    lastPhone = phone;
    if (phone == '+9647801111111') throw const RpcException(ErrorCode.ERROR_CODE_PHONE_BANNED);
    return SendCodeResponse(codeHash: 'h', codeLength: 5, resendAfterSeconds: 60, devCode: '24680');
  }

  @override
  Future<SignInResponse> signIn(String phone, String codeHash, String code) async {
    calls.add('signIn:$code');
    return SignInResponse(signUpRequired: SignUpRequired(termsVersion: '2026-11'));
  }

  @override
  Future<SignUpResponse> signUp(SignUpRequest request) async {
    calls.add('signUp:${request.firstName}');
    return SignUpResponse(
      authorization: Authorization(sessionToken: 'tok', user: User(id: Int64(1), firstName: request.firstName)),
    );
  }

  @override
  Future<ResendCodeResponse> resendCode(String phone, String codeHash) async => ResendCodeResponse();
  @override
  Future<CheckPasswordResponse> checkPassword(String loginToken, String password) async => CheckPasswordResponse();
  @override
  Future<void> logOut() async {}
  @override
  Future<User> getMe() async => User();
  @override
  Future<List<Session>> listSessions() async => [];
  @override
  Future<void> revokeSession(Session s) async {}
}

Widget app(FakeAuthApi api, MemorySessionStore store) => ProviderScope(
      overrides: [
        authApiProvider.overrideWithValue(api),
        sessionStoreProvider.overrideWithValue(store),
        localStoreProvider.overrideWithValue(Future.value(MemoryStore())),
        chatApiProvider.overrideWithValue(FakeChatApi()),
        connectionProvider.overrideWithValue(
          WaslaConnection(
            url: Uri.parse('ws://127.0.0.1:1/ws'),
            info: const ClientInfo(platform: Platform.PLATFORM_ANDROID, appVersion: 'test'),
          ),
        ),
      ],
      child: const WaslaApp(),
    );

void main() {
  testWidgets('Arabic sign-up flow, RTL layout, LTR phone field', (tester) async {
    final api = FakeAuthApi();
    final store = MemorySessionStore();
    await tester.pumpWidget(app(api, store));
    await tester.pumpAndSettle();

    // Arabic by default, laid out right-to-left.
    expect(find.text('رقم هاتفك'), findsOneWidget);
    final ctx = tester.element(find.text('رقم هاتفك'));
    expect(Directionality.of(ctx), TextDirection.rtl);
    final field = tester.widget<TextField>(find.byKey(const Key('phone-field')));
    expect(field.textDirection, TextDirection.ltr);

    // Eastern Arabic digits are normalised before sending.
    await tester.enterText(find.byKey(const Key('phone-field')), '٠٧٧٠١٢٣٤٥٦٧');
    await tester.tap(find.text('متابعة'));
    await tester.pumpAndSettle();
    expect(api.lastPhone, '+9647701234567');

    // Code screen: entering all digits submits automatically.
    expect(find.text('أدخل الرمز'), findsOneWidget);
    expect(find.text('وضع الاختبار — الرمز: 24680'), findsOneWidget);
    await tester.enterText(find.byKey(const Key('code-field')), '12345');
    await tester.pumpAndSettle();
    expect(api.calls, contains('signIn:12345'));

    // New account → sign-up form; Continue stays disabled until terms are accepted.
    expect(find.text('معلوماتك'), findsOneWidget);
    await tester.enterText(find.byKey(const Key('first-name')), 'علي');
    await tester.tap(find.byKey(const Key('accept-terms')));
    await tester.pump();
    await tester.tap(find.text('متابعة'));
    await tester.pumpAndSettle();

    expect(api.calls, contains('signUp:علي'));
    expect(store.token, 'tok');
    // Signed in: an empty chat list with the new-chat button.
    expect(find.text('لا توجد محادثات بعد. ابدأ محادثة جديدة.'), findsOneWidget);
    await tester.pumpWidget(const SizedBox()); // dispose timers
  });

  testWidgets('switching to English flips the layout to LTR', (tester) async {
    await tester.pumpWidget(app(FakeAuthApi(), MemorySessionStore()));
    await tester.pumpAndSettle();
    await tester.tap(find.text('English'));
    await tester.pumpAndSettle();
    expect(find.text('Your phone number'), findsOneWidget);
    expect(Directionality.of(tester.element(find.text('Your phone number'))), TextDirection.ltr);
  });

  testWidgets('server errors are shown in Arabic', (tester) async {
    await tester.pumpWidget(app(FakeAuthApi(), MemorySessionStore()));
    await tester.pumpAndSettle();
    await tester.enterText(find.byKey(const Key('phone-field')), '07801111111');
    await tester.tap(find.text('متابعة'));
    await tester.pumpAndSettle();
    expect(find.text('هذا الرقم محظور من استخدام وصلة'), findsOneWidget);

    await tester.enterText(find.byKey(const Key('phone-field')), '123');
    await tester.tap(find.text('متابعة'));
    await tester.pumpAndSettle();
    expect(find.text('رقم الهاتف غير صحيح'), findsOneWidget);
  });
}
