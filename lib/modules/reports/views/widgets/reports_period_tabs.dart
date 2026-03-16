import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../controllers/reports_controller.dart';

class ReportsPeriodTabs extends GetView<ReportsController> {
  const ReportsPeriodTabs({super.key});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.fromLTRB(16.w, 20.h, 16.w, 0),
        child: Obx(() {
          final sel = controller.selectedPeriodTab.value;
          return Container(
            padding: EdgeInsets.all(4.w),
            decoration: BoxDecoration(
              color: cs.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(14.r),
            ),
            child: Row(
              children: [
                _PeriodTab(
                  label: 'أسبوعي',
                  icon: Icons.view_week_rounded,
                  isSelected: sel == 0,
                  color: const Color(0xFF009688),
                  onTap: () => controller.changePeriodTab(0),
                ),
                _PeriodTab(
                  label: 'شهري',
                  icon: Icons.calendar_month_rounded,
                  isSelected: sel == 1,
                  color: const Color(0xFF3949AB),
                  onTap: () => controller.changePeriodTab(1),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}

class _PeriodTab extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool isSelected;
  final Color color;
  final VoidCallback onTap;

  const _PeriodTab({
    required this.label,
    required this.icon,
    required this.isSelected,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          curve: Curves.easeInOut,
          padding: EdgeInsets.symmetric(vertical: 11.h),
          decoration: BoxDecoration(
            gradient: isSelected
                ? LinearGradient(
                    colors: [color, color.withValues(alpha: 0.75)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  )
                : null,
            borderRadius: BorderRadius.circular(10.r),
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: color.withValues(alpha: 0.3),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ]
                : [],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 16.sp,
                color: isSelected ? Colors.white : cs.onSurfaceVariant,
              ),
              6.horizontalSpace,
              Text(
                label,
                style: TextStyle(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w700,
                  color: isSelected ? Colors.white : cs.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
