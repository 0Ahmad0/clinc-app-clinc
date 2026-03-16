import 'package:flutter/material.dart';
import 'widgets/notifications_filter_bar.dart';
import 'widgets/notifications_header.dart';
import 'widgets/notifications_list.dart';

/// Root shell — pure layout, zero logic.
class NotificationsView extends StatelessWidget {
  const NotificationsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: const Column(
        children: [
          NotificationsHeader(),
          NotificationsFilterBar(),
          Expanded(child: NotificationsList()),
        ],
      ),
    );
  }
}
