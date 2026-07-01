import '../../../app/data/base_model.dart';
import '../../../app/data/notification_model.dart';
import 'notifications_data_source.dart';

class NotificationsMockDataSource implements NotificationsDataSource {
  static const _pageSize = 2;
  static const _delay = Duration(milliseconds: 350);

  static final List<Map<String, dynamic>> _items = [
    {
      'notification_id': 'N-001',
      'title': 'طلب حجز جديد',
      'subtitle': 'يوجد طلب حجز جديد بانتظار المراجعة.',
      'type': 'appointment',
      'icon': 'calendar',
      'is_read': false,
      'related_id': 'A-001',
      'created_at': DateTime.now()
          .subtract(const Duration(minutes: 20))
          .toIso8601String(),
    },
    {
      'notification_id': 'N-002',
      'title': 'تم تأكيد الدفع',
      'subtitle': 'تم دفع فاتورة الموعد بقيمة 180 ر.س.',
      'type': 'payment',
      'icon': 'payment',
      'is_read': false,
      'related_id': 'P-001',
      'created_at': DateTime.now()
          .subtract(const Duration(hours: 2))
          .toIso8601String(),
    },
    {
      'notification_id': 'N-003',
      'title': 'نتيجة تحليل جاهزة',
      'subtitle': 'تم رفع نتيجة التحليل بنجاح.',
      'type': 'lab_result',
      'icon': 'lab',
      'is_read': true,
      'related_id': 'A-003',
      'created_at': DateTime.now()
          .subtract(const Duration(days: 1))
          .toIso8601String(),
    },
    {
      'notification_id': 'N-004',
      'title': 'رسالة من الإدارة',
      'subtitle': 'تمت الموافقة على تحديث معلومات العيادة.',
      'type': 'system',
      'icon': 'info',
      'is_read': true,
      'related_id': null,
      'created_at': DateTime.now()
          .subtract(const Duration(days: 2))
          .toIso8601String(),
    },
  ];

  @override
  Future<BaseModel<BaseModels<NotificationModel>>> getNotifications({
    required int page,
    bool? isRead,
  }) async {
    await Future<void>.delayed(_delay);
    final filtered = _items
        .where((item) => isRead == null || item['is_read'] == isRead)
        .toList();
    final start = (page - 1) * _pageSize;
    final pageItems = start >= filtered.length
        ? <Map<String, dynamic>>[]
        : filtered.sublist(
            start,
            (start + _pageSize).clamp(0, filtered.length),
          );
    final to = (start + pageItems.length).clamp(0, filtered.length);

    return BaseModel.fromJson(
      {
        'status': 'success',
        'message': 'Notifications retrieved successfully',
        'data': pageItems,
        'meta': {
          'current_page': page,
          'from': pageItems.isEmpty ? null : start + 1,
          'to': pageItems.isEmpty ? null : to,
          'per_page': _pageSize,
          'total': filtered.length,
        },
      },
      (json) => BaseModels.fromJson(
        json,
        (item) =>
            NotificationModel.fromJson(Map<String, dynamic>.from(item as Map)),
      ),
    );
  }

  @override
  Future<BaseModel<Map<String, dynamic>>> markAsRead(String id) async {
    await Future<void>.delayed(_delay);
    final index = _items.indexWhere((item) => item['notification_id'] == id);
    if (index != -1) _items[index] = {..._items[index], 'is_read': true};
    return _actionResponse('Notification marked as read successfully');
  }

  @override
  Future<BaseModel<Map<String, dynamic>>> markAllAsRead() async {
    await Future<void>.delayed(_delay);
    for (var index = 0; index < _items.length; index++) {
      _items[index] = {..._items[index], 'is_read': true};
    }
    return _actionResponse('All notifications marked as read successfully');
  }

  @override
  Future<BaseModel<Map<String, dynamic>>> deleteNotification(String id) async {
    await Future<void>.delayed(_delay);
    _items.removeWhere((item) => item['notification_id'] == id);
    return _actionResponse('Notification deleted successfully');
  }

  @override
  Future<BaseModel<Map<String, dynamic>>> deleteAllNotifications() async {
    await Future<void>.delayed(_delay);
    _items.clear();
    return _actionResponse('All notifications deleted successfully');
  }

  BaseModel<Map<String, dynamic>> _actionResponse(String message) {
    return BaseModel.fromJson({
      'status': 'success',
      'message': message,
      'data': <String, dynamic>{},
      'meta': <String, dynamic>{},
    }, (json) => Map<String, dynamic>.from(json as Map));
  }
}
