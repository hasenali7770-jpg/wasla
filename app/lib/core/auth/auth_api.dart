import '../../gen/proto/wasla/v1/auth.pb.dart';
import '../../gen/proto/wasla/v1/users.pb.dart';
import '../net/connection.dart';

/// Typed AuthService/UsersService calls used by the login flow.
abstract interface class AuthApi {
  Future<SendCodeResponse> sendCode(String phone, String attestation);
  Future<ResendCodeResponse> resendCode(String phone, String codeHash);
  Future<SignInResponse> signIn(String phone, String codeHash, String code);
  Future<SignUpResponse> signUp(SignUpRequest request);
  Future<CheckPasswordResponse> checkPassword(String loginToken, String password);
  Future<void> logOut();
  Future<User> getMe();
  Future<List<Session>> listSessions();
  Future<void> revokeSession(Session s);
}

class RemoteAuthApi implements AuthApi {
  RemoteAuthApi(this.conn);
  final WaslaConnection conn;
  static const _a = '/wasla.v1.AuthService/';
  static const _u = '/wasla.v1.UsersService/';

  @override
  Future<SendCodeResponse> sendCode(String phone, String attestation) => conn.call(
        '${_a}SendCode',
        SendCodeRequest(phone: phone, deviceAttestation: attestation),
        SendCodeResponse.fromBuffer,
      );

  @override
  Future<ResendCodeResponse> resendCode(String phone, String codeHash) => conn.call(
        '${_a}ResendCode',
        ResendCodeRequest(phone: phone, codeHash: codeHash),
        ResendCodeResponse.fromBuffer,
      );

  @override
  Future<SignInResponse> signIn(String phone, String codeHash, String code) => conn.call(
        '${_a}SignIn',
        SignInRequest(phone: phone, codeHash: codeHash, code: code),
        SignInResponse.fromBuffer,
      );

  @override
  Future<SignUpResponse> signUp(SignUpRequest request) =>
      conn.call('${_a}SignUp', request, SignUpResponse.fromBuffer);

  @override
  Future<CheckPasswordResponse> checkPassword(String loginToken, String password) => conn.call(
        '${_a}CheckPassword',
        CheckPasswordRequest(loginToken: loginToken, password: password),
        CheckPasswordResponse.fromBuffer,
      );

  @override
  Future<void> logOut() => conn.call('${_a}LogOut', LogOutRequest(), LogOutResponse.fromBuffer);

  @override
  Future<User> getMe() async =>
      (await conn.call('${_u}GetMe', GetMeRequest(), GetMeResponse.fromBuffer)).user;

  @override
  Future<List<Session>> listSessions() async =>
      (await conn.call('${_a}ListSessions', ListSessionsRequest(), ListSessionsResponse.fromBuffer)).sessions;

  @override
  Future<void> revokeSession(Session s) => conn.call(
        '${_a}RevokeSession',
        RevokeSessionRequest(sessionId: s.id),
        RevokeSessionResponse.fromBuffer,
      );
}
