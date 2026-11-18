import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/l10n/app_localizations.dart';
import '../core/providers.dart';
import 'lifecycle.dart';
import 'router.dart';
import 'theme.dart';

class WaslaApp extends ConsumerWidget {
  const WaslaApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      onGenerateTitle: (c) => AppLocalizations.of(c).appTitle,
      routerConfig: ref.watch(routerProvider),
      // Arabic first: Directionality follows the locale, so every screen is
      // RTL in Arabic and LTR in English without per-screen code.
      locale: ref.watch(localeProvider),
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      theme: waslaTheme(Brightness.light),
      darkTheme: waslaTheme(Brightness.dark),
      debugShowCheckedModeBanner: false,
      builder: (_, child) => AppLifecycle(child: child ?? const SizedBox.shrink()),
    );
  }
}
