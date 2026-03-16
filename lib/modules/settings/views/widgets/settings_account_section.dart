import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../../generated/locale_keys.g.dart';
import '../../controllers/settings_controller.dart';
import '../profile_view.dart';
import '../password_view.dart';
import 'settings_card.dart';
import 'settings_tile.dart';
import 'settings_divider.dart';

class SettingsAccountSection extends GetView<SettingsController> {
  const SettingsAccountSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SettingsCard(
        title: tr(LocaleKeys.settings_sections_account),
        icon: Icons.manage_accounts_rounded,
        iconColor: const Color(0xFF673AB7),
        children: [
          SettingsTile(
            icon: Icons.person_rounded,
            iconColor: const Color(0xFF673AB7),
            title: tr(LocaleKeys.settings_profile),
            subtitle: tr(LocaleKeys.settings_profile_subtitle),
            onTap: () => Get.to(() => const ProfileView()),
          ),
          const SettingsDivider(),
          SettingsTile(
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
}
