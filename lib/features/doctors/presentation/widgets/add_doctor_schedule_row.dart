import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../../../../config/theme/app_spacing.dart';
import '../../../../shared/extensions/context_extensions.dart';
import '../../domain/weekday.dart';
import '../cubit/add_doctor_state.dart';
import '../weekday_l10n.dart';
import 'add_doctor_time_box.dart';
import '../../../../shared/widgets/app_switch.dart';

/// One weekday row in the schedule card: a toggle plus the working hours that
/// appear when the day is switched on. The hours open a time picker.
class AddDoctorScheduleRow extends StatelessWidget {
  const AddDoctorScheduleRow({
    super.key,
    required this.day,
    required this.active,
    required this.hours,
    required this.onToggle,
    required this.onPickStart,
    required this.onPickEnd,
  });

  final Weekday day;
  final bool active;
  final WorkingHours hours;
  final VoidCallback onToggle;
  final VoidCallback onPickStart;
  final VoidCallback onPickEnd;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final l10n = context.l10n;
    return Container(
      padding: const EdgeInsetsDirectional.all(AppSpacing.sm + 1),
      decoration: BoxDecoration(
        color: active ? colors.primary500.withValues(alpha: 0.05) : colors.bg,
        borderRadius: BorderRadius.circular(AppRadius.button),
        border: Border.all(
          color: active
              ? colors.primary500.withValues(alpha: 0.22)
              : colors.line,
          width: active ? 1.5 : 1,
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: AppSizes.addDoctorSectionIcon - 2,
                height: AppSizes.addDoctorSectionIcon - 2,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: active
                      ? colors.primary500.withValues(alpha: 0.12)
                      : colors.ink.withValues(alpha: 0.06),
                  borderRadius: BorderRadius.circular(AppRadius.sm),
                ),
                child: Icon(
                  Iconsax.calendar_tick,
                  size: AppSizes.iconSm,
                  color: active ? colors.primary600 : colors.muted,
                ),
              ),
              AppGaps.w12,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      day.label(l10n),
                      style: context.textTheme.bodyMedium?.copyWith(
                        color: colors.ink,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      active
                          ? '${hours.start.format(context)} - ${hours.end.format(context)}'
                          : l10n.addDoctorDayOff,
                      textDirection: active ? TextDirection.ltr : null,
                      style: context.textTheme.labelSmall?.copyWith(
                        color: colors.muted,
                      ),
                    ),
                  ],
                ),
              ),
              AppSwitch(value: active, onChanged: onToggle),
            ],
          ),
          if (active) ...[
            AppGaps.h12,
            Divider(height: 1, color: colors.line),
            AppGaps.h12,
            Row(
              children: [
                Expanded(
                  child: AddDoctorTimeBox(
                    label: l10n.addDoctorFrom,
                    time: hours.start.format(context),
                    onTap: onPickStart,
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.symmetric(
                    horizontal: AppSpacing.sm,
                  ),
                  child: Icon(
                    Iconsax.arrow_left_3,
                    size: AppSizes.iconSm,
                    color: colors.muted,
                  ),
                ),
                Expanded(
                  child: AddDoctorTimeBox(
                    label: l10n.addDoctorTo,
                    time: hours.end.format(context),
                    onTap: onPickEnd,
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}
