import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../../generated/locale_keys.g.dart';
import '../controllers/onboarding_controller.dart';
import 'widgets/onboarding_footer_widget.dart';
import 'widgets/onboarding_header_widget.dart';
import 'widgets/onboarding_page_item_widget.dart';

class OnboardingView extends GetView<OnboardingController> {
  const OnboardingView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            OnboardingHeader(theme: theme),
            Expanded(
              child: PageView.builder(
                controller: controller.pageController,
                onPageChanged: controller.onPageChanged,
                itemCount: 3,
                itemBuilder: (context, index) {
                  return OnboardingPageItem(index: index, theme: theme);
                },
              ),
            ),
            OnboardingFooter(theme: theme),
            30.verticalSpace,
          ],
        ),
      ),
    );
  }
}
