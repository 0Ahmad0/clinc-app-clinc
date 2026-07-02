import '../../../app/data/base_model.dart';
import '../../../app/data/profile_model.dart';
import '../models/support_request_model.dart';
import 'settings_data_source.dart';

class SettingsMockDataSource implements SettingsDataSource {
  ProfileModel? pendingProfileUpdate;

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

  @override
  Future<BaseModel<ProfileModel>> submitProfileUpdate(
    ProfileModel profile,
  ) async {
    await Future<void>.delayed(const Duration(milliseconds: 700));
    pendingProfileUpdate = profile.copyWith(updateStatus: 'pending');
    return BaseModel.fromJson({
      'status': 'success',
      'message': 'Profile update request sent for admin approval',
      'data': pendingProfileUpdate!.toJson(),
      'meta': null,
    }, (json) => ProfileModel.fromJson(Map<String, dynamic>.from(json as Map)));
  }

  @override
  Future<BaseModel<SupportRequestModel>> submitSupportRequest({
    required String subject,
    required String description,
    required List<String> imagePaths,
  }) async {
    await Future<void>.delayed(const Duration(milliseconds: 700));
    return BaseModel.fromJson(
      {
        'status': 'success',
        'message': 'Support report submitted successfully',
        'data': {
          'request_id': 'SUP-${DateTime.now().millisecondsSinceEpoch}',
          'subject': subject,
          'description': description,
          'images': imagePaths,
          'status': 'pending',
        },
        'meta': null,
      },
      (json) =>
          SupportRequestModel.fromJson(Map<String, dynamic>.from(json as Map)),
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
