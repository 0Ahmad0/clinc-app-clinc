import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app/core/configuration/locator.dart';
import '../../../app/core/helper/response_helper.dart';
import '../../../app/domain/error_handler/network_exceptions.dart';
import '../domain/settings_repository.dart';

class ChangePasswordController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final currentPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmationController = TextEditingController();
  final isLoading = false.obs;
  final obscureCurrent = true.obs;
  final obscureNew = true.obs;
  final obscureConfirmation = true.obs;
  late final SettingsRepository _repository;

  @override
  void onInit() {
    _repository = locator<SettingsRepository>();
    super.onInit();
  }

  String? validateRequired(String? value) {
    if (value == null || value.trim().isEmpty) {
      return tr('settings.validation_required');
    }
    if (value.length < 8) return tr('settings.change_password.min_length');
    return null;
  }

  String? validateConfirmation(String? value) {
    final required = validateRequired(value);
    if (required != null) return required;
    if (value != newPasswordController.text) {
      return tr('settings.change_password.confirmation_mismatch');
    }
    return null;
  }

  Future<void> submit() async {
    if (isLoading.value || !(formKey.currentState?.validate() ?? false)) return;
    isLoading.value = true;
    final result = await _repository.changePassword(
      currentPassword: currentPasswordController.text,
      newPassword: newPasswordController.text,
      passwordConfirmation: confirmationController.text,
    );
    isLoading.value = false;
    result.when(
      success: (model) {
        if (model.status != 'success') {
          ResponseHelper.onFailure(message: model.message);
          return;
        }
        ResponseHelper.onSuccess(message: model.message);
        Get.back();
      },
      failure: (exception) {
        ResponseHelper.onFailure(
          message: NetworkExceptions.getErrorMessage(exception),
        );
      },
    );
  }

  @override
  void onClose() {
    currentPasswordController.dispose();
    newPasswordController.dispose();
    confirmationController.dispose();
    super.onClose();
  }
}
