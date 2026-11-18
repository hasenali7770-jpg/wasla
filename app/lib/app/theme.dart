import 'package:flutter/material.dart';

/// Placeholder palette until the brand kit arrives (docs/01-architecture.md §12).
const _seed = Color(0xFF0B6E5F);

ThemeData waslaTheme(Brightness brightness) {
  final scheme = ColorScheme.fromSeed(seedColor: _seed, brightness: brightness);
  return ThemeData(
    colorScheme: scheme,
    useMaterial3: true,
    fontFamily: 'IBMPlexSansArabic',
    inputDecorationTheme: const InputDecorationTheme(border: OutlineInputBorder()),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(minimumSize: const Size.fromHeight(52)),
    ),
  );
}
