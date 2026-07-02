import '../../../app/data/base_model.dart';
import '../../../app/data/profile_model.dart';
import '../../../app/data/remote/api_response.dart';
import '../../../app/domain/error_handler/network_exceptions.dart';
import '../data/settings_data_source.dart';
import '../models/support_request_model.dart';

class SettingsRepository {
  SettingsRepository(this._dataSource);

  final SettingsDataSource _dataSource;

  Future<ApiResponse<BaseModel<Map<String, dynamic>>>> changePassword({
    required String currentPassword,
    required String newPassword,
    required String passwordConfirmation,
  }) async {
    try {
      return ApiResponse.success(
        await _dataSource.changePassword(
          currentPassword: currentPassword,
          newPassword: newPassword,
          passwordConfirmation: passwordConfirmation,
        ),
      );
    } catch (error) {
      return ApiResponse.failure(NetworkExceptions.getException(error));
    }
  }

  Future<ApiResponse<BaseModel<ProfileModel>>> submitProfileUpdate(
    ProfileModel profile,
  ) async {
    try {
      return ApiResponse.success(
        await _dataSource.submitProfileUpdate(profile),
      );
    } catch (error) {
      return ApiResponse.failure(NetworkExceptions.getException(error));
    }
  }

  Future<ApiResponse<BaseModel<SupportRequestModel>>> submitSupportRequest({
    required String subject,
    required String description,
    required List<String> imagePaths,
  }) async {
    try {
      return ApiResponse.success(
        await _dataSource.submitSupportRequest(
          subject: subject,
          description: description,
          imagePaths: imagePaths,
        ),
      );
    } catch (error) {
      return ApiResponse.failure(NetworkExceptions.getException(error));
    }
  }
}
