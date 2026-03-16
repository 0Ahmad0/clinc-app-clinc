import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../controllers/services_controller.dart';

const _kBlue      = Color(0xFF2563EB);
const _kDarkIndigo = Color(0xFF1E1B4B);
const _kBlueShadow = Color(0x402563EB);

/// Animated pill tab bar switching between Labs and Specialties grids.
class ServicesTabBar extends GetView<ServicesController> {
  const ServicesTabBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 0),
      padding: EdgeInsets.all(5.r),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(14.r),
      ),
      child: Obx(() => Row(
        children: [
          _TabItem(
            title: 'التحاليل المخبرية',
            icon: Icons.biotech_rounded,
            index: 0,
            isActive: controller.currentTab.value == 0,
            onTap: () => controller.changeTab(0),
          ),
          _TabItem(
            title: 'التخصصات الطبية',
            icon: Icons.local_hospital_rounded,
            index: 1,
            isActive: controller.currentTab.value == 1,
            onTap: () => controller.changeTab(1),
          ),
        ],
      )),
    );
  }
}

// ── Private ───────────────────────────────────────────────────────────────────

class _TabItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final int index;
  final bool isActive;
  final VoidCallback onTap;

  const _TabItem({
    required this.title,
    required this.icon,
    required this.index,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          padding: EdgeInsets.symmetric(vertical: 11.h),
          decoration: BoxDecoration(
            gradient: isActive
                ? const LinearGradient(
                    colors: [_kDarkIndigo, _kBlue],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  )
                : null,
            borderRadius: BorderRadius.circular(10.r),
            boxShadow: isActive
                ? [BoxShadow(color: _kBlueShadow, blurRadius: 8, offset: const Offset(0, 3))]
                : [],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 15.sp,
                color: isActive ? Colors.white : theme.colorScheme.onSurfaceVariant,
              ),
              5.horizontalSpace,
              Text(
                title,
                style: theme.textTheme.labelMedium?.copyWith(
                  color: isActive ? Colors.white : theme.colorScheme.onSurfaceVariant,
                  fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
