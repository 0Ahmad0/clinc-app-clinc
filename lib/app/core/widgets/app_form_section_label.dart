import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Colored accent bar + icon + bold label used as a section divider inside forms.
/// Reusable across any module that needs to visually separate form sections.
class AppFormSectionLabel extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color color;

  const AppFormSectionLabel({
    super.key,
    required this.label,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 3.5.w,
          height: 16.h,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(4.r),
          ),
        ),
        8.horizontalSpace,
        Icon(icon, color: color, size: 16.r),
        6.horizontalSpace,
        Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.w800,
            fontSize: 13.sp,
            color: color,
          ),
        ),
      ],
    );
  }
}
