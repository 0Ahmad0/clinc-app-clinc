import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../app/data/notification_model.dart';
import '../../controllers/notifications_controller.dart';

const _kAmber = Color(0xFFF59E0B);
const _kBlue  = Color(0xFF3B82F6);
const _kGreen = Color(0xFF10B981);

/// Filter chips bar: الكل / غير مقروء / مقروء
class NotificationsFilterBar extends GetView<NotificationsController> {
  const NotificationsFilterBar({super.key});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      decoration: BoxDecoration(
        color: cs.surface,
        border: Border(
          bottom: BorderSide(color: cs.outlineVariant.withValues(alpha: 0.2)),
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
        final total    = controller.notifications.length;
        final unread   = controller.notifications
            .where((n) => n.status == NotificationStatus.unread)
            .length;
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
          child: Row(
            children: [
              _FilterChip(label: 'الكل',       count: total,           isSelected: selected == 'all',    color: _kAmber, onTap: () => controller.changeFilter('all')),
              10.horizontalSpace,
              _FilterChip(label: 'غير مقروء', count: unread,          isSelected: selected == 'unread', color: _kBlue,  onTap: () => controller.changeFilter('unread')),
              10.horizontalSpace,
              _FilterChip(label: 'مقروء',      count: total - unread,  isSelected: selected == 'read',   color: _kGreen, onTap: () => controller.changeFilter('read')),
            ],
          ),
        );
      }),
    );
  }
}

// ── Private ───────────────────────────────────────────────────────────────────

class _FilterChip extends StatelessWidget {
  final String label;
  final int count;
  final bool isSelected;
  final Color color;
  final VoidCallback onTap;

  const _FilterChip({
    required this.label,
    required this.count,
    required this.isSelected,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs    = theme.colorScheme;
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 7.h),
        decoration: BoxDecoration(
          color: isSelected
              ? color.withValues(alpha: 0.12)
              : cs.surfaceContainerHighest.withValues(alpha: 0.5),
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
                  color: isSelected
                      ? color
                      : cs.outlineVariant.withValues(alpha: 0.5),
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
