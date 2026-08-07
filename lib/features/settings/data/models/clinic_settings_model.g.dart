// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'clinic_settings_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ClinicSettingsProfileModel _$ClinicSettingsProfileModelFromJson(
  Map<String, dynamic> json,
) => _ClinicSettingsProfileModel(
  clinic: json['clinic'] == null
      ? null
      : ClinicSettingsClinicModel.fromJson(
          json['clinic'] as Map<String, dynamic>,
        ),
  pendingUpdate: json['pending_update'] as bool? ?? false,
);

Map<String, dynamic> _$ClinicSettingsProfileModelToJson(
  _ClinicSettingsProfileModel instance,
) => <String, dynamic>{
  'clinic': instance.clinic,
  'pending_update': instance.pendingUpdate,
};

_ClinicSettingsProfileUpdateModel _$ClinicSettingsProfileUpdateModelFromJson(
  Map<String, dynamic> json,
) => _ClinicSettingsProfileUpdateModel(
  submittedForReview: json['submitted_for_review'] as bool? ?? false,
  clinic: json['clinic'] == null
      ? null
      : ClinicSettingsClinicModel.fromJson(
          json['clinic'] as Map<String, dynamic>,
        ),
);

Map<String, dynamic> _$ClinicSettingsProfileUpdateModelToJson(
  _ClinicSettingsProfileUpdateModel instance,
) => <String, dynamic>{
  'submitted_for_review': instance.submittedForReview,
  'clinic': instance.clinic,
};

_ClinicSettingsClinicModel _$ClinicSettingsClinicModelFromJson(
  Map<String, dynamic> json,
) => _ClinicSettingsClinicModel(
  clinicId: (json['clinic_id'] as num?)?.toInt(),
  name: json['name'] as String?,
  email: json['email'] as String?,
  phone: json['phone'] as String?,
  location: json['location'] as String?,
  licenseNumber: json['license_number'] as String?,
  description: json['description'] as String?,
  website: json['website'] as String?,
  logo: json['logo'] as String?,
  cover: json['cover'] as String?,
  lat: json['lat'],
  lng: json['lng'],
  status: json['status'] as String?,
  isActive: json['is_active'] as bool?,
  type: json['type'] as String?,
  workingHours: json['working_hours'] as List<dynamic>? ?? const [],
);

Map<String, dynamic> _$ClinicSettingsClinicModelToJson(
  _ClinicSettingsClinicModel instance,
) => <String, dynamic>{
  'clinic_id': instance.clinicId,
  'name': instance.name,
  'email': instance.email,
  'phone': instance.phone,
  'location': instance.location,
  'license_number': instance.licenseNumber,
  'description': instance.description,
  'website': instance.website,
  'logo': instance.logo,
  'cover': instance.cover,
  'lat': instance.lat,
  'lng': instance.lng,
  'status': instance.status,
  'is_active': instance.isActive,
  'type': instance.type,
  'working_hours': instance.workingHours,
};

_ClinicInsuranceModel _$ClinicInsuranceModelFromJson(
  Map<String, dynamic> json,
) => _ClinicInsuranceModel(
  id: _intFromJson(json['id']),
  name: json['name'] as String?,
  nameAr: json['name_ar'] as String?,
  nameEn: json['name_en'] as String?,
  code: json['code'] as String?,
  logo: json['logo'] as String?,
  isActive: json['is_active'] as bool? ?? true,
  isSelected: json['is_selected'] as bool? ?? false,
);

Map<String, dynamic> _$ClinicInsuranceModelToJson(
  _ClinicInsuranceModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'name_ar': instance.nameAr,
  'name_en': instance.nameEn,
  'code': instance.code,
  'logo': instance.logo,
  'is_active': instance.isActive,
  'is_selected': instance.isSelected,
};

_ClinicNotificationSettingsModel _$ClinicNotificationSettingsModelFromJson(
  Map<String, dynamic> json,
) => _ClinicNotificationSettingsModel(
  appNotifications: json['app_notifications'] as bool? ?? false,
  emailNotifications: json['email_notifications'] as bool? ?? false,
  smsNotifications: json['sms_notifications'] as bool? ?? false,
);

Map<String, dynamic> _$ClinicNotificationSettingsModelToJson(
  _ClinicNotificationSettingsModel instance,
) => <String, dynamic>{
  'app_notifications': instance.appNotifications,
  'email_notifications': instance.emailNotifications,
  'sms_notifications': instance.smsNotifications,
};

_ClinicPasswordChangeModel _$ClinicPasswordChangeModelFromJson(
  Map<String, dynamic> json,
) => _ClinicPasswordChangeModel(
  passwordChanged: json['password_changed'] as bool? ?? false,
);

Map<String, dynamic> _$ClinicPasswordChangeModelToJson(
  _ClinicPasswordChangeModel instance,
) => <String, dynamic>{'password_changed': instance.passwordChanged};
