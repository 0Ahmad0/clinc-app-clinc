import 'package:freezed_annotation/freezed_annotation.dart';

part 'clinic_doctor_model.freezed.dart';
part 'clinic_doctor_model.g.dart';

@freezed
abstract class ClinicDoctorModel with _$ClinicDoctorModel {
  const factory ClinicDoctorModel({
    @JsonKey(name: 'doctor_id', fromJson: _stringFromJson) String? doctorId,
    @JsonKey(name: 'name_ar') String? nameAr,
    @JsonKey(name: 'name_en') String? nameEn,
    String? name,
    @JsonKey(name: 'specialization_id', fromJson: _stringFromJson)
    String? specializationId,
    @JsonKey(name: 'specialization_name') String? specializationName,
    @JsonKey(name: 'specialization_icon') String? specializationIcon,
    @JsonKey(name: 'specialization_color') String? specializationColor,
    String? gender,
    String? phone,
    String? email,
    @JsonKey(name: 'license_number') String? licenseNumber,
    @JsonKey(name: 'experience_years') @Default(0) int experienceYears,
    @JsonKey(name: 'consultation_fee') @Default(0) num consultationFee,
    String? bio,
    @JsonKey(name: 'image_url') String? imageUrl,
    @JsonKey(name: 'qualification_files')
    @Default(<String>[])
    List<String> qualificationFiles,
    @JsonKey(name: 'is_active') @Default(false) bool isActive,
    @Default(0) num rating,
    @JsonKey(name: 'patients_count') @Default(0) int patientsCount,
    @Default(<ClinicDoctorScheduleModel>[])
    List<ClinicDoctorScheduleModel> schedules,
  }) = _ClinicDoctorModel;

  factory ClinicDoctorModel.fromJson(Map<String, dynamic> json) =>
      _$ClinicDoctorModelFromJson(json);
}

@freezed
abstract class ClinicDoctorScheduleModel with _$ClinicDoctorScheduleModel {
  const factory ClinicDoctorScheduleModel({
    String? day,
    String? from,
    String? to,
    @JsonKey(name: 'is_active') @Default(false) bool isActive,
  }) = _ClinicDoctorScheduleModel;

  factory ClinicDoctorScheduleModel.fromJson(Map<String, dynamic> json) =>
      _$ClinicDoctorScheduleModelFromJson(json);
}

String? _stringFromJson(Object? value) => value?.toString();
