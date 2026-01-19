import 'package:clinc_app_clinc/modules/dashboard/bindings/dashboard_binding.dart';
import 'package:clinc_app_clinc/modules/doctors/bindings/doctors_binding.dart';
import 'package:get/get.dart';
import '../controllers/main_layout_controller.dart';

class MainLayoutBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MainLayoutController>(() => MainLayoutController());
    DashboardBinding().dependencies();
    DoctorsBinding().dependencies();

  }
}
