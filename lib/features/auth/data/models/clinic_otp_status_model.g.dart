// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'clinic_otp_status_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ClinicOtpStatusModel _$ClinicOtpStatusModelFromJson(
  Map<String, dynamic> json,
) => _ClinicOtpStatusModel(
  identifier: json['identifier'] as String?,
  purpose: json['purpose'] as String?,
  expiresIn: (json['expires_in'] as num?)?.toInt(),
);

Map<String, dynamic> _$ClinicOtpStatusModelToJson(
  _ClinicOtpStatusModel instance,
) => <String, dynamic>{
  'identifier': instance.identifier,
  'purpose': instance.purpose,
  'expires_in': instance.expiresIn,
};
