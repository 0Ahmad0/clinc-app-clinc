import 'package:freezed_annotation/freezed_annotation.dart';

part 'clinic_specialization_model.freezed.dart';
part 'clinic_specialization_model.g.dart';

@freezed
abstract class ClinicSpecializationModel with _$ClinicSpecializationModel {
  const factory ClinicSpecializationModel({
    @JsonKey(name: 'specialization_id') String? specializationId,
    String? name,
    @JsonKey(name: 'name_ar') String? nameAr,
    @JsonKey(name: 'name_en') String? nameEn,
    String? icon,
    @JsonKey(name: 'is_active') @Default(false) bool isActive,
  }) = _ClinicSpecializationModel;

  factory ClinicSpecializationModel.fromJson(Map<String, dynamic> json) =>
      _$ClinicSpecializationModelFromJson(json);
}
