import 'package:clinc_app_clinc/app/routes/app_routes.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    _navigateToNext();
  }

  void _navigateToNext() async {
    // ننتظر 3 ثواني لإظهار الهوية البصرية
    await Future.delayed(const Duration(seconds: 3));
    Get.toNamed(AppRoutes.onboarding);
    // هنا مستقبلاً تضع شرط: هل العيادة مسجلة دخول أم لا؟
    // if (isLoggedIn) Get.offAllNamed(Routes.DASHBOARD);
  }
}