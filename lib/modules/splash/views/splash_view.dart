import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../../generated/locale_keys.g.dart';
import '../controllers/splash_controller.dart';
import 'widgets/background_gradient_widget.dart';
import 'widgets/footer_loading_widget.dart';
import 'widgets/main_logo_section_widget.dart';
import 'widgets/welcome_text_widget.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.find<SplashController>();
    final theme = Theme.of(context);

    return Scaffold(
      body: Stack(
        children: [
          BackgroundGradient(theme: theme),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MainLogoSection(theme: theme),
                30.verticalSpace,
                WelcomeText(theme: theme),
              ],
            ),
          ),
          FooterLoadingWidget(theme: theme),
        ],
      ),
    );
  }
}
