import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../generated/locale_keys.g.dart';
import '../controllers/notifications_controller.dart';
import 'widgets/empty_notifications.dart';
import 'widgets/notification_item.dart';

class NotificationsView extends GetView<NotificationsController> {
  const NotificationsView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    return Scaffold(
      backgroundColor: cs.surface,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // 1. Sliver App Bar
          SliverAppBar(
            pinned: true,
            floating: true,
            backgroundColor: cs.surface,
            elevation: 0,
            centerTitle: true,
            title: Text(
              tr(LocaleKeys.notifications_title),
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w800,
              ),
            ),
            actions: [
              // زر قراءة الكل
              IconButton(
                onPressed: () {
                  Get.dialog(
                    AlertDialog(
                      title: Text(tr(LocaleKeys.notifications_mark_all_read)),
                      content: Text(
                        tr(LocaleKeys.notifications_confirm_mark_all_read),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Get.back(),
                          child: Text(tr(LocaleKeys.notifications_cancel)),
                        ),
                        TextButton(
                          onPressed: () {
                            controller.markAllAsRead();
                            Get.back();
                          },
                          child: Text(tr(LocaleKeys.notifications_confirm)),
                        ),
                      ],
                    ),
                  );
                },
                icon: Icon(Icons.mark_email_read_outlined, color: cs.primary),
                tooltip: tr(LocaleKeys.notifications_mark_all_read),
              ),
              // زر حذف الكل
              IconButton(
                onPressed: () {
                  if (controller.notifications.isEmpty) return;
                  Get.dialog(
                    AlertDialog(
                      title: Text(tr(LocaleKeys.notifications_delete_all)),
                      content: Text(
                        tr(LocaleKeys.notifications_confirm_delete_all),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Get.back(),
                          child: Text(tr(LocaleKeys.notifications_cancel)),
                        ),
                        TextButton(
                          onPressed: () {
                            controller.deleteAllNotifications();
                            Get.back();
                          },
                          child: Text(
                            tr(LocaleKeys.notifications_confirm),
                            style: TextStyle(color: cs.error),
                          ),
                        ),
                      ],
                    ),
                  );
                },
                icon: Icon(Icons.delete_outline, color: cs.error),
                tooltip: tr(LocaleKeys.notifications_delete_all),
              ),
            ],
          ),

          // 2. قائمة الإشعارات
          Obx(() {
            if (controller.notifications.isEmpty) {
              return const SliverFillRemaining(child: EmptyNotifications());
            }

            final grouped = controller.groupedNotifications;

            return SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                final dateKey = grouped.keys.elementAt(index);
                final notifications = grouped[dateKey]!;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // عنوان المجموعة (اليوم، البارحة، التاريخ)
                    Padding(
                      padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 8.h),
                      child: Text(
                        dateKey,
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                          color: cs.onSurfaceVariant,
                        ),
                      ),
                    ),

                    // عناصر الإشعارات في هذه المجموعة
                    ...notifications.map((notification) {
                      return Padding(
                        padding: EdgeInsets.only(bottom: 8.h),
                        child: Dismissible(
                          movementDuration: const Duration(milliseconds: 200),
                          resizeDuration: const Duration(milliseconds: 100),
                          key: ValueKey(notification.id),
                          direction: DismissDirection.endToStart,
                          background: Container(
                            margin: EdgeInsets.symmetric(
                              horizontal: 16.w,
                              vertical: 4.h,
                            ),
                            decoration: BoxDecoration(
                              color: cs.error,
                              borderRadius: BorderRadius.circular(16.r),
                            ),
                            alignment: Alignment.centerRight,
                            padding: EdgeInsets.only(right: 20.w),
                            child: Icon(
                              Icons.delete,
                              color: cs.onError,
                              size: 24.sp,
                            ),
                          ),
                          confirmDismiss: (direction) async {
                            // عرض تأكيد الحذف
                            return await Get.dialog(
                              AlertDialog(
                                title: Text(
                                  tr(LocaleKeys.notifications_delete),
                                ),
                                content: Text(
                                  tr(
                                    LocaleKeys.notifications_confirm_delete_all,
                                  ),
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () => Get.back(result: false),
                                    child: Text(
                                      tr(LocaleKeys.notifications_cancel),
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () => Get.back(result: true),
                                    child: Text(
                                      tr(LocaleKeys.notifications_confirm),
                                      style: TextStyle(color: cs.error),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                          onDismissed: (direction) {
                            controller.deleteNotification(notification.id);
                          },
                          child: NotificationItem(notification: notification),
                        ),
                      );
                    }),
                  ],
                );
              }, childCount: grouped.length),
            );
          }),
        ],
      ),
    );
  }
}
