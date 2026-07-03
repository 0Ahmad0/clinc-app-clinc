import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../../app/core/configuration/locator.dart';
import '../../../app/core/helper/response_helper.dart';
import '../../../app/domain/error_handler/network_exceptions.dart';
import '../../../app/routes/app_routes.dart';
import '../../../generated/locale_keys.g.dart';
import '../data/clinic_auth_model.dart';
import '../domain/repositories/clinic_auth_repository.dart';

class ResetPasswordController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final passwordController = TextEditingController();
  final confirmationController = TextEditingController();
  final isLoading = false.obs;
  final obscurePassword = true.obs;
  final obscureConfirmation = true.obs;
  late final ClinicAuthRepository _repository;

  String get identifier =>
      (Get.arguments as Map?)?['identifier']?.toString() ?? '';
  String get resetToken =>
      (Get.arguments as Map?)?['reset_token']?.toString() ?? '';

  @override
  void onInit() {
    _repository = locator<ClinicAuthRepository>();
    super.onInit();
  }

  String? validatePassword(String? value) {
    if (value == null || value.length < 8) {
      return tr(LocaleKeys.settings_change_password_min_length);
    }
    return null;
  }

  String? validateConfirmation(String? value) {
    final error = validatePassword(value);
    if (error != null) return error;
    if (value != passwordController.text) {
      return tr(LocaleKeys.settings_change_password_confirmation_mismatch);
    }
    return null;
  }

  Future<void> submit() async {
    if (isLoading.value || !(formKey.currentState?.validate() ?? false)) return;
    if (identifier.isEmpty || resetToken.isEmpty) {
      ResponseHelper.onFailure(message: 'Invalid or expired reset session');
      return;
    }
    isLoading.value = true;
    final result = await _repository.resetPassword(
      ResetPasswordRequest(
        identifier: identifier,
        resetToken: resetToken,
        password: passwordController.text,
        passwordConfirmation: confirmationController.text,
      ),
    );
    isLoading.value = false;
    result.when(
      success: (response) {
        if (!response.isSuccess) {
          ResponseHelper.onFailure(message: response.message);
          return;
        }
        ResponseHelper.onSuccess(message: response.message);
        Get.offAllNamed(AppRoutes.login);
      },
      failure: (exception) => ResponseHelper.onFailure(
        message: NetworkExceptions.getErrorMessage(exception),
      ),
    );
  }

  @override
  void onClose() {
    passwordController.dispose();
    confirmationController.dispose();
    super.onClose();
  }
}
