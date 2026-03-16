import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../../app/data/report_model.dart';
import '../../../../generated/locale_keys.g.dart';
import '../../controllers/reports_controller.dart';
import 'report_type_utils.dart';

class ReportsTypeFilters extends GetView<ReportsController> {
  const ReportsTypeFilters({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    return SliverToBoxAdapter(
      child: Container(
        color: cs.surface,
        padding: EdgeInsets.fromLTRB(16.w, 20.h, 16.w, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              tr(LocaleKeys.reports_filters_type),
              style: theme.textTheme.labelMedium?.copyWith(
                color: cs.onSurfaceVariant,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.5,
              ),
            ),
            12.verticalSpace,
            Obx(() {
              final selected = controller.selectedType.value;
              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: ReportType.values.map((t) {
                    return Padding(
                      padding: EdgeInsets.only(left: 8.w),
                      child: _TypeFilterChip(
                        type: t,
                        isSelected: t == selected,
                        color: t.typeColor(cs),
                        onTap: () => controller.changeType(t),
                      ),
                    );
                  }).toList(),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}

class _TypeFilterChip extends StatelessWidget {
  final ReportType type;
  final bool isSelected;
  final Color color;
  final VoidCallback onTap;

  const _TypeFilterChip({
    required this.type,
    required this.isSelected,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
        decoration: BoxDecoration(
          color: isSelected ? color : cs.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(999.r),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: color.withValues(alpha: 0.35),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ]
              : [],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              type.typeIcon,
              size: 16.sp,
              color: isSelected ? Colors.white : cs.onSurfaceVariant,
            ),
            6.horizontalSpace,
            Text(
              tr(type.key()),
              style: theme.textTheme.labelMedium?.copyWith(
                fontWeight: FontWeight.w700,
                color: isSelected ? Colors.white : cs.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
