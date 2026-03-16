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
import '../controllers/forgot_password_controller.dart';

class ForgotPasswordView extends GetView<ForgotPasswordController> {
  const ForgotPasswordView({super.key});

  static const _orange = Color(0xFFF59E0B);
  static const _darkOrange = Color(0xFFB45309);

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
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Column(
                children: [
                  36.verticalSpace,
                  _buildCard(),
                  32.verticalSpace,
                  GestureDetector(
                    onTap: controller.backToLogin,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.arrow_back_ios_rounded,
                          size: 13.r,
                          color: Colors.grey.shade600,
                        ),
                        6.horizontalSpace,
                        Text(
                          tr(LocaleKeys.forgot_password_buttons_back_to_login),
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Info banner
          Container(
            padding: EdgeInsets.all(14.r),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  _orange.withValues(alpha: 0.12),
                  _orange.withValues(alpha: 0.04),
                ],
              ),
              borderRadius: BorderRadius.circular(14.r),
              border: Border.all(color: _orange.withValues(alpha: 0.2)),
            ),
            child: Row(
              children: [
                Icon(Icons.info_outline_rounded, color: _orange, size: 18.r),
                10.horizontalSpace,
                Expanded(
                  child: Text(
                    'سنرسل لك رابط إعادة تعيين كلمة المرور على بريدك الإلكتروني أو رقم هاتفك',
                    style: TextStyle(
                      color: _darkOrange,
                      fontSize: 11.sp,
                      height: 1.5,
                    ),
                  ),
                ),
              ],
            ),
          ),
          20.verticalSpace,
          Form(
            key: controller.formKey,
            child: AppAuthField(
              controller: controller.identifierController,
              label: tr(LocaleKeys.forgot_password_fields_identifier_hint),
              icon: Icons.email_outlined,
              accentColor: _orange,
              keyboardType: TextInputType.emailAddress,
              inputAction: TextInputAction.done,
              onSubmitted: (_) => controller.sendResetLink(),
              validator: controller.validateRequired,
            ),
          ),
          24.verticalSpace,
          Obx(() => AppGradientButton(
            label: tr(LocaleKeys.forgot_password_buttons_submit),
            isLoading: controller.isLoading.value,
            onTap: controller.sendResetLink,
            gradient: AppGradients.amber,
            shadowColor: AppGradients.amberShadow,
          )),
        ],
      ),
    );
  }
}
