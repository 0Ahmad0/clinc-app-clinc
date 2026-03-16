import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../app/core/design/app_gradients.dart';
import '../../../app/core/widgets/app_gradient_header.dart';
import '../../../generated/locale_keys.g.dart';
import '../controllers/forgot_password_controller.dart';
import 'widgets/forgot_password_card.dart';
import 'widgets/forgot_password_nav_row.dart';

class ForgotPasswordView extends GetView<ForgotPasswordController> {
  const ForgotPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      body: Column(
        children: [
          AppGradientHeader(
            gradient: AppGradients.amber,
            icon: Icons.lock_reset_rounded,
            iconCircleSize: 76,
            iconSize: 38,
            title: tr(LocaleKeys.forgot_password_title),
            subtitle: tr(LocaleKeys.forgot_password_subtitle),
            leading: const AppHeaderBackButton(),
          ),
          Expanded(
            child: SingleChildScrollView(
               
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Column(
                children: [
                  36.verticalSpace,
                  ForgotPasswordCard(controller: controller),
                  32.verticalSpace,
                  ForgotPasswordNavRow(onBackToLogin: controller.backToLogin),
                  24.verticalSpace,
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
