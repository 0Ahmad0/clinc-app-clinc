import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../app/data/profile_model.dart';
import '../../../generated/locale_keys.g.dart';

class SettingsController extends GetxController {
  // ========== Loading States ==========
  final RxBool isLoading = false.obs;
  final RxBool isSavingProfile = false.obs;

  // ========== Theme & Language ==========
  final Rx<ThemeMode> themeMode = ThemeMode.system.obs;
  final RxString currentLanguage = 'ar'.obs;

  // ========== User Profile ==========
  final Rx<ProfileModel> profile = ProfileModel.mock.obs;

  // ========== Notification Settings ==========
  final RxBool appNotificationsEnabled = true.obs;
  final RxBool emailNotificationsEnabled = false.obs;
  final RxBool smsNotificationsEnabled = true.obs;
  final RxBool appointmentReminders = true.obs;
  final RxBool promotionalNotifications = false.obs;

  // ========== Privacy Settings ==========
  final RxBool profilePublic = true.obs;
  final RxBool showPhone = true.obs;
  final RxBool showEmail = false.obs;

  @override
  void onInit() {
    super.onInit();
    _loadSettings();
    _loadUserProfile();
  }

  // ========== Load ==========
  Future<void> _loadSettings() async {
    isLoading(true);
    try {
      await Future.delayed(const Duration(milliseconds: 500));
    } catch (e) {
      debugPrint('Error loading settings: $e');
      _showErrorSnackbar('Failed to load settings');
    } finally {
      isLoading(false);
    }
  }

  Future<void> _loadUserProfile() async {
    try {
      await Future.delayed(const Duration(milliseconds: 300));
    } catch (e) {
      debugPrint('Error loading profile: $e');
    }
  }

  // ========== Theme ==========
  void changeTheme(ThemeMode mode) {
    themeMode.value = mode;
    Get.changeThemeMode(mode);
    _showSuccessSnackbar('Theme changed to ${_getThemeModeName(mode)}');
  }

  /// Localized theme name — for UI subtitle display.
  String getThemeName(ThemeMode mode) {
    switch (mode) {
      case ThemeMode.system: return tr(LocaleKeys.settings_theme_system);
      case ThemeMode.light:  return tr(LocaleKeys.settings_theme_light);
      case ThemeMode.dark:   return tr(LocaleKeys.settings_theme_dark);
    }
  }

  String _getThemeModeName(ThemeMode mode) {
    switch (mode) {
      case ThemeMode.light:  return 'Light';
      case ThemeMode.dark:   return 'Dark';
      case ThemeMode.system: return 'System Default';
    }
  }

  // ========== Language ==========
  void changeLanguage(String languageCode) {
    currentLanguage.value = languageCode;
    if (languageCode == 'ar') {
      Get.updateLocale(const Locale('ar'));
      Get.context?.setLocale(const Locale('ar'));
    } else {
      Get.updateLocale(const Locale('en'));
      Get.context?.setLocale(const Locale('en'));
    }
    _showSuccessSnackbar(
      'Language changed to ${languageCode == 'ar' ? 'Arabic' : 'English'}',
    );
  }

  // ========== Profile ==========
  Future<void> updateProfile(ProfileModel newProfile) async {
    isSavingProfile(true);
    try {
      await Future.delayed(const Duration(milliseconds: 1500));
      profile.value = newProfile;
      _showSuccessSnackbar('Profile updated successfully');
    } catch (e) {
      debugPrint('Error updating profile: $e');
      _showErrorSnackbar('Failed to update profile: ${e.toString()}');
    } finally {
      isSavingProfile(false);
    }
  }

  Future<void> uploadAvatar(String imagePath) async {
    try {
      profile.value = profile.value.copyWith(avatar: imagePath);
      _showSuccessSnackbar('Avatar updated successfully');
    } catch (e) {
      debugPrint('Error uploading avatar: $e');
      _showErrorSnackbar('Failed to upload avatar');
    }
  }

  // ========== Notifications ==========
  void toggleAppNotifications(bool value) {
    appNotificationsEnabled.value = value;
    if (!value) {
      appointmentReminders.value = false;
      promotionalNotifications.value = false;
    }
  }

  void toggleEmailNotifications(bool value) => emailNotificationsEnabled.value = value;
  void toggleSmsNotifications(bool value)   => smsNotificationsEnabled.value = value;
  void toggleAppointmentReminders(bool v)   => appointmentReminders.value = v;
  void togglePromotionalNotifications(bool v) => promotionalNotifications.value = v;

  // ========== Privacy ==========
  void toggleProfilePublic(bool v) => profilePublic.value = v;
  void toggleShowPhone(bool v)     => showPhone.value = v;
  void toggleShowEmail(bool v)     => showEmail.value = v;

  // ========== Account Actions ==========
  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    try {
      isLoading(true);
      await Future.delayed(const Duration(milliseconds: 1000));
      _showSuccessSnackbar('Password changed successfully');
      Get.back();
    } catch (e) {
      debugPrint('Error changing password: $e');
      _showErrorSnackbar('Failed to change password');
    } finally {
      isLoading(false);
    }
  }

  Future<void> deleteAccount() async {
    try {
      isLoading(true);
      await Future.delayed(const Duration(milliseconds: 1000));
      _showSuccessSnackbar('Account deleted successfully');
    } catch (e) {
      debugPrint('Error deleting account: $e');
      _showErrorSnackbar('Failed to delete account');
    } finally {
      isLoading(false);
    }
  }

  Future<void> logout() async {
    try {
      isLoading(true);
      await Future.delayed(const Duration(milliseconds: 800));
      _showSuccessSnackbar('Logged out successfully');
    } catch (e) {
      debugPrint('Error logging out: $e');
      _showErrorSnackbar('Failed to logout');
    } finally {
      isLoading(false);
    }
  }

  // ========== Logout Dialog ==========
  void showLogoutDialog() {
    Get.dialog(
      AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r),
        ),
        title: Row(
          children: [
            Container(
              padding: EdgeInsets.all(8.r),
              decoration: BoxDecoration(
                color: const Color(0xFFEF4444).withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.logout_rounded,
                color: const Color(0xFFEF4444),
                size: 20.sp,
              ),
            ),
            12.horizontalSpace,
            Text(
              tr(LocaleKeys.settings_logout),
              style: TextStyle(fontWeight: FontWeight.w800, fontSize: 18.sp),
            ),
          ],
        ),
        content: Text(tr(LocaleKeys.settings_confirm_logout)),
        actions: [
          TextButton(
            onPressed: Get.back,
            child: Text(tr(LocaleKeys.settings_cancel)),
          ),
          ElevatedButton(
            onPressed: () {
              Get.back();
              logout();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFEF4444),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.r),
              ),
            ),
            child: Text(tr(LocaleKeys.settings_confirm)),
          ),
        ],
      ),
    );
  }

  // ========== Data / Cache ==========
  Future<void> exportData() async {
    try {
      isLoading(true);
      await Future.delayed(const Duration(seconds: 2));
      _showSuccessSnackbar('Data exported successfully');
    } catch (e) {
      _showErrorSnackbar('Failed to export data');
    } finally {
      isLoading(false);
    }
  }

  Future<void> clearCache() async {
    try {
      isLoading(true);
      await Future.delayed(const Duration(milliseconds: 800));
      _showSuccessSnackbar('Cache cleared successfully');
    } catch (e) {
      _showErrorSnackbar('Failed to clear cache');
    } finally {
      isLoading(false);
    }
  }

  // ========== App Info ==========
  String get appVersion => '1.0.0';
  String get buildNumber => '1';

  // ========== Snackbars ==========
  void _showSuccessSnackbar(String message) {
    Get.snackbar(
      'Success', message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green.shade100,
      colorText: Colors.green.shade900,
      icon: Icon(Icons.check_circle_outline, color: Colors.green.shade700),
      margin: const EdgeInsets.all(16),
      borderRadius: 12,
      duration: const Duration(seconds: 2),
    );
  }

  void _showErrorSnackbar(String message) {
    Get.snackbar(
      'Error', message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.red.shade100,
      colorText: Colors.red.shade900,
      icon: Icon(Icons.error_outline, color: Colors.red.shade700),
      margin: const EdgeInsets.all(16),
      borderRadius: 12,
      duration: const Duration(seconds: 3),
    );
  }
}
