import '../../../core/data/base_model.dart';
import '../../../core/domain/services/api_service.dart';
import '../../../core/utils/app_url.dart';
import 'models/clinic_notification_model.dart';

class ClinicNotificationsRemoteDataSource {
  ClinicNotificationsRemoteDataSource(this._apiServices);

  final ApiServices _apiServices;

  Future<BaseModel<BaseModels<ClinicNotificationModel>>> notifications({
    required int page,
    required int perPage,
    bool? isRead,
  }) async {
    final response = await _apiServices.get(
      AppUrl.clinicNotifications,
      queryParams: {
        'page': page,
        'per_page': perPage,
        if (isRead != null) 'is_read': isRead ? 1 : 0,
      },
    );

    return BaseModel.fromJson(
      _normalizePaginatedResponse(Map<String, dynamic>.from(response as Map)),
      (json) => BaseModels.fromJson(
        json,
        (itemJson) => ClinicNotificationModel.fromJson(
          Map<String, dynamic>.from(itemJson as Map),
        ),
      ),
    );
  }

  Future<BaseModel<ClinicNotificationModel>> markRead(int id) async {
    final response = await _apiServices.post(AppUrl.clinicNotificationRead(id));
    return _notificationResponse(response);
  }

  Future<BaseModel<ClinicMarkAllNotificationsModel>> markAllRead() async {
    final response = await _apiServices.post(
      AppUrl.clinicNotificationsMarkAllRead,
    );
    return BaseModel.fromJson(
      Map<String, dynamic>.from(response as Map),
      (json) => ClinicMarkAllNotificationsModel.fromJson(
        Map<String, dynamic>.from(json as Map),
      ),
    );
  }

  Future<BaseModel<ClinicUnreadCountModel>> unreadCount() async {
    final response = await _apiServices.get(
      AppUrl.clinicNotificationsUnreadCount,
    );
    return BaseModel.fromJson(
      Map<String, dynamic>.from(response as Map),
      (json) => ClinicUnreadCountModel.fromJson(
        Map<String, dynamic>.from(json as Map),
      ),
    );
  }

  Future<BaseModel<ClinicNotificationDeletionModel>> delete(int id) async {
    final response = await _apiServices.delete(AppUrl.clinicNotification(id));
    return BaseModel.fromJson(
      Map<String, dynamic>.from(response as Map),
      (json) => ClinicNotificationDeletionModel.fromJson(
        Map<String, dynamic>.from(json as Map),
      ),
    );
  }

  Future<BaseModel<ClinicNotificationsClearModel>> clear() async {
    final response = await _apiServices.delete(AppUrl.clinicNotifications);
    return BaseModel.fromJson(
      Map<String, dynamic>.from(response as Map),
      (json) => ClinicNotificationsClearModel.fromJson(
        Map<String, dynamic>.from(json as Map),
      ),
    );
  }

  Future<BaseModel<ClinicDeviceTokenModel>> storeDeviceToken({
    required String token,
    required String platform,
    String? deviceId,
    String? appVersion,
    String? locale,
  }) async {
    final response = await _apiServices.post(
      AppUrl.clinicDeviceToken,
      body: {
        'token': token,
        'platform': platform,
        if (deviceId != null) 'device_id': deviceId,
        if (appVersion != null) 'app_version': appVersion,
        if (locale != null) 'locale': locale,
      },
    );
    return BaseModel.fromJson(
      Map<String, dynamic>.from(response as Map),
      (json) => ClinicDeviceTokenModel.fromJson(
        Map<String, dynamic>.from(json as Map),
      ),
    );
  }

  BaseModel<ClinicNotificationModel> _notificationResponse(dynamic response) {
    return BaseModel.fromJson(
      Map<String, dynamic>.from(response as Map),
      (json) => ClinicNotificationModel.fromJson(
        Map<String, dynamic>.from(json as Map),
      ),
    );
  }

  Map<String, dynamic> _normalizePaginatedResponse(Map<String, dynamic> json) {
    final meta = json['meta'];
    if (meta is Map) {
      final normalized = Map<String, dynamic>.from(meta);
      final currentPage =
          int.tryParse(
            '${normalized['current_page'] ?? normalized['currentPage']}',
          ) ??
          1;
      final perPage =
          int.tryParse('${normalized['per_page'] ?? normalized['perPage']}') ??
          0;
      json['meta'] = {
        'current_page': currentPage,
        'from': normalized['from'],
        'per_page': perPage,
        'total': normalized['total'],
        'to': normalized['to'] ?? currentPage * perPage,
      };
    }
    return json;
  }
}
