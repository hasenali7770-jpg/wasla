import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/auth/auth_controller.dart';
import '../../core/l10n/app_localizations.dart';
import '../../core/providers.dart';
import 'widgets.dart';

class PasswordScreen extends ConsumerStatefulWidget {
  const PasswordScreen({super.key});
  @override
  ConsumerState<PasswordScreen> createState() => _PasswordScreenState();
}

class _PasswordScreenState extends ConsumerState<PasswordScreen> with AuthStep {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _submit() => run(() => ref.read(authProvider.notifier).checkPassword(_controller.text));

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final s = ref.watch(authProvider);
    final hint = s is AuthNeedsPassword ? s.hint : '';
    return AuthScaffold(
      title: l.passwordTitle,
      subtitle: l.passwordSubtitle,
      onBack: ref.read(authProvider.notifier).changeNumber,
      children: [
        TextField(
          controller: _controller,
          autofocus: true,
          obscureText: true,
          autofillHints: const [AutofillHints.password],
          decoration: InputDecoration(
            labelText: l.passwordLabel,
            helperText: hint.isEmpty ? null : l.passwordHint(hint),
          ),
          onSubmitted: (_) => _submit(),
        ),
        const SizedBox(height: 16),
        ErrorText(error),
        SubmitButton(busy: busy, onPressed: _submit, label: l.continueButton),
      ],
    );
  }
}
