import 'package:clinc_app_clinc/app/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../../app/core/configuration/locator.dart';
import '../../../app/core/helper/response_helper.dart';
import '../../../app/domain/error_handler/network_exceptions.dart';
import '../../../app/services/storage_service.dart';
import '../../../generated/locale_keys.g.dart';
import '../domain/repositories/auth_repository.dart';

class LoginController extends GetxController {
  // ── Text Controllers ──
  final TextEditingController identifierController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // ── State Variables ──
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final RxBool isLoading = false.obs;
  final RxBool isPassHidden = true.obs;
  late AuthRepository _repository;

  @override
  void onInit() {
    _repository = locator<AuthRepository>();
    super.onInit();
  }
  // ── Actions ──
  void togglePassVisibility() => isPassHidden.toggle();



  Future<void> login() async {
    if (isLoading.value || !(formKey.currentState?.validate() ?? false)) {
      return;
    }


    isLoading.value = true;
    final response = await _repository.Login(
      identifierController.text,
      passwordController.text,
    );

    response.when(
      success: (data) async {
        final result = data.result;
        print("result $result");

        await saveUserAuth(result);
        isLoading.value = false;
        // ResponseHelper.onSuccess(message: data.message);
        if (result?['token'] != null) {
          await saveUserAuth(result);
          isLoading.value = false;
          // ResponseHelper.onSuccess(message: data.message);
          _goToRoleHome();
        }
      },
      failure: (networkException) {
        isLoading.value = false;
        ResponseHelper.onFailure(
          message: NetworkExceptions.getErrorMessage(networkException),
        );
      },
    );
  }

  void _goToRoleHome() {
    Get.offAllNamed(AppRoutes.mainLayout);

  }
  Future<void> saveUserAuth(Map<String, dynamic>? result) async {
    if (result == null) return;

    await StorageService.instance.setAccessToken(result['token']?['access_token']);


    if (result['user'] != null) {
      await StorageService.instance.cacheUserModel(
        result['user'] as Map<String, dynamic>,
      );
    }

    await StorageService.instance.writeData(
      StorageService.REFRESH_TOKEN_EXPIRE,
      result['refreshTokenExpireInSeconds'],
    );
    await StorageService.instance.writeData(
      StorageService.REFRESH_TOKEN,
      result['token']?['refresh_token'],
    );
    await StorageService.instance.writeData(
      StorageService.LOGIN_TIME,
      DateTime.now().toIso8601String(),
    );
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