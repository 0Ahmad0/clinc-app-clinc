import 'package:flutter/material.dart';

import '../../../../config/theme/app_shadows.dart';
import '../../../../config/theme/app_spacing.dart';
import '../../../../shared/extensions/context_extensions.dart';
import '../../domain/app_notification.dart';
import '../notification_kind_style.dart';

/// A single notification row: kind icon, title + time, body and a "new" chip
/// while unread. Read rows are dimmed and flat.
class NotificationCard extends StatelessWidget {
  const NotificationCard({
    super.key,
    required this.notification,
    required this.unread,
    required this.onTap,
  });

  final AppNotification notification;
  final bool unread;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final accent = notification.kind.accent(colors);
    return Opacity(
      opacity: unread ? 1 : 0.72,
      child: Material(
        color: colors.surface,
        borderRadius: BorderRadius.circular(AppRadius.homeQuickAction),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(AppRadius.homeQuickAction),
          child: Container(
            padding: const EdgeInsetsDirectional.all(AppSpacing.md),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppRadius.homeQuickAction),
              border: Border.all(
                color: unread
                    ? accent.withValues(alpha: 0.14)
                    : colors.line,
                width: unread ? 1.5 : 1,
              ),
              boxShadow: unread ? AppShadows.homeCard : null,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: AppSizes.doctorsHeaderIcon - 4,
                  height: AppSizes.doctorsHeaderIcon - 4,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: accent.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(AppRadius.field),
                  ),
                  child: Icon(
                    notification.kind.icon,
                    size: AppSizes.iconMd,
                    color: accent,
                  ),
                ),
                AppGaps.w12,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              notification.title,
                              style: context.textTheme.bodyMedium?.copyWith(
                                color: colors.ink,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          AppGaps.w8,
                          Text(
                            notification.time,
                            textDirection: TextDirection.ltr,
                            style: context.textTheme.labelSmall?.copyWith(
                              color: colors.muted,
                            ),
                          ),
                        ],
                      ),
                      AppGaps.h8,
                      Text(
                        notification.body,
                        style: context.textTheme.bodySmall?.copyWith(
                          color: colors.gray,
                        ),
                      ),
                      if (unread) ...[
                        AppGaps.h8,
                        Container(
                          padding: const EdgeInsetsDirectional.symmetric(
                            horizontal: AppSpacing.sm,
                            vertical: AppSpacing.xxs,
                          ),
                          decoration: BoxDecoration(
                            color: accent.withValues(alpha: 0.12),
                            borderRadius: BorderRadius.circular(AppRadius.pill),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                width: AppSpacing.xs - 2,
                                height: AppSpacing.xs - 2,
                                decoration: BoxDecoration(
                                  color: accent,
                                  shape: BoxShape.circle,
                                ),
                              ),
                              AppGaps.w8,
                              Text(
                                context.l10n.notifNew,
                                style: context.textTheme.labelSmall?.copyWith(
                                  color: accent,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
