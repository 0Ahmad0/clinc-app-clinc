import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../../generated/locale_keys.g.dart';
import '../../controllers/settings_controller.dart';
import 'settings_card.dart';
import 'settings_tile.dart';
import 'settings_divider.dart';
import 'language_dialog.dart';
import 'theme_dialog.dart';

class SettingsAppearanceSection extends GetView<SettingsController> {
  const SettingsAppearanceSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SettingsCard(
        title: tr(LocaleKeys.settings_sections_appearance),
        icon: Icons.palette_rounded,
        iconColor: const Color(0xFFEC4899),
        children: [
          Obx(() => SettingsTile(
            icon: Icons.language_rounded,
            iconColor: const Color(0xFF10B981),
            title: tr(LocaleKeys.settings_language),
            subtitle: controller.currentLanguage.value == 'ar'
                ? 'العربية'
                : 'English',
            onTap: showLanguageBottomSheet,
          )),
          const SettingsDivider(),
          Obx(() => SettingsTile(
            icon: Icons.brightness_6_rounded,
            iconColor: const Color(0xFFF59E0B),
            title: tr(LocaleKeys.settings_theme),
            subtitle: controller.getThemeName(controller.themeMode.value),
            onTap: showThemeBottomSheet,
          )),
        ],
      ),
    );
  }
}
