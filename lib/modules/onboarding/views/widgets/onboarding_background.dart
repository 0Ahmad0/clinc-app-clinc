import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/onboarding_controller.dart';

/// Full-screen animated gradient that transitions between onboarding pages.
class OnboardingBackground extends GetView<OnboardingController> {
  const OnboardingBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => AnimatedContainer(
      duration: const Duration(milliseconds: 400),
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomCenter,
          colors: controller.gradientForPage(controller.currentIndex.value),
          stops: const [0.0, 0.55, 1.0],
        ),
      ),
    ));
  }
}
