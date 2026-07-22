// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'clinic_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ClinicModel _$ClinicModelFromJson(Map<String, dynamic> json) => _ClinicModel(
  clinicId: json['clinic_id'] as String?,
  name: json['name'] as String?,
  location: json['location'] as String?,
  doctorsCount: (json['doctors_count'] as num?)?.toInt(),
  appointmentsCount: (json['appointments_count'] as num?)?.toInt(),
  revenue: json['revenue'] as num?,
  rating: json['rating'] as num?,
  status: json['status'] as String?,
  email: json['email'] as String?,
  phone: json['phone'] as String?,
  type: json['type'] as String?,
  logo: json['logo'] as String?,
  cover: json['cover'] as String?,
  description: json['description'] as String?,
  lat: json['lat'],
  lng: json['lng'],
  isActive: json['is_active'] as bool?,
  createdAt: json['created_at'] as String?,
);

Map<String, dynamic> _$ClinicModelToJson(_ClinicModel instance) =>
    <String, dynamic>{
      'clinic_id': instance.clinicId,
      'name': instance.name,
      'location': instance.location,
      'doctors_count': instance.doctorsCount,
      'appointments_count': instance.appointmentsCount,
      'revenue': instance.revenue,
      'rating': instance.rating,
      'status': instance.status,
      'email': instance.email,
      'phone': instance.phone,
      'type': instance.type,
      'logo': instance.logo,
      'cover': instance.cover,
      'description': instance.description,
      'lat': instance.lat,
      'lng': instance.lng,
      'is_active': instance.isActive,
      'created_at': instance.createdAt,
    };
