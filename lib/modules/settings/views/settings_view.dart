import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../controllers/settings_controller.dart';
import 'widgets/settings_hero_header.dart';
import 'widgets/settings_account_section.dart';
import 'widgets/settings_notifications_section.dart';
import 'widgets/settings_appearance_section.dart';
import 'widgets/settings_support_section.dart';
import 'widgets/settings_logout_btn.dart';

/// Root shell — pure layout, zero logic.
class SettingsView extends GetView<SettingsController> {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: CustomScrollView(
         
        slivers: [
          const SettingsHeroHeader(),
          SliverToBoxAdapter(child: 20.verticalSpace),
          const SettingsAccountSection(),
          const SettingsNotificationsSection(),
          const SettingsAppearanceSection(),
          const SettingsSupportSection(),
          const SettingsLogoutBtn(),
          SliverToBoxAdapter(child: 40.verticalSpace),
        ],
      ),
    );
  }
}
