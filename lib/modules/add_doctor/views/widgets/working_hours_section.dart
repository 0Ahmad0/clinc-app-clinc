import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../../app/core/widgets/app_time_picker_tile.dart';
import '../../../../generated/locale_keys.g.dart';
import '../../controllers/add_doctor_controller.dart';

class WorkingHoursSection extends StatelessWidget {
  final AddDoctorController controller;
  const WorkingHoursSection({super.key, required this.controller});

  static const _teal = Color(0xFF00695C);

  @override
  Widget build(BuildContext context) {
    return Obx(() => Column(
      children: List.generate(
        controller.workingHoursList.length,
        (i) => _WorkingDayRow(
          controller: controller,
          index: i,
          accentColor: _teal,
        ),
      ),
    ));
  }
}

// ─── Single Day Row ───────────────────────────────────────────────────────────

class _WorkingDayRow extends StatelessWidget {
  final AddDoctorController controller;
  final int index;
  final Color accentColor;

  const _WorkingDayRow({
    required this.controller,
    required this.index,
    required this.accentColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final day = controller.workingHoursList[index];
    final keyStr = 'working_hours.days.${day.day}';
    final dayName = tr(keyStr) == keyStr ? day.day : tr(keyStr);

    return Container(
      margin: EdgeInsets.only(bottom: 10.h),
      decoration: BoxDecoration(
        color: day.isDayOff
            ? cs.surfaceContainerHighest
            : accentColor.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(
          color: day.isDayOff
              ? cs.outlineVariant.withValues(alpha: 0.3)
              : accentColor.withValues(alpha: 0.2),
        ),
      ),
      child: Column(
        children: [
          _DayHeader(
            dayName: dayName,
            day: day,
            index: index,
            controller: controller,
            accentColor: accentColor,
            theme: theme,
            cs: cs,
          ),
          if (!day.isDayOff) ...[
            Divider(height: 1, color: accentColor.withValues(alpha: 0.15)),
            _TimeRow(controller: controller, index: index, accentColor: accentColor),
          ],
        ],
      ),
    );
  }
}

// ─── Day Header ───────────────────────────────────────────────────────────────

class _DayHeader extends StatelessWidget {
  final String dayName;
  final dynamic day;
  final int index;
  final AddDoctorController controller;
  final Color accentColor;
  final ThemeData theme;
  final ColorScheme cs;

  const _DayHeader({
    required this.dayName,
    required this.day,
    required this.index,
    required this.controller,
    required this.accentColor,
    required this.theme,
    required this.cs,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      child: Row(
        children: [
          Container(
            width: 36.r,
            height: 36.r,
            decoration: BoxDecoration(
              color: day.isDayOff
                  ? cs.surfaceContainerHighest
                  : accentColor.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Icon(
              day.isDayOff
                  ? Icons.event_busy_rounded
                  : Icons.event_available_rounded,
              color: day.isDayOff ? cs.onSurfaceVariant : accentColor,
              size: 18.sp,
            ),
          ),
          12.horizontalSpace,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  dayName,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                if (!day.isDayOff &&
                    day.startTime != null &&
                    day.endTime != null)
                  Text(
                    '${day.startTime} - ${day.endTime}',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: accentColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
              ],
            ),
          ),
          Switch(
            value: !day.isDayOff,
            activeColor: accentColor,
            onChanged: (v) => controller.toggleDayOff(index, v),
          ),
        ],
      ),
    );
  }
}

// ─── Time Row ─────────────────────────────────────────────────────────────────

class _TimeRow extends StatelessWidget {
  final AddDoctorController controller;
  final int index;
  final Color accentColor;

  const _TimeRow({
    required this.controller,
    required this.index,
    required this.accentColor,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final day = controller.workingHoursList[index];

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
      child: Row(
        children: [
          Expanded(
            child: AppTimePickerTile(
              label: tr(LocaleKeys.working_hours_from),
              time: day.startTime ?? '--:--',
              accentColor: accentColor,
              onTap: () => controller.selectTime(context, index, true),
            ),
          ),
          12.horizontalSpace,
          Icon(
            Icons.arrow_back_rounded,
            size: 16.sp,
            color: cs.onSurfaceVariant.withValues(alpha: 0.5),
          ),
          12.horizontalSpace,
          Expanded(
            child: AppTimePickerTile(
              label: tr(LocaleKeys.working_hours_to),
              time: day.endTime ?? '--:--',
              accentColor: accentColor,
              onTap: () => controller.selectTime(context, index, false),
            ),
          ),
        ],
      ),
    );
  }
}
