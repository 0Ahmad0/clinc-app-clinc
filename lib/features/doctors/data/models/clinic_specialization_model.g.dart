// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'clinic_specialization_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ClinicSpecializationModel _$ClinicSpecializationModelFromJson(
  Map<String, dynamic> json,
) => _ClinicSpecializationModel(
  specializationId: json['specialization_id'] as String?,
  name: json['name'] as String?,
  nameAr: json['name_ar'] as String?,
  nameEn: json['name_en'] as String?,
  icon: json['icon'] as String?,
  color: json['color'] as String?,
  isActive: json['is_active'] as bool? ?? false,
);

Map<String, dynamic> _$ClinicSpecializationModelToJson(
  _ClinicSpecializationModel instance,
) => <String, dynamic>{
  'specialization_id': instance.specializationId,
  'name': instance.name,
  'name_ar': instance.nameAr,
  'name_en': instance.nameEn,
  'icon': instance.icon,
  'color': instance.color,
  'is_active': instance.isActive,
};
