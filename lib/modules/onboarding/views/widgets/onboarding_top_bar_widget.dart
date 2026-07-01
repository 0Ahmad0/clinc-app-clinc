import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:clinc_app_clinc/generated/locale_keys.g.dart';

import '../../controllers/onboarding_controller.dart';

class OnboardingTopBarWidget extends GetView<OnboardingController> {
  const OnboardingTopBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional.centerEnd,
      child: TextButton(
        onPressed: controller.skip,
        child: Text(tr(LocaleKeys.onboarding_skip)),
      ),
    );
  }
}
