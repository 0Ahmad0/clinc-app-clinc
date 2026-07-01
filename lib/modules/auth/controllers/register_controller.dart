import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app/core/configuration/locator.dart';
import '../../../app/core/helper/response_helper.dart';
import '../../../app/data/account_type.dart';
import '../../../app/domain/error_handler/network_exceptions.dart';
import '../../../app/routes/app_routes.dart';
import '../../../app/services/storage_service.dart';
import '../../../generated/locale_keys.g.dart';
import '../data/clinic_auth_model.dart';
import '../domain/repositories/clinic_auth_repository.dart';

class RegisterController extends GetxController {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController licenseController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final RxBool isLoading = false.obs;
  final RxBool isPassHidden = true.obs;
  final RxBool isConfirmPassHidden = true.obs;
  final Rxn<AccountType> selectedAccountType = Rxn<AccountType>();
  late final ClinicAuthRepository _repository;

  @override
  void onInit() {
    _repository = locator<ClinicAuthRepository>();
    super.onInit();
  }

  void selectAccountType(AccountType type) => selectedAccountType.value = type;

  String? validateRequired(String? value) {
    if (value == null || value.trim().isEmpty) {
      return tr(LocaleKeys.register_messages_required_field);
    }
    return null;
  }

  String? validateEmail(String? value) {
    final requiredError = validateRequired(value);
    if (requiredError != null) return requiredError;
    if (!GetUtils.isEmail(value!.trim())) {
      return tr(LocaleKeys.register_messages_email_invalid);
    }
    return null;
  }

  String? validateConfirmPassword(String? value) {
    final requiredError = validateRequired(value);
    if (requiredError != null) return requiredError;
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
    if (isLoading.value || !(formKey.currentState?.validate() ?? false)) return;

    final typeError = validateAccountType();
    if (typeError != null) {
      ResponseHelper.onFailure(message: typeError);
      return;
    }

    isLoading.value = true;
    final result = await _repository.register(
      ClinicRegisterRequest(
        name: nameController.text.trim(),
        licenseNumber: licenseController.text.trim(),
        email: emailController.text.trim(),
        password: passwordController.text,
        passwordConfirmation: confirmPasswordController.text,
        type: selectedAccountType.value!,
      ),
    );
    isLoading.value = false;

    result.when(
      success: (response) async {
        if (!response.isSuccess) {
          ResponseHelper.onFailure(message: response.message);
          return;
        }
        final clinic = response.data?['clinic'];
        if (clinic is Map) {
          await StorageService.instance.cacheClinic(
            Map<String, dynamic>.from(clinic),
          );
          await StorageService.instance.setPendingRegistrationReference(
            clinic['clinic_id']?.toString(),
          );
        }
        Get.offAllNamed(AppRoutes.pendingApproval);
      },
      failure: (exception) => ResponseHelper.onFailure(
        message: NetworkExceptions.getErrorMessage(exception),
      ),
    );
  }

  @override
  void onClose() {
    nameController.dispose();
    licenseController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}
