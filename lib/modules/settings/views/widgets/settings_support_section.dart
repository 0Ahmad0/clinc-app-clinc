import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../../generated/locale_keys.g.dart';
import '../support_view.dart';
import '../policy_view.dart';
import '../about_view.dart';
import 'settings_card.dart';
import 'settings_tile.dart';
import 'settings_divider.dart';

class SettingsSupportSection extends StatelessWidget {
  const SettingsSupportSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SettingsCard(
        title: tr(LocaleKeys.settings_sections_support),
        icon: Icons.support_agent_rounded,
        iconColor: const Color(0xFF2563EB),
        children: [
          SettingsTile(
            icon: Icons.support_agent_rounded,
            iconColor: const Color(0xFF2563EB),
            title: 'المساعدة والدعم',
            subtitle: 'أسئلة شائعة وتواصل مع الفريق',
            onTap: () => Get.to(() => const SupportView()),
          ),
          const SettingsDivider(),
          SettingsTile(
            icon: Icons.privacy_tip_rounded,
            iconColor: const Color(0xFF8B5CF6),
            title: tr(LocaleKeys.settings_privacy_policy),
            onTap: () => Get.to(() => const PolicyView()),
          ),
          const SettingsDivider(),
          SettingsTile(
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
}
