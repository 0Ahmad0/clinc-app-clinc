import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/theme/app_spacing.dart';
import '../../../../shared/extensions/context_extensions.dart';
import '../../domain/app_notification.dart';
import '../cubit/notifications_cubit.dart';
import 'notification_card.dart';

/// A dated section: a gradient marker + label header followed by its cards.
class NotificationGroup extends StatelessWidget {
  const NotificationGroup({
    super.key,
    required this.label,
    required this.items,
  });

  final String label;
  final List<AppNotification> items;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final cubit = context.read<NotificationsCubit>();
    final state = cubit.state;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsetsDirectional.symmetric(
            vertical: AppSpacing.sm,
          ),
          child: Row(
            children: [
              Container(
                width: AppSizes.homeSectionMarkerWidth,
                height: AppSizes.homeSectionMarkerHeight,
                decoration: BoxDecoration(
                  color: colors.primary500,
                  borderRadius: BorderRadius.circular(AppRadius.pill),
                ),
              ),
              AppGaps.w8,
              Text(
                label,
                style: context.textTheme.bodyMedium?.copyWith(
                  color: colors.ink,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
        for (final notification in items)
          Padding(
            padding: const EdgeInsetsDirectional.only(bottom: AppSpacing.sm),
            child: NotificationCard(
              notification: notification,
              unread: state.isUnread(notification),
              onTap: () => cubit.open(notification.id),
            ),
          ),
      ],
    );
  }
}
