import '../../../core/data/base_model.dart';
import '../../../core/data/remote/api_response.dart';
import '../../../core/domain/error_handler/network_exceptions.dart';
import '../data/clinic_settings_remote_data_source.dart';
import '../data/models/clinic_settings_model.dart';

class ClinicSettingsRepository {
  ClinicSettingsRepository(this._remoteDataSource);

  final ClinicSettingsRemoteDataSource _remoteDataSource;

  Future<ApiResponse<BaseModel<ClinicSettingsProfileModel>>> profile() =>
      _execute(_remoteDataSource.profile);

  Future<ApiResponse<BaseModel<ClinicSettingsProfileUpdateModel>>>
  updateProfile({
    required Map<String, dynamic> fields,
    String? logoPath,
    String? coverPath,
  }) => _execute(
    () => _remoteDataSource.updateProfile(
      fields: fields,
      logoPath: logoPath,
      coverPath: coverPath,
    ),
  );

  Future<ApiResponse<BaseModel<BaseModels<ClinicInsuranceModel>>>>
  insurances() => _execute(_remoteDataSource.insurances);

  Future<ApiResponse<BaseModel<ClinicPasswordChangeModel>>> changePassword({
    required String currentPassword,
    required String password,
    required String passwordConfirmation,
  }) => _execute(
    () => _remoteDataSource.changePassword(
      currentPassword: currentPassword,
      password: password,
      passwordConfirmation: passwordConfirmation,
    ),
  );

  Future<ApiResponse<BaseModel<ClinicNotificationSettingsModel>>>
  notificationSettings() => _execute(_remoteDataSource.notificationSettings);

  Future<ApiResponse<BaseModel<ClinicNotificationSettingsModel>>>
  updateNotificationSettings({
    required bool appNotifications,
    required bool emailNotifications,
    required bool smsNotifications,
  }) => _execute(
    () => _remoteDataSource.updateNotificationSettings(
      appNotifications: appNotifications,
      emailNotifications: emailNotifications,
      smsNotifications: smsNotifications,
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
