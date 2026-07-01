import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../generated/locale_keys.g.dart';
import '../controllers/notifications_controller.dart';
import 'widgets/notification_item.dart';

class NotificationsView extends GetView<NotificationsController> {
  const NotificationsView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Scaffold(
      body: CustomScrollView(
        controller: controller.scrollController,
        physics: const BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
        slivers: [
          SliverAppBar(
            pinned: true,
            floating: true,
            centerTitle: true,
            title: Text(
              tr(LocaleKeys.notifications_title),
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w800,
              ),
            ),
            actions: [
              Obx(
                () => IconButton(
                  onPressed: controller.isMarkingAll.value
                      ? null
                      : () => _confirmMarkAll(context),
                  icon: controller.isMarkingAll.value
                      ? _smallLoader()
                      : const Icon(Icons.mark_email_read_outlined),
                  tooltip: tr(LocaleKeys.notifications_mark_all_read),
                ),
              ),
              Obx(
                () => IconButton(
                  onPressed:
                      controller.isDeletingAll.value ||
                          controller.notifications.isEmpty
                      ? null
                      : () => _confirmDeleteAll(context),
                  icon: controller.isDeletingAll.value
                      ? _smallLoader()
                      : Icon(Icons.delete_sweep_outlined, color: colors.error),
                  tooltip: tr(LocaleKeys.notifications_delete_all),
                ),
              ),
            ],
          ),
          CupertinoSliverRefreshControl(onRefresh: controller.onRefresh),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 54.h,
              child: Obx(
                () => ListView(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 7.h,
                  ),
                  scrollDirection: Axis.horizontal,
                  children: [
                    _filterChip(
                      context,
                      NotificationsFilter.all,
                      'notifications.filters.all',
                    ),
                    _filterChip(
                      context,
                      NotificationsFilter.unread,
                      'notifications.filters.unread',
                    ),
                    _filterChip(
                      context,
                      NotificationsFilter.read,
                      'notifications.filters.read',
                    ),
                  ],
                ),
              ),
            ),
          ),
          Obx(() {
            final grouped = controller.groupedNotifications;
            final entries = grouped.entries.toList();
            final loadingMore = controller.isLoadingMore.value;

            return controller.buildNotifications(
              SliverList.builder(
                itemCount: entries.length + (loadingMore ? 1 : 0),
                itemBuilder: (context, index) {
                  if (index == entries.length) {
                    return Padding(
                      padding: EdgeInsets.all(20.h),
                      child: const Center(child: CircularProgressIndicator()),
                    );
                  }
                  final group = entries[index];
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 8.h),
                        child: Text(
                          _dateLabel(group.key),
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w700,
                            color: colors.onSurfaceVariant,
                          ),
                        ),
                      ),
                      ...group.value.map(
                        (notification) => Padding(
                          padding: EdgeInsets.only(bottom: 8.h),
                          child: Obx(
                            () => NotificationItem(
                              notification: notification,
                              isReading: controller.loadingReadIds.contains(
                                notification.id,
                              ),
                              isDeleting: controller.loadingDeleteIds.contains(
                                notification.id,
                              ),
                              onTap: () =>
                                  controller.markAsRead(notification.id),
                              onDelete: () =>
                                  _confirmDelete(context, notification.id),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _filterChip(
    BuildContext context,
    NotificationsFilter filter,
    String labelKey,
  ) {
    return Padding(
      padding: EdgeInsetsDirectional.only(end: 8.w),
      child: ChoiceChip(
        label: Text(tr(labelKey)),
        selected: controller.selectedFilter.value == filter,
        onSelected: (_) => controller.selectFilter(filter),
      ),
    );
  }

  Widget _smallLoader() {
    return SizedBox(
      width: 20.r,
      height: 20.r,
      child: const CircularProgressIndicator(strokeWidth: 2),
    );
  }

  String _dateLabel(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    if (date == today) return tr('notifications.today');
    if (date == today.subtract(const Duration(days: 1))) {
      return tr('notifications.yesterday');
    }
    return '${date.day}/${date.month}/${date.year}';
  }

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
            title: Text(title),
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
                      ? TextStyle(color: Theme.of(context).colorScheme.error)
                      : null,
                ),
              ),
            ],
          ),
        ) ??
        false;
  }
}
