import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/l10n/app_localizations.dart';
import '../../core/providers.dart';
import 'widgets.dart';

class SignUpScreen extends ConsumerStatefulWidget {
  const SignUpScreen({super.key});
  @override
  ConsumerState<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends ConsumerState<SignUpScreen> with AuthStep {
  final _first = TextEditingController();
  final _last = TextEditingController();
  bool _accepted = false;

  @override
  void dispose() {
    _first.dispose();
    _last.dispose();
    super.dispose();
  }

  void _submit() {
    final l = AppLocalizations.of(context);
    if (_first.text.trim().isEmpty) {
      setState(() => error = l.nameRequired);
      return;
    }
    run(() => ref.read(authProvider.notifier).signUp(_first.text, _last.text));
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    return AuthScaffold(
      title: l.signUpTitle,
      subtitle: l.signUpSubtitle,
      onBack: ref.read(authProvider.notifier).changeNumber,
      children: [
        TextField(
          key: const Key('first-name'),
          controller: _first,
          autofocus: true,
          maxLength: 64,
          textCapitalization: TextCapitalization.words,
          autofillHints: const [AutofillHints.givenName],
          decoration: InputDecoration(labelText: l.firstName, counterText: ''),
        ),
        const SizedBox(height: 12),
        TextField(
          controller: _last,
          maxLength: 64,
          textCapitalization: TextCapitalization.words,
          autofillHints: const [AutofillHints.familyName],
          decoration: InputDecoration(labelText: l.lastName, counterText: ''),
        ),
        CheckboxListTile(
          key: const Key('accept-terms'),
          contentPadding: EdgeInsetsDirectional.zero,
          controlAffinity: ListTileControlAffinity.leading,
          value: _accepted,
          onChanged: (v) => setState(() => _accepted = v ?? false),
          title: Text(l.acceptTerms),
        ),
        const SizedBox(height: 8),
        ErrorText(error),
        SubmitButton(busy: busy, onPressed: _accepted ? _submit : null, label: l.continueButton),
      ],
    );
  }
}
