import 'package:clinc_app_clinc/app/core/constants/app_constants.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../services/storage_service.dart';

class SettingsAppController extends GetxController {
  static SettingsAppController get instance => Get.find();

  final GetStorage _storage = GetStorage();
  final String _keyTheme = 'isDarkMode';
  final String _keyThemeMode = 'themeMode';

  late Rx<ThemeMode> _themeMode;

  ThemeMode get themeMode => _themeMode.value;

  bool get isDarkMode => _themeMode.value == ThemeMode.dark;

  @override
  void onInit() {
    super.onInit();
    _loadTheme();
  }

  void _loadTheme() {
    final savedMode = _storage.read<int>(_keyThemeMode);
    final legacyIsDark = _storage.read<bool>(_keyTheme) ?? false;
    final mode =
        savedMode != null &&
            savedMode >= 0 &&
            savedMode < ThemeMode.values.length
        ? ThemeMode.values[savedMode]
        : legacyIsDark
        ? ThemeMode.dark
        : ThemeMode.light;
    _themeMode = mode.obs;

    Get.changeThemeMode(_themeMode.value);
  }

  void changeTheme(ThemeMode mode) {
    _themeMode.value = mode;
    _storage.write(_keyThemeMode, mode.index);
    _storage.write(_keyTheme, mode == ThemeMode.dark);
    Get.changeThemeMode(mode);
    update();
  }

  void toggleTheme(bool isDark) {
    changeTheme(isDark ? ThemeMode.dark : ThemeMode.light);
  }

  Future<void> changeLanguage(BuildContext context, String langCode) async {
    if (context.locale.languageCode == langCode) return;

    final newLocale = Locale(langCode);
    await context.setLocale(newLocale);
    Get.updateLocale(newLocale);
    _storage.write(StorageService.LANG_CODE, langCode);
    update(['app_localization']);
  }

  Future<void> toggleLanguage(BuildContext context) async {
    bool isArabic = context.locale.languageCode == AppConstants.arLang;

    Locale newLocale = isArabic
        ? const Locale(AppConstants.enLang)
        : const Locale(AppConstants.arLang);

    await context.setLocale(newLocale);

    Get.updateLocale(newLocale);
    _storage.write(StorageService.LANG_CODE, newLocale.languageCode);
    update(['app_localization']);
  }
}
