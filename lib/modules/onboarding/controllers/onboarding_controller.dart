import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app/routes/app_routes.dart';
import '../../../app/services/storage_service.dart';

class OnboardingController extends GetxController {
  static const int pagesCount = 3;

  final PageController pageController = PageController();
  final RxInt currentIndex = 0.obs;

  bool get isLast => currentIndex.value == pagesCount - 1;

  void onPageChanged(int i) => currentIndex.value = i;

  void next() {
    if (isLast) return;
    pageController.nextPage(
      duration: const Duration(milliseconds: 280),
      curve: Curves.easeOutCubic,
    );
  }

  Future<void> skip() async {
    await StorageService.instance.setOnboardingSeen();
    Get.offAllNamed(AppRoutes.login);
  }

  Future<void> getStarted() async {
    await StorageService.instance.setOnboardingSeen();
    Get.offAllNamed(AppRoutes.login);
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}
