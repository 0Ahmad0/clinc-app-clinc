import '../../../app/core/utils/app_url.dart';
import '../../../app/data/base_model.dart';
import '../../../app/data/notification_model.dart';
import '../../../app/domain/services/api_service.dart';
import 'notifications_data_source.dart';

class NotificationsRemoteDataSource implements NotificationsDataSource {
  NotificationsRemoteDataSource(this._apiServices);

  final ApiServices _apiServices;

  @override
  Future<BaseModel<BaseModels<NotificationModel>>> getNotifications({
    required int page,
    bool? isRead,
  }) async {
    final response = await _apiServices.get(
      AppUrl.clinicNotifications,
      queryParams: {
        'page': page,
        if (isRead != null) 'is_read': isRead ? 1 : 0,
      },
      hasToken: true,
    );
    return BaseModel.fromJson(
      response,
      (json) => BaseModels.fromJson(
        json,
        (item) =>
            NotificationModel.fromJson(Map<String, dynamic>.from(item as Map)),
      ),
    );
  }

  @override
  Future<BaseModel<Map<String, dynamic>>> markAsRead(String id) async {
    final response = await _apiServices.put(
      '${AppUrl.clinicNotifications}/$id/read',
      hasToken: true,
    );
    return _actionResponse(response);
  }

  @override
  Future<BaseModel<Map<String, dynamic>>> markAllAsRead() async {
    final response = await _apiServices.put(
      '${AppUrl.clinicNotifications}/read-all',
      hasToken: true,
    );
    return _actionResponse(response);
  }

  @override
  Future<BaseModel<Map<String, dynamic>>> deleteNotification(String id) async {
    final response = await _apiServices.delete(
      '${AppUrl.clinicNotifications}/$id',
      hasToken: true,
    );
    return _actionResponse(response);
  }

  @override
  Future<BaseModel<Map<String, dynamic>>> deleteAllNotifications() async {
    final response = await _apiServices.delete(
      AppUrl.clinicNotifications,
      hasToken: true,
    );
    return _actionResponse(response);
  }

  BaseModel<Map<String, dynamic>> _actionResponse(
    Map<String, dynamic> response,
  ) {
    return BaseModel.fromJson(
      response,
      (json) => Map<String, dynamic>.from(json as Map),
    );
  }
}
