import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../../generated/locale_keys.g.dart'; // تأكد من المسار الصحيح للملف المولد

class RegisterController extends GetxController {
  // ── Text Controllers ──
  final TextEditingController nameController = TextEditingController();
  final TextEditingController licenseController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  // ── State Variables ──
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final RxBool isLoading = false.obs;
  final RxBool isPassHidden = true.obs;
  final RxBool isConfirmPassHidden = true.obs;

  // ── Actions ──
  void togglePassVisibility() => isPassHidden.toggle();
  void toggleConfirmPassVisibility() => isConfirmPassHidden.toggle();

  Future<void> register() async {
    if (!formKey.currentState!.validate()) return;

    try {
      isLoading.value = true;

      // Simulate API Call
      await Future.delayed(const Duration(seconds: 2));

      // TODO: Send to Backend -> Status: Pending

      Get.snackbar(
        tr(LocaleKeys.register_title), // أو أي عنوان عام للنجاح
        tr(LocaleKeys.register_messages_success),
        backgroundColor: Colors.green.withOpacity(0.1),
        colorText: Colors.green,
      );

      // Navigate to 'Pending Approval' Screen
      // Get.offAllNamed(Routes.PENDING);

    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  // ── Validators ──
  String? validateRequired(String? value) {
    if (value == null || value.isEmpty) {
      return tr(LocaleKeys.register_messages_required_field);
    }
    return null;
  }

  String? validateConfirmPassword(String? value) {
    if (value != passwordController.text) {
      return tr(LocaleKeys.register_messages_password_mismatch);
    }
    return null;
  }

  @override
  void onClose() {
    nameController.dispose();
    licenseController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}