import 'package:get/get.dart';
import '../../../app/data/notification_model.dart';

class NotificationsController extends GetxController {
  // ── State ──────────────────────────────────────────────────────────────────

  final RxList<NotificationModel> notifications = <NotificationModel>[].obs;
  final RxBool isLoading = false.obs;
  final RxString selectedFilter = 'all'.obs;

  // ── Getters ────────────────────────────────────────────────────────────────

  int get unreadCount =>
      notifications.where((n) => n.status == NotificationStatus.unread).length;

  List<NotificationModel> get _filtered => switch (selectedFilter.value) {
    'unread' => notifications.where((n) => n.status == NotificationStatus.unread).toList(),
    'read'   => notifications.where((n) => n.status == NotificationStatus.read).toList(),
    _        => notifications.toList(),
  };

  Map<String, List<NotificationModel>> get filteredGroupedNotifications {
    final groups = <String, List<NotificationModel>>{};
    for (final n in _filtered) {
      (groups[n.formattedDate] ??= []).add(n);
    }
    final keys = groups.keys.toList()
      ..sort((a, b) {
        if (a == 'اليوم')    return -1;
        if (b == 'اليوم')    return  1;
        if (a == 'البارحة') return -1;
        if (b == 'البارحة') return  1;
        return b.compareTo(a);
      });
    return {for (final k in keys) k: groups[k]!};
  }

  // ── Lifecycle ──────────────────────────────────────────────────────────────

  @override
  void onInit() {
    super.onInit();
    _seedMockNotifications();
  }

  // ── Commands ───────────────────────────────────────────────────────────────

  void changeFilter(String filter) => selectedFilter.value = filter;

  void markAsRead(String id) {
    final i = notifications.indexWhere((n) => n.id == id);
    if (i != -1) notifications[i] = notifications[i].copyWith(status: NotificationStatus.read);
  }

  void markAllAsRead() {
    for (int i = 0; i < notifications.length; i++) {
      if (notifications[i].status == NotificationStatus.unread) {
        notifications[i] = notifications[i].copyWith(status: NotificationStatus.read);
      }
    }
  }

  void deleteNotification(String id) => notifications.removeWhere((n) => n.id == id);

  void deleteAllNotifications() => notifications.clear();

  // ── Mock seed ──────────────────────────────────────────────────────────────

  void _seedMockNotifications() {
    final now = DateTime.now();
    notifications.value = [
      NotificationModel(id: 'n1', title: 'موعد جديد',        body: 'تم حجز موعد جديد مع المريض أحمد خالد في الساعة 3:00 مساءً', type: NotificationType.appointment, status: NotificationStatus.unread,  createdAt: now.subtract(const Duration(minutes: 30)), relatedId: 'a1'),
      NotificationModel(id: 'n2', title: 'نتائج الفحوصات',   body: 'تم تحميل نتائج فحوصات المريض سارة محمد',                       type: NotificationType.labResult,    status: NotificationStatus.unread,  createdAt: now.subtract(const Duration(hours: 2)),    relatedId: 'l1'),
      NotificationModel(id: 'n3', title: 'دفع فاتورة',        body: 'تم دفع الفاتورة رقم #1234 بقيمة 150 دولار',                    type: NotificationType.payment,      status: NotificationStatus.read,    createdAt: now.subtract(const Duration(days: 1)),     relatedId: 'p1'),
      NotificationModel(id: 'n4', title: 'رسالة جديدة',       body: 'لديك رسالة جديدة من الدكتور محمد علي',                         type: NotificationType.message,      status: NotificationStatus.unread,  createdAt: now.subtract(const Duration(days: 2)),     relatedId: 'm1'),
      NotificationModel(id: 'n5', title: 'موعد ملغى',         body: 'تم إلغاء الموعد مع المريض يوسف إبراهيم',                       type: NotificationType.appointment,  status: NotificationStatus.read,    createdAt: now.subtract(const Duration(days: 3)),     relatedId: 'a2'),
    ];
  }
}
