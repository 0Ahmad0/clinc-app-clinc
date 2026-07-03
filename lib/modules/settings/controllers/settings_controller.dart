import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import '../../../app/core/configuration/locator.dart';
import '../../../app/controllers/settings_app_controller.dart';
import '../../../app/core/helper/response_helper.dart';
import '../../../app/data/account_type.dart';
import '../../../app/data/profile_model.dart';
import '../../../app/data/user.dart';
import '../../../app/routes/app_routes.dart';
import '../../../app/services/storage_service.dart';
import '../../auth/bindings/login_binding.dart';
import '../../auth/domain/repositories/auth_repository.dart';
import '../../auth/views/login_view.dart';
import '../domain/settings_repository.dart';

class SettingsController extends GetxController {
  // ربط جديد: تخزين محلي لقراءة نوع الحساب (مستخدم في ميزة الأدوار/الإعلانات)
  final GetStorage _box = GetStorage();

  // ========== Repositories (ربط حقيقي من الكود القديم) ==========
  late AuthRepository _repository;
  late SettingsRepository _settingsRepository;

  // ========== Loading States ==========
  final RxBool isLoading = false.obs;
  final RxBool isSavingProfile = false.obs;
  final RxBool isSyncingNotificationSettings = false.obs;

  // ========== Theme & Language ==========
  final Rx<ThemeMode> themeMode = ThemeMode.system.obs;
  final RxString currentLanguage = 'ar'.obs;

  // ميزة جديدة من الواجهة الجديدة: الدور الحالي للحساب (لعرض تبويب الإعلانات)
  final Rx<AccountType> currentRole = AccountType.clinic.obs;

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
      appointmentReminders.value = StorageService.instance.readBool(
        StorageService.APPOINTMENT_REMINDERS,
        fallback: true,
      );
      promotionalNotifications.value = StorageService.instance.readBool(
        StorageService.PROMOTIONAL_NOTIFICATIONS,
        fallback: false,
      );

      // ميزة جديدة: قراءة نوع الحساب المخزّن محليًا لتحديد الدور
      final roleName = _box.read('account_type')?.toString() ?? '';
      currentRole.value = _mapRole(roleName);
      await _loadNotificationSettings();
    } catch (e) {
      debugPrint('Error loading settings: $e');
      _showErrorSnackbar('Failed to load settings');
    } finally {
      isLoading(false);
    }
  }

  // ========== Load User Profile ==========
  Future<void> _loadUserProfile() async {
    final result = await _settingsRepository.getProfile();
    result.when(
      success: (model) {
        if (model.status == 'success' && model.result != null) {
          profile.value = model.result!;
        }
      },
      failure: (_) => _showErrorSnackbar('Failed to load profile'),
    );
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

  // ========== Profile Management (ربط حقيقي: يرسل طلب تحديث بانتظار موافقة الأدمن) ==========
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

  // مطلوبة من الواجهة (settings_view.dart) لفتح منتقي الصور وتحديث الصورة الرمزية
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
  Future<void> _loadNotificationSettings() async {
    final result = await _settingsRepository.getNotificationSettings();
    result.when(
      success: (model) {
        if (model.status != 'success' || model.result == null) return;
        _applyNotificationSettings(model.result!);
        _persistNotificationSettings();
      },
      failure: (_) {},
    );
  }

  Future<void> toggleAppNotifications(bool value) async {
    final previous = _notificationSettingsMap();
    appNotificationsEnabled.value = value;
    if (!value) {
      appointmentReminders.value = false;
      promotionalNotifications.value = false;
    }
    await _syncNotificationSettings(previous);
  }

  Future<void> toggleEmailNotifications(bool value) async {
    final previous = _notificationSettingsMap();
    emailNotificationsEnabled.value = value;
    await _syncNotificationSettings(previous);
  }

  Future<void> toggleSmsNotifications(bool value) async {
    final previous = _notificationSettingsMap();
    smsNotificationsEnabled.value = value;
    await _syncNotificationSettings(previous);
  }

  Future<void> toggleAppointmentReminders(bool value) async {
    final previous = _notificationSettingsMap();
    appointmentReminders.value = value;
    await _syncNotificationSettings(previous);
  }

  Future<void> togglePromotionalNotifications(bool value) async {
    final previous = _notificationSettingsMap();
    promotionalNotifications.value = value;
    await _syncNotificationSettings(previous);
  }

  Future<void> _syncNotificationSettings(Map<String, bool> previous) async {
    _persistNotificationSettings();
    isSyncingNotificationSettings.value = true;
    final result = await _settingsRepository.updateNotificationSettings(
      settings: _notificationSettingsMap(),
    );
    isSyncingNotificationSettings.value = false;
    result.when(
      success: (model) {
        if (model.status != 'success' || model.result == null) {
          _applyNotificationSettings(previous);
          _persistNotificationSettings();
          _showErrorSnackbar(model.message ?? 'Failed to update settings');
          return;
        }
        _applyNotificationSettings(model.result!);
        _persistNotificationSettings();
      },
      failure: (_) {
        _applyNotificationSettings(previous);
        _persistNotificationSettings();
        _showErrorSnackbar('Failed to update notification settings');
      },
    );
  }

  Map<String, bool> _notificationSettingsMap() => {
    StorageService.APP_NOTIFICATIONS: appNotificationsEnabled.value,
    StorageService.EMAIL_NOTIFICATIONS: emailNotificationsEnabled.value,
    StorageService.SMS_NOTIFICATIONS: smsNotificationsEnabled.value,
    StorageService.APPOINTMENT_REMINDERS: appointmentReminders.value,
    StorageService.PROMOTIONAL_NOTIFICATIONS: promotionalNotifications.value,
  };

  void _applyNotificationSettings(Map<String, dynamic> settings) {
    appNotificationsEnabled.value =
        settings[StorageService.APP_NOTIFICATIONS] as bool? ??
        appNotificationsEnabled.value;
    emailNotificationsEnabled.value =
        settings[StorageService.EMAIL_NOTIFICATIONS] as bool? ??
        emailNotificationsEnabled.value;
    smsNotificationsEnabled.value =
        settings[StorageService.SMS_NOTIFICATIONS] as bool? ??
        smsNotificationsEnabled.value;
    appointmentReminders.value =
        settings[StorageService.APPOINTMENT_REMINDERS] as bool? ??
        appointmentReminders.value;
    promotionalNotifications.value =
        settings[StorageService.PROMOTIONAL_NOTIFICATIONS] as bool? ??
        promotionalNotifications.value;
  }

  void _persistNotificationSettings() {
    final settings = _notificationSettingsMap();
    for (final entry in settings.entries) {
      StorageService.instance.saveBool(entry.key, entry.value);
    }
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

        if (fetchedUser != null) {
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

  // ربط حقيقي: تسجيل خروج فعلي عبر الـ Repository + تنظيف الجلسة + الانتقال لصفحة تسجيل الدخول
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
    appNotificationsEnabled.value = true;
    emailNotificationsEnabled.value = false;
    smsNotificationsEnabled.value = true;
    appointmentReminders.value = true;
    promotionalNotifications.value = false;
    isLoading.value = false;

    Get.closeAllSnackbars();
    Get.offAll<void>(() => const LoginView(), binding: LoginBinding());
    if ((successMessage ?? '').isNotEmpty) {
      ResponseHelper.onSuccess(message: successMessage);
    }
  }

  void updateUser(UserModel userModel) {
    update();
  }

  // ميزة جديدة: تسمية الدور المعروضة في تبويب الإعلانات بالواجهة الجديدة
  String get roleLabelKey {
    switch (currentRole.value) {
      case AccountType.clinic:
        return 'ads.roles.clinic';
      case AccountType.both:
        return 'ads.roles.clinic_with_lab';
      case AccountType.lab:
        return 'ads.roles.lab';
    }
  }

  AccountType _mapRole(String value) {
    switch (value) {
      case 'clinicWithLab':
      case 'clinic_with_lab':
        return AccountType.both;
      case 'lab':
        return AccountType.lab;
      default:
        return AccountType.clinic;
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
    if (isLoading.value) return;
    isLoading(true);
    final result = await _settingsRepository.exportData();
    isLoading(false);
    result.when(
      success: (model) {
        if (model.status != 'success') {
          _showErrorSnackbar(model.message ?? 'Failed to export data');
          return;
        }
        _showSuccessSnackbar(model.message ?? 'Data exported successfully');
      },
      failure: (_) => _showErrorSnackbar('Failed to export data'),
    );
  }

  // ========== Cache Management ==========
  Future<void> clearCache() async {
    if (isLoading.value) return;
    isLoading(true);
    final result = await _settingsRepository.clearCache();
    isLoading(false);
    result.when(
      success: (model) {
        if (model.status != 'success') {
          _showErrorSnackbar(model.message ?? 'Failed to clear cache');
          return;
        }
        _showSuccessSnackbar(model.message ?? 'Cache cleared successfully');
      },
      failure: (_) => _showErrorSnackbar('Failed to clear cache'),
    );
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
