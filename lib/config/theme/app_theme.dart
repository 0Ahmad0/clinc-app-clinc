import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_spacing.dart';
import 'app_text_styles.dart';

/// The single source of [ThemeData] for the app. Component styling (buttons,
/// fields, cards) lives here — not in widgets. Both modes are always valid;
/// `themeMode: ThemeMode.system` selects between them.
class AppTheme {
  const AppTheme._();

  // Built once and cached — rebuilding ThemeData (ColorScheme.fromSeed + the
  // Google font load) on every navigation is what made transitions janky.
  static final ThemeData light = _build(
    brightness: Brightness.light,
    colors: AppColorsTheme.light,
  );

  static final ThemeData dark = _build(
    brightness: Brightness.dark,
    colors: AppColorsTheme.dark,
  );

  static ThemeData _build({
    required Brightness brightness,
    required AppColorsTheme colors,
  }) {
    final textTheme = AppTextStyles.themeFor(colors.ink);
    final scheme = ColorScheme.fromSeed(
      seedColor: AppColors.primary600,
      brightness: brightness,
      primary: AppColors.primary600,
      surface: colors.surface,
      error: AppColors.dangerFg,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: scheme,
      scaffoldBackgroundColor: colors.bg,
      canvasColor: colors.bg,
      dividerColor: colors.line,
      textTheme: textTheme,
      extensions: [colors],
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: textTheme.titleLarge,
        foregroundColor: colors.ink,
      ),
      cardTheme: CardThemeData(
        color: colors.surface,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.card),
          side: BorderSide(color: colors.line),
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          minimumSize: const Size.fromHeight(AppSizes.buttonHeightSm),
          backgroundColor: AppColors.primary600,
          foregroundColor: AppColors.white,
          textStyle: textTheme.labelLarge,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.field),
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          minimumSize: const Size.fromHeight(AppSizes.buttonHeightSm),
          foregroundColor: AppColors.primary600,
          textStyle: textTheme.labelLarge,
          side: BorderSide(
            color: AppColors.primary600.withValues(alpha: 0.35),
            width: 1.5,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.field),
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: colors.gray,
          textStyle: textTheme.labelLarge,
        ),
      ),
    );
  }
}
