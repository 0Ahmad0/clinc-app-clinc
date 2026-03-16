import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../../app/core/widgets/app_auth_field.dart';
import '../../../../app/core/widgets/app_form_section_label.dart';
import '../../../../generated/locale_keys.g.dart';
import '../../controllers/register_controller.dart';

class RegisterFormCard extends StatelessWidget {
  final RegisterController controller;
  const RegisterFormCard({super.key, required this.controller});

  static const _indigo = Color(0xFF3949AB);
  static const _teal = Color(0xFF009688);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: EdgeInsets.all(20.r),
      child: Form(
        key: controller.formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const AppFormSectionLabel(
              label: 'معلومات العيادة',
              icon: Icons.business_rounded,
              color: _teal,
            ),
            12.verticalSpace,
            AppAuthField(
              controller: controller.nameController,
              label: tr(LocaleKeys.register_fields_clinic_name_hint),
              icon: Icons.local_hospital_outlined,
              validator: controller.validateRequired,
            ),
            14.verticalSpace,
            AppAuthField(
              controller: controller.licenseController,
              label: tr(LocaleKeys.register_fields_license_hint),
              icon: Icons.badge_outlined,
              validator: controller.validateRequired,
            ),
            22.verticalSpace,
            const AppFormSectionLabel(
              label: 'كلمة المرور',
              icon: Icons.lock_rounded,
              color: _indigo,
            ),
            12.verticalSpace,
            AppAuthField(
              controller: controller.passwordController,
              label: tr(LocaleKeys.register_fields_password),
              icon: Icons.lock_outline,
              isPassword: true,
              accentColor: _indigo,
              validator: controller.validateRequired,
            ),
            14.verticalSpace,
            AppAuthField(
              controller: controller.confirmPasswordController,
              label: tr(LocaleKeys.register_fields_confirm_password),
              icon: Icons.lock_reset_outlined,
              isPassword: true,
              accentColor: _indigo,
              validator: controller.validateConfirmPassword,
              inputAction: TextInputAction.done,
            ),
          ],
        ),
      ),
    );
  }
}
