import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../generated/locale_keys.g.dart';
import '../../models/day_schedule_model.dart';
import 'cp_time_chip.dart';

class CPScheduleDayRow extends StatelessWidget {
  final DaySchedule day;
  final Color accentColor;
  final ValueChanged<bool> onToggle;
  final VoidCallback onStartTimeTap;
  final VoidCallback onEndTimeTap;
  final bool showDivider;

  const CPScheduleDayRow({
    super.key,
    required this.day,
    required this.accentColor,
    required this.onToggle,
    required this.onStartTimeTap,
    required this.onEndTimeTap,
    this.showDivider = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 8.h),
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: Text(
                  tr('complete_profile.schedule.days.${day.dayKey}'),
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 13.sp,
                    color: day.isDayOff
                        ? Colors.grey.shade400
                        : Colors.grey.shade800,
                  ),
                ),
              ),
              Switch.adaptive(
                value: !day.isDayOff,
                onChanged: onToggle,
                activeColor: accentColor,
              ),
              if (!day.isDayOff) ...[
                const Spacer(),
                CPTimeChip(
                  time: day.startTime,
                  accentColor: accentColor,
                  onTap: onStartTimeTap,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4.w),
                  child: Icon(
                    Icons.arrow_forward_rounded,
                    size: 14.r,
                    color: Colors.grey.shade400,
                  ),
                ),
                CPTimeChip(
                  time: day.endTime,
                  accentColor: accentColor,
                  onTap: onEndTimeTap,
                ),
              ] else
                Text(
                  tr(LocaleKeys.complete_profile_schedule_day_off),
                  style: TextStyle(
                    color: Colors.red.shade400,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
            ],
          ),
        ),
        if (showDivider) Divider(color: Colors.grey.shade100, height: 1),
      ],
    );
  }
}
