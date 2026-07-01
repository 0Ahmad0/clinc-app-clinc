import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'widgets/settings_info_page.dart';

class ContactSupportView extends StatelessWidget {
  const ContactSupportView({super.key});

  @override
  Widget build(BuildContext context) {
    return SettingsInfoPage(
      title: tr('settings.contact_support'),
      icon: Icons.contact_support_outlined,
      children: [
        Text(
          tr('settings.contact_support_content'),
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        const SizedBox(height: 20),
        const ListTile(
          leading: Icon(Icons.email_outlined),
          title: Text('support@clinicapp.com'),
        ),
        const ListTile(
          leading: Icon(Icons.phone_outlined),
          title: Text('+963 11 000 0000'),
        ),
      ],
    );
  }
}
