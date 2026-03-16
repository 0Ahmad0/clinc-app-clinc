import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../app/core/widgets/app_bottom_nav_bar.dart';
import '../../../../generated/locale_keys.g.dart';
import '../../../main_layout/controllers/main_layout_controller.dart';

// ─── Nav Items ────────────────────────────────────────────────────────────────
// Defined here — owned by the module, referenced by MainLayoutNav.

const kMainNavItems = <AppNavItem>[
  AppNavItem(
    icon: Icons.home_outlined,
    activeIcon: Icons.home_rounded,
    labelKey: LocaleKeys.nav_dashboard,
    color: Color(0xFF009688),
  ),
  AppNavItem(
    icon: Icons.people_outline_rounded,
    activeIcon: Icons.people_rounded,
    labelKey: LocaleKeys.nav_doctors,
    color: Color(0xFF3949AB),
  ),
  AppNavItem(
    icon: Icons.medical_services_outlined,
    activeIcon: Icons.medical_services_rounded,
    labelKey: LocaleKeys.nav_services,
    color: Color(0xFF2563EB),
  ),
  AppNavItem(
    icon: Icons.calendar_month_outlined,
    activeIcon: Icons.calendar_month_rounded,
    labelKey: LocaleKeys.nav_appointments,
    color: Color(0xFF00897B),
  ),
  AppNavItem(
    icon: Icons.analytics_outlined,
    activeIcon: Icons.analytics_rounded,
    labelKey: LocaleKeys.nav_reports,
    color: Color(0xFF8B5CF6),
  ),
];

// ─── Widget ───────────────────────────────────────────────────────────────────

/// Animated bottom navigation bar for the main layout.
/// Delegates all tap logic (haptic + profile guard) to [MainLayoutController].
class MainLayoutNav extends GetView<MainLayoutController> {
  const MainLayoutNav({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => AppBottomNavBar(
      currentIndex: controller.currentIndex.value,
      items: kMainNavItems,
      onTap: controller.changeTab,
    ));
  }
}
