import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:clinc_app_clinc/generated/locale_keys.g.dart';

import '../../controllers/onboarding_controller.dart';

class OnboardingBottomBarWidget extends GetView<OnboardingController> {
  const OnboardingBottomBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Obx(() {
        final idx = controller.currentIndex.value;
        final isLast = controller.isLast;

        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                OnboardingController.pagesCount,
                (i) => AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  margin: EdgeInsets.only(right: 8.w),
                  height: 8.h,
                  width: i == idx ? 22.w : 8.w,
                  decoration: BoxDecoration(
                    color: i == idx ? cs.primary : cs.outlineVariant,
                    borderRadius: BorderRadius.circular(99),
                  ),
                ),
              ),
            ),
            20.verticalSpace,
            ElevatedButton(
              onPressed: isLast ? controller.getStarted : controller.next,
              style: ElevatedButton.styleFrom(
                backgroundColor: cs.primary,
                foregroundColor: cs.onPrimary,
                padding: EdgeInsets.symmetric(horizontal: 18.w),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14.r),
                ),
              ),
              child: Text(
                isLast
                    ? tr(LocaleKeys.onboarding_get_started)
                    : tr(LocaleKeys.onboarding_next),
                style: theme.textTheme.labelLarge?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
