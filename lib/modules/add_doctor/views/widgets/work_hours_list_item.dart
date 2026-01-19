import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';

class WorkHoursListItem extends StatelessWidget {
  final Map<String, dynamic> item;

  const WorkHoursListItem({super.key, required this.item});

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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // الوقت (يسار)
          Text(
            isOff ? tr('complete_profile.schedule.day_off') : item['time'],
            style: theme.textTheme.bodyLarge?.copyWith(
              color: isOff ? colorScheme.error : colorScheme.onSurface, // أحمر للعطلة
            ),
          ),

          // اليوم (يمين)
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
}