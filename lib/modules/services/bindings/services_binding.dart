import 'package:get/get.dart';
import '../views/services_view.dart';

class ServicesBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<ServicesController>(ServicesController(), permanent: true);
  }
}
