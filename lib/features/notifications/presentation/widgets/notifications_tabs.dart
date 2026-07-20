import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../config/theme/app_spacing.dart';
import '../../../../shared/extensions/context_extensions.dart';
import '../../domain/notification_tab.dart';
import '../cubit/notifications_cubit.dart';
import '../cubit/notifications_state.dart';
import '../notifications_catalog.dart';
import '../../../../shared/widgets/app_tab_chip.dart';

/// The all / unread / read filter row.
class NotificationsTabs extends StatelessWidget {
  const NotificationsTabs({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final all = localizedNotifications(l10n);
    final format = NumberFormat.decimalPattern(
      Localizations.localeOf(context).toLanguageTag(),
    );
    return BlocBuilder<NotificationsCubit, NotificationsState>(
      builder: (context, state) {
        final cubit = context.read<NotificationsCubit>();
        final total = cubit.active(all).length;
        final unread = cubit.unreadCount(all);
        final counts = {
          NotificationTab.all: total,
          NotificationTab.unread: unread,
          NotificationTab.read: total - unread,
        };
        final labels = {
          NotificationTab.all: l10n.notifTabAll,
          NotificationTab.unread: l10n.notifTabUnread,
          NotificationTab.read: l10n.notifTabRead,
        };
        return Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(
            AppSpacing.screen,
            AppSpacing.md,
            AppSpacing.screen,
            AppSpacing.xxs,
          ),
          child: Row(
            children: [
              for (final tab in NotificationTab.values)
                Padding(
                  padding: const EdgeInsetsDirectional.only(end: AppSpacing.xs),
                  child: AppTabChip(
                    label: labels[tab]!,
                    count: format.format(counts[tab]),
                    selected: state.tab == tab,
                    onTap: () => cubit.selectTab(tab),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
