import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../app/data/notification_model.dart';
import '../../controllers/notifications_controller.dart';

class NotificationItem extends GetView<NotificationsController> {
  final NotificationModel notification;

  const NotificationItem({super.key, required this.notification});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    return InkWell(
      onTap: () {
        // وضع الإشعار كمقروء عند النقر عليه
        if (notification.status == NotificationStatus.unread) {
          controller.markAsRead(notification.id);
        }

        // TODO: الانتقال إلى الصفحة المرتبطة بالإشعار
        // مثال: إذا كان إشعار موعد، انتقل إلى تفاصيل الموعد
        // Get.toNamed(Routes.appointmentDetails, arguments: notification.relatedId);
      },
      borderRadius: BorderRadius.circular(16.r),
      child: Container(
        padding: EdgeInsets.all(16.w),
        margin: EdgeInsets.symmetric(horizontal: 16.w),
        decoration: BoxDecoration(
          color: notification.status == NotificationStatus.unread
              ? cs.primary.withOpacity(0.05)
              : cs.surface,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: notification.status == NotificationStatus.unread
                ? cs.primary.withOpacity(0.2)
                : cs.outlineVariant.withOpacity(0.2),
          ),
          boxShadow: [
            BoxShadow(
              color: cs.shadow.withOpacity(0.03),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            // أيقونة الإشعار
            Container(
              width: 48.r,
              height: 48.r,
              decoration: BoxDecoration(
                color: _getNotificationColor(notification.type, cs).withOpacity(0.15),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Icon(
                _getNotificationIcon(notification.type),
                color: _getNotificationColor(notification.type, cs),
                size: 24.sp,
              ),
            ),
            12.horizontalSpace,

            // محتوى الإشعار
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // العنوان والوقت
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          notification.title,
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w700,
                            color: notification.status == NotificationStatus.unread
                                ? cs.onSurface
                                : cs.onSurfaceVariant,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      8.horizontalSpace,
                      Text(
                        notification.formattedTime,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: cs.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                  4.verticalSpace,

                  // نص الإشعار
                  Text(
                    notification.body,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: notification.status == NotificationStatus.unread
                          ? cs.onSurface
                          : cs.onSurfaceVariant,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),

            // مؤشر غير مقروء
            if (notification.status == NotificationStatus.unread)
              Padding(
                padding: EdgeInsets.only(left: 8.w),
                child: Container(
                  width: 8.r,
                  height: 8.r,
                  decoration: BoxDecoration(
                    color: cs.primary,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  IconData _getNotificationIcon(NotificationType type) {
    switch (type) {
      case NotificationType.appointment:
        return Icons.event_note_outlined;
      case NotificationType.labResult:
        return Icons.science_outlined;
      case NotificationType.payment:
        return Icons.payments_outlined;
      case NotificationType.message:
        return Icons.message_outlined;
    }
  }

  Color _getNotificationColor(NotificationType type, ColorScheme cs) {
    switch (type) {
      case NotificationType.appointment:
        return cs.primary;
      case NotificationType.labResult:
        return cs.secondary;
      case NotificationType.payment:
        return Colors.green;
      case NotificationType.message:
        return cs.tertiary;
    }
  }
}