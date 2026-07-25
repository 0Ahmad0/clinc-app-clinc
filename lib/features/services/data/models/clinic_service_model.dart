import 'package:freezed_annotation/freezed_annotation.dart';

part 'clinic_service_model.freezed.dart';
part 'clinic_service_model.g.dart';

int? _intFromJson(dynamic value) {
  if (value == null) return null;
  if (value is int) return value;
  if (value is num) return value.toInt();
  return int.tryParse(value.toString());
}

num? _numFromJson(dynamic value) {
  if (value == null) return null;
  if (value is num) return value;
  return num.tryParse(value.toString());
}

bool _boolFromJson(dynamic value) {
  if (value == null) return false;
  if (value is bool) return value;
  final normalized = value.toString().trim().toLowerCase();
  return normalized == '1' ||
      normalized == 'true' ||
      normalized == 'yes' ||
      normalized == 'on';
}

@freezed
abstract class ClinicLabSectionModel with _$ClinicLabSectionModel {
  const factory ClinicLabSectionModel({
    @JsonKey(name: 'section_id', fromJson: _intFromJson) int? sectionId,
    String? slug,
    String? name,
    @JsonKey(name: 'name_ar') String? nameAr,
    @JsonKey(name: 'name_en') String? nameEn,
    String? description,
    String? icon,
    @JsonKey(name: 'is_active', fromJson: _boolFromJson)
    @Default(false)
    bool isActive,
  }) = _ClinicLabSectionModel;

  factory ClinicLabSectionModel.fromJson(Map<String, dynamic> json) =>
      _$ClinicLabSectionModelFromJson(json);
}

@freezed
abstract class ClinicAvailableLabTestModel with _$ClinicAvailableLabTestModel {
  const factory ClinicAvailableLabTestModel({
    @JsonKey(name: 'lab_test_id', fromJson: _intFromJson) int? labTestId,
    String? code,
    String? name,
    @JsonKey(name: 'name_ar') String? nameAr,
    @JsonKey(name: 'name_en') String? nameEn,
    String? description,
    @JsonKey(name: 'section_id', fromJson: _intFromJson) int? sectionId,
    @JsonKey(name: 'section_slug') String? sectionSlug,
    @JsonKey(name: 'section_name') String? sectionName,
    @JsonKey(name: 'default_price', fromJson: _numFromJson) num? defaultPrice,
    @JsonKey(name: 'is_active', fromJson: _boolFromJson)
    @Default(false)
    bool isActive,
  }) = _ClinicAvailableLabTestModel;

  factory ClinicAvailableLabTestModel.fromJson(Map<String, dynamic> json) =>
      _$ClinicAvailableLabTestModelFromJson(json);
}

@freezed
abstract class ClinicEnabledLabTestModel with _$ClinicEnabledLabTestModel {
  const factory ClinicEnabledLabTestModel({
    @JsonKey(name: 'clinic_lab_test_id', fromJson: _intFromJson)
    int? clinicLabTestId,
    @JsonKey(name: 'lab_test_id', fromJson: _intFromJson) int? labTestId,
    String? code,
    String? name,
    @JsonKey(name: 'name_ar') String? nameAr,
    @JsonKey(name: 'name_en') String? nameEn,
    @JsonKey(name: 'section_id', fromJson: _intFromJson) int? sectionId,
    @JsonKey(name: 'section_slug') String? sectionSlug,
    @JsonKey(name: 'section_name') String? sectionName,
    @JsonKey(fromJson: _numFromJson) num? price,
    @JsonKey(name: 'default_price', fromJson: _numFromJson) num? defaultPrice,
    @JsonKey(name: 'is_active', fromJson: _boolFromJson)
    @Default(false)
    bool isActive,
  }) = _ClinicEnabledLabTestModel;

  factory ClinicEnabledLabTestModel.fromJson(Map<String, dynamic> json) =>
      _$ClinicEnabledLabTestModelFromJson(json);
}

@freezed
abstract class ClinicAvailableSpecializationModel
    with _$ClinicAvailableSpecializationModel {
  const factory ClinicAvailableSpecializationModel({
    @JsonKey(name: 'specialization_id', fromJson: _intFromJson)
    int? specializationId,
    String? slug,
    String? name,
    @JsonKey(name: 'name_ar') String? nameAr,
    @JsonKey(name: 'name_en') String? nameEn,
    String? description,
    String? icon,
    @JsonKey(name: 'is_active', fromJson: _boolFromJson)
    @Default(false)
    bool isActive,
  }) = _ClinicAvailableSpecializationModel;

  factory ClinicAvailableSpecializationModel.fromJson(
    Map<String, dynamic> json,
  ) => _$ClinicAvailableSpecializationModelFromJson(json);
}

@freezed
abstract class ClinicEnabledSpecializationModel
    with _$ClinicEnabledSpecializationModel {
  const factory ClinicEnabledSpecializationModel({
    @JsonKey(name: 'clinic_specialization_id', fromJson: _intFromJson)
    int? clinicSpecializationId,
    @JsonKey(name: 'specialization_id', fromJson: _intFromJson)
    int? specializationId,
    String? slug,
    String? name,
    @JsonKey(name: 'name_ar') String? nameAr,
    @JsonKey(name: 'name_en') String? nameEn,
    String? icon,
    @JsonKey(name: 'is_active', fromJson: _boolFromJson)
    @Default(false)
    bool isActive,
  }) = _ClinicEnabledSpecializationModel;

  factory ClinicEnabledSpecializationModel.fromJson(
    Map<String, dynamic> json,
  ) => _$ClinicEnabledSpecializationModelFromJson(json);
}

@freezed
abstract class ClinicServiceRemovalModel with _$ClinicServiceRemovalModel {
  const factory ClinicServiceRemovalModel({@Default(false) bool removed}) =
      _ClinicServiceRemovalModel;

  factory ClinicServiceRemovalModel.fromJson(Map<String, dynamic> json) =>
      _$ClinicServiceRemovalModelFromJson(json);
}
