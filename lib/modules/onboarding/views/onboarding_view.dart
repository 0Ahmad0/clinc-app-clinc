import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:clinc_app_clinc/generated/locale_keys.g.dart';
import '../controllers/onboarding_controller.dart';
import 'widgets/onboarding_bottom_bar_widget.dart';
import 'widgets/onboarding_page_widget.dart';
import 'widgets/onboarding_top_bar_widget.dart';

class OnboardingView extends GetView<OnboardingController> {
  const OnboardingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const OnboardingTopBarWidget(),
            10.verticalSpace,
            Expanded(
              child: PageView.builder(
                controller: controller.pageController,
                itemCount: OnboardingController.pagesCount,
                onPageChanged: controller.onPageChanged,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  return OnboardingPageWidget(index: index);
                },
              ),
            ),

            const OnboardingBottomBarWidget(),
            16.verticalSpace,
          ],
        ),
      ),
    );
  }
}
