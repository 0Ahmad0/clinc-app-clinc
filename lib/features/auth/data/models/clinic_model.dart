import 'package:freezed_annotation/freezed_annotation.dart';

part 'clinic_model.freezed.dart';
part 'clinic_model.g.dart';

@freezed
abstract class ClinicModel with _$ClinicModel {
  const factory ClinicModel({
    @JsonKey(name: 'clinic_id') String? clinicId,
    String? name,
    String? location,
    @JsonKey(name: 'doctors_count') int? doctorsCount,
    @JsonKey(name: 'appointments_count') int? appointmentsCount,
    num? revenue,
    num? rating,
    String? status,
    String? email,
    String? phone,
    String? type,
    String? logo,
    String? cover,
    String? description,
    Object? lat,
    Object? lng,
    @JsonKey(name: 'is_active') bool? isActive,
    @JsonKey(name: 'created_at') String? createdAt,
  }) = _ClinicModel;

  factory ClinicModel.fromJson(Map<String, dynamic> json) =>
      _$ClinicModelFromJson(json);
}
