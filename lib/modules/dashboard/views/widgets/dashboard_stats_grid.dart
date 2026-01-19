import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';

class DashboardStatCard extends StatelessWidget {
  final String count;
  final String label;
  final Color iconColor;

  const DashboardStatCard({
    super.key,
    required this.count,
    required this.label,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surface, // لون الكارت من الثيم
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow.withOpacity(0.05), // ظل خفيف جداً
            blurRadius: 15,
            offset: const Offset(0, 5),
          )
        ],
        border: Border.all(
          color: colorScheme.outlineVariant.withOpacity(0.5),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            count,
            style: theme.textTheme.displaySmall?.copyWith( // خط كبير للأرقام
              fontWeight: FontWeight.bold,
              color: iconColor, // اللون المميز
            ),
          ),
          8.verticalSpace,
          Text(
            tr(label),
            style: theme.textTheme.bodyMedium?.copyWith(
              color: colorScheme.onSurfaceVariant, // لون رمادي للنص الثانوي
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}