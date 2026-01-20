import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../app/data/specialty_model.dart';

class SpecialtyCardWidget extends StatelessWidget {
  final SpecialtyModel specialty;

  const SpecialtyCardWidget({super.key, required this.specialty});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(color: colorScheme.outlineVariant.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          // Icon Box
          Container(
            width: 50.r,
            height: 50.r,
            decoration: BoxDecoration(
              color: specialty.color.withOpacity(0.1), // لون خلفية شفاف من لون القسم
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Icon(
              specialty.icon,
              color: specialty.color,
              size: 26.sp,
            ),
          ),
          16.horizontalSpace,

          // Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  specialty.name,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                4.verticalSpace,
                Text(
                  specialty.description,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),

          // Actions
          Row(
            children: [
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.edit, size: 20.sp, color: Colors.grey),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.delete_outline, size: 20.sp, color: Colors.grey),
              ),
            ],
          )
        ],
      ),
    );
  }
}