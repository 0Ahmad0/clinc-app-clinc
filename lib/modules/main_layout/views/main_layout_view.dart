import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../../app/core/widgets/app_bottom_nav_bar.dart';
import '../../../generated/locale_keys.g.dart';
import '../../appointments/views/appointments_view.dart';
import '../../dashboard/views/dashboard_view.dart';
import '../../doctors/views/doctors_view.dart';
import '../../reports/views/reports_view.dart';
import '../../services/views/services_view.dart';
import '../controllers/main_layout_controller.dart';

// ─── Nav Items Definition ─────────────────────────────────────────────────────

const _kNavItems = [
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

// ─── View ─────────────────────────────────────────────────────────────────────

class MainLayoutView extends GetView<MainLayoutController> {
  const MainLayoutView({super.key});

  static const _pages = [
    DashboardView(),
    DoctorsView(),
    ServicesView(),
    AppointmentsView(),
    ReportsView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => IndexedStack(
        index: controller.currentIndex.value,
        children: _pages,
      )),
      bottomNavigationBar: Obx(() => AppBottomNavBar(
        currentIndex: controller.currentIndex.value,
        items: _kNavItems,
        onTap: (i) {
          HapticFeedback.lightImpact();
          controller.changeTab(i);
        },
      )),
    );
  }
}
