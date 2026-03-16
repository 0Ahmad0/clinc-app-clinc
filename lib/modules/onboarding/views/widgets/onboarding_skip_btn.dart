import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../generated/locale_keys.g.dart';
import '../../controllers/onboarding_controller.dart';

/// Animated skip button — fades out on the last page.
class OnboardingSkipBtn extends GetView<OnboardingController> {
  const OnboardingSkipBtn({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
      child: Align(
        alignment: AlignmentDirectional.centerEnd,
        child: Obx(() => AnimatedOpacity(
          duration: const Duration(milliseconds: 200),
          opacity: controller.isLast ? 0.0 : 1.0,
          child: TextButton(
            onPressed: controller.skip,
            style: TextButton.styleFrom(
              foregroundColor: Colors.white.withValues(alpha: 0.85),
              padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 6.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.r),
                side: BorderSide(color: Colors.white.withValues(alpha: 0.4)),
              ),
            ),
            child: Text(
              tr(LocaleKeys.onboarding_skip),
              style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w600),
            ),
          ),
        )),
      ),
    );
  }
}
