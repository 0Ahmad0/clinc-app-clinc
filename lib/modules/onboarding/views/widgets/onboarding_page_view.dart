import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/onboarding_controller.dart';
import 'onboarding_page.dart';

/// Horizontal PageView wired to [OnboardingController].
class OnboardingPageView extends GetView<OnboardingController> {
  const OnboardingPageView({super.key});

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: controller.pageController,
      itemCount: OnboardingController.pagesCount,
      onPageChanged: controller.onPageChanged,
      physics: const BouncingScrollPhysics(),
      itemBuilder: (_, i) => OnboardingPage(index: i),
    );
  }
}
