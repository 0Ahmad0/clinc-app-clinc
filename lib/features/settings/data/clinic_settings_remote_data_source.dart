import 'package:dio/dio.dart';

import '../../../core/data/base_model.dart';
import '../../../core/domain/services/api_service.dart';
import '../../../core/utils/app_url.dart';
import 'models/clinic_settings_model.dart';

class ClinicSettingsRemoteDataSource {
  ClinicSettingsRemoteDataSource(this._apiServices);

  final ApiServices _apiServices;

  Future<BaseModel<ClinicSettingsProfileModel>> profile() async {
    final response = await _apiServices.get(AppUrl.clinicProfile);
    return BaseModel.fromJson(
      Map<String, dynamic>.from(response as Map),
      (json) => ClinicSettingsProfileModel.fromJson(
        Map<String, dynamic>.from(json as Map),
      ),
    );
  }

  Future<BaseModel<ClinicSettingsProfileUpdateModel>> updateProfile({
    required Map<String, dynamic> fields,
    String? logoPath,
    String? coverPath,
  }) async {
    final form = FormData();
    for (final entry in fields.entries) {
      final value = entry.value;
      if (value is List) {
        for (var index = 0; index < value.length; index++) {
          form.fields.add(MapEntry('${entry.key}[$index]', '${value[index]}'));
        }
      } else if (value != null) {
        form.fields.add(MapEntry(entry.key, value.toString()));
      }
    }
    if (logoPath != null) {
      form.files.add(MapEntry('logo', await MultipartFile.fromFile(logoPath)));
    }
    if (coverPath != null) {
      form.files.add(
        MapEntry('cover', await MultipartFile.fromFile(coverPath)),
      );
    }
    final response = await _apiServices.put(
      AppUrl.clinicProfile,
      formData: form,
    );
    return BaseModel.fromJson(
      Map<String, dynamic>.from(response as Map),
      (json) => ClinicSettingsProfileUpdateModel.fromJson(
        Map<String, dynamic>.from(json as Map),
      ),
    );
  }

  Future<BaseModel<BaseModels<ClinicInsuranceModel>>> insurances() async {
    final response = await _apiServices.get(AppUrl.clinicInsurances);
    return BaseModel.fromJson(
      Map<String, dynamic>.from(response as Map),
      (json) => BaseModels.fromJson(
        json,
        (itemJson) => ClinicInsuranceModel.fromJson(
          Map<String, dynamic>.from(itemJson as Map),
        ),
      ),
    );
  }

  Future<BaseModel<ClinicPasswordChangeModel>> changePassword({
    required String currentPassword,
    required String password,
    required String passwordConfirmation,
  }) async {
    final response = await _apiServices.post(
      AppUrl.clinicChangePassword,
      body: {
        'current_password': currentPassword,
        'password': password,
        'password_confirmation': passwordConfirmation,
      },
    );
    return BaseModel.fromJson(
      Map<String, dynamic>.from(response as Map),
      (json) => ClinicPasswordChangeModel.fromJson(
        Map<String, dynamic>.from(json as Map),
      ),
    );
  }

  Future<BaseModel<ClinicNotificationSettingsModel>>
  notificationSettings() async {
    final response = await _apiServices.get(AppUrl.clinicNotificationSettings);
    return _notificationSettingsResponse(response);
  }

  Future<BaseModel<ClinicNotificationSettingsModel>>
  updateNotificationSettings({
    required bool appNotifications,
    required bool emailNotifications,
    required bool smsNotifications,
  }) async {
    final response = await _apiServices.put(
      AppUrl.clinicNotificationSettings,
      body: {
        'app_notifications': appNotifications,
        'email_notifications': emailNotifications,
        'sms_notifications': smsNotifications,
      },
    );
    return _notificationSettingsResponse(response);
  }

  BaseModel<ClinicNotificationSettingsModel> _notificationSettingsResponse(
    dynamic response,
  ) {
    return BaseModel.fromJson(
      Map<String, dynamic>.from(response as Map),
      (json) => ClinicNotificationSettingsModel.fromJson(
        Map<String, dynamic>.from(json as Map),
      ),
    );
  }
}
