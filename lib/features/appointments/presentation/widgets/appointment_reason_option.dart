import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../../../../config/theme/app_motion.dart';
import '../../../../config/theme/app_spacing.dart';
import '../../../../shared/extensions/context_extensions.dart';

/// A selectable rejection-reason row with a leading radio indicator.
class AppointmentReasonOption extends StatelessWidget {
  const AppointmentReasonOption({
    super.key,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
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
        padding: const EdgeInsetsDirectional.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm + 1,
        ),
        decoration: BoxDecoration(
          color: selected
              ? colors.danger.withValues(alpha: 0.05)
              : colors.surface,
          borderRadius: BorderRadius.circular(AppRadius.field),
          border: Border.all(
            color: selected
                ? colors.dangerFg
                : colors.ink.withValues(alpha: 0.09),
            width: selected ? 2 : 1.5,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: AppSizes.iconMd,
              height: AppSizes.iconMd,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: selected ? colors.dangerFg : null,
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
                      size: AppSpacing.sm,
                      color: colors.onBrand,
                    )
                  : null,
            ),
            AppGaps.w12,
            Expanded(
              child: Text(
                label,
                style: context.textTheme.bodyMedium?.copyWith(
                  color: selected ? colors.ink : colors.gray,
                  fontWeight: selected ? FontWeight.w700 : FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
