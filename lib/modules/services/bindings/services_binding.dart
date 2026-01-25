import 'package:clinc_app_clinc/modules/services/controllers/add_service_controller.dart';
import 'package:clinc_app_clinc/modules/services/controllers/add_specialty_controller.dart';
import 'package:clinc_app_clinc/modules/services/views/add_specialty_view.dart';
import 'package:get/get.dart';
import '../controllers/services_controller.dart';

class ServicesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ServicesController>(() => ServicesController());
    Get.lazyPut<AddServiceController>(() => AddServiceController());
    Get.lazyPut<AddSpecialtyController>(() => AddSpecialtyController());

  }
}
