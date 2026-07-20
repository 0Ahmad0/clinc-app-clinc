import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../../../../config/theme/app_shadows.dart';
import '../../../../config/theme/app_spacing.dart';
import '../../../../shared/extensions/context_extensions.dart';
import '../../../../shared/widgets/app_switch.dart';

/// Reception-status card with a toggle for whether the doctor takes bookings.
class DoctorProfileAvailability extends StatelessWidget {
  const DoctorProfileAvailability({
    super.key,
    required this.available,
    required this.onToggle,
  });

  final bool available;
  final VoidCallback onToggle;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final l10n = context.l10n;
    return Container(
      margin: const EdgeInsetsDirectional.fromSTEB(
        AppSpacing.screen,
        AppSpacing.md,
        AppSpacing.screen,
        0,
      ),
      padding: const EdgeInsetsDirectional.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(AppRadius.homeQuickAction),
        border: Border.all(color: colors.line),
        boxShadow: AppShadows.homeCard,
      ),
      child: Row(
        children: [
          Container(
            width: AppSizes.iconBox,
            height: AppSizes.iconBox,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: (available ? colors.success : colors.ink).withValues(
                alpha: available ? 0.12 : 0.07,
              ),
              borderRadius: BorderRadius.circular(AppRadius.sm),
            ),
            child: Icon(
              Iconsax.clock,
              size: AppSizes.iconSm,
              color: available ? colors.successFg : colors.gray,
            ),
          ),
          AppGaps.w12,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.doctorProfileAvailTitle,
                  style: context.textTheme.bodyMedium?.copyWith(
                    color: colors.ink,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  available
                      ? l10n.doctorProfileAvailOn
                      : l10n.doctorProfileAvailOff,
                  style: context.textTheme.labelSmall?.copyWith(
                    color: colors.muted,
                  ),
                ),
              ],
            ),
          ),
          AppSwitch(value: available, onChanged: onToggle),
        ],
      ),
    );
  }
}
