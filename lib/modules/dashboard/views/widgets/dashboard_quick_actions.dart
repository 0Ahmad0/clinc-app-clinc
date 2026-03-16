import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../controllers/dashboard_controller.dart';
import '../../models/dashboard_models.dart';

class DashboardQuickActions extends GetView<DashboardController> {
  const DashboardQuickActions({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.fromLTRB(16.w, 20.h, 16.w, 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: controller.quickActions
              .map((a) => _QuickActionTile(action: a))
              .toList(),
        ),
      ),
    );
  }
}

class _QuickActionTile extends StatelessWidget {
  final DashboardQuickAction action;
  const _QuickActionTile({required this.action});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: () => Get.toNamed(action.route),
      child: Column(
        children: [
          Container(
            width: 54.r, height: 54.r,
            decoration: BoxDecoration(
              color: action.color.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(color: action.color.withValues(alpha: 0.2), width: 1.5),
            ),
            child: Icon(action.icon, color: action.color, size: 26.sp),
          ),
          8.verticalSpace,
          Text(
            action.label,
            style: theme.textTheme.labelSmall?.copyWith(fontWeight: FontWeight.w700, fontSize: 11.sp),
          ),
        ],
      ),
    );
  }
}
