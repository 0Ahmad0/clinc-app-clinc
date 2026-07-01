import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../app/data/notification_model.dart';

class NotificationItem extends StatelessWidget {
  const NotificationItem({
    super.key,
    required this.notification,
    required this.onTap,
    required this.onDelete,
    required this.isReading,
    required this.isDeleting,
  });

  final NotificationModel notification;
  final VoidCallback onTap;
  final VoidCallback onDelete;
  final bool isReading;
  final bool isDeleting;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final accent = _notificationColor(notification.type, colors);

    return InkWell(
      onTap: isReading ? null : onTap,
      borderRadius: BorderRadius.circular(16.r),
      child: Container(
        padding: EdgeInsets.all(14.w),
        margin: EdgeInsets.symmetric(horizontal: 16.w),
        decoration: BoxDecoration(
          color: notification.isRead
              ? colors.surface
              : colors.primary.withValues(alpha: .05),
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: notification.isRead
                ? colors.outlineVariant
                : colors.primary.withValues(alpha: .22),
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 46.r,
              height: 46.r,
              decoration: BoxDecoration(
                color: accent.withValues(alpha: .14),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Icon(_notificationIcon(notification.type), color: accent),
            ),
            12.horizontalSpace,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    notification.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontWeight: notification.isRead
                          ? FontWeight.w600
                          : FontWeight.w800,
                    ),
                  ),
                  5.verticalSpace,
                  Text(
                    notification.body,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: colors.onSurfaceVariant,
                    ),
                  ),
                  7.verticalSpace,
                  Text(
                    TimeOfDay.fromDateTime(
                      notification.createdAt.toLocal(),
                    ).format(context),
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: colors.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
            if (isReading || isDeleting)
              SizedBox(
                width: 22.r,
                height: 22.r,
                child: const CircularProgressIndicator(strokeWidth: 2),
              )
            else
              IconButton(
                onPressed: onDelete,
                icon: Icon(Icons.delete_outline, color: colors.error),
              ),
            if (!notification.isRead)
              Container(
                width: 8.r,
                height: 8.r,
                decoration: BoxDecoration(
                  color: colors.primary,
                  shape: BoxShape.circle,
                ),
              ),
          ],
        ),
      ),
    );
  }

  IconData _notificationIcon(NotificationType type) {
    switch (type) {
      case NotificationType.appointment:
        return Icons.event_note_outlined;
      case NotificationType.labResult:
        return Icons.science_outlined;
      case NotificationType.payment:
        return Icons.payments_outlined;
      case NotificationType.message:
        return Icons.message_outlined;
      case NotificationType.system:
        return Icons.info_outline;
    }
  }

  Color _notificationColor(NotificationType type, ColorScheme colors) {
    switch (type) {
      case NotificationType.appointment:
        return colors.primary;
      case NotificationType.labResult:
        return colors.secondary;
      case NotificationType.payment:
        return Colors.green;
      case NotificationType.message:
        return colors.tertiary;
      case NotificationType.system:
        return Colors.blueGrey;
    }
  }
}
