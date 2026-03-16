import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../../generated/locale_keys.g.dart';

class MainLayoutController extends GetxController {
  // ── State ──────────────────────────────────────────────────────────────────

  final RxInt currentIndex = 0.obs;

  /// Replace with actual value from UserModel / local storage.
  final bool isProfileCompleted = true;

  // ── Public API ─────────────────────────────────────────────────────────────

  /// Owns haptic feedback + profile guard — View only calls this.
  void changeTab(int index) {
    HapticFeedback.lightImpact();

    if (index == 0 || isProfileCompleted) {
      currentIndex.value = index;
    } else {
      _showBlockingAlert(index);
    }
  }

  // ── Private ────────────────────────────────────────────────────────────────

  void _showBlockingAlert(int index) {
    Get.defaultDialog(
      title: tr(LocaleKeys.home_incomplete_profile_alert_title),
      middleText: tr(
        LocaleKeys.alerts_incomplete_profile_blocking,
        args: [_sectionName(index)],
      ),
      textConfirm: tr(LocaleKeys.alerts_complete_now),
      confirmTextColor: Colors.white,
      onConfirm: () {
        Get.back();
        // Get.toNamed(Routes.COMPLETE_PROFILE);
      },
      textCancel: tr('cancel'),
    );
  }

  String _sectionName(int index) => switch (index) {
    1 => tr(LocaleKeys.nav_doctors),
    2 => tr(LocaleKeys.nav_services),
    3 => tr(LocaleKeys.nav_appointments),
    4 => tr(LocaleKeys.nav_reports),
    _ => '',
  };
}
