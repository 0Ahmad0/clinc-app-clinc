import 'package:clinc_app_clinc/modules/appointments/views/appointments_view.dart';
import 'package:clinc_app_clinc/modules/doctors/views/doctors_view.dart';
import 'package:clinc_app_clinc/modules/reports/views/reports_view.dart';
import 'package:clinc_app_clinc/modules/services/views/services_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../generated/locale_keys.g.dart';
import '../../dashboard/views/dashboard_view.dart';
import '../controllers/main_layout_controller.dart';

class MainLayoutView extends GetView<MainLayoutController> {
  const MainLayoutView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => IndexedStack(
          index: controller.currentIndex.value,
          children: const [
            DashboardView(),
            DoctorsView(),
            ServicesView(),
            AppointmentsView(),
            ReportsView(),
          ],
        ),
      ),
      bottomNavigationBar: Obx(() => _CustomNavBar(
        currentIndex: controller.currentIndex.value,
        onTap: (i) {
          HapticFeedback.lightImpact();
          controller.changeTab(i);
        },
      )),
    );
  }
}

class _NavItem {
  final IconData icon;
  final IconData activeIcon;
  final String labelKey;
  final Color color;

  const _NavItem({
    required this.icon,
    required this.activeIcon,
    required this.labelKey,
    required this.color,
  });
}

const _navItems = [
  _NavItem(
    icon: Icons.home_outlined,
    activeIcon: Icons.home_rounded,
    labelKey: LocaleKeys.nav_dashboard,
    color: Color(0xFF009688),
  ),
  _NavItem(
    icon: Icons.people_outline_rounded,
    activeIcon: Icons.people_rounded,
    labelKey: LocaleKeys.nav_doctors,
    color: Color(0xFF3949AB),
  ),
  _NavItem(
    icon: Icons.medical_services_outlined,
    activeIcon: Icons.medical_services_rounded,
    labelKey: LocaleKeys.nav_services,
    color: Color(0xFF2563EB),
  ),
  _NavItem(
    icon: Icons.calendar_month_outlined,
    activeIcon: Icons.calendar_month_rounded,
    labelKey: LocaleKeys.nav_appointments,
    color: Color(0xFF00897B),
  ),
  _NavItem(
    icon: Icons.analytics_outlined,
    activeIcon: Icons.analytics_rounded,
    labelKey: LocaleKeys.nav_reports,
    color: Color(0xFF8B5CF6),
  ),
];

class _CustomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const _CustomNavBar({
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        color: cs.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.3 : 0.08),
            blurRadius: 20,
            offset: const Offset(0, -4),
          ),
        ],
        border: Border(
          top: BorderSide(
            color: cs.outlineVariant.withValues(alpha: 0.2),
            width: 0.8,
          ),
        ),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(
              _navItems.length,
              (i) => _NavBarItem(
                item: _navItems[i],
                isSelected: currentIndex == i,
                onTap: () => onTap(i),
                theme: theme,
                cs: cs,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _NavBarItem extends StatelessWidget {
  final _NavItem item;
  final bool isSelected;
  final VoidCallback onTap;
  final ThemeData theme;
  final ColorScheme cs;

  const _NavBarItem({
    required this.item,
    required this.isSelected,
    required this.onTap,
    required this.theme,
    required this.cs,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOut,
        padding: EdgeInsets.symmetric(
          horizontal: isSelected ? 16.w : 12.w,
          vertical: 8.h,
        ),
        decoration: BoxDecoration(
          gradient: isSelected
              ? LinearGradient(
                  colors: [
                    item.color.withValues(alpha: 0.15),
                    item.color.withValues(alpha: 0.08),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                )
              : null,
          borderRadius: BorderRadius.circular(16.r),
          border: isSelected
              ? Border.all(
                  color: item.color.withValues(alpha: 0.2),
                  width: 1,
                )
              : null,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 200),
              child: Icon(
                isSelected ? item.activeIcon : item.icon,
                key: ValueKey(isSelected),
                color: isSelected
                    ? item.color
                    : cs.onSurfaceVariant.withValues(alpha: 0.5),
                size: isSelected ? 24.sp : 22.sp,
              ),
            ),
            AnimatedSize(
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeInOut,
              child: isSelected
                  ? Row(
                      children: [
                        8.horizontalSpace,
                        Text(
                          tr(item.labelKey),
                          style: TextStyle(
                            color: item.color,
                            fontWeight: FontWeight.w700,
                            fontSize: 12.sp,
                          ),
                        ),
                      ],
                    )
                  : const SizedBox.shrink(),
            ),
          ],
        ),
      ),
    );
  }
}
