import 'package:clinc_app_clinc/modules/appointments/views/appointments_view.dart';
import 'package:clinc_app_clinc/modules/doctors/views/doctors_view.dart';
import 'package:clinc_app_clinc/modules/reports/views/reports_view.dart';
import 'package:clinc_app_clinc/modules/services/views/services_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../generated/locale_keys.g.dart';
import '../../dashboard/views/dashboard_view.dart';
import '../controllers/main_layout_controller.dart';

class MainLayoutView extends GetView<MainLayoutController> {
  const MainLayoutView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: Obx(
        () => IndexedStack(
          index: controller.currentIndex.value,
          children: const [
            DashboardView(), // 0
            DoctorsView(),
            ServicesView(),
            AppointmentsView(),
            ReportsView()
          ],
        ),
      ),

      bottomNavigationBar: Obx(
        () => Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 10,
                offset: const Offset(0, -2),
              ),
            ],
          ),
          child: BottomNavigationBar(
            currentIndex: controller.currentIndex.value,
            onTap: controller.changeTab,
            type: BottomNavigationBarType.fixed,
            // لأن عندنا 5 عناصر
            backgroundColor: theme.colorScheme.surface,
            selectedItemColor: theme.colorScheme.primary,
            unselectedItemColor: Colors.grey,
            showUnselectedLabels: true,
            selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
            items: [
              _buildNavItem(
                Icons.dashboard_outlined,
                Icons.dashboard,
                LocaleKeys.nav_dashboard,
              ),
              _buildNavItem(
                Icons.people_outline,
                Icons.people,
                LocaleKeys.nav_doctors,
              ),
              _buildNavItem(
                Icons.medical_services_outlined,
                Icons.medical_services,
                LocaleKeys.nav_services,
              ), // Services فالنصف عادةً
              _buildNavItem(
                Icons.calendar_today_outlined,
                Icons.calendar_today,
                LocaleKeys.nav_appointments,
              ),
              _buildNavItem(
                Icons.bar_chart_outlined,
                Icons.bar_chart,
                LocaleKeys.nav_reports,
              ),
            ],
          ),
        ),
      ),
    );
  }

  BottomNavigationBarItem _buildNavItem(
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
