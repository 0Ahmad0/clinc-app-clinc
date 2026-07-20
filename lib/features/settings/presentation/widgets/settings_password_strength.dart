import 'package:flutter/material.dart';

import '../../../../config/theme/app_spacing.dart';
import '../../../../shared/extensions/context_extensions.dart';

/// Password-strength meter: a caption, a filling bar and a colored label.
/// [level] runs 0 (empty) → 3 (strong).
class SettingsPasswordStrength extends StatelessWidget {
  const SettingsPasswordStrength({super.key, required this.level});

  final int level;

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
      1 => l10n.settingsStrengthWeak,
      2 => l10n.settingsStrengthMedium,
      3 => l10n.settingsStrengthStrong,
      _ => l10n.settingsStrengthNone,
    };
    return Row(
      children: [
        Text(
          l10n.settingsPasswordStrength,
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
