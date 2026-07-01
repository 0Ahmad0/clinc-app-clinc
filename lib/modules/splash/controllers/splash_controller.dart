import 'package:get/get.dart';

import '../../../app/routes/app_routes.dart';
import '../../../app/services/storage_service.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    _navigate();
    super.onInit();
  }

  Future<void> _navigate() async {
    await Future<void>.delayed(const Duration(seconds: 2));
    if (StorageService.instance.getAccessToken().isNotEmpty) {
      Get.offAllNamed(AppRoutes.mainLayout);
      return;
    }
    Get.offAllNamed(
      StorageService.instance.hasSeenOnboarding
          ? AppRoutes.login
          : AppRoutes.onboarding,
    );
  }
}
