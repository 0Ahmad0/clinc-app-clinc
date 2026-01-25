import 'package:clinc_app_clinc/modules/appointments/bindings/appointments_binding.dart';
import 'package:clinc_app_clinc/modules/appointments/controllers/appointment_details_controller.dart';
import 'package:clinc_app_clinc/modules/dashboard/bindings/dashboard_binding.dart';
import 'package:clinc_app_clinc/modules/doctors/bindings/doctors_binding.dart';
import 'package:clinc_app_clinc/modules/reports/bindings/reports_binding.dart';
import 'package:clinc_app_clinc/modules/services/bindings/services_binding.dart';
import 'package:get/get.dart';
import '../controllers/main_layout_controller.dart';

class MainLayoutBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MainLayoutController>(() => MainLayoutController());
    Get.lazyPut<AppointmentDetailsController>(() => AppointmentDetailsController());
    DashboardBinding().dependencies();
    DoctorsBinding().dependencies();
    ServicesBinding().dependencies();
    AppointmentsBinding().dependencies();
    ReportsBinding().dependencies();


  }
}
