import 'package:flutter/material.dart';

import 'app_colors.dart';

/// Elevation tokens. Referenced from design-system widgets — never hand-roll a
/// [BoxShadow] in feature UI.
class AppShadows {
  const AppShadows._();

  /// Large elevated hero/illustration card. CSS: 0 24px 50px -18px blue @45%.
  static List<BoxShadow> get elevatedCard => [
    BoxShadow(
      color: AppColors.primary500.withValues(alpha: 0.45),
      blurRadius: 50,
      spreadRadius: -18,
      offset: const Offset(0, 24),
    ),
  ];

  /// Floating chip. CSS: 0 10px 26px ink @25%.
  static List<BoxShadow> get chip => [
    BoxShadow(
      color: AppColors.ink.withValues(alpha: 0.25),
      blurRadius: 26,
      offset: const Offset(0, 10),
    ),
  ];

  /// Primary CTA button. CSS: 0 14px 30px -8px blue @50%.
  static List<BoxShadow> get primaryButton => [
    BoxShadow(
      color: AppColors.primary500.withValues(alpha: 0.5),
      blurRadius: 30,
      spreadRadius: -8,
      offset: const Offset(0, 14),
    ),
  ];

  static List<BoxShadow> get homeCard => [
    BoxShadow(
      color: AppColors.ink.withValues(alpha: 0.14),
      blurRadius: 22,
      spreadRadius: -12,
      offset: const Offset(0, 8),
    ),
  ];

  static List<BoxShadow> get homeDarkCard => [
    BoxShadow(
      color: AppColors.ink.withValues(alpha: 0.5),
      blurRadius: 34,
      spreadRadius: -14,
      offset: const Offset(0, 16),
    ),
  ];

  static List<BoxShadow> get homeBlueCard => [
    BoxShadow(
      color: AppColors.primary500.withValues(alpha: 0.55),
      blurRadius: 30,
      spreadRadius: -12,
      offset: const Offset(0, 14),
    ),
  ];

  static List<BoxShadow> get homeNavigation => [
    BoxShadow(
      color: AppColors.ink.withValues(alpha: 0.3),
      blurRadius: 40,
      spreadRadius: -14,
      offset: const Offset(0, 16),
    ),
  ];

  /// Selected filter chip glow. CSS: 0 8px 18px -6px blue @50%.
  static List<BoxShadow> get selectedChip => [
    BoxShadow(
      color: AppColors.primary500.withValues(alpha: 0.5),
      blurRadius: 18,
      spreadRadius: -6,
      offset: const Offset(0, 8),
    ),
  ];
}
