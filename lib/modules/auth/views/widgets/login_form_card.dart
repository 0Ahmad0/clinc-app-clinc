import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../../app/core/design/app_gradients.dart';
import '../../../../app/core/widgets/app_gradient_button.dart';
import '../../../../app/core/widgets/app_auth_field.dart';
import '../../../../generated/locale_keys.g.dart';
import '../../controllers/login_controller.dart';

class LoginFormCard extends StatelessWidget {
  final LoginController controller;
  const LoginFormCard({super.key, required this.controller});

  static const _teal = Color(0xFF009688);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.07),
            blurRadius: 24,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      padding: EdgeInsets.all(22.r),
      child: Form(
        key: controller.formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppAuthField(
              controller: controller.identifierController,
              label: tr(LocaleKeys.login_fields_identifier_hint),
              icon: Icons.email_outlined,
              inputAction: TextInputAction.next,
              validator: controller.validateRequired,
            ),
            16.verticalSpace,
            Obx(() => AppAuthField(
              controller: controller.passwordController,
              label: tr(LocaleKeys.login_fields_password),
              icon: Icons.lock_outline,
              isPassword: true,
              inputAction: TextInputAction.done,
              validator: controller.validateRequired,
              onSubmitted: (_) => controller.login(),
            )),
            6.verticalSpace,
            Align(
              alignment: AlignmentDirectional.centerEnd,
              child: TextButton(
                onPressed: controller.toForgotPassword,
                style: TextButton.styleFrom(foregroundColor: _teal),
                child: Text(
                  tr(LocaleKeys.login_fields_forgot_password),
                  style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w600),
                ),
              ),
            ),
            16.verticalSpace,
            Obx(() => AppGradientButton(
              label: tr(LocaleKeys.login_buttons_login),
              isLoading: controller.isLoading.value,
              onTap: controller.login,
              gradient: AppGradients.teal,
              shadowColor: AppGradients.tealShadow,
            )),
          ],
        ),
      ),
    );
  }
}
