import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app/core/configuration/locator.dart';
import '../../../app/core/helper/response_helper.dart';
import '../../../app/domain/error_handler/network_exceptions.dart';
import '../../../app/routes/app_routes.dart';
import '../../../generated/locale_keys.g.dart';
import '../data/clinic_auth_model.dart';
import '../domain/repositories/clinic_auth_repository.dart';

class ForgotPasswordController extends GetxController {
  final TextEditingController identifierController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final RxBool isLoading = false.obs;
  late final ClinicAuthRepository _repository;

  @override
  void onInit() {
    _repository = locator<ClinicAuthRepository>();
    super.onInit();
  }

  Future<void> sendResetLink() async {
    if (isLoading.value || !(formKey.currentState?.validate() ?? false)) return;

    final identifier = identifierController.text.trim();
    isLoading.value = true;
    final result = await _repository.forgotPassword(
      ForgotPasswordRequest(identifier: identifier),
    );
    isLoading.value = false;

    result.when(
      success: (response) {
        if (!response.isSuccess) {
          ResponseHelper.onFailure(message: response.message);
          return;
        }
        ResponseHelper.onSuccess(message: response.message);
        Get.toNamed(
          AppRoutes.otp,
          arguments: {'identifier': identifier, 'purpose': 'password_reset'},
        );
      },
      failure: (exception) => ResponseHelper.onFailure(
        message: NetworkExceptions.getErrorMessage(exception),
      ),
    );
  }

  void backToLogin() => Get.back();

  String? validateRequired(String? value) {
    if (value == null || value.trim().isEmpty) {
      return tr(LocaleKeys.forgot_password_messages_required_field);
    }
    return null;
  }

  @override
  void onClose() {
    identifierController.dispose();
    super.onClose();
  }
}
