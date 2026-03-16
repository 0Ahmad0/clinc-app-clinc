import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../app/core/design/app_gradients.dart';
import '../../../app/core/widgets/app_gradient_button.dart';
import '../../../app/core/widgets/app_auth_field.dart';
import '../../../app/core/widgets/app_gradient_header.dart';
import '../../../generated/locale_keys.g.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

  static const _teal = Color(0xFF009688);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      body: Column(
        children: [
          AppGradientHeader(
            gradient: AppGradients.teal,
            icon: Icons.local_hospital_rounded,
            title: tr(LocaleKeys.login_title),
            subtitle: tr(LocaleKeys.login_subtitle),
          ),
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Column(
                children: [
                  28.verticalSpace,
                  _buildCard(),
                  24.verticalSpace,
                  _buildRegisterRow(),
                  24.verticalSpace,
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCard() {
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

  Widget _buildRegisterRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          tr(LocaleKeys.login_buttons_register_text),
          style: TextStyle(color: Colors.grey.shade600, fontSize: 13.sp),
        ),
        6.horizontalSpace,
        GestureDetector(
          onTap: controller.toRegister,
          child: Text(
            tr(LocaleKeys.login_buttons_register_action),
            style: TextStyle(
              color: _teal,
              fontSize: 13.sp,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
      ],
    );
  }
}
