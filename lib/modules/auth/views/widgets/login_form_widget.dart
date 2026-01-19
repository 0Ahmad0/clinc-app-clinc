import 'package:clinc_app_clinc/app/core/widgets/app_text_filed_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../app/core/widgets/app_text_button_widget.dart';
import '../../../../generated/locale_keys.g.dart';
import '../../controllers/login_controller.dart';

class LoginFormWidget extends GetView<LoginController> {
  const LoginFormWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: controller.formKey,
      child: Column(
        children: [
          // Identifier (Email/License)
          AppTextFormFieldWidget(
            controller: controller.identifierController,
            hintText: tr(LocaleKeys.login_fields_identifier_hint),
            prefixIcon: Icons.email_outlined,
            // أو badge_outlined
            validator: controller.validateRequired,
            textInputAction: TextInputAction.next,
          ),
          16.verticalSpace,

          // Password
          Obx(
            () => AppTextFormFieldWidget(
              controller: controller.passwordController,
              prefixIcon: Icons.lock_outline,
              hintText: tr(LocaleKeys.login_fields_password),
              isPassword: controller.isPassHidden.value,
              validator: controller.validateRequired,
              textInputAction: TextInputAction.done,
              onFieldSubmitted: (_) => controller.login(),
            ),
          ),

          8.verticalSpace,

          // Forgot Password
          Align(
            alignment: AlignmentDirectional.centerEnd,
            child: AppTextButtonWidget(
              text: tr(LocaleKeys.login_fields_forgot_password),
              onPressed: controller.toForgotPassword,
              // يمكن إضافة ستايل خاص لتصغير الخط قليلاً
              // style: TextStyle(fontSize: 12.sp),
            ),
          ),
        ],
      ),
    );
  }
}
