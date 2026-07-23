import 'package:freezed_annotation/freezed_annotation.dart';

part 'clinic_settings_model.freezed.dart';
part 'clinic_settings_model.g.dart';

@freezed
abstract class ClinicSettingsProfileModel with _$ClinicSettingsProfileModel {
  const factory ClinicSettingsProfileModel({
    ClinicSettingsClinicModel? clinic,
    @JsonKey(name: 'pending_update') @Default(false) bool pendingUpdate,
  }) = _ClinicSettingsProfileModel;

  factory ClinicSettingsProfileModel.fromJson(Map<String, dynamic> json) =>
      _$ClinicSettingsProfileModelFromJson(json);
}

@freezed
abstract class ClinicSettingsProfileUpdateModel
    with _$ClinicSettingsProfileUpdateModel {
  const factory ClinicSettingsProfileUpdateModel({
    @JsonKey(name: 'submitted_for_review')
    @Default(false)
    bool submittedForReview,
    ClinicSettingsClinicModel? clinic,
  }) = _ClinicSettingsProfileUpdateModel;

  factory ClinicSettingsProfileUpdateModel.fromJson(
    Map<String, dynamic> json,
  ) => _$ClinicSettingsProfileUpdateModelFromJson(json);
}

@freezed
abstract class ClinicSettingsClinicModel with _$ClinicSettingsClinicModel {
  const factory ClinicSettingsClinicModel({
    @JsonKey(name: 'clinic_id') int? clinicId,
    String? name,
    String? email,
    String? phone,
    String? location,
    @JsonKey(name: 'license_number') String? licenseNumber,
    String? description,
    String? website,
    String? logo,
    String? cover,
    Object? lat,
    Object? lng,
    String? status,
    @JsonKey(name: 'is_active') bool? isActive,
    String? type,
    @JsonKey(name: 'working_hours') @Default([]) List<dynamic> workingHours,
  }) = _ClinicSettingsClinicModel;

  factory ClinicSettingsClinicModel.fromJson(Map<String, dynamic> json) =>
      _$ClinicSettingsClinicModelFromJson(json);
}

@freezed
abstract class ClinicNotificationSettingsModel
    with _$ClinicNotificationSettingsModel {
  const factory ClinicNotificationSettingsModel({
    @JsonKey(name: 'app_notifications') @Default(false) bool appNotifications,
    @JsonKey(name: 'email_notifications')
    @Default(false)
    bool emailNotifications,
    @JsonKey(name: 'sms_notifications') @Default(false) bool smsNotifications,
  }) = _ClinicNotificationSettingsModel;

  factory ClinicNotificationSettingsModel.fromJson(Map<String, dynamic> json) =>
      _$ClinicNotificationSettingsModelFromJson(json);
}

@freezed
abstract class ClinicPasswordChangeModel with _$ClinicPasswordChangeModel {
  const factory ClinicPasswordChangeModel({
    @JsonKey(name: 'password_changed') @Default(false) bool passwordChanged,
  }) = _ClinicPasswordChangeModel;

  factory ClinicPasswordChangeModel.fromJson(Map<String, dynamic> json) =>
      _$ClinicPasswordChangeModelFromJson(json);
}
