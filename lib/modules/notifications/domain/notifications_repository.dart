import '../../../app/data/base_model.dart';
import '../../../app/data/notification_model.dart';
import '../../../app/data/remote/api_response.dart';
import '../../../app/domain/error_handler/network_exceptions.dart';
import '../data/notifications_data_source.dart';

class NotificationsRepository {
  NotificationsRepository(this._dataSource);

  final NotificationsDataSource _dataSource;

  Future<ApiResponse<BaseModel<BaseModels<NotificationModel>>>>
  getNotifications({required int page, bool? isRead}) {
    return _execute(
      () => _dataSource.getNotifications(page: page, isRead: isRead),
    );
  }

  Future<ApiResponse<BaseModel<Map<String, dynamic>>>> markAsRead(String id) {
    return _execute(() => _dataSource.markAsRead(id));
  }

  Future<ApiResponse<BaseModel<Map<String, dynamic>>>> markAllAsRead() {
    return _execute(_dataSource.markAllAsRead);
  }

  Future<ApiResponse<BaseModel<Map<String, dynamic>>>> deleteNotification(
    String id,
  ) {
    return _execute(() => _dataSource.deleteNotification(id));
  }

  Future<ApiResponse<BaseModel<Map<String, dynamic>>>>
  deleteAllNotifications() {
    return _execute(_dataSource.deleteAllNotifications);
  }

  Future<ApiResponse<T>> _execute<T>(Future<T> Function() action) async {
    try {
      return ApiResponse.success(await action());
    } catch (error) {
      return ApiResponse.failure(NetworkExceptions.getException(error));
    }
  }
}
