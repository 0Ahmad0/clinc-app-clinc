import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Typography scale — IBM Plex Sans Arabic, set once here and consumed through
/// `context.textTheme`. Never build a raw [TextStyle] or set `fontFamily`
/// inside a widget; use these slots (or `.copyWith` on one of them).
///
/// Scale (from the design system):
///   h1 26/700 · h2 20/700 · h3 16/700 · body 14/600 · secondary 12.5/400 ·
///   caption 11/400 · button label 15/700.
class AppTextStyles {
  const AppTextStyles._();

  /// Builds a [TextTheme] whose default ink color is [onSurface] so light and
  /// dark reuse the same scale with different text tones.
  static TextTheme themeFor(Color onSurface) {
    final base = GoogleFonts.ibmPlexSansArabic(color: onSurface, height: 1.5);
    TextStyle s(double size, FontWeight weight, {double height = 1.5}) =>
        base.copyWith(fontSize: size, fontWeight: weight, height: height);

    return TextTheme(
      headlineMedium: s(26, FontWeight.w700, height: 1.25), // H1
      titleLarge: s(20, FontWeight.w700, height: 1.3), // H2
      titleMedium: s(16, FontWeight.w700, height: 1.35), // H3 card title
      bodyMedium: s(14, FontWeight.w600), // Body
      bodySmall: s(12.5, FontWeight.w400, height: 1.7), // Secondary
      labelSmall: s(11, FontWeight.w400), // Caption
      labelLarge: s(15, FontWeight.w700), // Button label
    );
  }
}
