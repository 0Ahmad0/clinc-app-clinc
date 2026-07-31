// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'clinic_doctor_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ClinicDoctorModel _$ClinicDoctorModelFromJson(Map<String, dynamic> json) =>
    _ClinicDoctorModel(
      doctorId: _stringFromJson(json['doctor_id']),
      nameAr: json['name_ar'] as String?,
      nameEn: json['name_en'] as String?,
      name: json['name'] as String?,
      specializationId: _stringFromJson(json['specialization_id']),
      specializationName: json['specialization_name'] as String?,
      specializationIcon: json['specialization_icon'] as String?,
      specializationColor: json['specialization_color'] as String?,
      gender: json['gender'] as String?,
      phone: json['phone'] as String?,
      email: json['email'] as String?,
      licenseNumber: json['license_number'] as String?,
      experienceYears: (json['experience_years'] as num?)?.toInt() ?? 0,
      consultationFee: json['consultation_fee'] as num? ?? 0,
      bio: json['bio'] as String?,
      imageUrl: json['image_url'] as String?,
      qualificationFiles:
          (json['qualification_files'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const <String>[],
      isActive: json['is_active'] as bool? ?? false,
      rating: json['rating'] as num? ?? 0,
      patientsCount: (json['patients_count'] as num?)?.toInt() ?? 0,
      schedules:
          (json['schedules'] as List<dynamic>?)
              ?.map(
                (e) => ClinicDoctorScheduleModel.fromJson(
                  e as Map<String, dynamic>,
                ),
              )
              .toList() ??
          const <ClinicDoctorScheduleModel>[],
    );

Map<String, dynamic> _$ClinicDoctorModelToJson(_ClinicDoctorModel instance) =>
    <String, dynamic>{
      'doctor_id': instance.doctorId,
      'name_ar': instance.nameAr,
      'name_en': instance.nameEn,
      'name': instance.name,
      'specialization_id': instance.specializationId,
      'specialization_name': instance.specializationName,
      'specialization_icon': instance.specializationIcon,
      'specialization_color': instance.specializationColor,
      'gender': instance.gender,
      'phone': instance.phone,
      'email': instance.email,
      'license_number': instance.licenseNumber,
      'experience_years': instance.experienceYears,
      'consultation_fee': instance.consultationFee,
      'bio': instance.bio,
      'image_url': instance.imageUrl,
      'qualification_files': instance.qualificationFiles,
      'is_active': instance.isActive,
      'rating': instance.rating,
      'patients_count': instance.patientsCount,
      'schedules': instance.schedules,
    };

_ClinicDoctorScheduleModel _$ClinicDoctorScheduleModelFromJson(
  Map<String, dynamic> json,
) => _ClinicDoctorScheduleModel(
  day: json['day'] as String?,
  from: json['from'] as String?,
  to: json['to'] as String?,
  isActive: json['is_active'] as bool? ?? false,
);

Map<String, dynamic> _$ClinicDoctorScheduleModelToJson(
  _ClinicDoctorScheduleModel instance,
) => <String, dynamic>{
  'day': instance.day,
  'from': instance.from,
  'to': instance.to,
  'is_active': instance.isActive,
};
