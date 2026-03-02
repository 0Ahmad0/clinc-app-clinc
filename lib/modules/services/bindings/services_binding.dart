import 'package:get/get.dart';
import '../controllers/services_controller.dart';
import '../views/services_view.dart';

class ServicesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ServicesController>(() => ServicesController());

  }
}
