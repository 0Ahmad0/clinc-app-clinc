import 'package:clinc_app_clinc/app/routes/app_routes.dart';
import 'package:clinc_app_clinc/modules/settings/controllers/settings_controller.dart';
import 'package:get/get.dart';

import '../../../app/services/storage_service.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    // _navigateToNext();
    initSplash();
  }

  void _navigateToNext() async {
    // ننتظر 3 ثواني لإظهار الهوية البصرية
    await Future.delayed(const Duration(seconds: 3));
    Get.toNamed(AppRoutes.onboarding);
    // هنا مستقبلاً تضع شرط: هل العيادة مسجلة دخول أم لا؟
    // if (isLoggedIn) Get.offAllNamed(Routes.DASHBOARD);
  }

  Future<void> _loadSplash() async {
    // final langCode = StorageService.instance.getLangCode();
    // Get.updateLocale(Locale(langCode));
    // await NotificationService.instance.init();
    // getToken();

    if (StorageService.instance.getAccessToken().isNotEmpty) {
      SettingsController settingsController = Get.put(SettingsController());
      await settingsController.getProfile();
    } else {
      await Future.delayed(const Duration(seconds: 3), () {
        Get.offNamed(AppRoutes.onboarding);
      });
    }
  }

  Future<void> _initSplash() async {

  }

  Future<void> initSplash() async {
    await _initSplash();
    await _loadSplash();
  }
}