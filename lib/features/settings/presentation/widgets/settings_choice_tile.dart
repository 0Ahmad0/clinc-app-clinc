import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../../../../config/theme/app_motion.dart';
import '../../../../config/theme/app_spacing.dart';
import '../../../../shared/extensions/context_extensions.dart';

/// A selectable option inside a settings sheet: icon, name + description and a
/// trailing radio that fills when selected.
class SettingsChoiceTile extends StatelessWidget {
  const SettingsChoiceTile({
    super.key,
    required this.icon,
    required this.name,
    required this.sub,
    required this.selected,
    required this.onTap,
  });

  final IconData icon;
  final String name;
  final String sub;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: AppMotion.quick,
        curve: AppMotion.emphasized,
        padding: const EdgeInsetsDirectional.all(AppSpacing.sm + 1),
        decoration: BoxDecoration(
          color: selected
              ? colors.primary500.withValues(alpha: 0.06)
              : colors.surface,
          borderRadius: BorderRadius.circular(AppRadius.button),
          border: Border.all(
            color: selected
                ? colors.primary500
                : colors.ink.withValues(alpha: 0.09),
            width: selected ? 2 : 1.5,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: AppSizes.iconBox,
              height: AppSizes.iconBox,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: selected
                    ? colors.primary500.withValues(alpha: 0.12)
                    : colors.ink.withValues(alpha: 0.06),
                borderRadius: BorderRadius.circular(AppRadius.sm),
              ),
              child: Icon(
                icon,
                size: AppSizes.iconSm,
                color: selected ? colors.primary600 : colors.gray,
              ),
            ),
            AppGaps.w12,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: context.textTheme.bodyMedium?.copyWith(
                      color: colors.ink,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    sub,
                    style: context.textTheme.labelSmall?.copyWith(
                      color: colors.muted,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: AppSizes.iconLg,
              height: AppSizes.iconLg,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: selected ? colors.primary500 : null,
                border: selected
                    ? null
                    : Border.all(
                        color: colors.ink.withValues(alpha: 0.2),
                        width: 2,
                      ),
              ),
              child: selected
                  ? Icon(
                      Iconsax.tick_circle,
                      size: AppSpacing.sm + 1,
                      color: colors.onBrand,
                    )
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}
