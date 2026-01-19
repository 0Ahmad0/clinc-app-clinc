import 'package:clinc_app_clinc/app/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../../generated/locale_keys.g.dart';

class LoginController extends GetxController {
  // ── Text Controllers ──
  final TextEditingController identifierController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // ── State Variables ──
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final RxBool isLoading = false.obs;
  final RxBool isPassHidden = true.obs;

  // ── Actions ──
  void togglePassVisibility() => isPassHidden.toggle();

  Future<void> login() async {
    if (!formKey.currentState!.validate()) return;

    try {
      isLoading.value = true;

      // محاكاة الاتصال بالسيرفر
      await Future.delayed(const Duration(seconds: 2));

      // TODO: API Call -> Get Token -> Save Token

      Get.snackbar(
        tr(LocaleKeys.login_title),
        tr(LocaleKeys.login_messages_success),
        backgroundColor: Colors.green.withOpacity(0.1),
        colorText: Colors.green,
      );

      // التوجيه للشاشة الرئيسية
      // Get.offAllNamed(Routes.HOME);

    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  void toRegister() {
    Get.offAllNamed(AppRoutes.register);
  }

  void toForgotPassword() {
    // التوجيه لصفحة استعادة كلمة المرور
    Get.toNamed(AppRoutes.forgotPassword);
  }

  // ── Validators ──
  String? validateRequired(String? value) {
    if (value == null || value.isEmpty) {
      return tr(LocaleKeys.login_messages_required_field);
    }
    return null;
  }

  @override
  void onClose() {
    identifierController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}