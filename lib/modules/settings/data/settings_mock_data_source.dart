import '../../../app/data/base_model.dart';
import '../../../app/data/profile_model.dart';
import '../models/support_request_model.dart';
import 'settings_data_source.dart';

class SettingsMockDataSource implements SettingsDataSource {
  ProfileModel? pendingProfileUpdate;
  ProfileModel _profile = ProfileModel.mock;
  final Map<String, bool> _notificationSettings = {
    'app_notifications': true,
    'email_notifications': false,
    'sms_notifications': true,
    'appointment_reminders': true,
    'promotional_notifications': false,
  };

  @override
  Future<BaseModel<ProfileModel>> getProfile() async {
    await Future<void>.delayed(const Duration(milliseconds: 450));
    return BaseModel.fromJson({
      'status': 'success',
      'message': 'Clinic profile retrieved successfully',
      'data': _profile.toJson(),
      'meta': null,
    }, (json) => ProfileModel.fromJson(Map<String, dynamic>.from(json as Map)));
  }

  @override
  Future<BaseModel<Map<String, dynamic>>> getNotificationSettings() async {
    await Future<void>.delayed(const Duration(milliseconds: 350));
    return _response(
      status: 'success',
      message: 'Notification settings retrieved successfully',
      data: Map<String, dynamic>.from(_notificationSettings),
    );
  }

  @override
  Future<BaseModel<Map<String, dynamic>>> updateNotificationSettings({
    required Map<String, bool> settings,
  }) async {
    await Future<void>.delayed(const Duration(milliseconds: 450));
    _notificationSettings
      ..clear()
      ..addAll(settings);
    return _response(
      status: 'success',
      message: 'Notification settings updated successfully',
      data: Map<String, dynamic>.from(_notificationSettings),
    );
  }

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
    _profile = profile;
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

  @override
  Future<BaseModel<Map<String, dynamic>>> exportData() async {
    await Future<void>.delayed(const Duration(milliseconds: 700));
    return _response(
      status: 'success',
      message: 'Clinic data export generated successfully',
      data: {
        'file_url':
            'mock://settings/export-${DateTime.now().millisecondsSinceEpoch}.json',
        'generated_at': DateTime.now().toIso8601String(),
      },
    );
  }

  @override
  Future<BaseModel<Map<String, dynamic>>> clearCache() async {
    await Future<void>.delayed(const Duration(milliseconds: 500));
    return _response(
      status: 'success',
      message: 'App cache cleared successfully',
      data: {'cleared': true},
    );
  }

  BaseModel<Map<String, dynamic>> _response({
    required String status,
    required String message,
    Map<String, dynamic>? data,
  }) {
    return BaseModel.fromJson({
      'status': status,
      'message': message,
      'data': data ?? <String, dynamic>{},
      'error': null,
    }, (json) => Map<String, dynamic>.from(json as Map));
  }
}
