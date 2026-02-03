import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class QualificationChip extends StatelessWidget {
  final String label;
  final VoidCallback onDeleted;

  const QualificationChip({
    super.key,
    required this.label,
    required this.onDeleted,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Chip(
      label: Text(label),
      backgroundColor: colorScheme.primary.withOpacity(0.1),
      labelStyle: theme.textTheme.bodySmall?.copyWith(
        color: colorScheme.primary,
      ),
      deleteIcon: Icon(
        Icons.close,
        size: 18.sp,
        color: colorScheme.primary,
      ),
      onDeleted: onDeleted,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.r),
        side: BorderSide(color: colorScheme.primary.withOpacity(0.3)),
      ),
    );
  }
}