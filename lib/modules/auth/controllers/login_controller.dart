import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app/core/configuration/locator.dart';
import '../../../app/core/helper/response_helper.dart';
import '../../../app/domain/error_handler/network_exceptions.dart';
import '../../../app/routes/app_routes.dart';
import '../../../app/services/storage_service.dart';
import '../../../generated/locale_keys.g.dart';
import '../data/login_model.dart';
import '../domain/repositories/clinic_login_repository.dart';

class LoginController extends GetxController {
  final TextEditingController identifierController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final RxBool isLoading = false.obs;
  final RxBool isPassHidden = true.obs;
  late final ClinicLoginRepository _repository;

  @override
  void onInit() {
    _repository = locator<ClinicLoginRepository>();
    super.onInit();
  }

  void togglePassVisibility() => isPassHidden.toggle();

  Future<void> login() async {
    if (isLoading.value || !(formKey.currentState?.validate() ?? false)) {
      return;
    }

    isLoading.value = true;
    final result = await _repository.login(
      identifier: identifierController.text.trim(),
      password: passwordController.text,
    );
    isLoading.value = false;

    result.when(
      success: _handleResponse,
      failure: (exception) => ResponseHelper.onFailure(
        message: NetworkExceptions.getErrorMessage(exception),
      ),
    );
  }

  Future<void> socialLogin(String provider) async {
    if (isLoading.value) return;
    isLoading.value = true;
    final result = await _repository.socialLogin(provider);
    isLoading.value = false;
    result.when(
      success: _handleResponse,
      failure: (exception) => ResponseHelper.onFailure(
        message: NetworkExceptions.getErrorMessage(exception),
      ),
    );
  }

  Future<void> _handleResponse(ClinicLoginResponse response) async {
    if (!response.isSuccess || response.data == null) {
      if (response.error?['status'] == 'pending') {
        await StorageService.instance.setPendingRegistrationReference(
          identifierController.text.trim(),
        );
        Get.offAllNamed(AppRoutes.pendingApproval);
        return;
      }
      ResponseHelper.onFailure(message: response.message);
      return;
    }

    final data = response.data!;
    await StorageService.instance.setAccessToken(data.token);
    await StorageService.instance.cacheClinic(data.clinic.toJson());
    await StorageService.instance.setProfileCompleted(!data.needsCompletion);
    await StorageService.instance.writeData(
      StorageService.LOGIN_TIME,
      DateTime.now().toIso8601String(),
    );

    if (data.needsCompletion) {
      Get.offAllNamed(AppRoutes.completeProfile);
      return;
    }
    Get.offAllNamed(AppRoutes.mainLayout);
  }

  void toRegister() => Get.offAllNamed(AppRoutes.register);

  void toForgotPassword() => Get.toNamed(AppRoutes.forgotPassword);

  String? validateRequired(String? value) {
    if (value == null || value.trim().isEmpty) {
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
