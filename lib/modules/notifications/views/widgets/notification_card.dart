import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../app/data/notification_model.dart';
import '../../../../generated/locale_keys.g.dart';
import '../../controllers/notifications_controller.dart';
import 'notification_confirm_dialog.dart';

/// Dismissible, animated notification card with unread indicator.
class NotificationCard extends GetView<NotificationsController> {
  final NotificationModel notification;
  const NotificationCard({super.key, required this.notification});

  @override
  Widget build(BuildContext context) {
    final cs       = Theme.of(context).colorScheme;
    final isUnread = notification.status == NotificationStatus.unread;
    final color    = notification.type.color;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
      child: Dismissible(
        key: ValueKey(notification.id),
        direction: DismissDirection.endToStart,
        background: _DismissBackground(cs: cs),
        confirmDismiss: (_) => Get.dialog(NotificationConfirmDialog(
          title: tr(LocaleKeys.notifications_delete),
          body: tr(LocaleKeys.notifications_confirm_delete_all),
          onConfirm: () {},
          isDestructive: true,
        )),
        onDismissed: (_) => controller.deleteNotification(notification.id),
        child: GestureDetector(
          onTap: () { if (isUnread) controller.markAsRead(notification.id); },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: EdgeInsets.all(14.r),
            decoration: BoxDecoration(
              color: isUnread
                  ? color.withValues(alpha: 0.06)
                  : cs.surfaceContainerHighest.withValues(alpha: 0.35),
              borderRadius: BorderRadius.circular(18.r),
              border: Border.all(
                color: isUnread
                    ? color.withValues(alpha: 0.25)
                    : cs.outlineVariant.withValues(alpha: 0.15),
                width: isUnread ? 1.5 : 1,
              ),
              boxShadow: isUnread
                  ? [BoxShadow(color: color.withValues(alpha: 0.08), blurRadius: 12, offset: const Offset(0, 3))]
                  : [],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _TypeIcon(type: notification.type, color: color),
                12.horizontalSpace,
                Expanded(
                  child: _CardContent(
                    notification: notification,
                    isUnread: isUnread,
                    color: color,
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

// ── Private sub-widgets ───────────────────────────────────────────────────────

class _DismissBackground extends StatelessWidget {
  final ColorScheme cs;
  const _DismissBackground({required this.cs});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: cs.error,
        borderRadius: BorderRadius.circular(18.r),
      ),
      alignment: Alignment.centerRight,
      padding: EdgeInsets.only(right: 20.w),
      child: Icon(Icons.delete_rounded, color: cs.onError, size: 24.sp),
    );
  }
}

class _TypeIcon extends StatelessWidget {
  final NotificationType type;
  final Color color;
  const _TypeIcon({required this.type, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 46.r,
      height: 46.r,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [color.withValues(alpha: 0.8), color],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(13.r),
        boxShadow: [
          BoxShadow(color: color.withValues(alpha: 0.25), blurRadius: 8, offset: const Offset(0, 3)),
        ],
      ),
      child: Icon(type.icon, color: Colors.white, size: 22.sp),
    );
  }
}

class _CardContent extends StatelessWidget {
  final NotificationModel notification;
  final bool isUnread;
  final Color color;
  const _CardContent({required this.notification, required this.isUnread, required this.color});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs    = theme.colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                notification.title,
                style: theme.textTheme.titleSmall?.copyWith(
                  fontWeight: isUnread ? FontWeight.w800 : FontWeight.w600,
                  color: isUnread ? cs.onSurface : cs.onSurfaceVariant,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            8.horizontalSpace,
            Text(
              notification.formattedTime,
              style: theme.textTheme.bodySmall?.copyWith(
                color: cs.onSurfaceVariant.withValues(alpha: 0.7),
                fontSize: 10.sp,
              ),
            ),
          ],
        ),
        5.verticalSpace,
        Text(
          notification.body,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: isUnread
                ? cs.onSurface.withValues(alpha: 0.75)
                : cs.onSurfaceVariant.withValues(alpha: 0.6),
            height: 1.45,
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        if (isUnread) ...[
          8.verticalSpace,
          _UnreadBadge(color: color),
        ],
      ],
    );
  }
}

class _UnreadBadge extends StatelessWidget {
  final Color color;
  const _UnreadBadge({required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 6.r,
            height: 6.r,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          5.horizontalSpace,
          Text(
            'جديد',
            style: TextStyle(color: color, fontSize: 10.sp, fontWeight: FontWeight.w700),
          ),
        ],
      ),
    );
  }
}
