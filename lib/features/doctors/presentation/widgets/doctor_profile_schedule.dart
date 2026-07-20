import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../../../../config/theme/app_spacing.dart';
import '../../../../shared/extensions/context_extensions.dart';
import '../../domain/weekday.dart';
import '../weekday_l10n.dart';
import 'doctor_profile_section_title.dart';

/// Working days as chips (off days struck through) plus the working-hours line.
class DoctorProfileSchedule extends StatelessWidget {
  const DoctorProfileSchedule({super.key});

  // Server-supplied later; a sensible default pattern for now.
  static const Set<Weekday> _activeDays = {
    Weekday.saturday,
    Weekday.sunday,
    Weekday.monday,
    Weekday.wednesday,
    Weekday.thursday,
  };

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final l10n = context.l10n;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        DoctorProfileSectionTitle(title: l10n.doctorProfileSchedule),
        Padding(
          padding: const EdgeInsetsDirectional.symmetric(
            horizontal: AppSpacing.screen,
          ),
          child: Wrap(
            spacing: AppSpacing.xs - 1,
            runSpacing: AppSpacing.xs - 1,
            children: [
              for (final day in Weekday.values)
                _DayChip(label: day.label(l10n), active: _activeDays.contains(day)),
            ],
          ),
        ),
        Container(
          margin: const EdgeInsetsDirectional.fromSTEB(
            AppSpacing.screen,
            AppSpacing.sm,
            AppSpacing.screen,
            0,
          ),
          padding: const EdgeInsetsDirectional.all(AppSpacing.sm + 1),
          decoration: BoxDecoration(
            color: colors.primary500.withValues(alpha: 0.07),
            borderRadius: BorderRadius.circular(AppRadius.field),
            border: Border.all(color: colors.primary500.withValues(alpha: 0.16)),
          ),
          child: Row(
            children: [
              Icon(
                Iconsax.clock,
                size: AppSizes.iconSm,
                color: colors.primary600,
              ),
              AppGaps.w8,
              Expanded(
                child: Text(
                  l10n.doctorProfileHours,
                  style: context.textTheme.bodySmall?.copyWith(
                    color: colors.slate,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _DayChip extends StatelessWidget {
  const _DayChip({required this.label, required this.active});

  final String label;
  final bool active;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Container(
      padding: const EdgeInsetsDirectional.symmetric(
        horizontal: AppSpacing.sm + 1,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: active ? colors.primary500.withValues(alpha: 0.1) : colors.fill,
        borderRadius: BorderRadius.circular(AppRadius.pill),
      ),
      child: Text(
        label,
        style: context.textTheme.labelSmall?.copyWith(
          fontWeight: FontWeight.w700,
          color: active ? colors.primary600 : colors.muted,
          decoration: active ? null : TextDecoration.lineThrough,
        ),
      ),
    );
  }
}
