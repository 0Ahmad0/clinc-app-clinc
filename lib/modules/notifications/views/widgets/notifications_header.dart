import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../generated/locale_keys.g.dart';
import '../../controllers/notifications_controller.dart';
import 'notification_confirm_dialog.dart';

// Amber palette — Notifications module colour identity
const _kAmber     = Color(0xFFF59E0B);
const _kDeepAmber = Color(0xFFD97706);
const _kDarkAmber = Color(0xFF92400E);
const _kDarkBg    = Color(0xFF78350F);

/// Gradient header with icon, title, unread count, and action buttons.
class NotificationsHeader extends GetView<NotificationsController> {
  const NotificationsHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: isDark ? [_kDarkBg, _kDarkAmber] : [_kAmber, _kDeepAmber],
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: EdgeInsets.fromLTRB(20.w, 16.h, 12.w, 20.h),
          child: Row(
            children: [
              const _HeaderIcon(),
              14.horizontalSpace,
              const Expanded(child: _HeaderTitle()),
              const _HeaderActions(),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Private sub-widgets ───────────────────────────────────────────────────────

class _HeaderIcon extends StatelessWidget {
  const _HeaderIcon();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.r),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(14.r),
      ),
      child: Icon(Icons.notifications_rounded, color: Colors.white, size: 26.sp),
    );
  }
}

class _HeaderTitle extends GetView<NotificationsController> {
  const _HeaderTitle();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
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
    );
  }
}

class _HeaderActions extends GetView<NotificationsController> {
  const _HeaderActions();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _ActionBtn(
          icon: Icons.mark_email_read_outlined,
          onTap: () => Get.dialog(NotificationConfirmDialog(
            title: tr(LocaleKeys.notifications_mark_all_read),
            body: tr(LocaleKeys.notifications_confirm_mark_all_read),
            onConfirm: controller.markAllAsRead,
          )),
        ),
        6.horizontalSpace,
        _ActionBtn(
          icon: Icons.delete_outline_rounded,
          isDanger: true,
          onTap: () {
            if (controller.notifications.isEmpty) return;
            Get.dialog(NotificationConfirmDialog(
              title: tr(LocaleKeys.notifications_delete_all),
              body: tr(LocaleKeys.notifications_confirm_delete_all),
              onConfirm: controller.deleteAllNotifications,
              isDestructive: true,
            ));
          },
        ),
      ],
    );
  }
}

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
