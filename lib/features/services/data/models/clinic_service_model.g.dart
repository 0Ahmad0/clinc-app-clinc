// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'clinic_service_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ClinicLabSectionModel _$ClinicLabSectionModelFromJson(
  Map<String, dynamic> json,
) => _ClinicLabSectionModel(
  sectionId: _intFromJson(json['section_id']),
  slug: json['slug'] as String?,
  name: json['name'] as String?,
  nameAr: json['name_ar'] as String?,
  nameEn: json['name_en'] as String?,
  description: json['description'] as String?,
  icon: json['icon'] as String?,
  color: json['color'] as String?,
  isActive: json['is_active'] == null
      ? false
      : _boolFromJson(json['is_active']),
);

Map<String, dynamic> _$ClinicLabSectionModelToJson(
  _ClinicLabSectionModel instance,
) => <String, dynamic>{
  'section_id': instance.sectionId,
  'slug': instance.slug,
  'name': instance.name,
  'name_ar': instance.nameAr,
  'name_en': instance.nameEn,
  'description': instance.description,
  'icon': instance.icon,
  'color': instance.color,
  'is_active': instance.isActive,
};

_ClinicAvailableLabTestModel _$ClinicAvailableLabTestModelFromJson(
  Map<String, dynamic> json,
) => _ClinicAvailableLabTestModel(
  labTestId: _intFromJson(json['lab_test_id']),
  code: json['code'] as String?,
  name: json['name'] as String?,
  nameAr: json['name_ar'] as String?,
  nameEn: json['name_en'] as String?,
  description: json['description'] as String?,
  sectionId: _intFromJson(json['section_id']),
  sectionSlug: json['section_slug'] as String?,
  sectionName: json['section_name'] as String?,
  icon: json['section_icon'] as String?,
  color: json['section_color'] as String?,
  defaultPrice: _numFromJson(json['default_price']),
  isActive: json['is_active'] == null
      ? false
      : _boolFromJson(json['is_active']),
);

Map<String, dynamic> _$ClinicAvailableLabTestModelToJson(
  _ClinicAvailableLabTestModel instance,
) => <String, dynamic>{
  'lab_test_id': instance.labTestId,
  'code': instance.code,
  'name': instance.name,
  'name_ar': instance.nameAr,
  'name_en': instance.nameEn,
  'description': instance.description,
  'section_id': instance.sectionId,
  'section_slug': instance.sectionSlug,
  'section_name': instance.sectionName,
  'section_icon': instance.icon,
  'section_color': instance.color,
  'default_price': instance.defaultPrice,
  'is_active': instance.isActive,
};

_ClinicEnabledLabTestModel _$ClinicEnabledLabTestModelFromJson(
  Map<String, dynamic> json,
) => _ClinicEnabledLabTestModel(
  clinicLabTestId: _intFromJson(json['clinic_lab_test_id']),
  labTestId: _intFromJson(json['lab_test_id']),
  code: json['code'] as String?,
  name: json['name'] as String?,
  nameAr: json['name_ar'] as String?,
  nameEn: json['name_en'] as String?,
  sectionId: _intFromJson(json['section_id']),
  sectionSlug: json['section_slug'] as String?,
  sectionName: json['section_name'] as String?,
  icon: json['section_icon'] as String?,
  color: json['section_color'] as String?,
  price: _numFromJson(json['price']),
  defaultPrice: _numFromJson(json['default_price']),
  isActive: json['is_active'] == null
      ? false
      : _boolFromJson(json['is_active']),
);

Map<String, dynamic> _$ClinicEnabledLabTestModelToJson(
  _ClinicEnabledLabTestModel instance,
) => <String, dynamic>{
  'clinic_lab_test_id': instance.clinicLabTestId,
  'lab_test_id': instance.labTestId,
  'code': instance.code,
  'name': instance.name,
  'name_ar': instance.nameAr,
  'name_en': instance.nameEn,
  'section_id': instance.sectionId,
  'section_slug': instance.sectionSlug,
  'section_name': instance.sectionName,
  'section_icon': instance.icon,
  'section_color': instance.color,
  'price': instance.price,
  'default_price': instance.defaultPrice,
  'is_active': instance.isActive,
};

_ClinicAvailableSpecializationModel
_$ClinicAvailableSpecializationModelFromJson(Map<String, dynamic> json) =>
    _ClinicAvailableSpecializationModel(
      specializationId: _intFromJson(json['specialization_id']),
      slug: json['slug'] as String?,
      name: json['name'] as String?,
      nameAr: json['name_ar'] as String?,
      nameEn: json['name_en'] as String?,
      description: json['description'] as String?,
      icon: json['icon'] as String?,
      color: json['color'] as String?,
      isActive: json['is_active'] == null
          ? false
          : _boolFromJson(json['is_active']),
    );

Map<String, dynamic> _$ClinicAvailableSpecializationModelToJson(
  _ClinicAvailableSpecializationModel instance,
) => <String, dynamic>{
  'specialization_id': instance.specializationId,
  'slug': instance.slug,
  'name': instance.name,
  'name_ar': instance.nameAr,
  'name_en': instance.nameEn,
  'description': instance.description,
  'icon': instance.icon,
  'color': instance.color,
  'is_active': instance.isActive,
};

_ClinicEnabledSpecializationModel _$ClinicEnabledSpecializationModelFromJson(
  Map<String, dynamic> json,
) => _ClinicEnabledSpecializationModel(
  clinicSpecializationId: _intFromJson(json['clinic_specialization_id']),
  specializationId: _intFromJson(json['specialization_id']),
  slug: json['slug'] as String?,
  name: json['name'] as String?,
  nameAr: json['name_ar'] as String?,
  nameEn: json['name_en'] as String?,
  icon: json['icon'] as String?,
  color: json['color'] as String?,
  isActive: json['is_active'] == null
      ? false
      : _boolFromJson(json['is_active']),
);

Map<String, dynamic> _$ClinicEnabledSpecializationModelToJson(
  _ClinicEnabledSpecializationModel instance,
) => <String, dynamic>{
  'clinic_specialization_id': instance.clinicSpecializationId,
  'specialization_id': instance.specializationId,
  'slug': instance.slug,
  'name': instance.name,
  'name_ar': instance.nameAr,
  'name_en': instance.nameEn,
  'icon': instance.icon,
  'color': instance.color,
  'is_active': instance.isActive,
};

_ClinicServiceRemovalModel _$ClinicServiceRemovalModelFromJson(
  Map<String, dynamic> json,
) => _ClinicServiceRemovalModel(removed: json['removed'] as bool? ?? false);

Map<String, dynamic> _$ClinicServiceRemovalModelToJson(
  _ClinicServiceRemovalModel instance,
) => <String, dynamic>{'removed': instance.removed};
