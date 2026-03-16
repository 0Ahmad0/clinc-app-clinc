import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../appointments/views/appointments_view.dart';
import '../../../dashboard/views/dashboard_view.dart';
import '../../../doctors/views/doctors_view.dart';
import '../../../reports/views/reports_view.dart';
import '../../../services/views/services_view.dart';
import '../../controllers/main_layout_controller.dart';

/// Renders the currently selected tab via IndexedStack (all tabs stay alive).
class MainLayoutPages extends GetView<MainLayoutController> {
  const MainLayoutPages({super.key});

  // const singletons — built once, never rebuilt
  static const _pages = <Widget>[
    DashboardView(),
    DoctorsView(),
    ServicesView(),
    AppointmentsView(),
    ReportsView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Obx(() => IndexedStack(
      index: controller.currentIndex.value,
      children: _pages,
    ));
  }
}
