import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../app/data/profile_model.dart';
import '../../../app/services/storage_service.dart';

class SettingsController extends GetxController {
  // ========== Services ==========
  // final StorageService _storage = Get.find<StorageService>();
  // final AuthService _auth = Get.find<AuthService>();

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

  // ========== Load Settings ==========
  Future<void> _loadSettings() async {
    isLoading(true);
    try {
      // TODO: Load from storage
      // final savedTheme = _storage.read('theme_mode');
      // if (savedTheme != null) {
      //   themeMode.value = ThemeMode.values[savedTheme];
      // }

      // final savedLang = _storage.read('language');
      // if (savedLang != null) {
      //   currentLanguage.value = savedLang;
      // }

      await Future.delayed(const Duration(milliseconds: 500));
    } catch (e) {
      debugPrint('Error loading settings: $e');
      _showErrorSnackbar('Failed to load settings');
    } finally {
      isLoading(false);
    }
  }

  // ========== Load User Profile ==========
  Future<void> _loadUserProfile() async {
    try {
      // TODO: Load from API
      // final response = await _api.getUserProfile();
      // profile.value = ProfileModel.fromJson(response.data);

      // For now, using mock data
      await Future.delayed(const Duration(milliseconds: 300));
    } catch (e) {
      debugPrint('Error loading profile: $e');
    }
  }

  // ========== Theme Management ==========
  void changeTheme(ThemeMode mode) {
    themeMode.value = mode;
    Get.changeThemeMode(mode);

    // Save to storage
    // _storage.write('theme_mode', mode.index);

    _showSuccessSnackbar(
      'Theme changed to ${_getThemeModeName(mode)}',
    );
  }

  String _getThemeModeName(ThemeMode mode) {
    switch (mode) {
      case ThemeMode.light:
        return 'Light';
      case ThemeMode.dark:
        return 'Dark';
      case ThemeMode.system:
        return 'System Default';
    }
  }

  // ========== Language Management ==========
  void changeLanguage(String languageCode) {
    currentLanguage.value = languageCode;

    // Change app locale
    if (languageCode == 'ar') {
      Get.updateLocale(const Locale('ar'));
      Get.context?.setLocale(const Locale('ar'));
    } else {
      Get.updateLocale(const Locale('en'));
      Get.context?.setLocale(const Locale('en'));
    }

    // Save to storage
    // _storage.write('language', languageCode);

    _showSuccessSnackbar(
      'Language changed to ${languageCode == 'ar' ? 'Arabic' : 'English'}',
    );
  }

  // ========== Profile Management ==========
  Future<void> updateProfile(ProfileModel newProfile) async {
    isSavingProfile(true);

    try {
      // Simulate API call
      await Future.delayed(const Duration(milliseconds: 1500));

      // TODO: Send to API
      // await _api.updateProfile(newProfile.toJson());

      // Update local state
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
      // TODO: Upload to server
      // final response = await _api.uploadAvatar(imagePath);
      // final avatarUrl = response.data['url'];

      // Update profile
      profile.value = profile.value.copyWith(avatar: imagePath);

      _showSuccessSnackbar('Avatar updated successfully');
    } catch (e) {
      debugPrint('Error uploading avatar: $e');
      _showErrorSnackbar('Failed to upload avatar');
    }
  }

  // ========== Notification Settings ==========
  void toggleAppNotifications(bool value) {
    appNotificationsEnabled.value = value;
    // _storage.write('app_notifications', value);

    // If turning off, disable all sub-notifications
    if (!value) {
      appointmentReminders.value = false;
      promotionalNotifications.value = false;
    }
  }

  void toggleEmailNotifications(bool value) {
    emailNotificationsEnabled.value = value;
    // _storage.write('email_notifications', value);
  }

  void toggleSmsNotifications(bool value) {
    smsNotificationsEnabled.value = value;
    // _storage.write('sms_notifications', value);
  }

  void toggleAppointmentReminders(bool value) {
    appointmentReminders.value = value;
    // _storage.write('appointment_reminders', value);
  }

  void togglePromotionalNotifications(bool value) {
    promotionalNotifications.value = value;
    // _storage.write('promotional_notifications', value);
  }

  // ========== Privacy Settings ==========
  void toggleProfilePublic(bool value) {
    profilePublic.value = value;
    // _storage.write('profile_public', value);
  }

  void toggleShowPhone(bool value) {
    showPhone.value = value;
    // _storage.write('show_phone', value);
  }

  void toggleShowEmail(bool value) {
    showEmail.value = value;
    // _storage.write('show_email', value);
  }

  // ========== Account Actions ==========
  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    try {
      isLoading(true);

      // TODO: Send to API
      // await _api.changePassword(currentPassword, newPassword);

      await Future.delayed(const Duration(milliseconds: 1000));

      _showSuccessSnackbar('Password changed successfully');
      Get.back(); // Close dialog
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

      // TODO: Send to API
      // await _api.deleteAccount();

      await Future.delayed(const Duration(milliseconds: 1000));

      // Clear storage and logout
      // _storage.erase();
      // Get.offAllNamed('/login');

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

      // TODO: Call logout API
      // await _auth.logout();

      await Future.delayed(const Duration(milliseconds: 800));

      // Clear storage
      // _storage.erase();

      // Navigate to login
      // Get.offAllNamed('/login');

      _showSuccessSnackbar('Logged out successfully');
    } catch (e) {
      debugPrint('Error logging out: $e');
      _showErrorSnackbar('Failed to logout');
    } finally {
      isLoading(false);
    }
  }

  // ========== Helper Methods ==========
  void _showSuccessSnackbar(String message) {
    Get.snackbar(
      'Success',
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green.shade100,
      colorText: Colors.green.shade900,
      icon: Icon(Icons.check_circle_outline, color: Colors.green.shade700),
      margin: EdgeInsets.all(16),
      borderRadius: 12,
      duration: const Duration(seconds: 2),
    );
  }

  void _showErrorSnackbar(String message) {
    Get.snackbar(
      'Error',
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.red.shade100,
      colorText: Colors.red.shade900,
      icon: Icon(Icons.error_outline, color: Colors.red.shade700),
      margin: EdgeInsets.all(16),
      borderRadius: 12,
      duration: const Duration(seconds: 3),
    );
  }

  // ========== Data Export ==========
  Future<void> exportData() async {
    try {
      isLoading(true);

      // TODO: Generate and download data export
      await Future.delayed(const Duration(seconds: 2));

      _showSuccessSnackbar('Data exported successfully');
    } catch (e) {
      _showErrorSnackbar('Failed to export data');
    } finally {
      isLoading(false);
    }
  }

  // ========== Cache Management ==========
  Future<void> clearCache() async {
    try {
      isLoading(true);

      // TODO: Clear app cache
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

  Map<String, dynamic> get appInfo => {
    'version': appVersion,
    'build': buildNumber,
    'platform': GetPlatform.isIOS ? 'iOS' : 'Android',
    'language': currentLanguage.value,
    'theme': themeMode.value.toString(),
  };
}