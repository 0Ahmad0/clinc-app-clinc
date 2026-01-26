import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app/routes/app_routes.dart';

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

  void skip() {
    // TODO: save onboarding seen flag
    Get.offAllNamed(AppRoutes.login);
  }

  void getStarted() {
    // TODO: save onboarding seen flag
    Get.offAllNamed(AppRoutes.login);
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}