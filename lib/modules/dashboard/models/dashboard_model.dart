class DashboardModel {
  const DashboardModel({
    required this.clinic,
    required this.stats,
    required this.todayAppointments,
  });

  final DashboardClinic clinic;
  final DashboardStats stats;
  final List<DashboardAppointment> todayAppointments;

  factory DashboardModel.fromJson(Map<String, dynamic> json) {
    return DashboardModel(
      clinic: DashboardClinic.fromJson(
        Map<String, dynamic>.from(json['clinic'] as Map),
      ),
      stats: DashboardStats.fromJson(
        Map<String, dynamic>.from(json['stats'] as Map),
      ),
      todayAppointments: (json['today_appointments'] as List? ?? const [])
          .map(
            (item) => DashboardAppointment.fromJson(
              Map<String, dynamic>.from(item as Map),
            ),
          )
          .toList(),
    );
  }
}

class DashboardClinic {
  const DashboardClinic({
    required this.clinicId,
    required this.name,
    this.logo,
    required this.isOpen,
    this.opensAt,
    this.closesAt,
  });

  final String clinicId;
  final String name;
  final String? logo;
  final bool isOpen;
  final String? opensAt;
  final String? closesAt;

  factory DashboardClinic.fromJson(Map<String, dynamic> json) {
    final hours = json['today_working_hours'];
    return DashboardClinic(
      clinicId: json['clinic_id'].toString(),
      name: json['name'] as String,
      logo: json['logo'] as String?,
      isOpen: json['is_open'] as bool? ?? false,
      opensAt: hours is Map ? hours['from'] as String? : null,
      closesAt: hours is Map ? hours['to'] as String? : null,
    );
  }
}

class DashboardStats {
  const DashboardStats({
    required this.doctorsCount,
    required this.patientsCount,
    required this.todayAppointmentsCount,
    required this.dailyIncome,
    required this.currency,
  });

  final int doctorsCount;
  final int patientsCount;
  final int todayAppointmentsCount;
  final num dailyIncome;
  final String currency;

  factory DashboardStats.fromJson(Map<String, dynamic> json) {
    return DashboardStats(
      doctorsCount: json['doctors_count'] as int? ?? 0,
      patientsCount: json['patients_count'] as int? ?? 0,
      todayAppointmentsCount: json['today_appointments_count'] as int? ?? 0,
      dailyIncome: json['daily_income'] as num? ?? 0,
      currency: json['currency'] as String? ?? 'SAR',
    );
  }
}

class DashboardAppointment {
  const DashboardAppointment({
    required this.appointmentId,
    required this.patientName,
    this.patientImage,
    required this.consultationType,
    required this.consultationIcon,
    required this.time,
    required this.status,
  });

  final String appointmentId;
  final String patientName;
  final String? patientImage;
  final String consultationType;
  final String consultationIcon;
  final String time;
  final String status;

  factory DashboardAppointment.fromJson(Map<String, dynamic> json) {
    final patient = Map<String, dynamic>.from(json['patient'] as Map);
    final consultation = Map<String, dynamic>.from(json['consultation'] as Map);
    return DashboardAppointment(
      appointmentId: json['appointment_id'].toString(),
      patientName: patient['name'] as String,
      patientImage: patient['image'] as String?,
      consultationType: consultation['name'] as String,
      consultationIcon: consultation['icon'] as String? ?? 'medical',
      time: json['time'] as String,
      status: json['status'] as String,
    );
  }
}

class DashboardResponse {
  const DashboardResponse({
    required this.status,
    required this.message,
    this.data,
    this.error,
    this.meta = const {},
  });

  final String status;
  final String message;
  final DashboardModel? data;
  final Map<String, dynamic>? error;
  final Map<String, dynamic> meta;

  bool get isSuccess => status == 'success';

  factory DashboardResponse.fromJson(Map<String, dynamic> json) {
    return DashboardResponse(
      status: json['status'] as String,
      message: json['message'] as String,
      data: json['data'] is Map
          ? DashboardModel.fromJson(
              Map<String, dynamic>.from(json['data'] as Map),
            )
          : null,
      error: json['error'] is Map
          ? Map<String, dynamic>.from(json['error'] as Map)
          : null,
      meta: json['meta'] is Map
          ? Map<String, dynamic>.from(json['meta'] as Map)
          : const {},
    );
  }
}
