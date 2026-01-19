import 'package:clinc_app_clinc/app/core/widgets/app_text_filed_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../generated/locale_keys.g.dart';
import '../../controllers/register_controller.dart';

class RegisterFormWidget extends GetView<RegisterController> {
  const RegisterFormWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: controller.formKey,
      child: Column(
        children: [
          // Name
          AppTextFormFieldWidget(
            controller: controller.nameController,
            hintText: tr(LocaleKeys.register_fields_clinic_name_hint),
            prefixIcon: Icons.local_hospital_outlined, // أو SVG إذا عندك
            validator: controller.validateRequired,
            textInputAction: TextInputAction.next,
          ),
          16.verticalSpace,

          // License
          AppTextFormFieldWidget(
            controller: controller.licenseController,
            hintText: tr(LocaleKeys.register_fields_license_hint),
            prefixIcon: Icons.badge_outlined,
            validator: controller.validateRequired,
            textInputAction: TextInputAction.next,
          ),
          16.verticalSpace,

          // Password
          Obx(() => AppTextFormFieldWidget(
            controller: controller.passwordController,
            prefixIcon: Icons.lock_outline,
            isPassword: controller.isPassHidden.value,
            hintText: tr(LocaleKeys.register_fields_password),
            validator: controller.validateRequired,
            textInputAction: TextInputAction.next,
          )),
          16.verticalSpace,

          // Confirm Password
          Obx(() => AppTextFormFieldWidget(
            controller: controller.confirmPasswordController,
            prefixIcon: Icons.lock_reset_outlined,
            hintText: tr(LocaleKeys.register_fields_confirm_password),
            isPassword: controller.isConfirmPassHidden.value,
            validator: controller.validateConfirmPassword,
            textInputAction: TextInputAction.done,
            onFieldSubmitted: (_) => controller.register(),
          )),
        ],
      ),
    );
  }
}