import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../app/data/profile_model.dart';

class SettingsController extends GetxController {
  // حالة التحميل
  final RxBool isLoading = false.obs;

  // الثيم الحالي
  final Rx<ThemeMode> themeMode = ThemeMode.system.obs;

  // اللغة الحالية
  final RxString currentLanguage = 'ar'.obs;

  // بيانات المستخدم
  final Rx<ProfileModel> profile = ProfileModel.mock.obs;

  // حالة إشعارات التطبيق
  final RxBool appNotificationsEnabled = true.obs;
  final RxBool emailNotificationsEnabled = false.obs;
  final RxBool smsNotificationsEnabled = true.obs;

  @override
  void onInit() {
    super.onInit();
    // تحميل الإعدادات المحفوظة
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    isLoading(true);
    try {
      // TODO: تحميل الإعدادات من التخزين المحلي أو الخادم
      await Future.delayed(const Duration(milliseconds: 500));
    } finally {
      isLoading(false);
    }
  }

  // تغيير الثيم
  void changeTheme(ThemeMode mode) {
    themeMode.value = mode;
    Get.changeThemeMode(mode);
    // TODO: حفظ الإعداد في التخزين المحلي
  }

  // تغيير اللغة
  void changeLanguage(String languageCode) {
    currentLanguage.value = languageCode;
    // تغيير لغة التطبيق
    if (languageCode == 'ar') {
      Get.updateLocale(const Locale('ar'));
    } else {
      Get.updateLocale(const Locale('en'));
    }
    // TODO: حفظ الإعداد في التخزين المحلي
  }

  // تحديث بيانات المستخدم
  Future<void> updateProfile(ProfileModel newProfile) async {
    isLoading(true);
    try {
      // TODO: إرسال البيانات للخادم
      await Future.delayed(const Duration(milliseconds: 800));
      profile.value = newProfile;
      Get.snackbar(
        'نجاح',
        'تم تحديث بياناتك بنجاح',
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      Get.snackbar(
        'خطأ',
        'فشل تحديث البيانات: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading(false);
    }
  }

  // تبديل حالة الإشعارات
  void toggleAppNotifications(bool value) {
    appNotificationsEnabled.value = value;
    // TODO: حفظ الإعداد في التخزين المحلي
  }

  void toggleEmailNotifications(bool value) {
    emailNotificationsEnabled.value = value;
    // TODO: حفظ الإعداد في التخزين المحلي
  }

  void toggleSmsNotifications(bool value) {
    smsNotificationsEnabled.value = value;
    // TODO: حفظ الإعداد في التخزين المحلي
  }
}