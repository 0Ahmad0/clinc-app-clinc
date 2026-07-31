import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../../../../config/theme/app_spacing.dart';
import '../../../../core/utils/app_time_formatter.dart';
import '../../../../shared/extensions/context_extensions.dart';
import '../../data/models/clinic_doctor_model.dart';
import '../../domain/weekday.dart';
import '../weekday_l10n.dart';
import 'doctor_profile_section_title.dart';

/// Working days as chips (off days struck through) plus the working-hours line.
class DoctorProfileSchedule extends StatelessWidget {
  const DoctorProfileSchedule({super.key, required this.schedules, this.today});

  final List<ClinicDoctorScheduleModel> schedules;
  final DateTime? today;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final l10n = context.l10n;
    final activeDays = {
      for (final schedule in schedules)
        if (schedule.isActive) _weekday(schedule.day),
    };
    final todaySchedule = _scheduleOf(_today());
    final hoursText = todaySchedule == null || !todaySchedule.isActive
        ? l10n.addDoctorDayOff
        : '${formatClockTime12(todaySchedule.from)} - ${formatClockTime12(todaySchedule.to)}';
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
                _DayChip(
                  label: day.label(l10n),
                  active: activeDays.contains(day),
                ),
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
            border: Border.all(
              color: colors.primary500.withValues(alpha: 0.16),
            ),
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
                  hoursText,
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

  ClinicDoctorScheduleModel? _scheduleOf(Weekday day) {
    for (final schedule in schedules) {
      if (_weekday(schedule.day) == day) return schedule;
    }
    return null;
  }

  Weekday _today() {
    final value = today ?? DateTime.now();
    return switch (value.weekday) {
      DateTime.monday => Weekday.monday,
      DateTime.tuesday => Weekday.tuesday,
      DateTime.wednesday => Weekday.wednesday,
      DateTime.thursday => Weekday.thursday,
      DateTime.friday => Weekday.friday,
      DateTime.saturday => Weekday.saturday,
      DateTime.sunday => Weekday.sunday,
      _ => Weekday.saturday,
    };
  }

  Weekday _weekday(String? value) {
    return Weekday.values.firstWhere(
      (day) => day.name == (value ?? '').toLowerCase(),
      orElse: () => Weekday.saturday,
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
