import '../../gen/proto/wasla/v1/frame.pb.dart' as pb;
import '../../gen/proto/wasla/v1/frame.pbenum.dart';
import '../l10n/app_localizations.dart';

/// An RPC failure. [code] is a stable API error code; the UI localises it
/// with [message] rather than showing the server's developer text.
class RpcException implements Exception {
  const RpcException(this.code, {this.retryAfterSeconds = 0, this.debugMessage = ''});

  factory RpcException.fromProto(pb.Error e) =>
      RpcException(e.code, retryAfterSeconds: e.retryAfterSeconds, debugMessage: e.message);

  /// No connection or timed out.
  factory RpcException.network() => const RpcException(ErrorCode.ERROR_CODE_UNAVAILABLE, debugMessage: 'network');

  final ErrorCode code;
  final int retryAfterSeconds;
  final String debugMessage;

  String message(AppLocalizations l) => switch (code) {
        ErrorCode.ERROR_CODE_PHONE_INVALID => l.errPhoneInvalid,
        ErrorCode.ERROR_CODE_PHONE_CODE_INVALID => l.errCodeInvalid,
        ErrorCode.ERROR_CODE_PHONE_CODE_EXPIRED => l.errCodeExpired,
        ErrorCode.ERROR_CODE_PHONE_BANNED => l.errPhoneBanned,
        ErrorCode.ERROR_CODE_PASSWORD_INVALID => l.errPasswordInvalid,
        ErrorCode.ERROR_CODE_RATE_LIMITED => retryAfterSeconds > 90
            ? l.errRateLimitedMinutes((retryAfterSeconds / 60).ceil())
            : l.errRateLimited(retryAfterSeconds),
        ErrorCode.ERROR_CODE_UNAVAILABLE => l.errNetwork,
        ErrorCode.ERROR_CODE_UPDATE_REQUIRED => l.errUpdateRequired,
        _ => l.errGeneric,
      };

  @override
  String toString() => 'RpcException($code, $debugMessage)';
}
