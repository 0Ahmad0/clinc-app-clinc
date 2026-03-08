import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../generated/locale_keys.g.dart';
import '../../controllers/complete_profile_controller.dart';

class CPScheduleWidget extends GetView<CompleteProfileController> {
  const CPScheduleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        // لون خلفية الكارد (فاتح في اللايت، غامق في الدارك)
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: colorScheme.outlineVariant),
      ),
      child: Obx(
        () => Column(
          children: List.generate(controller.weekSchedule.length, (index) {
            final day = controller.weekSchedule[index];
            return Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.h),
                  child: Row(
                    children: [
                      // اسم اليوم
                      FittedBox(
                        child: Text(
                          tr('complete_profile.schedule.days.${day.dayKey}'),
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: colorScheme.onSurface,
                          ),
                        ),
                      ),

                      // Switch يأخذ لونه تلقائياً من الثيم
                      Switch.adaptive(
                        value: !day.isDayOff,
                        onChanged: (val) =>
                            controller.toggleDayOff(index, !val),
                      ),

                      const Spacer(),

                      // اختيار الساعات
                      if (!day.isDayOff) ...[
                        _buildTimeChip(
                          context,
                          day.startTime,
                          () => controller.pickTime(context, index, true),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 5.w),
                          child: Icon(
                            Icons.arrow_forward,
                            size: 14.sp,
                            color: colorScheme
                                .onSurfaceVariant, // لون الأيقونة الثانوي
                          ),
                        ),
                        _buildTimeChip(
                          context,
                          day.endTime,
                          () => controller.pickTime(context, index, false),
                        ),
                      ] else
                        Text(
                          tr(LocaleKeys.complete_profile_schedule_day_off),
                          // لون الخطأ (أحمر عادة)
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: colorScheme.error,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                    ],
                  ),
                ),
                if (index != controller.weekSchedule.length - 1)
                  Divider(color: colorScheme.outlineVariant),
              ],
            );
          }),
        ),
      ),
    );
  }

  Widget _buildTimeChip(BuildContext context, String time, VoidCallback onTap) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
        decoration: BoxDecoration(
          // لون خلفية التشيب (افتح قليلاً من الخلفية العادية)
          color: colorScheme.surfaceVariant.withOpacity(0.3),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: colorScheme.outline.withOpacity(0.5)),
        ),
        child: Text(
          time,
          style: theme.textTheme.bodySmall?.copyWith(
            fontWeight: FontWeight.w600,
            color: colorScheme.onSurface, // لون النص ليناسب الخلفية
          ),
        ),
      ),
    );
  }
}
