import 'package:flutter/material.dart';

/// Wasla brand kit v2 (app/assets/brand/README.md).
const brandBlack = Color(0xFF111111);
const brandYellow = Color(0xFFF7C531);
const brandGreen = Color(0xFF12823F); // icon ring, large text, illustrations
const brandDeepGreen = Color(0xFF0F6E35); // buttons and app bar with white text (6.4:1)

ThemeData waslaTheme(Brightness brightness) {
  final dark = brightness == Brightness.dark;
  final base = ColorScheme.fromSeed(seedColor: brandDeepGreen, brightness: brightness);
  final scheme = base.copyWith(
    primary: brandDeepGreen,
    onPrimary: Colors.white,
    secondary: brandYellow, // accent: highlights, badges, outgoing bubble
    onSecondary: brandBlack, // black on yellow is 11.7:1
    secondaryContainer: brandYellow,
    onSecondaryContainer: brandBlack,
    surface: dark ? brandBlack : Colors.white,
  );
  return ThemeData(
    colorScheme: scheme,
    useMaterial3: true,
    fontFamily: 'Cairo',
    scaffoldBackgroundColor: scheme.surface,
    appBarTheme: const AppBarTheme(backgroundColor: brandDeepGreen, foregroundColor: Colors.white),
    inputDecorationTheme: const InputDecorationTheme(border: OutlineInputBorder()),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        minimumSize: const Size.fromHeight(52),
        backgroundColor: brandDeepGreen,
        foregroundColor: Colors.white,
      ),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: brandYellow,
      foregroundColor: brandBlack,
    ),
    badgeTheme: const BadgeThemeData(backgroundColor: brandYellow, textColor: brandBlack),
  );
}

/// The logo and "وصلة" wordmark (Cairo ExtraBold). Yellow on dark, deep
/// green on light, as the brand kit specifies.
class BrandMark extends StatelessWidget {
  const BrandMark({super.key, this.size = 88});
  final double size;

  @override
  Widget build(BuildContext context) {
    final dark = Theme.of(context).brightness == Brightness.dark;
    return Column(mainAxisSize: MainAxisSize.min, children: [
      ClipRRect(
        borderRadius: BorderRadius.circular(size * 0.22),
        child: Image.asset('assets/brand/wasla-icon-rounded-1024.png', width: size, height: size),
      ),
      const SizedBox(height: 8),
      Text(
        'وصلة',
        style: TextStyle(
          fontFamily: 'Cairo',
          fontWeight: FontWeight.w800,
          fontSize: size * 0.4,
          color: dark ? brandYellow : brandDeepGreen,
          height: 1.1,
        ),
      ),
    ]);
  }
}
