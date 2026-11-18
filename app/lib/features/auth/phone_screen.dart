import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/l10n/app_localizations.dart';
import '../../core/phone.dart';
import '../../core/providers.dart';
import 'widgets.dart';

class PhoneScreen extends ConsumerStatefulWidget {
  const PhoneScreen({super.key});
  @override
  ConsumerState<PhoneScreen> createState() => _PhoneScreenState();
}

class _PhoneScreenState extends ConsumerState<PhoneScreen> with AuthStep {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final l = AppLocalizations.of(context);
    final phone = normalizePhone(_controller.text);
    if (phone == null) {
      setState(() => error = l.errPhoneInvalid);
      return;
    }
    await run(() => ref.read(authProvider.notifier).sendCode(phone));
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    return AuthScaffold(
      title: l.phoneTitle,
      subtitle: l.phoneSubtitle,
      children: [
        TextField(
          key: const Key('phone-field'),
          controller: _controller,
          autofocus: true,
          keyboardType: TextInputType.phone,
          // Phone numbers are always left-to-right, even in Arabic.
          textDirection: TextDirection.ltr,
          textAlign: TextAlign.left,
          autofillHints: const [AutofillHints.telephoneNumber],
          inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9٠-٩۰-۹+\s\-()]'))],
          decoration: InputDecoration(labelText: l.phoneLabel, hintText: '0770 123 4567', hintTextDirection: TextDirection.ltr),
          onSubmitted: (_) => _submit(),
        ),
        const SizedBox(height: 16),
        ErrorText(error),
        SubmitButton(busy: busy, onPressed: _submit, label: l.continueButton),
      ],
    );
  }
}
