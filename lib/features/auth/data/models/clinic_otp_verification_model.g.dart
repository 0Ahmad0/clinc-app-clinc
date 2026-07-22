// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'clinic_otp_verification_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ClinicOtpVerificationModel _$ClinicOtpVerificationModelFromJson(
  Map<String, dynamic> json,
) => _ClinicOtpVerificationModel(
  resetToken: json['reset_token'] as String?,
  expiresIn: (json['expires_in'] as num?)?.toInt(),
);

Map<String, dynamic> _$ClinicOtpVerificationModelToJson(
  _ClinicOtpVerificationModel instance,
) => <String, dynamic>{
  'reset_token': instance.resetToken,
  'expires_in': instance.expiresIn,
};
