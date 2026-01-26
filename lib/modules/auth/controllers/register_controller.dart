import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../../app/data/account_type.dart';
import '../../../generated/locale_keys.g.dart';

class RegisterController extends GetxController {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController licenseController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final RxBool isLoading = false.obs;
  final RxBool isPassHidden = true.obs;
  final RxBool isConfirmPassHidden = true.obs;

  final Rxn<AccountType> selectedAccountType = Rxn<AccountType>();

  void selectAccountType(AccountType type) => selectedAccountType.value = type;

  String? validateRequired(String? value) {
    if (value == null || value.trim().isEmpty) {
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

  String? validateAccountType() {
    if (selectedAccountType.value == null) {
      return tr(LocaleKeys.register_messages_type_required);
    }
    return null;
  }

  Future<void> register() async {
    final ok = formKey.currentState?.validate() ?? false;
    if (!ok) return;

    // تحقق نوع الحساب
    if (validateAccountType() != null) {
      Get.snackbar('Error', tr(LocaleKeys.register_messages_type_required));
      return;
    }

    try {
      isLoading.value = true;

      // TODO: call API
      // payload: name, license, password, accountType = selectedAccountType.value

      await Future.delayed(const Duration(seconds: 1));

      // بعدها: Pending Approval
      // Get.offAllNamed(AppRoutes.pendingApproval);

    } finally {
      isLoading.value = false;
    }
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