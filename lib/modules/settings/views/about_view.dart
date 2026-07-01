import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'widgets/settings_info_page.dart';

class AboutView extends StatelessWidget {
  const AboutView({super.key});

  @override
  Widget build(BuildContext context) {
    return SettingsInfoPage(
      title: tr('settings.about'),
      icon: Icons.info_outline,
      children: [
        Text(
          tr('settings.about_content'),
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        const SizedBox(height: 20),
        Text('${tr('settings.version')}: 1.0.0'),
      ],
    );
  }
}
