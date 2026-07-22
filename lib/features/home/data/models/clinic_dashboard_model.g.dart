// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'clinic_dashboard_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ClinicDashboardModel _$ClinicDashboardModelFromJson(
  Map<String, dynamic> json,
) => _ClinicDashboardModel(
  clinic: json['clinic'] == null
      ? null
      : ClinicDashboardClinicModel.fromJson(
          json['clinic'] as Map<String, dynamic>,
        ),
  stats: json['stats'] == null
      ? null
      : ClinicDashboardStatsModel.fromJson(
          json['stats'] as Map<String, dynamic>,
        ),
  appointments:
      (json['appointments'] as List<dynamic>?)
          ?.map(
            (e) => ClinicDashboardAppointmentModel.fromJson(
              e as Map<String, dynamic>,
            ),
          )
          .toList() ??
      const <ClinicDashboardAppointmentModel>[],
  notifications: json['notifications'] == null
      ? null
      : ClinicDashboardNotificationsModel.fromJson(
          json['notifications'] as Map<String, dynamic>,
        ),
);

Map<String, dynamic> _$ClinicDashboardModelToJson(
  _ClinicDashboardModel instance,
) => <String, dynamic>{
  'clinic': instance.clinic,
  'stats': instance.stats,
  'appointments': instance.appointments,
  'notifications': instance.notifications,
};

_ClinicDashboardClinicModel _$ClinicDashboardClinicModelFromJson(
  Map<String, dynamic> json,
) => _ClinicDashboardClinicModel(
  clinicId: json['clinic_id'] as String?,
  name: json['name'] as String?,
  logo: json['logo'] as String?,
  cover: json['cover'] as String?,
  status: json['status'] as String?,
  isActive: json['is_active'] as bool?,
  isOpen: json['is_open'] as bool?,
  workingHoursText: json['working_hours_text'] as String?,
);

Map<String, dynamic> _$ClinicDashboardClinicModelToJson(
  _ClinicDashboardClinicModel instance,
) => <String, dynamic>{
  'clinic_id': instance.clinicId,
  'name': instance.name,
  'logo': instance.logo,
  'cover': instance.cover,
  'status': instance.status,
  'is_active': instance.isActive,
  'is_open': instance.isOpen,
  'working_hours_text': instance.workingHoursText,
};

_ClinicDashboardStatsModel _$ClinicDashboardStatsModelFromJson(
  Map<String, dynamic> json,
) => _ClinicDashboardStatsModel(
  patientsCount: (json['patients_count'] as num?)?.toInt() ?? 0,
  doctorsCount: (json['doctors_count'] as num?)?.toInt() ?? 0,
  dailyIncome: json['daily_income'] as num? ?? 0,
  todayAppointmentsCount:
      (json['today_appointments_count'] as num?)?.toInt() ?? 0,
  pendingAppointmentsCount:
      (json['pending_appointments_count'] as num?)?.toInt() ?? 0,
  completedAppointmentsCount:
      (json['completed_appointments_count'] as num?)?.toInt() ?? 0,
  rejectedAppointmentsCount:
      (json['rejected_appointments_count'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$ClinicDashboardStatsModelToJson(
  _ClinicDashboardStatsModel instance,
) => <String, dynamic>{
  'patients_count': instance.patientsCount,
  'doctors_count': instance.doctorsCount,
  'daily_income': instance.dailyIncome,
  'today_appointments_count': instance.todayAppointmentsCount,
  'pending_appointments_count': instance.pendingAppointmentsCount,
  'completed_appointments_count': instance.completedAppointmentsCount,
  'rejected_appointments_count': instance.rejectedAppointmentsCount,
};

_ClinicDashboardAppointmentModel _$ClinicDashboardAppointmentModelFromJson(
  Map<String, dynamic> json,
) => _ClinicDashboardAppointmentModel(
  appointmentId: json['appointment_id'] as String?,
  patientName: json['patient_name'] as String?,
  serviceName: json['service_name'] as String?,
  type: json['type'] as String?,
  time: json['time'] as String?,
  date: json['date'] as String?,
  status: json['status'] as String?,
  doctorName: json['doctor_name'] as String?,
  specializationName: json['specialization_name'] as String?,
  icon: json['icon'] as String?,
);

Map<String, dynamic> _$ClinicDashboardAppointmentModelToJson(
  _ClinicDashboardAppointmentModel instance,
) => <String, dynamic>{
  'appointment_id': instance.appointmentId,
  'patient_name': instance.patientName,
  'service_name': instance.serviceName,
  'type': instance.type,
  'time': instance.time,
  'date': instance.date,
  'status': instance.status,
  'doctor_name': instance.doctorName,
  'specialization_name': instance.specializationName,
  'icon': instance.icon,
};

_ClinicDashboardNotificationsModel _$ClinicDashboardNotificationsModelFromJson(
  Map<String, dynamic> json,
) => _ClinicDashboardNotificationsModel(
  unreadCount: (json['unread_count'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$ClinicDashboardNotificationsModelToJson(
  _ClinicDashboardNotificationsModel instance,
) => <String, dynamic>{'unread_count': instance.unreadCount};
