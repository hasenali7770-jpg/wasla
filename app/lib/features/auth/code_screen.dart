import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/auth/auth_controller.dart';
import '../../core/l10n/app_localizations.dart';
import '../../core/phone.dart';
import '../../core/providers.dart';
import '../../gen/proto/wasla/v1/auth.pbenum.dart';
import 'widgets.dart';

// Unicode LEFT-TO-RIGHT ISOLATE / POP DIRECTIONAL ISOLATE.
final _lri = String.fromCharCode(0x2066);
final _pdi = String.fromCharCode(0x2069);

class CodeScreen extends ConsumerStatefulWidget {
  const CodeScreen({super.key});
  @override
  ConsumerState<CodeScreen> createState() => _CodeScreenState();
}

class _CodeScreenState extends ConsumerState<CodeScreen> with AuthStep {
  final _controller = TextEditingController();
  Timer? _ticker;

  @override
  void initState() {
    super.initState();
    _ticker = Timer.periodic(const Duration(seconds: 1), (_) => setState(() {}));
  }

  @override
  void dispose() {
    _ticker?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final s = ref.watch(authProvider);
    if (s is! AuthCodeSent) return const SizedBox.shrink();
    final phone = displayPhone(s.phone);
    // Keep the number LTR inside the Arabic sentence (Unicode isolate).
    final isolated = '$_lri$phone$_pdi';
    final remaining = s.resendAt.difference(DateTime.now()).inSeconds;
    return AuthScaffold(
      title: l.codeTitle,
      subtitle: s.delivery == CodeDelivery.CODE_DELIVERY_VOICE_CALL
          ? l.codeSentVoice(isolated)
          : l.codeSentSms(s.codeLength, isolated),
      onBack: ref.read(authProvider.notifier).changeNumber,
      children: [
        TextField(
          key: const Key('code-field'),
          controller: _controller,
          autofocus: true,
          keyboardType: TextInputType.number,
          textDirection: TextDirection.ltr,
          textAlign: TextAlign.center,
          maxLength: s.codeLength,
          autofillHints: const [AutofillHints.oneTimeCode],
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(letterSpacing: 8),
          decoration: InputDecoration(labelText: l.codeLabel, counterText: ''),
          onChanged: (v) {
            if (v.length == s.codeLength) {
              run(() => ref.read(authProvider.notifier).submitCode(v));
            }
          },
        ),
        if (s.devCode.isNotEmpty)
          Padding(
            padding: const EdgeInsetsDirectional.only(top: 8),
            child: Text(
              l.devCodeHint(s.devCode),
              key: const Key('dev-code'),
              style: TextStyle(color: Theme.of(context).colorScheme.tertiary),
            ),
          ),
        const SizedBox(height: 12),
        ErrorText(error),
        if (busy) const Center(child: CircularProgressIndicator()),
        Align(
          alignment: AlignmentDirectional.centerStart,
          child: remaining > 0
              ? Text(l.resendIn(remaining))
              : TextButton(
                  onPressed: () => run(ref.read(authProvider.notifier).resend),
                  child: Text(l.resendByCall),
                ),
        ),
        Align(
          alignment: AlignmentDirectional.centerStart,
          child: TextButton(
            onPressed: ref.read(authProvider.notifier).changeNumber,
            child: Text(l.wrongNumber),
          ),
        ),
      ],
    );
  }
}
