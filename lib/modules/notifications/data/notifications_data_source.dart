import '../../../app/data/base_model.dart';
import '../../../app/data/notification_model.dart';

abstract class NotificationsDataSource {
  Future<BaseModel<BaseModels<NotificationModel>>> getNotifications({
    required int page,
    bool? isRead,
  });

  Future<BaseModel<Map<String, dynamic>>> markAsRead(String id);

  Future<BaseModel<Map<String, dynamic>>> markAllAsRead();

  Future<BaseModel<Map<String, dynamic>>> deleteNotification(String id);

  Future<BaseModel<Map<String, dynamic>>> deleteAllNotifications();
}
