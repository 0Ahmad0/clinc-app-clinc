import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../generated/locale_keys.g.dart';
import '../../appointments/views/appointments_view.dart';
import '../../dashboard/views/dashboard_view.dart';
import '../../doctors/views/doctors_view.dart';
import '../../reports/views/reports_view.dart';
import '../../services/views/services_view.dart';
import '../controllers/main_layout_controller.dart';

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
    final theme = Theme.of(context);

    return Obx(
      () => PopScope(
        canPop: controller.currentIndex.value == 0,
        onPopInvokedWithResult: (didPop, _) {
          if (!didPop) controller.returnToDashboard();
        },
        child: Scaffold(
          body: IndexedStack(
            index: controller.currentIndex.value,
            children: _pages,
          ),
          bottomNavigationBar: DecoratedBox(
            decoration: const BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 10,
                  offset: Offset(0, -2),
                ),
              ],
            ),
            child: BottomNavigationBar(
              currentIndex: controller.currentIndex.value,
              onTap: controller.changeTab,
              type: BottomNavigationBarType.fixed,
              backgroundColor: theme.colorScheme.surface,
              selectedItemColor: theme.colorScheme.primary,
              unselectedItemColor: theme.colorScheme.onSurfaceVariant,
              showUnselectedLabels: true,
              selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
              items: [
                _navItem(
                  Icons.dashboard_outlined,
                  Icons.dashboard,
                  LocaleKeys.nav_dashboard,
                ),
                _navItem(
                  Icons.people_outline,
                  Icons.people,
                  LocaleKeys.nav_doctors,
                ),
                _navItem(
                  Icons.medical_services_outlined,
                  Icons.medical_services,
                  LocaleKeys.nav_services,
                ),
                _navItem(
                  Icons.calendar_today_outlined,
                  Icons.calendar_today,
                  LocaleKeys.nav_appointments,
                ),
                _navItem(
                  Icons.bar_chart_outlined,
                  Icons.bar_chart,
                  LocaleKeys.nav_reports,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  BottomNavigationBarItem _navItem(
    IconData icon,
    IconData activeIcon,
    String labelKey,
  ) {
    return BottomNavigationBarItem(
      icon: Icon(icon),
      activeIcon: Icon(activeIcon),
      label: tr(labelKey),
    );
  }
}
