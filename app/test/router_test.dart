import 'package:flutter_test/flutter_test.dart';
import 'package:wasla/app/router.dart';
import 'package:wasla/core/auth/auth_controller.dart';
import 'package:wasla/gen/proto/wasla/v1/auth.pbenum.dart';
import 'package:wasla/gen/proto/wasla/v1/users.pb.dart';

void main() {
  test('login states map to their screens', () {
    expect(authRedirect(const AuthRestoring(), '/chats'), '/splash');
    expect(authRedirect(const AuthSignedOut(), '/chats'), '/login');
    expect(authRedirect(const AuthSignedOut(), '/login'), isNull);
    expect(
      authRedirect(
        AuthCodeSent(
          phone: '+9647701234567',
          codeHash: 'h',
          codeLength: 5,
          delivery: CodeDelivery.CODE_DELIVERY_SMS,
          resendAt: DateTime.now(),
        ),
        '/login',
      ),
      '/login/code',
    );
    expect(authRedirect(const AuthNeedsPassword(hint: '', loginToken: 't'), '/login/code'), '/login/password');
  });

  test('signed-in users leave login screens but may browse the app', () {
    final signedIn = AuthSignedIn(User());
    expect(authRedirect(signedIn, '/login/code'), '/chats');
    expect(authRedirect(signedIn, '/splash'), '/chats');
    expect(authRedirect(signedIn, '/settings/sessions'), isNull);
  });
}
