import '../extension/appointment_type_extensions.dart';

class AppointmentModel {
  final String id;

  final String patientName;
  final String? patientPhone;

  final String title; // service/visit name
  final AppointmentType type;

  final DateTime dateTime;

  final AppointmentStatus status;

  // reject
  final String? rejectReasonKey; // e.g. "doctor_unavailable"
  final String? rejectNote;

  // lab result pdf
  final String? resultPdfPathOrUrl;

  const AppointmentModel({
    required this.id,
    required this.patientName,
    this.patientPhone,
    required this.title,
    required this.type,
    required this.dateTime,
    required this.status,
    this.rejectReasonKey,
    this.rejectNote,
    this.resultPdfPathOrUrl,
  });

  bool get hasResult => (resultPdfPathOrUrl ?? '').isNotEmpty;

  AppointmentModel copyWith({
    String? id,
    String? patientName,
    String? patientPhone,
    String? title,
    AppointmentType? type,
    DateTime? dateTime,
    AppointmentStatus? status,
    String? rejectReasonKey,
    String? rejectNote,
    String? resultPdfPathOrUrl,
  }) {
    return AppointmentModel(
      id: id ?? this.id,
      patientName: patientName ?? this.patientName,
      patientPhone: patientPhone ?? this.patientPhone,
      title: title ?? this.title,
      type: type ?? this.type,
      dateTime: dateTime ?? this.dateTime,
      status: status ?? this.status,
      rejectReasonKey: rejectReasonKey ?? this.rejectReasonKey,
      rejectNote: rejectNote ?? this.rejectNote,
      resultPdfPathOrUrl: resultPdfPathOrUrl ?? this.resultPdfPathOrUrl,
    );
  }
}
