import 'package:flutter/material.dart';

/// Wasla brand (brand kit v2): green primary, yellow secondary, Cairo font.
const brandGreen = Color(0xFF0F6E35);
const brandYellow = Color(0xFFF7C531);

ThemeData waslaTheme(Brightness brightness) {
  final base = ColorScheme.fromSeed(seedColor: brandGreen, brightness: brightness);
  final scheme = brightness == Brightness.light
      ? base.copyWith(
          primary: brandGreen,
          onPrimary: Colors.white,
          secondary: brandYellow,
          onSecondary: Colors.black,
          secondaryContainer: brandYellow,
          onSecondaryContainer: Colors.black,
        )
      // Dark mode: the exact brand green is too dark on a dark background, so
      // keep the seed's lighter green tone for contrast; yellow stays exact.
      : base.copyWith(secondary: brandYellow, onSecondary: Colors.black);
  return ThemeData(
    colorScheme: scheme,
    useMaterial3: true,
    fontFamily: 'Cairo',
    inputDecorationTheme: const InputDecorationTheme(border: OutlineInputBorder()),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(minimumSize: const Size.fromHeight(52)),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: brandYellow,
      foregroundColor: Colors.black,
    ),
  );
}
