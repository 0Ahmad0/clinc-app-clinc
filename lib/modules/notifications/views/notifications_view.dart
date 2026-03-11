import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../generated/locale_keys.g.dart';
import '../controllers/notifications_controller.dart';
import '../../../app/data/notification_model.dart';
import 'widgets/empty_notifications.dart';

class NotificationsView extends GetView<NotificationsController> {
  const NotificationsView({super.key});

  static const _amber = Color(0xFFF59E0B);
  static const _deepAmber = Color(0xFFD97706);
  static const _darkAmber = Color(0xFF92400E);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: cs.surface,
      body: Column(
        children: [
          _buildGradientHeader(theme, cs, isDark),
          _buildFilterTabs(theme, cs),
          Expanded(child: _buildList(theme, cs)),
        ],
      ),
    );
  }

  Widget _buildGradientHeader(ThemeData theme, ColorScheme cs, bool isDark) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: isDark
              ? [const Color(0xFF78350F), _darkAmber]
              : [_amber, _deepAmber],
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: EdgeInsets.fromLTRB(20.w, 16.h, 12.w, 20.h),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(10.r),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(14.r),
                ),
                child: Icon(
                  Icons.notifications_rounded,
                  color: Colors.white,
                  size: 26.sp,
                ),
              ),
              14.horizontalSpace,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      tr(LocaleKeys.notifications_title),
                      style: theme.textTheme.headlineSmall?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w900,
                        letterSpacing: -0.5,
                      ),
                    ),
                    Obx(() {
                      final unread = controller.unreadCount;
                      return Text(
                        unread > 0 ? '$unread غير مقروء' : 'لا توجد إشعارات جديدة',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: Colors.white.withValues(alpha: 0.85),
                        ),
                      );
                    }),
                  ],
                ),
              ),
              _buildHeaderActions(theme),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderActions(ThemeData theme) {
    return Row(
      children: [
        _ActionBtn(
          icon: Icons.mark_email_read_outlined,
          onTap: () => Get.dialog(
            _ConfirmDialog(
              title: tr(LocaleKeys.notifications_mark_all_read),
              body: tr(LocaleKeys.notifications_confirm_mark_all_read),
              onConfirm: controller.markAllAsRead,
              isDestructive: false,
            ),
          ),
        ),
        6.horizontalSpace,
        _ActionBtn(
          icon: Icons.delete_outline_rounded,
          onTap: () {
            if (controller.notifications.isEmpty) return;
            Get.dialog(
              _ConfirmDialog(
                title: tr(LocaleKeys.notifications_delete_all),
                body: tr(LocaleKeys.notifications_confirm_delete_all),
                onConfirm: controller.deleteAllNotifications,
                isDestructive: true,
              ),
            );
          },
          isDanger: true,
        ),
      ],
    );
  }

  Widget _buildFilterTabs(ThemeData theme, ColorScheme cs) {
    return Container(
      decoration: BoxDecoration(
        color: cs.surface,
        border: Border(
          bottom: BorderSide(
            color: cs.outlineVariant.withValues(alpha: 0.2),
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: cs.shadow.withValues(alpha: 0.04),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Obx(() {
        final selected = controller.selectedFilter.value;
        final unread = controller.notifications
            .where((n) => n.status == NotificationStatus.unread)
            .length;
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
          child: Row(
            children: [
              _FilterTab(
                label: 'الكل',
                count: controller.notifications.length,
                isSelected: selected == 'all',
                onTap: () => controller.changeFilter('all'),
                color: _amber,
              ),
              10.horizontalSpace,
              _FilterTab(
                label: 'غير مقروء',
                count: unread,
                isSelected: selected == 'unread',
                onTap: () => controller.changeFilter('unread'),
                color: const Color(0xFF3B82F6),
              ),
              10.horizontalSpace,
              _FilterTab(
                label: 'مقروء',
                count: controller.notifications.length - unread,
                isSelected: selected == 'read',
                onTap: () => controller.changeFilter('read'),
                color: const Color(0xFF10B981),
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildList(ThemeData theme, ColorScheme cs) {
    return Obx(() {
      final grouped = controller.filteredGroupedNotifications;
      if (grouped.isEmpty) {
        return const EmptyNotifications();
      }
      return ListView.builder(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.fromLTRB(0, 8.h, 0, 40.h),
        itemCount: grouped.length,
        itemBuilder: (context, index) {
          final dateKey = grouped.keys.elementAt(index);
          final items = grouped[dateKey]!;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 8.h),
                child: Row(
                  children: [
                    Container(
                      width: 5.w,
                      height: 16.h,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [_amber, _deepAmber],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                    ),
                    8.horizontalSpace,
                    Text(
                      dateKey,
                      style: theme.textTheme.labelLarge?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: cs.onSurfaceVariant,
                        letterSpacing: 0.2,
                      ),
                    ),
                  ],
                ),
              ),
              ...items.map((notification) => _NotifCard(notification: notification)),
            ],
          );
        },
      );
    });
  }
}

// ─── Action button in header ──────────────────────────────────────────────────
class _ActionBtn extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  final bool isDanger;
  const _ActionBtn({required this.icon, required this.onTap, this.isDanger = false});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(9.r),
        decoration: BoxDecoration(
          color: isDanger
              ? Colors.red.withValues(alpha: 0.2)
              : Colors.white.withValues(alpha: 0.2),
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Icon(icon, color: Colors.white, size: 20.sp),
      ),
    );
  }
}

// ─── Filter tab chip ──────────────────────────────────────────────────────────
class _FilterTab extends StatelessWidget {
  final String label;
  final int count;
  final bool isSelected;
  final VoidCallback onTap;
  final Color color;
  const _FilterTab({
    required this.label,
    required this.count,
    required this.isSelected,
    required this.onTap,
    required this.color,
  });
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 7.h),
        decoration: BoxDecoration(
          color: isSelected ? color.withValues(alpha: 0.12) : cs.surfaceContainerHighest.withValues(alpha: 0.5),
          borderRadius: BorderRadius.circular(22.r),
          border: Border.all(
            color: isSelected ? color : Colors.transparent,
            width: 1.5,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: theme.textTheme.labelMedium?.copyWith(
                color: isSelected ? color : cs.onSurfaceVariant,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
              ),
            ),
            if (count > 0) ...[
              6.horizontalSpace,
              Container(
                padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 1.h),
                decoration: BoxDecoration(
                  color: isSelected ? color : cs.outlineVariant.withValues(alpha: 0.5),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Text(
                  '$count',
                  style: TextStyle(
                    color: isSelected ? Colors.white : cs.onSurfaceVariant,
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

// ─── Notification card ────────────────────────────────────────────────────────
class _NotifCard extends GetView<NotificationsController> {
  final NotificationModel notification;
  const _NotifCard({required this.notification});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final isUnread = notification.status == NotificationStatus.unread;
    final color = _typeColor(notification.type, cs);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
      child: Dismissible(
        key: ValueKey(notification.id),
        direction: DismissDirection.endToStart,
        background: Container(
          decoration: BoxDecoration(
            color: cs.error,
            borderRadius: BorderRadius.circular(18.r),
          ),
          alignment: Alignment.centerRight,
          padding: EdgeInsets.only(right: 20.w),
          child: Icon(Icons.delete_rounded, color: cs.onError, size: 24.sp),
        ),
        confirmDismiss: (_) => Get.dialog(
          _ConfirmDialog(
            title: tr(LocaleKeys.notifications_delete),
            body: tr(LocaleKeys.notifications_confirm_delete_all),
            onConfirm: () {},
            isDestructive: true,
          ),
        ),
        onDismissed: (_) => controller.deleteNotification(notification.id),
        child: GestureDetector(
          onTap: () {
            if (isUnread) controller.markAsRead(notification.id);
          },
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
                  ? [
                      BoxShadow(
                        color: color.withValues(alpha: 0.08),
                        blurRadius: 12,
                        offset: const Offset(0, 3),
                      ),
                    ]
                  : [],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
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
                      BoxShadow(
                        color: color.withValues(alpha: 0.25),
                        blurRadius: 8,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Icon(
                    _typeIcon(notification.type),
                    color: Colors.white,
                    size: 22.sp,
                  ),
                ),
                12.horizontalSpace,
                Expanded(
                  child: Column(
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
                        Container(
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
                                decoration: BoxDecoration(
                                  color: color,
                                  shape: BoxShape.circle,
                                ),
                              ),
                              5.horizontalSpace,
                              Text(
                                'جديد',
                                style: TextStyle(
                                  color: color,
                                  fontSize: 10.sp,
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

  IconData _typeIcon(NotificationType type) {
    switch (type) {
      case NotificationType.appointment:
        return Icons.event_note_rounded;
      case NotificationType.labResult:
        return Icons.science_rounded;
      case NotificationType.payment:
        return Icons.payments_rounded;
      case NotificationType.message:
        return Icons.message_rounded;
    }
  }

  Color _typeColor(NotificationType type, ColorScheme cs) {
    switch (type) {
      case NotificationType.appointment:
        return const Color(0xFF009688);
      case NotificationType.labResult:
        return const Color(0xFF8B5CF6);
      case NotificationType.payment:
        return const Color(0xFF10B981);
      case NotificationType.message:
        return const Color(0xFF3B82F6);
    }
  }
}

// ─── Confirm dialog ────────────────────────────────────────────────────────────
class _ConfirmDialog extends StatelessWidget {
  final String title;
  final String body;
  final VoidCallback onConfirm;
  final bool isDestructive;
  const _ConfirmDialog({
    required this.title,
    required this.body,
    required this.onConfirm,
    required this.isDestructive,
  });
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
      title: Text(title, style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800)),
      content: Text(body),
      actions: [
        TextButton(
          onPressed: () => Get.back(result: false),
          child: Text(tr(LocaleKeys.notifications_cancel)),
        ),
        TextButton(
          onPressed: () {
            onConfirm();
            Get.back(result: true);
          },
          child: Text(
            tr(LocaleKeys.notifications_confirm),
            style: TextStyle(
              color: isDestructive ? cs.error : cs.primary,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }
}
