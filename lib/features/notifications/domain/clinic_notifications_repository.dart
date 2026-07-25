import '../../../core/data/base_model.dart';
import '../../../core/data/remote/api_response.dart';
import '../../../core/domain/error_handler/network_exceptions.dart';
import '../data/clinic_notifications_remote_data_source.dart';
import '../data/models/clinic_notification_model.dart';

class ClinicNotificationsRepository {
  ClinicNotificationsRepository(this._remoteDataSource);

  final ClinicNotificationsRemoteDataSource _remoteDataSource;

  Future<ApiResponse<BaseModel<BaseModels<ClinicNotificationModel>>>>
  notifications({required int page, required int perPage, bool? isRead}) =>
      _execute(
        () => _remoteDataSource.notifications(
          page: page,
          perPage: perPage,
          isRead: isRead,
        ),
      );

  Future<ApiResponse<BaseModel<ClinicNotificationModel>>> markRead(int id) =>
      _execute(() => _remoteDataSource.markRead(id));

  Future<ApiResponse<BaseModel<ClinicMarkAllNotificationsModel>>>
  markAllRead() => _execute(_remoteDataSource.markAllRead);

  Future<ApiResponse<BaseModel<ClinicUnreadCountModel>>> unreadCount() =>
      _execute(_remoteDataSource.unreadCount);

  Future<ApiResponse<BaseModel<ClinicNotificationDeletionModel>>> delete(
    int id,
  ) => _execute(() => _remoteDataSource.delete(id));

  Future<ApiResponse<BaseModel<ClinicNotificationsClearModel>>> clear() =>
      _execute(_remoteDataSource.clear);

  Future<ApiResponse<BaseModel<ClinicDeviceTokenModel>>> storeDeviceToken({
    required String token,
    required String platform,
    String? deviceId,
    String? appVersion,
    String? locale,
  }) => _execute(
    () => _remoteDataSource.storeDeviceToken(
      token: token,
      platform: platform,
      deviceId: deviceId,
      appVersion: appVersion,
      locale: locale,
    ),
  );

  Future<ApiResponse<BaseModel<T>>> _execute<T>(
    Future<BaseModel<T>> Function() action,
  ) async {
    try {
      return ApiResponse.success(await action());
    } catch (error) {
      return ApiResponse.failure(NetworkExceptions.getException(error));
    }
  }
}
