import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../../generated/locale_keys.g.dart';

class ForgotPasswordController extends GetxController {
  // ── Text Controllers ──
  final TextEditingController identifierController = TextEditingController();

  // ── State Variables ──
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final RxBool isLoading = false.obs;

  // ── Actions ──

  Future<void> sendResetLink() async {
    if (!formKey.currentState!.validate()) return;

    try {
      isLoading.value = true;

      // Simulate API Call
      await Future.delayed(const Duration(seconds: 2));

      // TODO: Call API to send OTP or Reset Link

      Get.snackbar(
        tr(LocaleKeys.forgot_password_title),
        tr(LocaleKeys.forgot_password_messages_success),
        backgroundColor: Colors.green.withOpacity(0.1),
        colorText: Colors.green,
        duration: const Duration(seconds: 4),
      );

      // يمكن التوجيه لصفحة إدخال الـ OTP
      // Get.toNamed(Routes.OTP_VERIFICATION, arguments: identifierController.text);
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  void backToLogin() {
    Get.back();
  }

  // ── Validators ──
  String? validateRequired(String? value) {
    if (value == null || value.isEmpty) {
      return tr(LocaleKeys.forgot_password_messages_required_field);
    }
    // يمكن إضافة تحقق من صحة البريد الإلكتروني هنا إذا لزم الأمر
    return null;
  }

  @override
  void onClose() {
    identifierController.dispose();
    super.onClose();
  }
}
