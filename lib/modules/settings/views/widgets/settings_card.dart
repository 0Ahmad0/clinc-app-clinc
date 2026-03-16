import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SettingsCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color iconColor;
  final List<Widget> children;

  const SettingsCard({
    super.key,
    required this.title,
    required this.icon,
    required this.iconColor,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    return Padding(
      padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 12.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 8.h, right: 4.w),
            child: Row(
              children: [
                Icon(icon, color: iconColor, size: 16.sp),
                6.horizontalSpace,
                Text(
                  title,
                  style: theme.textTheme.labelLarge?.copyWith(
                    color: iconColor,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.3,
                  ),
                ),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: cs.surface,
              borderRadius: BorderRadius.circular(18.r),
              border: Border.all(
                color: cs.outlineVariant.withValues(alpha: 0.3),
              ),
              boxShadow: [
                BoxShadow(
                  color: cs.shadow.withValues(alpha: 0.04),
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(children: children),
          ),
        ],
      ),
    );
  }
}
