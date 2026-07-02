import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../app/core/configuration/locator.dart';
import '../../../app/controllers/settings_app_controller.dart';
import '../../../app/core/helper/response_helper.dart';
import '../../../app/data/profile_model.dart';
import '../../../app/data/user.dart';
import '../../../app/routes/app_routes.dart';
import '../../../app/services/storage_service.dart';
import '../../auth/bindings/login_binding.dart';
import '../../auth/domain/repositories/auth_repository.dart';
import '../../auth/views/login_view.dart';
import '../domain/settings_repository.dart';

class SettingsController extends GetxController {
  // ========== Services ==========
  // final StorageService _storage = Get.find<StorageService>();
  // final AuthService _auth = Get.find<AuthService>();
  late AuthRepository _repository;
  late SettingsRepository _settingsRepository;
  // ========== Loading States ==========
  final RxBool isLoading = false.obs;
  final RxBool isSavingProfile = false.obs;

  // ========== Theme & Language ==========
  final Rx<ThemeMode> themeMode = ThemeMode.system.obs;
  final RxString currentLanguage = 'ar'.obs;

  // ========== User Profile ==========
  final Rx<ProfileModel> profile = ProfileModel.mock.obs;
  final Rxn<ProfileModel> pendingProfileUpdate = Rxn<ProfileModel>();

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
    _repository = locator<AuthRepository>();
    _settingsRepository = locator<SettingsRepository>();
    _loadSettings();
    _loadUserProfile();
  }

  // ========== Load Settings ==========
  Future<void> _loadSettings() async {
    isLoading(true);
    try {
      themeMode.value = SettingsAppController.instance.themeMode;
      currentLanguage.value = StorageService.instance.languageCode;
      appNotificationsEnabled.value = StorageService.instance.readBool(
        StorageService.APP_NOTIFICATIONS,
        fallback: true,
      );
      emailNotificationsEnabled.value = StorageService.instance.readBool(
        StorageService.EMAIL_NOTIFICATIONS,
        fallback: false,
      );
      smsNotificationsEnabled.value = StorageService.instance.readBool(
        StorageService.SMS_NOTIFICATIONS,
        fallback: true,
      );
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
    SettingsAppController.instance.changeTheme(mode);

    _showSuccessSnackbar('Theme changed to ${_getThemeModeName(mode)}');
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
  Future<void> changeLanguage(String languageCode) async {
    currentLanguage.value = languageCode;
    final context = Get.context;
    if (context != null) {
      await SettingsAppController.instance.changeLanguage(
        context,
        languageCode,
      );
    } else {
      StorageService.instance.saveLanguage(languageCode);
    }

    _showSuccessSnackbar(
      'Language changed to ${languageCode == 'ar' ? 'Arabic' : 'English'}',
    );
  }

  // ========== Profile Management ==========
  Future<void> updateProfile(ProfileModel newProfile) async {
    if (isSavingProfile.value) return;
    isSavingProfile.value = true;
    final result = await _settingsRepository.submitProfileUpdate(newProfile);
    isSavingProfile.value = false;
    result.when(
      success: (model) {
        if (model.status != 'success' || model.result == null) {
          _showErrorSnackbar(model.message ?? 'Failed to submit profile');
          return;
        }
        pendingProfileUpdate.value = model.result;
        _showSuccessSnackbar('Profile update request sent for admin approval');
      },
      failure: (_) {
        _showErrorSnackbar('Failed to submit profile update');
      },
    );
  }

  Future<void> uploadAvatar(String imagePath) async {
    await updateProfile(profile.value.copyWith(avatar: imagePath));
  }

  Future<void> pickProfileImage(ImageSource source) async {
    final image = await ImagePicker().pickImage(source: source);
    if (image == null) return;
    await uploadAvatar(image.path);
  }

  Future<void> pickCoverImage(ImageSource source) async {
    final image = await ImagePicker().pickImage(source: source);
    if (image == null) return;
    await updateProfile(profile.value.copyWith(cover: image.path));
  }

  // ========== Notification Settings ==========
  void toggleAppNotifications(bool value) {
    appNotificationsEnabled.value = value;
    StorageService.instance.saveBool(StorageService.APP_NOTIFICATIONS, value);

    // If turning off, disable all sub-notifications
    if (!value) {
      appointmentReminders.value = false;
      promotionalNotifications.value = false;
    }
  }

  void toggleEmailNotifications(bool value) {
    emailNotificationsEnabled.value = value;
    StorageService.instance.saveBool(StorageService.EMAIL_NOTIFICATIONS, value);
  }

  void toggleSmsNotifications(bool value) {
    smsNotificationsEnabled.value = value;
    StorageService.instance.saveBool(StorageService.SMS_NOTIFICATIONS, value);
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

  Future<bool?> getProfile({bool isSplash = true}) async {
    final response = await _repository.getProfile();

    bool isGetProfile = false;
    await response.when(
      success: (data) async {
        final fetchedUser = data.result;
        // user = fetchedUser;

        if (fetchedUser != null) {
          // الآن الـ Compiler متأكد أن fetchedUser ليس null
          await StorageService.instance.cacheUserModel(fetchedUser.toJson());
          updateUser(fetchedUser);
        }

        isGetProfile = true;

        Get.offNamed(AppRoutes.mainLayout);
      },
      failure: (networkException) async {
        if (isSplash) Get.offAllNamed(AppRoutes.login);
      },
    );
    return isGetProfile;
  }

  Future<void> logout() async {
    if (isLoading.value) return;
    isLoading.value = true;

    String? successMessage;
    final result = await _repository.logout();
    result.when(
      success: (data) => successMessage = data.message,
      failure: (_) {},
    );

    await StorageService.instance.depose();
    profile.value = ProfileModel.mock;
    pendingProfileUpdate.value = null;
    isLoading.value = false;

    Get.closeAllSnackbars();
    Get.offAll<void>(() => const LoginView(), binding: LoginBinding());
    if ((successMessage ?? '').isNotEmpty) {
      ResponseHelper.onSuccess(message: successMessage);
    }
  }

  void updateUser(UserModel userModel) {
    // user = userModel;
    update();
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
