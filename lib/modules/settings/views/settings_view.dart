import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../generated/locale_keys.g.dart';
import '../controllers/settings_controller.dart';
import 'widgets/language_dialog.dart';
import 'widgets/theme_dialog.dart';
import 'profile_view.dart';
import 'password_view.dart';
import 'support_view.dart';
import 'policy_view.dart';
import 'about_view.dart';

class SettingsView extends GetView<SettingsController> {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: cs.surface,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          _buildHeroHeader(theme, cs, isDark),
          SliverToBoxAdapter(child: 20.verticalSpace),
          _buildAccountSection(theme, cs),
          _buildNotificationsSection(theme, cs),
          _buildAppearanceSection(theme, cs),
          _buildSupportSection(theme, cs),
          _buildLogoutButton(theme, cs),
          SliverToBoxAdapter(child: 40.verticalSpace),
        ],
      ),
    );
  }

  Widget _buildHeroHeader(ThemeData theme, ColorScheme cs, bool isDark) {
    return SliverAppBar(
      pinned: true,
      expandedHeight: 200.h,
      backgroundColor: const Color(0xFF4527A0),
      elevation: 0,
      surfaceTintColor: Colors.transparent,
      leading: IconButton(
        onPressed: () => Get.back(),
        icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white),
      ),
      title: Text(
        tr(LocaleKeys.settings_title),
        style: theme.textTheme.titleMedium?.copyWith(
          color: Colors.white,
          fontWeight: FontWeight.w800,
        ),
      ),
      flexibleSpace: FlexibleSpaceBar(
        collapseMode: CollapseMode.pin,
        background: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: isDark
                  ? [const Color(0xFF311B92), const Color(0xFF1A0050)]
                  : [const Color(0xFF673AB7), const Color(0xFF311B92)],
            ),
          ),
          child: SafeArea(
            child: Obx(() {
              final profile = controller.profile.value;
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  60.verticalSpace,
                  GestureDetector(
                    onTap: () => Get.to(() => const ProfileView()),
                    child: Stack(
                      children: [
                        Container(
                          width: 72.r,
                          height: 72.r,
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [Color(0xFF9C27B0), Color(0xFF673AB7)],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.white.withValues(alpha: 0.4),
                              width: 2.5,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.2),
                                blurRadius: 12,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Center(
                            child: Text(
                              profile.name.isNotEmpty ? profile.name[0] : 'م',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 28.sp,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            width: 22.r,
                            height: 22.r,
                            decoration: BoxDecoration(
                              color: const Color(0xFF7C4DFF),
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.white,
                                width: 2,
                              ),
                            ),
                            child: Icon(
                              Icons.edit_rounded,
                              color: Colors.white,
                              size: 11.sp,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  10.verticalSpace,
                  Text(
                    profile.name,
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  4.verticalSpace,
                  Text(
                    profile.email,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: Colors.white.withValues(alpha: 0.7),
                    ),
                  ),
                ],
              );
            }),
          ),
        ),
      ),
    );
  }

  Widget _buildAccountSection(ThemeData theme, ColorScheme cs) {
    return SliverToBoxAdapter(
      child: _SettingsCard(
        title: tr(LocaleKeys.settings_sections_account),
        icon: Icons.manage_accounts_rounded,
        iconColor: const Color(0xFF673AB7),
        children: [
          _SettingsTile(
            icon: Icons.person_rounded,
            iconColor: const Color(0xFF673AB7),
            title: tr(LocaleKeys.settings_profile),
            subtitle: tr(LocaleKeys.settings_profile_subtitle),
            onTap: () => Get.to(() => const ProfileView()),
          ),
          _Divider(),
          _SettingsTile(
            icon: Icons.lock_rounded,
            iconColor: const Color(0xFF1E88E5),
            title: tr(LocaleKeys.settings_password),
            subtitle: tr(LocaleKeys.settings_password_subtitle),
            onTap: () => Get.to(() => const PasswordView()),
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationsSection(ThemeData theme, ColorScheme cs) {
    return SliverToBoxAdapter(
      child: _SettingsCard(
        title: tr(LocaleKeys.settings_sections_notifications),
        icon: Icons.notifications_rounded,
        iconColor: const Color(0xFFF59E0B),
        children: [
          Obx(() => _SwitchTile(
            icon: Icons.notifications_active_rounded,
            iconColor: const Color(0xFFF59E0B),
            title: tr(LocaleKeys.settings_app_notifications),
            value: controller.appNotificationsEnabled.value,
            onChanged: controller.toggleAppNotifications,
          )),
          _Divider(),
          Obx(() => _SwitchTile(
            icon: Icons.email_rounded,
            iconColor: const Color(0xFF26A69A),
            title: tr(LocaleKeys.settings_email_notifications),
            value: controller.emailNotificationsEnabled.value,
            onChanged: controller.toggleEmailNotifications,
          )),
          _Divider(),
          Obx(() => _SwitchTile(
            icon: Icons.sms_rounded,
            iconColor: const Color(0xFF42A5F5),
            title: tr(LocaleKeys.settings_sms_notifications),
            value: controller.smsNotificationsEnabled.value,
            onChanged: controller.toggleSmsNotifications,
          )),
        ],
      ),
    );
  }

  Widget _buildAppearanceSection(ThemeData theme, ColorScheme cs) {
    return SliverToBoxAdapter(
      child: _SettingsCard(
        title: tr(LocaleKeys.settings_sections_appearance),
        icon: Icons.palette_rounded,
        iconColor: const Color(0xFFEC4899),
        children: [
          Obx(() => _SettingsTile(
            icon: Icons.language_rounded,
            iconColor: const Color(0xFF10B981),
            title: tr(LocaleKeys.settings_language),
            subtitle: controller.currentLanguage.value == 'ar' ? 'العربية' : 'English',
            onTap: () => _showLanguageDialog(),
          )),
          _Divider(),
          Obx(() => _SettingsTile(
            icon: Icons.brightness_6_rounded,
            iconColor: const Color(0xFFF59E0B),
            title: tr(LocaleKeys.settings_theme),
            subtitle: _getThemeName(controller.themeMode.value),
            onTap: () => _showThemeDialog(),
          )),
        ],
      ),
    );
  }

  Widget _buildSupportSection(ThemeData theme, ColorScheme cs) {
    return SliverToBoxAdapter(
      child: _SettingsCard(
        title: tr(LocaleKeys.settings_sections_support),
        icon: Icons.support_agent_rounded,
        iconColor: const Color(0xFF2563EB),
        children: [
          _SettingsTile(
            icon: Icons.support_agent_rounded,
            iconColor: const Color(0xFF2563EB),
            title: 'المساعدة والدعم',
            subtitle: 'أسئلة شائعة وتواصل مع الفريق',
            onTap: () => Get.to(() => const SupportView()),
          ),
          _Divider(),
          _SettingsTile(
            icon: Icons.privacy_tip_rounded,
            iconColor: const Color(0xFF8B5CF6),
            title: tr(LocaleKeys.settings_privacy_policy),
            onTap: () => Get.to(() => const PolicyView()),
          ),
          _Divider(),
          _SettingsTile(
            icon: Icons.info_rounded,
            iconColor: const Color(0xFF64748B),
            title: tr(LocaleKeys.settings_about),
            subtitle: 'الإصدار 1.0.0',
            onTap: () => Get.to(() => const AboutView()),
          ),
        ],
      ),
    );
  }

  Widget _buildLogoutButton(ThemeData theme, ColorScheme cs) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        child: GestureDetector(
          onTap: () {
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
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 18.sp,
                      ),
                    ),
                  ],
                ),
                content: Text(tr(LocaleKeys.settings_confirm_logout)),
                actions: [
                  TextButton(
                    onPressed: () => Get.back(),
                    child: Text(tr(LocaleKeys.settings_cancel)),
                  ),
                  ElevatedButton(
                    onPressed: () => Get.back(),
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
          },
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 16.h),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFFEF4444), Color(0xFFDC2626)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16.r),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFFEF4444).withValues(alpha: 0.3),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.logout_rounded, color: Colors.white, size: 20),
                10.horizontalSpace,
                Text(
                  tr(LocaleKeys.settings_logout),
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                    fontSize: 15.sp,
                  ),
                ),
              ],
            ),
          ),
        ),
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

  void _showLanguageDialog() {
    showLanguageBottomSheet();
  }

  void _showThemeDialog() {
    showThemeBottomSheet();
  }
}

class _SettingsCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color iconColor;
  final List<Widget> children;

  const _SettingsCard({
    required this.title,
    required this.icon,
    required this.iconColor,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    return Padding(
      padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 12.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 8.h, right: 4.w),
            child: Row(
              children: [
                Icon(icon, color: iconColor, size: 16.sp),
                6.horizontalSpace,
                Text(
                  title,
                  style: theme.textTheme.labelLarge?.copyWith(
                    color: iconColor,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.3,
                  ),
                ),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: cs.surface,
              borderRadius: BorderRadius.circular(18.r),
              border: Border.all(
                color: cs.outlineVariant.withValues(alpha: 0.3),
              ),
              boxShadow: [
                BoxShadow(
                  color: cs.shadow.withValues(alpha: 0.04),
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(children: children),
          ),
        ],
      ),
    );
  }
}

class _SettingsTile extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String? subtitle;
  final VoidCallback onTap;

  const _SettingsTile({
    required this.icon,
    required this.iconColor,
    required this.title,
    this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(18.r),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        child: Row(
          children: [
            Container(
              width: 38.r,
              height: 38.r,
              decoration: BoxDecoration(
                color: iconColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(11.r),
              ),
              child: Icon(icon, color: iconColor, size: 20.sp),
            ),
            14.horizontalSpace,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  if (subtitle != null) ...[
                    4.verticalSpace,
                    Text(
                      subtitle!,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: cs.onSurfaceVariant.withValues(alpha: 0.7),
                      ),
                    ),
                  ],
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios_rounded,
              size: 15.sp,
              color: cs.onSurfaceVariant.withValues(alpha: 0.4),
            ),
          ],
        ),
      ),
    );
  }
}

class _SwitchTile extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final bool value;
  final ValueChanged<bool> onChanged;

  const _SwitchTile({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
      child: Row(
        children: [
          Container(
            width: 38.r,
            height: 38.r,
            decoration: BoxDecoration(
              color: iconColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(11.r),
            ),
            child: Icon(icon, color: iconColor, size: 20.sp),
          ),
          14.horizontalSpace,
          Expanded(
            child: Text(
              title,
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Switch.adaptive(
            value: value,
            onChanged: onChanged,
            activeColor: iconColor,
          ),
        ],
      ),
    );
  }
}

class _Divider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Divider(
      height: 1,
      thickness: 1,
      indent: 68.w,
      endIndent: 0,
      color: Theme.of(context).colorScheme.outlineVariant.withValues(alpha: 0.2),
    );
  }
}
