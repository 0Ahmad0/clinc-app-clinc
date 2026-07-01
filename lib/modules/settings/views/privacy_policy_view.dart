import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'widgets/settings_info_page.dart';

class PrivacyPolicyView extends StatelessWidget {
  const PrivacyPolicyView({super.key});

  @override
  Widget build(BuildContext context) {
    return SettingsInfoPage(
      title: tr('settings.privacy_policy'),
      icon: Icons.privacy_tip_outlined,
      children: [
        Text(
          tr('settings.privacy_content'),
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(height: 1.7),
        ),
      ],
    );
  }
}
