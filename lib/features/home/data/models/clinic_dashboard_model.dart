import 'package:freezed_annotation/freezed_annotation.dart';

part 'clinic_dashboard_model.freezed.dart';
part 'clinic_dashboard_model.g.dart';

@freezed
abstract class ClinicDashboardModel with _$ClinicDashboardModel {
  const factory ClinicDashboardModel({
    ClinicDashboardClinicModel? clinic,
    ClinicDashboardStatsModel? stats,
    @Default(<ClinicDashboardAppointmentModel>[])
    List<ClinicDashboardAppointmentModel> appointments,
    ClinicDashboardNotificationsModel? notifications,
  }) = _ClinicDashboardModel;

  factory ClinicDashboardModel.fromJson(Map<String, dynamic> json) =>
      _$ClinicDashboardModelFromJson(json);
}

@freezed
abstract class ClinicDashboardClinicModel with _$ClinicDashboardClinicModel {
  const factory ClinicDashboardClinicModel({
    @JsonKey(name: 'clinic_id') String? clinicId,
    String? name,
    String? logo,
    String? cover,
    String? status,
    @JsonKey(name: 'is_active') bool? isActive,
    @JsonKey(name: 'is_open') bool? isOpen,
    @JsonKey(name: 'working_hours_text') String? workingHoursText,
  }) = _ClinicDashboardClinicModel;

  factory ClinicDashboardClinicModel.fromJson(Map<String, dynamic> json) =>
      _$ClinicDashboardClinicModelFromJson(json);
}

@freezed
abstract class ClinicDashboardStatsModel with _$ClinicDashboardStatsModel {
  const factory ClinicDashboardStatsModel({
    @JsonKey(name: 'patients_count') @Default(0) int patientsCount,
    @JsonKey(name: 'doctors_count') @Default(0) int doctorsCount,
    @JsonKey(name: 'daily_income') @Default(0) num dailyIncome,
    @JsonKey(name: 'today_appointments_count')
    @Default(0)
    int todayAppointmentsCount,
    @JsonKey(name: 'pending_appointments_count')
    @Default(0)
    int pendingAppointmentsCount,
    @JsonKey(name: 'completed_appointments_count')
    @Default(0)
    int completedAppointmentsCount,
    @JsonKey(name: 'rejected_appointments_count')
    @Default(0)
    int rejectedAppointmentsCount,
  }) = _ClinicDashboardStatsModel;

  factory ClinicDashboardStatsModel.fromJson(Map<String, dynamic> json) =>
      _$ClinicDashboardStatsModelFromJson(json);
}

@freezed
abstract class ClinicDashboardAppointmentModel
    with _$ClinicDashboardAppointmentModel {
  const factory ClinicDashboardAppointmentModel({
    @JsonKey(name: 'appointment_id') String? appointmentId,
    @JsonKey(name: 'patient_name') String? patientName,
    @JsonKey(name: 'service_name') String? serviceName,
    String? type,
    String? time,
    String? date,
    String? status,
    @JsonKey(name: 'doctor_name') String? doctorName,
    @JsonKey(name: 'specialization_name') String? specializationName,
    String? icon,
  }) = _ClinicDashboardAppointmentModel;

  factory ClinicDashboardAppointmentModel.fromJson(Map<String, dynamic> json) =>
      _$ClinicDashboardAppointmentModelFromJson(json);
}

@freezed
abstract class ClinicDashboardNotificationsModel
    with _$ClinicDashboardNotificationsModel {
  const factory ClinicDashboardNotificationsModel({
    @JsonKey(name: 'unread_count') @Default(0) int unreadCount,
  }) = _ClinicDashboardNotificationsModel;

  factory ClinicDashboardNotificationsModel.fromJson(
    Map<String, dynamic> json,
  ) => _$ClinicDashboardNotificationsModelFromJson(json);
}
