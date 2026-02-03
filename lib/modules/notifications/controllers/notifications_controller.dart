import 'package:get/get.dart';
import '../../../app/data/notification_model.dart';

class NotificationsController extends GetxController {
  final RxList<NotificationModel> notifications = <NotificationModel>[].obs;
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    _seedMockNotifications();
  }

  // تحميل بيانات وهمية للإشعارات
  void _seedMockNotifications() {
    final now = DateTime.now();
    notifications.value = [
      NotificationModel(
        id: 'n1',
        title: 'موعد جديد',
        body: 'تم حجز موعد جديد مع المريض أحمد خالد في الساعة 3:00 مساءً',
        type: NotificationType.appointment,
        status: NotificationStatus.unread,
        createdAt: now.subtract(const Duration(minutes: 30)),
        relatedId: 'a1',
      ),
      NotificationModel(
        id: 'n2',
        title: 'نتائج الفحوصات',
        body: 'تم تحميل نتائج فحوصات المريض سارة محمد',
        type: NotificationType.labResult,
        status: NotificationStatus.unread,
        createdAt: now.subtract(const Duration(hours: 2)),
        relatedId: 'l1',
      ),
      NotificationModel(
        id: 'n3',
        title: 'دفع فاتورة',
        body: 'تم دفع الفاتورة رقم #1234 بقيمة 150 دولار',
        type: NotificationType.payment,
        status: NotificationStatus.read,
        createdAt: now.subtract(const Duration(days: 1)),
        relatedId: 'p1',
      ),
      NotificationModel(
        id: 'n4',
        title: 'رسالة جديدة',
        body: 'لديك رسالة جديدة من الدكتور محمد علي',
        type: NotificationType.message,
        status: NotificationStatus.unread,
        createdAt: now.subtract(const Duration(days: 2)),
        relatedId: 'm1',
      ),
      NotificationModel(
        id: 'n5',
        title: 'موعد ملغى',
        body: 'تم إلغاء الموعد مع المريض يوسف إبراهيم',
        type: NotificationType.appointment,
        status: NotificationStatus.read,
        createdAt: now.subtract(const Duration(days: 3)),
        relatedId: 'a2',
      ),
    ];
  }

  // الحصول على الإشعارات مجمعة حسب التاريخ
  Map<String, List<NotificationModel>> get groupedNotifications {
    final Map<String, List<NotificationModel>> groups = {};

    for (final notification in notifications) {
      final dateKey = notification.formattedDate;
      if (!groups.containsKey(dateKey)) {
        groups[dateKey] = [];
      }
      groups[dateKey]!.add(notification);
    }

    // ترتيب المجموعات حسب التاريخ (الأحدث أولاً)
    final sortedKeys = groups.keys.toList()
      ..sort((a, b) {
        if (a == 'اليوم') return -1;
        if (b == 'اليوم') return 1;
        if (a == 'البارحة') return -1;
        if (b == 'البارحة') return 1;
        return b.compareTo(a); // للترتيب التنازلي
      });

    final sortedGroups = <String, List<NotificationModel>>{};
    for (final key in sortedKeys) {
      sortedGroups[key] = groups[key]!;
    }

    return sortedGroups;
  }

  // وضع إشعار كمقروء
  void markAsRead(String id) {
    final index = notifications.indexWhere((n) => n.id == id);
    if (index != -1) {
      notifications[index] = notifications[index].copyWith(
        status: NotificationStatus.read,
      );
    }
  }

  // وضع جميع الإشعارات كمقروءة
  void markAllAsRead() {
    for (int i = 0; i < notifications.length; i++) {
      if (notifications[i].status == NotificationStatus.unread) {
        notifications[i] = notifications[i].copyWith(
          status: NotificationStatus.read,
        );
      }
    }
  }

  // حذف إشعار
  void deleteNotification(String id) {
    notifications.removeWhere((n) => n.id == id);
  }

  // حذف جميع الإشعارات
  void deleteAllNotifications() {
    notifications.clear();
  }
}

extension NotificationCopy on NotificationModel {
  NotificationModel copyWith({
    String? id,
    String? title,
    String? body,
    NotificationType? type,
    NotificationStatus? status,
    DateTime? createdAt,
    String? relatedId,
  }) {
    return NotificationModel(
      id: id ?? this.id,
      title: title ?? this.title,
      body: body ?? this.body,
      type: type ?? this.type,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      relatedId: relatedId ?? this.relatedId,
    );
  }
}
