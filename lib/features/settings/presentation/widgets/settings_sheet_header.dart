import 'package:flutter/material.dart';

import '../../../../config/theme/app_spacing.dart';
import '../../../../shared/extensions/context_extensions.dart';

/// Icon-and-title header used at the top of a settings sheet.
class SettingsSheetHeader extends StatelessWidget {
  const SettingsSheetHeader({
    super.key,
    required this.icon,
    required this.title,
  });

  final IconData icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Row(
      children: [
        Container(
          width: AppSizes.hitTarget - 2,
          height: AppSizes.hitTarget - 2,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: colors.primary500.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(AppRadius.field),
          ),
          child: Icon(icon, color: colors.primary600, size: AppSizes.iconMd),
        ),
        AppGaps.w12,
        Text(
          title,
          style: context.textTheme.titleMedium?.copyWith(
            color: colors.ink,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}
