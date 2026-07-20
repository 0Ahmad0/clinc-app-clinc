import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/theme/app_spacing.dart';
import '../../../../shared/extensions/context_extensions.dart';
import '../cubit/notifications_cubit.dart';
import '../cubit/notifications_state.dart';
import '../notifications_catalog.dart';
import '../widgets/notification_group.dart';
import '../widgets/notifications_empty.dart';
import '../widgets/notifications_header.dart';
import '../widgets/notifications_tabs.dart';

class NotificationsView extends StatelessWidget {
  const NotificationsView({super.key});

  @override
  Widget build(BuildContext context) {
    final all = localizedNotifications(context.l10n);
    return Scaffold(
      backgroundColor: context.colors.bg,
      body: Column(
        children: [
          const NotificationsHeader(),
          const NotificationsTabs(),
          Expanded(
            child: BlocBuilder<NotificationsCubit, NotificationsState>(
              builder: (context, state) {
                final groups = context.read<NotificationsCubit>().grouped(all);
                if (groups.isEmpty) return const NotificationsEmpty();
                return ListView(
                  padding: const EdgeInsetsDirectional.fromSTEB(
                    AppSpacing.screen,
                    AppSpacing.xs,
                    AppSpacing.screen,
                    AppSpacing.xl,
                  ),
                  children: [
                    for (final group in groups)
                      NotificationGroup(
                        label: group.label,
                        items: group.items,
                      ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
