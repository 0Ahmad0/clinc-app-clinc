import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../generated/locale_keys.g.dart';
import '../../controllers/onboarding_controller.dart';
import 'page_indicator_row_widget.dart';

class OnboardingFooter extends GetView<OnboardingController> {
  final ThemeData theme;

  const OnboardingFooter({super.key, required this.theme});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // النقاط المؤشرة (Indicator)
          const PageIndicatorRow(),

          // زر الانتقال
          ElevatedButton(
            onPressed: controller.nextStep,
            style: theme.elevatedButtonTheme.style?.copyWith(
              minimumSize: WidgetStateProperty.all(
                Size(150.w, 54.h),
              ), // استخدام ScreenUtil
            ),
            child: Obx(
              () => Text(
                tr(
                  controller.currentPage.value == 2
                      ? LocaleKeys.onboarding_get_started
                      : LocaleKeys.onboarding_next,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
