import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../../generated/locale_keys.g.dart';
import '../../controllers/add_doctor_controller.dart';

class AvailabilitySection extends StatelessWidget {
  final AddDoctorController controller;
  const AvailabilitySection({super.key, required this.controller});

  static const _teal = Color(0xFF00695C);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final isAvailable = controller.isAvailable.value;
      final cs = Theme.of(context).colorScheme;
      final theme = Theme.of(context);

      return GestureDetector(
        onTap: () => controller.isAvailable.value = !isAvailable,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: isAvailable
                  ? [
                      _teal.withValues(alpha: 0.1),
                      _teal.withValues(alpha: 0.04),
                    ]
                  : [cs.surfaceContainerHighest, cs.surfaceContainerHighest],
            ),
            borderRadius: BorderRadius.circular(20.r),
            border: Border.all(
              color: isAvailable
                  ? _teal.withValues(alpha: 0.3)
                  : cs.outlineVariant.withValues(alpha: 0.4),
            ),
          ),
          child: Row(
            children: [
              _AvailabilityIcon(isAvailable: isAvailable, cs: cs),
              14.horizontalSpace,
              Expanded(
                child: _AvailabilityText(
                  isAvailable: isAvailable,
                  theme: theme,
                  cs: cs,
                ),
              ),
              Switch(
                value: isAvailable,
                activeColor: _teal,
                onChanged: (v) => controller.isAvailable.value = v,
              ),
            ],
          ),
        ),
      );
    });
  }
}

// ─── Sub-widgets ──────────────────────────────────────────────────────────────

class _AvailabilityIcon extends StatelessWidget {
  final bool isAvailable;
  final ColorScheme cs;
  const _AvailabilityIcon({required this.isAvailable, required this.cs});

  static const _teal = Color(0xFF00695C);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.r),
      decoration: BoxDecoration(
        color: isAvailable
            ? _teal.withValues(alpha: 0.15)
            : cs.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Icon(
        isAvailable ? Icons.check_circle_rounded : Icons.cancel_rounded,
        color: isAvailable ? _teal : cs.onSurfaceVariant,
        size: 22.sp,
      ),
    );
  }
}

class _AvailabilityText extends StatelessWidget {
  final bool isAvailable;
  final ThemeData theme;
  final ColorScheme cs;
  const _AvailabilityText({
    required this.isAvailable,
    required this.theme,
    required this.cs,
  });

  static const _teal = Color(0xFF00695C);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          tr(LocaleKeys.add_doctor_labels_availability),
          style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w700),
        ),
        4.verticalSpace,
        Text(
          isAvailable ? 'الطبيب متاح للمواعيد' : 'الطبيب غير متاح حالياً',
          style: theme.textTheme.bodySmall?.copyWith(
            color: isAvailable ? _teal : cs.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}
