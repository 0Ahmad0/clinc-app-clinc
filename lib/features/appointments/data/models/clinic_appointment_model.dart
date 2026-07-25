import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:intl/intl.dart';

import '../../../../core/utils/app_url.dart';
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

  Uri? get resultFileUri {
    final raw = resultFile?.trim();
    if (raw == null || raw.isEmpty) return null;
    final uri = Uri.tryParse(raw);
    if (uri == null) return null;

    if (uri.host.toLowerCase() != 'localhost') return uri;

    final base = Uri.tryParse(baseServSlashLess);
    if (base == null) return uri;
    return uri.replace(
      scheme: base.scheme.isEmpty ? uri.scheme : base.scheme,
      host: base.host.isEmpty ? uri.host : base.host,
      port: base.hasPort ? base.port : uri.port,
    );
  }

  String get formattedDateTime {
    final rawDate = date?.trim();
    final rawTime = time?.trim();
    if ((rawDate == null || rawDate.isEmpty) &&
        (rawTime == null || rawTime.isEmpty)) {
      return '-';
    }

    final formattedTime = _formatTime(rawTime);
    if (rawDate == null || rawDate.isEmpty) return formattedTime ?? '-';
    if (formattedTime == null || formattedTime.isEmpty) return rawDate;
    return '$rawDate $formattedTime';
  }

  String? _formatTime(String? rawTime) {
    if (rawTime == null || rawTime.isEmpty) return null;
    for (final pattern in const ['HH:mm:ss', 'HH:mm', 'h:mm a', 'h:mm aaa']) {
      final parsed = DateFormat(pattern).tryParseStrict(rawTime);
      if (parsed != null) {
        final formatted = DateFormat('h:mm a').format(parsed);
        return formatted.replaceAll('AM', 'am').replaceAll('PM', 'pm');
      }
    }
    return rawTime.replaceAll('AM', 'am').replaceAll('PM', 'pm');
  }
}
