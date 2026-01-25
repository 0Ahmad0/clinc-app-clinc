import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../../generated/locale_keys.g.dart';

class MainLayoutController extends GetxController {
  // ── State ──
  final RxInt currentIndex = 3.obs;

  // هذه القيمة تأتي من User Model المخزن محلياً
  // اجعلها false للتجربة (لمنع الدخول)
  final bool isProfileCompleted = true;

  // ── Navigation Logic ──
  void changeTab(int index) {
    // الصفحة 0 (Dashboard) مسموحة دائماً
    if (index == 0) {
      currentIndex.value = index;
      return;
    }

    // باقي الصفحات تتطلب بروفايل مكتمل
    if (!isProfileCompleted) {
      _showBlockingAlert(index);
    } else {
      currentIndex.value = index;
    }
  }

  void _showBlockingAlert(int index) {
    String sectionName = '';
    switch (index) {
      case 1:
        sectionName = tr(LocaleKeys.nav_doctors);
        break;
      case 2:
        sectionName = tr(LocaleKeys.nav_services);
        break;
      case 3:
        sectionName = tr(LocaleKeys.nav_appointments);
        break;
      case 4:
        sectionName = tr(LocaleKeys.nav_reports);
        break;
    }

    Get.defaultDialog(
      title: tr(LocaleKeys.home_incomplete_profile_alert_title),
      // "ملفك غير مكتمل"
      middleText: tr(
        LocaleKeys.alerts_incomplete_profile_blocking,
        args: [sectionName],
      ),
      textConfirm: tr(LocaleKeys.alerts_complete_now),
      confirmTextColor: Colors.white,
      onConfirm: () {
        Get.back(); // إغلاق الدايلوج
        // Get.toNamed(Routes.COMPLETE_PROFILE); // الذهاب للاستكمال
      },
      textCancel: tr('cancel'), // زر إلغاء اختياري
    );
  }
}
