import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app/routes/app_routes.dart';
import '../../../app/services/storage_service.dart';
import '../../../generated/locale_keys.g.dart';

class MainLayoutController extends GetxController {
  final RxInt currentIndex = 0.obs;
  final RxBool isProfileCompleted = false.obs;

  @override
  void onInit() {
    refreshProfileCompletion();
    super.onInit();
  }

  void refreshProfileCompletion() {
    isProfileCompleted.value = StorageService.instance.isProfileCompleted;
  }

  void changeTab(int index) {
    if (index == currentIndex.value) return;
    FocusManager.instance.primaryFocus?.unfocus();

    if (index == 0 || isProfileCompleted.value) {
      currentIndex.value = index;
      return;
    }
    _showIncompleteProfileDialog(index);
  }

  void returnToDashboard() => currentIndex.value = 0;

  Future<void> _showIncompleteProfileDialog(int index) async {
    if (Get.isDialogOpen == true) return;

    await Get.defaultDialog<void>(
      title: tr(LocaleKeys.home_incomplete_profile_alert_title),
      middleText: tr(
        LocaleKeys.alerts_incomplete_profile_blocking,
        args: [_sectionName(index)],
      ),
      textConfirm: tr(LocaleKeys.alerts_complete_now),
      textCancel: tr('main_layout.cancel'),
      confirmTextColor: Colors.white,
      onConfirm: () async {
        Get.back<void>();
        await Get.toNamed(AppRoutes.completeProfile);
        refreshProfileCompletion();
      },
    );
  }

  String _sectionName(int index) {
    switch (index) {
      case 1:
        return tr(LocaleKeys.nav_doctors);
      case 2:
        return tr(LocaleKeys.nav_services);
      case 3:
        return tr(LocaleKeys.nav_appointments);
      case 4:
        return tr(LocaleKeys.nav_reports);
      default:
        return '';
    }
  }
}
