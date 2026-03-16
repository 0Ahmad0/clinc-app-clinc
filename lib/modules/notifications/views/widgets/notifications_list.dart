import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../controllers/notifications_controller.dart';
import 'empty_notifications.dart';
import 'notification_card.dart';

const _kAmber     = Color(0xFFF59E0B);
const _kDeepAmber = Color(0xFFD97706);

/// Grouped list of notifications. Shows [EmptyNotifications] when empty.
class NotificationsList extends GetView<NotificationsController> {
  const NotificationsList({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final grouped = controller.filteredGroupedNotifications;
      if (grouped.isEmpty) return const EmptyNotifications();

      return ListView.builder(
         
        padding: EdgeInsets.fromLTRB(0, 8.h, 0, 40.h),
        itemCount: grouped.length,
        itemBuilder: (_, index) {
          final dateKey = grouped.keys.elementAt(index);
          final items   = grouped[dateKey]!;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _DateHeader(label: dateKey),
              ...items.map((n) => NotificationCard(notification: n)),
            ],
          );
        },
      );
    });
  }
}

// ── Private ───────────────────────────────────────────────────────────────────

class _DateHeader extends StatelessWidget {
  final String label;
  const _DateHeader({required this.label});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 8.h),
      child: Row(
        children: [
          Container(
            width: 5.w,
            height: 16.h,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [_kAmber, _kDeepAmber],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              borderRadius: BorderRadius.circular(4.r),
            ),
          ),
          8.horizontalSpace,
          Text(
            label,
            style: theme.textTheme.labelLarge?.copyWith(
              fontWeight: FontWeight.w700,
              color: theme.colorScheme.onSurfaceVariant,
              letterSpacing: 0.2,
            ),
          ),
        ],
      ),
    );
  }
}
