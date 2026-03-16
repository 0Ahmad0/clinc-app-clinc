import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CPTimeChip extends StatelessWidget {
  final String time;
  final Color accentColor;
  final VoidCallback onTap;

  const CPTimeChip({
    super.key,
    required this.time,
    required this.accentColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8.r),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
        decoration: BoxDecoration(
          color: accentColor.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(color: accentColor.withValues(alpha: 0.3)),
        ),
        child: Text(
          time,
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 11.sp,
            color: accentColor,
          ),
        ),
      ),
    );
  }
}
