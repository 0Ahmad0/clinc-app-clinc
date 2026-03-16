import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../../generated/locale_keys.g.dart';
import '../../controllers/settings_controller.dart';
import 'settings_card.dart';
import 'settings_switch_tile.dart';
import 'settings_divider.dart';

class SettingsNotificationsSection extends GetView<SettingsController> {
  const SettingsNotificationsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SettingsCard(
        title: tr(LocaleKeys.settings_sections_notifications),
        icon: Icons.notifications_rounded,
        iconColor: const Color(0xFFF59E0B),
        children: [
          Obx(() => SettingsSwitchTile(
            icon: Icons.notifications_active_rounded,
            iconColor: const Color(0xFFF59E0B),
            title: tr(LocaleKeys.settings_app_notifications),
            value: controller.appNotificationsEnabled.value,
            onChanged: controller.toggleAppNotifications,
          )),
          const SettingsDivider(),
          Obx(() => SettingsSwitchTile(
            icon: Icons.email_rounded,
            iconColor: const Color(0xFF26A69A),
            title: tr(LocaleKeys.settings_email_notifications),
            value: controller.emailNotificationsEnabled.value,
            onChanged: controller.toggleEmailNotifications,
          )),
          const SettingsDivider(),
          Obx(() => SettingsSwitchTile(
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
}
