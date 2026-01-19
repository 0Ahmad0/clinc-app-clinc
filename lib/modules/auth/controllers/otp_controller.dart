import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../../generated/locale_keys.g.dart';

class OtpController extends GetxController {
  // ── Arguments ──
  // نستقبل البريد أو الهاتف الذي تم إرسال الكود له
  final String emailOrPhone = Get.arguments ?? "info@clinic.com";

  // ── Controllers ──
  final TextEditingController otpController = TextEditingController();

  // ── State Variables ──
  final RxBool isLoading = false.obs;
  final RxInt remainingSeconds = 60.obs; // العداد يبدأ من 60 ثانية
  final RxBool canResend = false.obs;
  Timer? _timer;

  @override
  void onInit() {
    super.onInit();
    startTimer();
  }

  // ── Timer Logic ──
  void startTimer() {
    remainingSeconds.value = 60;
    canResend.value = false;
    _timer?.cancel();

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (remainingSeconds.value > 0) {
        remainingSeconds.value--;
      } else {
        canResend.value = true;
        _timer?.cancel();
      }
    });
  }

  // ── Actions ──
  Future<void> verifyOtp() async {
    if (otpController.text.length < 4) return;

    try {
      isLoading.value = true;
      // Simulate API verification
      await Future.delayed(const Duration(seconds: 2));

      // TODO: Verify Logic Here

      Get.snackbar(
        'Success',
        tr(LocaleKeys.otp_messages_success),
        backgroundColor: Colors.green.withOpacity(0.1),
        colorText: Colors.green,
      );

      // Go to Complete Profile or Home
      // Get.offAllNamed(Routes.COMPLETE_PROFILE);

    } catch (e) {
      Get.snackbar('Error', tr(LocaleKeys.otp_messages_invalid_code));
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> resendCode() async {
    if (!canResend.value) return;

    try {
      // Simulate API Resend
      await Future.delayed(const Duration(seconds: 1));

      Get.snackbar(
        'Sent',
        tr(LocaleKeys.otp_messages_resend_success),
        backgroundColor: Colors.blue.withOpacity(0.1),
        colorText: Colors.blue,
      );

      // Restart Timer
      startTimer();
      otpController.clear();

    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  @override
  void onClose() {
    _timer?.cancel();
    otpController.dispose();
    super.onClose();
  }
}