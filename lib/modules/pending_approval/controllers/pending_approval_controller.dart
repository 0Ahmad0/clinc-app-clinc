import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../../generated/locale_keys.g.dart';

class PendingApprovalController extends GetxController {

  final RxBool isLoading = false.obs;

  // فحص حالة الطلب يدوياً
  Future<void> checkStatus() async {
    try {
      isLoading.value = true;

      // Simulate API Call
      await Future.delayed(const Duration(seconds: 2));

      // TODO: Call API -> Check if status changed from 'pending' to 'approved'
      bool isApproved = false; // غيّرها لـ true للتجربة

      if (isApproved) {
        Get.snackbar(
          'Success',
          tr(LocaleKeys.pending_approval_messages_approved),
          backgroundColor: Colors.green.withOpacity(0.1),
          colorText: Colors.green,
        );
        // الانتقال لاستكمال البيانات
        // Get.offAllNamed(Routes.COMPLETE_PROFILE);
      } else {
        Get.snackbar(
          'Info',
          tr(LocaleKeys.pending_approval_messages_still_pending),
          backgroundColor: Colors.orange.withOpacity(0.1),
          colorText: Colors.orange,
        );
      }

    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  void contactSupport() {
    // فتح واتساب أو اتصال
  }

  void logout() {
    // مسح التوكن والعودة للبداية
    // Get.offAllNamed(Routes.LOGIN);
  }
}