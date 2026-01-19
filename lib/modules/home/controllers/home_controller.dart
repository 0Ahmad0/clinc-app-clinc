import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../../generated/locale_keys.g.dart';

class HomeController extends GetxController {
  // افترض أن هذه القيمة تأتي من موديل المستخدم المحفوظ
  bool isProfileComplete = false;

  @override
  void onReady() {
    super.onReady();
    _checkProfileStatus();
  }

  void _checkProfileStatus() {
    if (!isProfileComplete) {
      Get.snackbar(
        tr(LocaleKeys.home_incomplete_profile_alert_title),
        tr(LocaleKeys.home_incomplete_profile_alert_message),
        duration: const Duration(seconds: 6),
        backgroundColor: Colors.orange.shade50,
        colorText: Colors.orange.shade900,
        icon: const Icon(Icons.warning_amber_rounded, color: Colors.orange),
        mainButton: TextButton(
          onPressed: () {
            // Get.toNamed(Routes.COMPLETE_PROFILE);
          },
          child: Text(
            tr(LocaleKeys.home_incomplete_profile_alert_action),
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        snackPosition: SnackPosition.TOP,
        margin: const EdgeInsets.all(10),
      );
    }
  }
}
