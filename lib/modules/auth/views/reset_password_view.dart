import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../../generated/locale_keys.g.dart';
import '../controllers/reset_password_controller.dart';

class ResetPasswordView extends GetView<ResetPasswordController> {
  const ResetPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(tr(LocaleKeys.settings_change_password_title)),
      ),
      body: Form(
        key: controller.formKey,
        child: ListView(
          padding: const EdgeInsets.all(24),
          children: [
            Obx(
              () => TextFormField(
                controller: controller.passwordController,
                obscureText: controller.obscurePassword.value,
                validator: controller.validatePassword,
                decoration: InputDecoration(
                  labelText: tr(LocaleKeys.settings_change_password_new),
                  prefixIcon: const Icon(Icons.lock_outline),
                  suffixIcon: IconButton(
                    onPressed: controller.obscurePassword.toggle,
                    icon: Icon(
                      controller.obscurePassword.value
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Obx(
              () => TextFormField(
                controller: controller.confirmationController,
                obscureText: controller.obscureConfirmation.value,
                validator: controller.validateConfirmation,
                decoration: InputDecoration(
                  labelText: tr(
                    LocaleKeys.settings_change_password_confirmation,
                  ),
                  prefixIcon: const Icon(Icons.lock_outline),
                  suffixIcon: IconButton(
                    onPressed: controller.obscureConfirmation.toggle,
                    icon: Icon(
                      controller.obscureConfirmation.value
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 28),
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
                    : Text(tr(LocaleKeys.settings_change_password_submit)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
