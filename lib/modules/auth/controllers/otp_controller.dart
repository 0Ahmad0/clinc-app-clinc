import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app/core/configuration/locator.dart';
import '../../../app/core/helper/response_helper.dart';
import '../../../app/domain/error_handler/network_exceptions.dart';
import '../../../app/routes/app_routes.dart';
import '../data/clinic_auth_model.dart';
import '../domain/repositories/clinic_auth_repository.dart';

class OtpController extends GetxController {
  final TextEditingController otpController = TextEditingController();
  final RxBool isLoading = false.obs;
  final RxInt remainingSeconds = 60.obs;
  final RxBool canResend = false.obs;
  late final ClinicAuthRepository _repository;
  Timer? _timer;

  String get identifier {
    final arguments = Get.arguments;
    if (arguments is Map) return arguments['identifier']?.toString() ?? '';
    return arguments?.toString() ?? '';
  }

  @override
  void onInit() {
    _repository = locator<ClinicAuthRepository>();
    startTimer();
    super.onInit();
  }

  void startTimer() {
    remainingSeconds.value = 60;
    canResend.value = false;
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (remainingSeconds.value > 0) {
        remainingSeconds.value--;
      } else {
        canResend.value = true;
        timer.cancel();
      }
    });
  }

  Future<void> verifyOtp() async {
    if (isLoading.value || otpController.text.length != 4) return;

    isLoading.value = true;
    final result = await _repository.verifyOtp(
      VerifyOtpRequest(identifier: identifier, otp: otpController.text),
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

  Future<void> resendCode() async {
    if (!canResend.value || isLoading.value) return;

    isLoading.value = true;
    final result = await _repository.resendOtp(
      ResendOtpRequest(identifier: identifier),
    );
    isLoading.value = false;

    result.when(
      success: (response) {
        if (!response.isSuccess) {
          ResponseHelper.onFailure(message: response.message);
          return;
        }
        ResponseHelper.onSuccess(message: response.message);
        otpController.clear();
        startTimer();
      },
      failure: (exception) => ResponseHelper.onFailure(
        message: NetworkExceptions.getErrorMessage(exception),
      ),
    );
  }

  @override
  void onClose() {
    _timer?.cancel();
    otpController.dispose();
    super.onClose();
  }
}
