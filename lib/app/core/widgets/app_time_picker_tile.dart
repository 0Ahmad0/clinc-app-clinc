import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// A tappable tile that displays a time value and triggers a time-picker on tap.
/// Used inside working-hours rows, appointment forms, and any time selection UI.
class AppTimePickerTile extends StatelessWidget {
  final String label;
  final String time;
  final Color accentColor;
  final VoidCallback onTap;

  const AppTimePickerTile({
    super.key,
    required this.label,
    required this.time,
    required this.accentColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
        decoration: BoxDecoration(
          color: accentColor.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(color: accentColor.withValues(alpha: 0.25)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 10.sp,
                color: accentColor,
                fontWeight: FontWeight.w600,
              ),
            ),
            4.verticalSpace,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  time,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
                ),
                Icon(Icons.access_time_rounded, size: 14.sp, color: accentColor),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
