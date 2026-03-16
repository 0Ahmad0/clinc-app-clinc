import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../../generated/locale_keys.g.dart';

class PendingApprovalController extends GetxController {
  // ── State ──────────────────────────────────────────────────────────────────

  final RxBool isLoading = false.obs;

  // ── Lifecycle ──────────────────────────────────────────────────────────────

  @override
  void onReady() {
    super.onReady();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
  }

  // ── Commands ───────────────────────────────────────────────────────────────

  Future<void> checkStatus() async {
    try {
      isLoading.value = true;
      await Future.delayed(const Duration(seconds: 2));

      // TODO: replace with real API call
      const isApproved = false;

      if (isApproved) {
        Get.snackbar(
          'Success',
          tr(LocaleKeys.pending_approval_messages_approved),
          backgroundColor: Colors.green.withValues(alpha: 0.1),
          colorText: Colors.green,
        );
        // Get.offAllNamed(Routes.COMPLETE_PROFILE);
      } else {
        Get.snackbar(
          'Info',
          tr(LocaleKeys.pending_approval_messages_still_pending),
          backgroundColor: Colors.orange.withValues(alpha: 0.1),
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
    // TODO: open WhatsApp / phone call
  }

  void logout() {
    // TODO: clear token → Get.offAllNamed(Routes.LOGIN);
  }
}
