import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../app/data/doctor_model.dart';

class DoctorWeeklySchedule extends StatelessWidget {
  final List<WorkingHours> workingHours;
  final Color specColor;
  const DoctorWeeklySchedule({super.key, required this.workingHours, required this.specColor});

  static const _dayNames = {
    'saturday':  'السبت',
    'sunday':    'الأحد',
    'monday':    'الاثنين',
    'tuesday':   'الثلاثاء',
    'wednesday': 'الأربعاء',
    'thursday':  'الخميس',
    'friday':    'الجمعة',
  };

  @override
  Widget build(BuildContext context) {
    if (workingHours.isEmpty) return _EmptySchedule();

    return Column(
      children: workingHours.map((wh) => _ScheduleRow(
        dayName:  _dayNames[wh.day] ?? wh.day,
        isOff:    wh.isDayOff,
        start:    wh.startTime,
        end:      wh.endTime,
        specColor: specColor,
      )).toList(),
    );
  }
}

// ─── Empty ────────────────────────────────────────────────────────────────────

class _EmptySchedule extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs    = theme.colorScheme;
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: cs.surfaceContainerHighest.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        children: [
          Icon(Icons.info_outline_rounded, size: 18.sp, color: cs.onSurfaceVariant),
          8.horizontalSpace,
          Text('لا يوجد جدول دوام محدد',
              style: theme.textTheme.bodyMedium?.copyWith(color: cs.onSurfaceVariant)),
        ],
      ),
    );
  }
}

// ─── Single Row ───────────────────────────────────────────────────────────────

class _ScheduleRow extends StatelessWidget {
  final String dayName;
  final bool isOff;
  final String? start;
  final String? end;
  final Color specColor;
  const _ScheduleRow({required this.dayName, required this.isOff, this.start, this.end, required this.specColor});

  @override
  Widget build(BuildContext context) {
    final theme    = Theme.of(context);
    final cs       = theme.colorScheme;
    final rowColor = isOff ? const Color(0xFFF04438) : specColor;

    return Padding(
      padding: EdgeInsets.only(bottom: 10.h),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: rowColor.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: rowColor.withValues(alpha: 0.15)),
        ),
        child: Row(
          children: [
            Container(
              width: 8.r, height: 8.r,
              decoration: BoxDecoration(shape: BoxShape.circle, color: rowColor),
            ),
            10.horizontalSpace,
            SizedBox(
              width: 70.w,
              child: Text(dayName,
                  style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w700, color: cs.onSurface)),
            ),
            const Spacer(),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 5.h),
              decoration: BoxDecoration(
                color: rowColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(999),
                border: Border.all(color: rowColor.withValues(alpha: 0.3)),
              ),
              child: Text(
                isOff ? 'إجازة' : '$start - $end',
                style: theme.textTheme.labelMedium?.copyWith(color: rowColor, fontWeight: FontWeight.w700),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
