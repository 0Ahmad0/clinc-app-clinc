import 'package:flutter/material.dart';

import '../../config/theme/app_spacing.dart';
import '../extensions/context_extensions.dart';

/// Password-strength meter: a caption, a filling bar and a colored label.
/// Shared by the change-password and reset-password screens.
class AppPasswordStrength extends StatelessWidget {
  const AppPasswordStrength({super.key, required this.level});

  /// 0 empty · 1 weak · 2 medium · 3 strong — see [levelOf].
  final int level;

  /// Rates [password]: strong needs 8+ characters mixing letters and digits,
  /// medium is 6+, anything shorter is weak.
  static int levelOf(String password) {
    if (password.isEmpty) return 0;
    final hasDigit = password.contains(RegExp(r'\d'));
    final hasLetter = password.contains(RegExp(r'[A-Za-zء-ي]'));
    if (password.length >= 8 && hasDigit && hasLetter) return 3;
    return password.length >= 6 ? 2 : 1;
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final l10n = context.l10n;
    final color = switch (level) {
      1 => colors.danger,
      2 => colors.warning,
      3 => colors.success,
      _ => colors.muted,
    };
    final label = switch (level) {
      1 => l10n.passwordStrengthWeak,
      2 => l10n.passwordStrengthMedium,
      3 => l10n.passwordStrengthStrong,
      _ => l10n.passwordStrengthNone,
    };
    return Row(
      children: [
        Text(
          l10n.passwordStrengthLabel,
          style: context.textTheme.bodySmall?.copyWith(
            color: colors.ink,
            fontWeight: FontWeight.w600,
          ),
        ),
        AppGaps.w12,
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(AppRadius.pill),
            child: LinearProgressIndicator(
              value: level / 3,
              minHeight: AppSpacing.xs - 1,
              backgroundColor: colors.fill,
              valueColor: AlwaysStoppedAnimation(color),
            ),
          ),
        ),
        AppGaps.w8,
        Text(
          label,
          style: context.textTheme.bodySmall?.copyWith(
            color: color,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}
