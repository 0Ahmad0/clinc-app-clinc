class DoctorSpecialization {
  const DoctorSpecialization({
    required this.id,
    required this.nameAr,
    required this.nameEn,
    this.icon,
  });

  final int id;
  final String nameAr;
  final String nameEn;
  final String? icon;

  factory DoctorSpecialization.fromJson(Map<String, dynamic> json) {
    return DoctorSpecialization(
      id: json['id'] as int,
      nameAr: json['name_ar'] as String,
      nameEn: json['name_en'] as String? ?? json['name_ar'] as String,
      icon: json['icon'] as String?,
    );
  }
}

class ClinicDoctor {
  const ClinicDoctor({
    required this.doctorId,
    required this.nameAr,
    required this.nameEn,
    required this.specialization,
    this.image,
    required this.isAvailable,
    required this.experienceYears,
    required this.consultationFee,
    required this.currency,
  });

  final String doctorId;
  final String nameAr;
  final String nameEn;
  final DoctorSpecialization specialization;
  final String? image;
  final bool isAvailable;
  final int experienceYears;
  final num consultationFee;
  final String currency;

  factory ClinicDoctor.fromJson(Map<String, dynamic> json) {
    return ClinicDoctor(
      doctorId: json['doctor_id'].toString(),
      nameAr: json['name_ar'] as String,
      nameEn: json['name_en'] as String? ?? json['name_ar'] as String,
      specialization: DoctorSpecialization.fromJson(
        Map<String, dynamic>.from(json['specialization'] as Map),
      ),
      image: json['image'] as String?,
      isAvailable: json['is_available'] as bool? ?? false,
      experienceYears: json['experience_years'] as int? ?? 0,
      consultationFee: json['consultation_fee'] as num? ?? 0,
      currency: json['currency'] as String? ?? 'SAR',
    );
  }
}

class DoctorsListData {
  const DoctorsListData({required this.doctors, required this.specializations});

  final List<ClinicDoctor> doctors;
  final List<DoctorSpecialization> specializations;

  factory DoctorsListData.fromJson(Map<String, dynamic> json) {
    return DoctorsListData(
      doctors: (json['doctors'] as List? ?? const [])
          .map(
            (item) =>
                ClinicDoctor.fromJson(Map<String, dynamic>.from(item as Map)),
          )
          .toList(),
      specializations: (json['specializations'] as List? ?? const [])
          .map(
            (item) => DoctorSpecialization.fromJson(
              Map<String, dynamic>.from(item as Map),
            ),
          )
          .toList(),
    );
  }
}

class DoctorsListResponse {
  const DoctorsListResponse({
    required this.status,
    required this.message,
    this.data,
    this.error,
    this.meta = const {},
  });

  final String status;
  final String message;
  final DoctorsListData? data;
  final Map<String, dynamic>? error;
  final Map<String, dynamic> meta;

  bool get isSuccess => status == 'success';

  factory DoctorsListResponse.fromJson(Map<String, dynamic> json) {
    return DoctorsListResponse(
      status: json['status'] as String,
      message: json['message'] as String,
      data: json['data'] is Map
          ? DoctorsListData.fromJson(
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
