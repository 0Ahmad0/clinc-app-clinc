import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/appointment_kind.dart';
import '../../domain/appointment_status.dart';

part 'clinic_appointment_model.freezed.dart';
part 'clinic_appointment_model.g.dart';

@freezed
abstract class ClinicAppointmentModel with _$ClinicAppointmentModel {
  const factory ClinicAppointmentModel({
    @JsonKey(name: 'appointment_id') String? appointmentId,
    String? type,
    String? status,
    @JsonKey(name: 'patient_name') String? patientName,
    @JsonKey(name: 'patient_phone') String? patientPhone,
    @JsonKey(name: 'patient_image') String? patientImage,
    @JsonKey(name: 'doctor_id') String? doctorId,
    @JsonKey(name: 'doctor_name') String? doctorName,
    @JsonKey(name: 'specialization_id') String? specializationId,
    @JsonKey(name: 'specialization_name') String? specializationName,
    @JsonKey(name: 'service_name') String? serviceName,
    String? date,
    String? time,
    @Default(0) num price,
    String? notes,
    String? problem,
    @JsonKey(name: 'result_file') String? resultFile,
    @JsonKey(name: 'rejection_reason') String? rejectionReason,
  }) = _ClinicAppointmentModel;

  factory ClinicAppointmentModel.fromJson(Map<String, dynamic> json) =>
      _$ClinicAppointmentModelFromJson(json);
}

extension ClinicAppointmentModelX on ClinicAppointmentModel {
  AppointmentStatus get statusValue => switch (status) {
    'accepted' => AppointmentStatus.confirmed,
    'completed' => AppointmentStatus.done,
    'rejected' => AppointmentStatus.rejected,
    _ => AppointmentStatus.pending,
  };

  AppointmentKind get kindValue => switch (type) {
    'lab' => AppointmentKind.lab,
    _ => AppointmentKind.clinic,
  };
}
