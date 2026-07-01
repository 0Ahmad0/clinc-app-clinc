import '../../../app/data/base_model.dart';
import '../../../app/data/remote/api_response.dart';
import '../../../app/domain/error_handler/network_exceptions.dart';
import '../data/settings_data_source.dart';

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
}
