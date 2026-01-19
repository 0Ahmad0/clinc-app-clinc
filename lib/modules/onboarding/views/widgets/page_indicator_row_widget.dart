import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/onboarding_controller.dart';
import 'page_indicator_widget.dart';

class PageIndicatorRow extends GetView<OnboardingController> {
  const PageIndicatorRow({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context); // الاعتماد على الثيم
    
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        3, // عدد الصفحات
        (index) => Obx(
          () => PageIndicator(
            isActive: controller.currentPage.value == index,
            theme: theme,
          ),
        ),
      ),
    );
  }
}