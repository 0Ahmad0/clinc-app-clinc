import '../extension/appointment_type_extensions.dart';

class AppointmentModel {
  final String id;

  final String patientName;
  final String? patientPhone;
  final String? patientImage;

  final String title; // service/visit name
  final String? specialization;
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
    this.patientImage,
    required this.title,
    this.specialization,
    required this.type,
    required this.dateTime,
    required this.status,
    this.rejectReasonKey,
    this.rejectNote,
    this.resultPdfPathOrUrl,
  });

  factory AppointmentModel.fromJson(Map<String, dynamic> json) {
    return AppointmentModel(
      id: json['appointment_id'].toString(),
      patientName: json['patient_name'] as String,
      patientPhone: json['patient_phone'] as String?,
      patientImage: json['patient_image'] as String?,
      title: json['title'] as String,
      specialization: json['specialization'] as String?,
      type: AppointmentType.values.firstWhere(
        (value) => _typeValue(value) == json['type'],
        orElse: () => AppointmentType.consultation,
      ),
      dateTime: DateTime.parse(json['date_time'] as String),
      status: AppointmentStatus.values.firstWhere(
        (value) => value.name == json['status'],
        orElse: () => AppointmentStatus.pending,
      ),
      rejectReasonKey: json['reject_reason'] as String?,
      rejectNote: json['reject_note'] as String?,
      resultPdfPathOrUrl: json['result_file'] as String?,
    );
  }

  static String _typeValue(AppointmentType type) {
    return type == AppointmentType.labTest ? 'lab_test' : type.name;
  }

  bool get hasResult => (resultPdfPathOrUrl ?? '').isNotEmpty;

  AppointmentModel copyWith({
    String? id,
    String? patientName,
    String? patientPhone,
    String? patientImage,
    String? title,
    String? specialization,
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
      patientImage: patientImage ?? this.patientImage,
      title: title ?? this.title,
      specialization: specialization ?? this.specialization,
      type: type ?? this.type,
      dateTime: dateTime ?? this.dateTime,
      status: status ?? this.status,
      rejectReasonKey: rejectReasonKey ?? this.rejectReasonKey,
      rejectNote: rejectNote ?? this.rejectNote,
      resultPdfPathOrUrl: resultPdfPathOrUrl ?? this.resultPdfPathOrUrl,
    );
  }
}
