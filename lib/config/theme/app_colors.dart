import 'package:flutter/material.dart';

/// Raw color tokens — the single source of truth for the palette.
///
/// Never reference these directly inside widgets. Widgets read colors from the
/// theme via `context.colors` ([AppColorsTheme]) so that light/dark both work.
class AppColors {
  const AppColors._();

  static const white = Color(0xFFFFFFFF);

  // Primary blue ramp
  static const primary900 = Color(0xFF0C1424);
  static const primary800 = Color(0xFF123A8C);
  static const primary600 = Color(0xFF1E63D6);
  static const primary500 = Color(0xFF257CFF);
  static const primary300 = Color(0xFF59C3FF);
  static const primary100 = Color(0xFFDCEBFF);
  static const primary50 = Color(0xFFEFF6FF);

  // Onboarding illustration gradient stops (between the ramp steps)
  static const illustrationA = Color(0xFF1B57C8);
  static const illustrationB = primary500;
  static const illustrationC = Color(0xFF3F9BFF);

  // Neutrals
  static const ink = Color(0xFF13294B);
  static const slate = Color(0xFF3D5680);
  static const paragraph = Color(0xFF556685);
  static const gray = Color(0xFF64748B);
  static const muted = Color(0xFF9AA8C0);
  static const line = Color(0xFFE3E9F4);
  static const fill = Color(0xFFEEF2F9);
  static const bg = Color(0xFFF5F7FB);

  // Semantic
  static const success = Color(0xFF22B573);
  static const successBright = Color(0xFF5EEAA0);
  static const successFg = Color(0xFF128A50);
  static const warning = Color(0xFFF0A92E);
  static const warningFg = Color(0xFFB07A15);
  static const danger = Color(0xFFE15050);
  static const dangerFg = Color(0xFFC93535);
  static const info = Color(0xFF0D84C0);
  static const purple = Color(0xFF7C4FD8);
  static const teal = Color(0xFF0E8F8F);
  static const pink = Color(0xFFC23A80);

  // Dark surfaces (neutrals flip; brand + semantic stay constant)
  static const darkBg = primary900;
  static const darkSurface = Color(0xFF16213B);
  static const darkFill = Color(0xFF1B2740);
  static const darkLine = Color(0xFF24314F);
  static const darkInk = Color(0xFFF1F5FC);
  static const darkSlate = Color(0xFFC2CEE4);
  static const darkParagraph = Color(0xFFAFBBD3);
  static const darkMuted = Color(0xFF6B7A96);
}

/// Theme-aware colors exposed to widgets through `context.colors`.
///
/// Brand and semantic colors are constant across brightness; only the neutral
/// surfaces and text tones flip between light and dark.
@immutable
class AppColorsTheme extends ThemeExtension<AppColorsTheme> {
  const AppColorsTheme({
    required this.bg,
    required this.surface,
    required this.ink,
    required this.slate,
    required this.paragraph,
    required this.gray,
    required this.muted,
    required this.line,
    required this.fill,
  });

  final Color bg;
  final Color surface;
  final Color ink;
  final Color slate;
  final Color paragraph;
  final Color gray;
  final Color muted;
  final Color line;
  final Color fill;

  // Brand ramp (constant)
  Color get primary900 => AppColors.primary900;
  Color get primary800 => AppColors.primary800;
  Color get primary600 => AppColors.primary600;
  Color get primary500 => AppColors.primary500;
  Color get primary300 => AppColors.primary300;
  Color get primary100 => AppColors.primary100;
  Color get primary50 => AppColors.primary50;

  // Semantic (constant)
  Color get success => AppColors.success;
  Color get successBright => AppColors.successBright;
  Color get onBrand => AppColors.white;
  Color get successFg => AppColors.successFg;
  Color get warning => AppColors.warning;
  Color get warningFg => AppColors.warningFg;
  Color get danger => AppColors.danger;
  Color get dangerFg => AppColors.dangerFg;
  Color get info => AppColors.info;
  Color get purple => AppColors.purple;
  Color get teal => AppColors.teal;
  Color get pink => AppColors.pink;

  /// Header gradient (155°, brand blues).
  Gradient get headerGradient => const LinearGradient(
    begin: Alignment.topRight,
    end: Alignment.bottomLeft,
    colors: [AppColors.primary800, AppColors.primary600, AppColors.primary500],
    stops: [0.0, 0.6, 1.0],
  );

  /// Primary CTA gradient (135°, mid → bright blue).
  Gradient get ctaGradient => const LinearGradient(
    begin: AlignmentDirectional.topStart,
    end: AlignmentDirectional.bottomEnd,
    colors: [AppColors.primary600, AppColors.primary500],
  );

  /// Hero badge gradient (135°, mid → light blue) — forgot/pending icons.
  Gradient get heroBadgeGradient => const LinearGradient(
    begin: AlignmentDirectional.topStart,
    end: AlignmentDirectional.bottomEnd,
    colors: [AppColors.primary600, AppColors.primary300],
  );

  /// Onboarding illustration card gradient (160°, three blue stops).
  Gradient get illustrationGradient => const LinearGradient(
    begin: AlignmentDirectional.topStart,
    end: AlignmentDirectional.bottomEnd,
    colors: [
      AppColors.illustrationA,
      AppColors.illustrationB,
      AppColors.illustrationC,
    ],
    stops: [0.0, 0.6, 1.0],
  );

  static const light = AppColorsTheme(
    bg: AppColors.bg,
    surface: AppColors.white,
    ink: AppColors.ink,
    slate: AppColors.slate,
    paragraph: AppColors.paragraph,
    gray: AppColors.gray,
    muted: AppColors.muted,
    line: AppColors.line,
    fill: AppColors.fill,
  );

  static const dark = AppColorsTheme(
    bg: AppColors.darkBg,
    surface: AppColors.darkSurface,
    ink: AppColors.darkInk,
    slate: AppColors.darkSlate,
    paragraph: AppColors.darkParagraph,
    gray: AppColors.darkMuted,
    muted: AppColors.darkMuted,
    line: AppColors.darkLine,
    fill: AppColors.darkFill,
  );

  @override
  AppColorsTheme copyWith({
    Color? bg,
    Color? surface,
    Color? ink,
    Color? slate,
    Color? paragraph,
    Color? gray,
    Color? muted,
    Color? line,
    Color? fill,
  }) {
    return AppColorsTheme(
      bg: bg ?? this.bg,
      surface: surface ?? this.surface,
      ink: ink ?? this.ink,
      slate: slate ?? this.slate,
      paragraph: paragraph ?? this.paragraph,
      gray: gray ?? this.gray,
      muted: muted ?? this.muted,
      line: line ?? this.line,
      fill: fill ?? this.fill,
    );
  }

  @override
  AppColorsTheme lerp(covariant AppColorsTheme? other, double t) {
    if (other == null) return this;
    return AppColorsTheme(
      bg: Color.lerp(bg, other.bg, t)!,
      surface: Color.lerp(surface, other.surface, t)!,
      ink: Color.lerp(ink, other.ink, t)!,
      slate: Color.lerp(slate, other.slate, t)!,
      paragraph: Color.lerp(paragraph, other.paragraph, t)!,
      gray: Color.lerp(gray, other.gray, t)!,
      muted: Color.lerp(muted, other.muted, t)!,
      line: Color.lerp(line, other.line, t)!,
      fill: Color.lerp(fill, other.fill, t)!,
    );
  }
}
