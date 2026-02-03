import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';

class WorkHoursListItem extends StatelessWidget {
  final Map<String, dynamic> item;
  final VoidCallback onToggle;
  final Function(String) onTimeChanged;

  const WorkHoursListItem({
    super.key,
    required this.item,
    required this.onToggle,
    required this.onTimeChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isOff = item['isOff'] as bool;

    return Container(
      decoration: BoxDecoration(
        color: isOff ? Colors.transparent : colorScheme.surface,
        border: Border(bottom: BorderSide(color: colorScheme.outlineVariant.withOpacity(0.4))),
      ),
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
      child: Row(
        children: [
          // زر التبديل
          IconButton(
            onPressed: onToggle,
            icon: Icon(
              isOff ? Icons.toggle_off_outlined : Icons.toggle_on_outlined,
              color: isOff ? colorScheme.outline : colorScheme.primary,
              size: 30.sp,
            ),
          ),
          8.horizontalSpace,

          // الوقت
          Expanded(
            child: isOff
                ? Text(
              tr('complete_profile.schedule.day_off'),
              style: theme.textTheme.bodyLarge?.copyWith(
                color: colorScheme.error,
              ),
            )
                : InkWell(
              onTap: () => _showTimePicker(context),
              child: Text(
                item['time'],
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: colorScheme.onSurface,
                ),
              ),
            ),
          ),

          // اليوم
          Text(
            tr('complete_profile.schedule.days.${item['day']}'),
            style: theme.textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: colorScheme.onSurface,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _showTimePicker(BuildContext context) async {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    // تحليل الوقت الحالي
    final currentTime = item['time'] as String;
    final times = currentTime.split(' - ');
    final startTime = _parseTime(times[0]);
    final endTime = _parseTime(times[1]);

    // اختيار وقت البداية
    final pickedStartTime = await showTimePicker(
      context: context,
      initialTime: startTime,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: colorScheme.copyWith(
              primary: colorScheme.primary,
              onPrimary: colorScheme.onPrimary,
            ),
          ),
          child: child!,
        );
      },
    );

    if (pickedStartTime == null) return;

    // اختيار وقت النهاية
    final pickedEndTime = await showTimePicker(
      context: context,
      initialTime: endTime,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: colorScheme.copyWith(
              primary: colorScheme.primary,
              onPrimary: colorScheme.onPrimary,
            ),
          ),
          child: child!,
        );
      },
    );

    if (pickedEndTime == null) return;

    // تنسيق الوقت الجديد
    final newTime = '${_formatTime(pickedStartTime)} - ${_formatTime(pickedEndTime)}';
    onTimeChanged(newTime);
  }

  TimeOfDay _parseTime(String time) {
    final hourMinute = time.split(' ')[0].split(':');
    final hour = int.parse(hourMinute[0]);
    final minute = int.parse(hourMinute[1]);
    final period = time.split(' ')[1];

    if (period == 'PM' && hour != 12) {
      return TimeOfDay(hour: hour + 12, minute: minute);
    } else if (period == 'AM' && hour == 12) {
      return TimeOfDay(hour: 0, minute: minute);
    } else {
      return TimeOfDay(hour: hour, minute: minute);
    }
  }

  String _formatTime(TimeOfDay time) {
    final hour = time.hourOfPeriod;
    final minute = time.minute.toString().padLeft(2, '0');
    final period = time.period == DayPeriod.am ? 'AM' : 'PM';
    return '$hour:$minute $period';
  }
}