import '../../../app/data/base_model.dart';
import '../../../app/data/profile_model.dart';
import '../models/support_request_model.dart';

abstract class SettingsDataSource {
  Future<BaseModel<Map<String, dynamic>>> changePassword({
    required String currentPassword,
    required String newPassword,
    required String passwordConfirmation,
  });

  Future<BaseModel<ProfileModel>> submitProfileUpdate(ProfileModel profile);

  Future<BaseModel<SupportRequestModel>> submitSupportRequest({
    required String subject,
    required String description,
    required List<String> imagePaths,
  });
}
