import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../generated/locale_keys.g.dart';
import '../controllers/notifications_controller.dart';
import '../../../app/data/notification_model.dart';
import 'widgets/notification_item.dart';
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
          // Header الجديد مع الربط القديم
          _buildGradientHeader(theme, cs, isDark),
          // فلتر التبويبات الجديد مع الربط القديم
          _buildFilterTabs(theme, cs),
          // قائمة الإشعارات المدمجة (جديد + قديم)
          Expanded(child: _buildList(theme, cs)),
        ],
      ),
    );
  }

  // ===== HEADER الجديد مع ربط قديم =====
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
                    // ربط unreadCount من الكود القديم
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
              // أزرار الإجراءات مع ربط قديم
              _buildHeaderActions(theme),
            ],
          ),
        ),
      ),
    );
  }

  // ===== أزرار الهيدر مع ربط قديم =====
  Widget _buildHeaderActions(ThemeData theme) {
    return Row(
      children: [
        // زر تحديد الكل كمقروء
        Obx(() => _ActionBtn(
          icon: Icons.mark_email_read_outlined,
          isLoading: controller.isMarkingAll.value,
          onTap: controller.isMarkingAll.value
              ? null
              : () => _confirmMarkAll(Get.context!),
        )),
        6.horizontalSpace,
        // زر حذف الكل
        Obx(() => _ActionBtn(
          icon: Icons.delete_outline_rounded,
          isLoading: controller.isDeletingAll.value,
          isDanger: true,
          onTap: (controller.isDeletingAll.value || controller.notifications.isEmpty)
              ? null
              : () => _confirmDeleteAll(Get.context!),
        )),
      ],
    );
  }

  // ===== فلتر التبويبات الجديد مع ربط قديم =====
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
                isSelected: selected == NotificationsFilter.all,
                onTap: () => controller.selectFilter(NotificationsFilter.all),
                color: _amber,
              ),
              10.horizontalSpace,
              _FilterTab(
                label: 'غير مقروء',
                count: unread,
                isSelected: selected == NotificationsFilter.unread,
                onTap: () => controller.selectFilter(NotificationsFilter.unread),
                color: const Color(0xFF3B82F6),
              ),
              10.horizontalSpace,
              _FilterTab(
                label: 'مقروء',
                count: controller.notifications.length - unread,
                isSelected: selected == NotificationsFilter.read,
                onTap: () => controller.selectFilter(NotificationsFilter.read),
                color: const Color(0xFF10B981),
              ),
            ],
          ),
        );
      }),
    );
  }

  // ===== قائمة الإشعارات المدمجة =====
  Widget _buildList(ThemeData theme, ColorScheme cs) {
    return Obx(() {
      // استخدام groupedNotifications من الكود القديم
      final grouped = controller.groupedNotifications;

      if (grouped.isEmpty) {
        return const EmptyNotifications();
      }

      final entries = grouped.entries.toList();
      final loadingMore = controller.isLoadingMore.value;

      // استخدام ListView.builder مع دعم التحميل اللامتناهي
      return ListView.builder(
        controller: controller.scrollController,
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.fromLTRB(0, 8.h, 0, 40.h),
        itemCount: entries.length + (loadingMore ? 1 : 0),
        itemBuilder: (context, index) {
          // عرض مؤشر التحميل في النهاية
          if (index == entries.length) {
            return Padding(
              padding: EdgeInsets.all(20.h),
              child: const Center(child: CircularProgressIndicator()),
            );
          }

          final group = entries[index];
          final dateKey = group.key;
          final items = group.value;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // عنوان التاريخ
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
                      _dateLabel(dateKey),
                      style: theme.textTheme.labelLarge?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: cs.onSurfaceVariant,
                        letterSpacing: 0.2,
                      ),
                    ),
                  ],
                ),
              ),
              // عناصر الإشعارات
              ...items.map((notification) => Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
                child: Obx(
                      () => NotificationItem(
                    notification: notification,
                    isReading: controller.loadingReadIds.contains(notification.id),
                    isDeleting: controller.loadingDeleteIds.contains(notification.id),
                    onTap: () => controller.markAsRead(notification.id),
                    onDelete: () => _confirmDelete(Get.context!, notification.id),
                  ),
                ),
              )),
            ],
          );
        },
      );
    });
  }

  // ===== دوال مساعدة =====
  String _dateLabel(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    if (date == today) return tr('notifications.today');
    if (date == today.subtract(const Duration(days: 1))) {
      return tr('notifications.yesterday');
    }
    return '${date.day}/${date.month}/${date.year}';
  }

  // ===== دوال التأكيد =====
  Future<void> _confirmMarkAll(BuildContext context) async {
    final confirmed = await _showConfirmation(
      context,
      title: tr(LocaleKeys.notifications_mark_all_read),
      message: tr(LocaleKeys.notifications_confirm_mark_all_read),
    );
    if (confirmed) await controller.markAllAsRead();
  }

  Future<void> _confirmDeleteAll(BuildContext context) async {
    final confirmed = await _showConfirmation(
      context,
      title: tr(LocaleKeys.notifications_delete_all),
      message: tr(LocaleKeys.notifications_confirm_delete_all),
      destructive: true,
    );
    if (confirmed) await controller.deleteAllNotifications();
  }

  Future<void> _confirmDelete(BuildContext context, String id) async {
    final confirmed = await _showConfirmation(
      context,
      title: tr(LocaleKeys.notifications_delete),
      message: tr('notifications.confirm_delete'),
      destructive: true,
    );
    if (confirmed) await controller.deleteNotification(id);
  }

  Future<bool> _showConfirmation(
      BuildContext context, {
        required String title,
        required String message,
        bool destructive = false,
      }) async {
    return await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r),
        ),
        title: Text(
          title,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w800,
          ),
        ),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(tr(LocaleKeys.notifications_cancel)),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text(
              tr(LocaleKeys.notifications_confirm),
              style: destructive
                  ? TextStyle(
                color: Theme.of(context).colorScheme.error,
                fontWeight: FontWeight.w700,
              )
                  : const TextStyle(fontWeight: FontWeight.w700),
            ),
          ),
        ],
      ),
    ) ??
        false;
  }
}

// ===== ويدجت زر الإجراء =====
class _ActionBtn extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onTap;
  final bool isDanger;
  final bool isLoading;

  const _ActionBtn({
    required this.icon,
    this.onTap,
    this.isDanger = false,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isLoading ? null : onTap,
      child: Container(
        padding: EdgeInsets.all(9.r),
        decoration: BoxDecoration(
          color: isDanger
              ? Colors.red.withValues(alpha: 0.2)
              : Colors.white.withValues(alpha: 0.2),
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: isLoading
            ? SizedBox(
          width: 20.r,
          height: 20.r,
          child: const CircularProgressIndicator(
            strokeWidth: 2,
            color: Colors.white,
          ),
        )
            : Icon(icon, color: Colors.white, size: 20.sp),
      ),
    );
  }
}

// ===== ويدجت فلتر التبويب =====
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