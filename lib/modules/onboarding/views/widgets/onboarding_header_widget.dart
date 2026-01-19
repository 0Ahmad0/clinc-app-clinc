import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../generated/locale_keys.g.dart';
import '../../controllers/onboarding_controller.dart';


class OnboardingHeader extends GetView<OnboardingController> {
  final ThemeData theme;
  const OnboardingHeader({super.key, required this.theme});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      alignment: Alignment.centerLeft,
      child: TextButton(
        onPressed: controller.skip,
        child: Text(
          tr(LocaleKeys.onboarding_skip),
          style: theme.textTheme.bodyLarge?.copyWith(
            color: theme.primaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}