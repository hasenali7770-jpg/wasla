import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/l10n/app_localizations.dart';
import '../../core/net/rpc_exception.dart';
import '../../app/theme.dart';
import '../../core/providers.dart';

/// Common layout for the login steps.
class AuthScaffold extends ConsumerWidget {
  const AuthScaffold({
    super.key,
    required this.title,
    required this.subtitle,
    required this.children,
    this.onBack,
  });

  final String title;
  final String subtitle;
  final List<Widget> children;
  final VoidCallback? onBack;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale = ref.watch(localeProvider);
    return Scaffold(
      // Login screens use a plain bar so the logo stands on the page itself.
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Theme.of(context).colorScheme.onSurface,
        leading: onBack == null ? null : BackButton(onPressed: onBack),
        actions: [
          TextButton(
            onPressed: () => ref
                .read(localeProvider.notifier)
                .set(Locale(locale.languageCode == 'ar' ? 'en' : 'ar')),
            child: Text(locale.languageCode == 'ar' ? 'English' : 'العربية'),
          ),
        ],
      ),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 420),
            child: ListView(
              padding: const EdgeInsetsDirectional.fromSTEB(24, 8, 24, 24),
              children: [
                const Center(child: BrandMark(size: 72)),
                const SizedBox(height: 16),
                Text(title, style: Theme.of(context).textTheme.headlineSmall),
                const SizedBox(height: 8),
                Text(subtitle, style: Theme.of(context).textTheme.bodyMedium),
                const SizedBox(height: 24),
                ...children,
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Runs an auth step, showing a spinner and a localised error.
mixin AuthStep<T extends StatefulWidget> on State<T> {
  bool busy = false;
  String? error;

  Future<void> run(Future<void> Function() step) async {
    if (busy) return;
    setState(() {
      busy = true;
      error = null;
    });
    try {
      await step();
    } on RpcException catch (e) {
      if (mounted) setState(() => error = e.message(AppLocalizations.of(context)));
    } finally {
      if (mounted) setState(() => busy = false);
    }
  }
}

class SubmitButton extends StatelessWidget {
  const SubmitButton({super.key, required this.busy, required this.onPressed, required this.label});
  final bool busy;
  final VoidCallback? onPressed;
  final String label;

  @override
  Widget build(BuildContext context) => FilledButton(
        onPressed: busy ? null : onPressed,
        child: busy
            ? const SizedBox.square(dimension: 22, child: CircularProgressIndicator(strokeWidth: 2.5))
            : Text(label),
      );
}

class ErrorText extends StatelessWidget {
  const ErrorText(this.text, {super.key});
  final String? text;
  @override
  Widget build(BuildContext context) => text == null
      ? const SizedBox.shrink()
      : Padding(
          padding: const EdgeInsetsDirectional.only(bottom: 12),
          child: Text(text!, style: TextStyle(color: Theme.of(context).colorScheme.error)),
        );
}
