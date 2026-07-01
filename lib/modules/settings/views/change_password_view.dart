import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../controllers/change_password_controller.dart';

class ChangePasswordView extends GetView<ChangePasswordController> {
  const ChangePasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(tr('settings.change_password.title'))),
      body: Form(
        key: controller.formKey,
        child: ListView(
          padding: EdgeInsets.all(20.w),
          children: [
            Obx(
              () => _PasswordField(
                controller: controller.currentPasswordController,
                label: tr('settings.change_password.current'),
                obscure: controller.obscureCurrent.value,
                onToggle: controller.obscureCurrent.toggle,
                validator: controller.validateRequired,
              ),
            ),
            16.verticalSpace,
            Obx(
              () => _PasswordField(
                controller: controller.newPasswordController,
                label: tr('settings.change_password.new'),
                obscure: controller.obscureNew.value,
                onToggle: controller.obscureNew.toggle,
                validator: controller.validateRequired,
              ),
            ),
            16.verticalSpace,
            Obx(
              () => _PasswordField(
                controller: controller.confirmationController,
                label: tr('settings.change_password.confirmation'),
                obscure: controller.obscureConfirmation.value,
                onToggle: controller.obscureConfirmation.toggle,
                validator: controller.validateConfirmation,
              ),
            ),
            28.verticalSpace,
            Obx(
              () => FilledButton(
                onPressed: controller.isLoading.value
                    ? null
                    : controller.submit,
                child: controller.isLoading.value
                    ? const SizedBox.square(
                        dimension: 22,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : Text(tr('settings.change_password.submit')),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PasswordField extends StatelessWidget {
  const _PasswordField({
    required this.controller,
    required this.label,
    required this.obscure,
    required this.onToggle,
    required this.validator,
  });

  final TextEditingController controller;
  final String label;
  final bool obscure;
  final VoidCallback onToggle;
  final FormFieldValidator<String> validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscure,
      validator: validator,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: const Icon(Icons.lock_outline),
        suffixIcon: IconButton(
          onPressed: onToggle,
          icon: Icon(
            obscure ? Icons.visibility_outlined : Icons.visibility_off,
          ),
        ),
      ),
    );
  }
}
