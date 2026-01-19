import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PageIndicator extends StatelessWidget {
  final bool isActive;
  final ThemeData theme;

  const PageIndicator({super.key, required this.isActive, required this.theme});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: EdgeInsets.only(right: 8.w),
      height: 8.h,
      width: isActive ? 24.w : 8.w,
      decoration: BoxDecoration(
        color: isActive
            ? theme.primaryColor
            : theme.primaryColor.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12.r),
      ),
    );
  }
}
