import '../../../app/data/base_model.dart';

abstract class SettingsDataSource {
  Future<BaseModel<Map<String, dynamic>>> changePassword({
    required String currentPassword,
    required String newPassword,
    required String passwordConfirmation,
  });
}
