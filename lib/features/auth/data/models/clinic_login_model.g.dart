// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'clinic_login_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ClinicLoginModel _$ClinicLoginModelFromJson(Map<String, dynamic> json) =>
    _ClinicLoginModel(
      clinic: json['clinic'] == null
          ? null
          : ClinicModel.fromJson(json['clinic'] as Map<String, dynamic>),
      token: json['token'] as String?,
      tokenType: json['token_type'] as String?,
      expiresAt: json['expires_at'] as String?,
      needsCompletion: json['needs_completion'] as bool? ?? false,
      missingFields:
          (json['missing_fields'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const <String>[],
    );

Map<String, dynamic> _$ClinicLoginModelToJson(_ClinicLoginModel instance) =>
    <String, dynamic>{
      'clinic': instance.clinic,
      'token': instance.token,
      'token_type': instance.tokenType,
      'expires_at': instance.expiresAt,
      'needs_completion': instance.needsCompletion,
      'missing_fields': instance.missingFields,
    };
