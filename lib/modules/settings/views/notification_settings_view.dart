import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/settings_controller.dart';

class NotificationSettingsView extends GetView<SettingsController> {
  const NotificationSettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Notification settings')),
      body: Obx(() {
        final syncing = controller.isSyncingNotificationSettings.value;
        return ListView(
          children: [
            if (syncing) const LinearProgressIndicator(),
            SwitchListTile(
              title: const Text('App notifications'),
              value: controller.appNotificationsEnabled.value,
              onChanged: syncing
                  ? null
                  : (value) => controller.toggleAppNotifications(value),
            ),
            SwitchListTile(
              title: const Text('Email notifications'),
              value: controller.emailNotificationsEnabled.value,
              onChanged: syncing
                  ? null
                  : (value) => controller.toggleEmailNotifications(value),
            ),
            SwitchListTile(
              title: const Text('SMS notifications'),
              value: controller.smsNotificationsEnabled.value,
              onChanged: syncing
                  ? null
                  : (value) => controller.toggleSmsNotifications(value),
            ),
            SwitchListTile(
              title: const Text('Appointment reminders'),
              value: controller.appointmentReminders.value,
              onChanged: syncing || !controller.appNotificationsEnabled.value
                  ? null
                  : (value) => controller.toggleAppointmentReminders(value),
            ),
            SwitchListTile(
              title: const Text('Promotional notifications'),
              value: controller.promotionalNotifications.value,
              onChanged: syncing || !controller.appNotificationsEnabled.value
                  ? null
                  : (value) => controller.togglePromotionalNotifications(value),
            ),
          ],
        );
      }),
    );
  }
}
