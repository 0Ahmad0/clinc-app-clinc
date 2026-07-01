import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'widgets/settings_info_page.dart';

class HelpView extends StatelessWidget {
  const HelpView({super.key});

  @override
  Widget build(BuildContext context) {
    return SettingsInfoPage(
      title: tr('settings.help'),
      icon: Icons.help_outline,
      children: [
        _HelpItem(
          title: tr('settings.help_doctors_title'),
          body: tr('settings.help_doctors_body'),
        ),
        _HelpItem(
          title: tr('settings.help_appointments_title'),
          body: tr('settings.help_appointments_body'),
        ),
        _HelpItem(
          title: tr('settings.help_reports_title'),
          body: tr('settings.help_reports_body'),
        ),
      ],
    );
  }
}

class _HelpItem extends StatelessWidget {
  const _HelpItem({required this.title, required this.body});

  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(title),
      childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      children: [Text(body)],
    );
  }
}
