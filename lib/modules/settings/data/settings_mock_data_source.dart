import '../../../app/data/base_model.dart';
import 'settings_data_source.dart';

class SettingsMockDataSource implements SettingsDataSource {
  @override
  Future<BaseModel<Map<String, dynamic>>> changePassword({
    required String currentPassword,
    required String newPassword,
    required String passwordConfirmation,
  }) async {
    await Future<void>.delayed(const Duration(milliseconds: 600));
    if (currentPassword != 'password') {
      return _response(
        status: 'error',
        message: 'Current password is incorrect',
      );
    }
    if (newPassword != passwordConfirmation) {
      return _response(
        status: 'error',
        message: 'Password confirmation does not match',
      );
    }
    return _response(
      status: 'success',
      message: 'Password changed successfully',
    );
  }

  BaseModel<Map<String, dynamic>> _response({
    required String status,
    required String message,
  }) {
    return BaseModel.fromJson({
      'status': status,
      'message': message,
      'data': <String, dynamic>{},
      'error': null,
    }, (json) => Map<String, dynamic>.from(json as Map));
  }
}
