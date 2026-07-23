// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'clinic_appointment_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ClinicAppointmentModel _$ClinicAppointmentModelFromJson(
  Map<String, dynamic> json,
) => _ClinicAppointmentModel(
  appointmentId: json['appointment_id'] as String?,
  type: json['type'] as String?,
  status: json['status'] as String?,
  patientName: json['patient_name'] as String?,
  patientPhone: json['patient_phone'] as String?,
  patientImage: json['patient_image'] as String?,
  doctorId: json['doctor_id'] as String?,
  doctorName: json['doctor_name'] as String?,
  specializationId: json['specialization_id'] as String?,
  specializationName: json['specialization_name'] as String?,
  serviceName: json['service_name'] as String?,
  date: json['date'] as String?,
  time: json['time'] as String?,
  price: json['price'] as num? ?? 0,
  notes: json['notes'] as String?,
  problem: json['problem'] as String?,
  resultFile: json['result_file'] as String?,
  rejectionReason: json['rejection_reason'] as String?,
);

Map<String, dynamic> _$ClinicAppointmentModelToJson(
  _ClinicAppointmentModel instance,
) => <String, dynamic>{
  'appointment_id': instance.appointmentId,
  'type': instance.type,
  'status': instance.status,
  'patient_name': instance.patientName,
  'patient_phone': instance.patientPhone,
  'patient_image': instance.patientImage,
  'doctor_id': instance.doctorId,
  'doctor_name': instance.doctorName,
  'specialization_id': instance.specializationId,
  'specialization_name': instance.specializationName,
  'service_name': instance.serviceName,
  'date': instance.date,
  'time': instance.time,
  'price': instance.price,
  'notes': instance.notes,
  'problem': instance.problem,
  'result_file': instance.resultFile,
  'rejection_reason': instance.rejectionReason,
};
