import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:image_picker/image_picker.dart';

import '../../../app/routes/app_routes.dart';
import '../../../generated/locale_keys.g.dart';
import '../controllers/settings_controller.dart';
import 'widgets/profile_header.dart';
import 'widgets/settings_section.dart';
import 'widgets/settings_tile.dart';
import 'widgets/theme_dialog.dart';
import 'widgets/language_dialog.dart';
import 'widgets/profile_edit_dialog.dart';

class SettingsView extends GetView<SettingsController> {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    return Scaffold(
      backgroundColor: cs.surface,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // 1. Sliver App Bar
          SliverAppBar(
            pinned: true,
            floating: true,
            backgroundColor: cs.surface,
            elevation: 0,
            centerTitle: true,
            title: Text(
              tr(LocaleKeys.settings_title),
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w800,
              ),
            ),
          ),

          // 2. Profile Header
          SliverToBoxAdapter(
            child: Obx(
              () => ProfileHeader(
                profile: controller.profile.value,
                onEdit: () => _showImagePickerDialog(context),
              ),
            ),
          ),

          // 3. Settings Sections
          SliverPadding(
            padding: EdgeInsets.symmetric(vertical: 16.h),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                // Account Section
                SettingsSection(
                  title: tr(LocaleKeys.settings_sections_account),
                  children: [
                    SettingsTile(
                      icon: Icons.person_outline,
                      title: tr(LocaleKeys.settings_profile),
                      subtitle: tr(LocaleKeys.settings_profile_subtitle),
                      onTap: () => _showEditProfileDialog(context),
                    ),
                    SettingsTile(
                      icon: Icons.lock_outline,
                      title: tr(LocaleKeys.settings_password),
                      subtitle: tr(LocaleKeys.settings_password_subtitle),
                      onTap: () => Get.toNamed(AppRoutes.changePassword),
                    ),
                  ],
                ),

                // Notifications Section
                SettingsSection(
                  title: tr(LocaleKeys.settings_sections_notifications),
                  children: [
                    Obx(
                      () => SettingsTile.switchTile(
                        icon: Icons.notifications_outlined,
                        title: tr(LocaleKeys.settings_app_notifications),
                        value: controller.appNotificationsEnabled.value,
                        onChanged: controller.toggleAppNotifications,
                      ),
                    ),
                    Obx(
                      () => SettingsTile.switchTile(
                        icon: Icons.email_outlined,
                        title: tr(LocaleKeys.settings_email_notifications),
                        value: controller.emailNotificationsEnabled.value,
                        onChanged: controller.toggleEmailNotifications,
                      ),
                    ),
                    Obx(
                      () => SettingsTile.switchTile(
                        icon: Icons.sms_outlined,
                        title: tr(LocaleKeys.settings_sms_notifications),
                        value: controller.smsNotificationsEnabled.value,
                        onChanged: controller.toggleSmsNotifications,
                      ),
                    ),
                  ],
                ),

                // Appearance Section
                SettingsSection(
                  title: tr(LocaleKeys.settings_sections_appearance),
                  children: [
                    Obx(
                      () => SettingsTile(
                        icon: Icons.language_outlined,
                        title: tr(LocaleKeys.settings_language),
                        subtitle: controller.currentLanguage.value == 'ar'
                            ? 'العربية'
                            : 'English',
                        onTap: () => _showLanguageDialog(context),
                      ),
                    ),
                    Obx(
                      () => SettingsTile(
                        icon: Icons.brightness_6_outlined,
                        title: tr(LocaleKeys.settings_theme),
                        subtitle: _getThemeName(controller.themeMode.value),
                        onTap: () => _showThemeDialog(context),
                      ),
                    ),
                  ],
                ),

                // Support Section
                SettingsSection(
                  title: tr(LocaleKeys.settings_sections_support),
                  children: [
                    SettingsTile(
                      icon: Icons.help_outline,
                      title: tr(LocaleKeys.settings_help),
                      onTap: () => Get.toNamed(AppRoutes.help),
                    ),
                    SettingsTile(
                      icon: Icons.contact_support_outlined,
                      title: tr(LocaleKeys.settings_contact_support),
                      onTap: () => Get.toNamed(AppRoutes.contactSupport),
                    ),
                    SettingsTile(
                      icon: Icons.privacy_tip_outlined,
                      title: tr(LocaleKeys.settings_privacy_policy),
                      onTap: () => Get.toNamed(AppRoutes.privacyPolicy),
                    ),
                    SettingsTile(
                      icon: Icons.info_outline,
                      title: tr(LocaleKeys.settings_about),
                      onTap: () => Get.toNamed(AppRoutes.about),
                    ),
                  ],
                ),

                // Logout Button
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 8.h,
                  ),
                  child: Obx(
                    () => ElevatedButton.icon(
                      onPressed: controller.isLoading.value
                          ? null
                          : () => _confirmLogout(context),
                      icon: controller.isLoading.value
                          ? SizedBox(
                              width: 20.w,
                              height: 20.w,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: cs.onPrimary,
                              ),
                            )
                          : Icon(Icons.logout, color: cs.onPrimary),
                      label: Text(
                        tr(LocaleKeys.settings_logout),
                        style: theme.textTheme.labelLarge?.copyWith(
                          color: cs.onPrimary,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: cs.error,
                        disabledBackgroundColor: cs.error.withValues(alpha: .6),
                        padding: EdgeInsets.symmetric(vertical: 14.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                      ),
                    ),
                  ),
                ),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  String _getThemeName(ThemeMode mode) {
    switch (mode) {
      case ThemeMode.system:
        return tr(LocaleKeys.settings_theme_system);
      case ThemeMode.light:
        return tr(LocaleKeys.settings_theme_light);
      case ThemeMode.dark:
        return tr(LocaleKeys.settings_theme_dark);
    }
  }

  void _showEditProfileDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => ProfileEditDialog(
        profile: controller.profile.value,
        onSave: (newProfile) => controller.updateProfile(newProfile),
      ),
    );
  }

  Future<void> _showImagePickerDialog(BuildContext context) async {
    final source = await showModalBottomSheet<ImageSource>(
      context: context,
      builder: (sheetContext) => SafeArea(
        child: Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.photo_library_outlined),
              title: Text(tr('settings.image_picker.gallery')),
              onTap: () => Navigator.of(sheetContext).pop(ImageSource.gallery),
            ),
            ListTile(
              leading: const Icon(Icons.camera_alt_outlined),
              title: Text(tr('settings.image_picker.camera')),
              onTap: () => Navigator.of(sheetContext).pop(ImageSource.camera),
            ),
          ],
        ),
      ),
    );
    if (source != null) await controller.pickProfileImage(source);
  }

  void _showLanguageDialog(BuildContext context) {
    showDialog(context: context, builder: (context) => const LanguageDialog());
  }

  void _showThemeDialog(BuildContext context) {
    showDialog(context: context, builder: (context) => const ThemeDialog());
  }

  Future<void> _confirmLogout(BuildContext context) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(tr(LocaleKeys.settings_logout)),
        content: Text(tr(LocaleKeys.settings_confirm_logout)),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: Text(tr(LocaleKeys.settings_cancel)),
          ),
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(true),
            child: Text(
              tr(LocaleKeys.settings_confirm),
              style: TextStyle(
                color: Theme.of(dialogContext).colorScheme.error,
              ),
            ),
          ),
        ],
      ),
    );
    if (confirmed == true) await controller.logout();
  }
}
