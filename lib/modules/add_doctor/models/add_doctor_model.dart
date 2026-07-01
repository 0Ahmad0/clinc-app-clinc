import '../../../app/data/doctor_model.dart';

class AddDoctorRequest {
  const AddDoctorRequest({
    required this.nameAr,
    required this.nameEn,
    required this.specializationId,
    required this.consultationFee,
    required this.licenseNumber,
    required this.experienceYears,
    required this.biography,
    required this.phone,
    required this.email,
    required this.isAvailable,
    required this.schedule,
    this.imagePath,
    this.qualificationFiles = const [],
  });

  final String nameAr;
  final String nameEn;
  final int specializationId;
  final num consultationFee;
  final String licenseNumber;
  final int experienceYears;
  final String biography;
  final String phone;
  final String email;
  final bool isAvailable;
  final List<DoctorScheduleRequest> schedule;
  final String? imagePath;
  final List<String> qualificationFiles;

  Map<String, dynamic> toJson() => {
    'name_ar': nameAr,
    'name_en': nameEn,
    'specialization_id': specializationId,
    'consultation_fee': consultationFee,
    'license_number': licenseNumber,
    'experience_years': experienceYears,
    'biography': biography,
    'phone': phone,
    'email': email,
    'is_available': isAvailable,
    'schedule': schedule.map((item) => item.toJson()).toList(),
  };
}

class DoctorScheduleRequest {
  const DoctorScheduleRequest({
    required this.day,
    required this.isActive,
    this.from,
    this.to,
  });

  final String day;
  final bool isActive;
  final String? from;
  final String? to;

  factory DoctorScheduleRequest.fromWorkingHours(WorkingHours value) {
    return DoctorScheduleRequest(
      day: value.day.toLowerCase(),
      isActive: !value.isDayOff,
      from: value.isDayOff ? null : value.startTime,
      to: value.isDayOff ? null : value.endTime,
    );
  }

  Map<String, dynamic> toJson() => {
    'day': day,
    'is_active': isActive,
    'from': from,
    'to': to,
  };
}

class AddedDoctorModel {
  const AddedDoctorModel({
    required this.doctorId,
    required this.nameAr,
    required this.nameEn,
  });

  final String doctorId;
  final String nameAr;
  final String nameEn;

  factory AddedDoctorModel.fromJson(Map<String, dynamic> json) {
    return AddedDoctorModel(
      doctorId: json['doctor_id'].toString(),
      nameAr: json['name_ar'] as String,
      nameEn: json['name_en'] as String? ?? json['name_ar'] as String,
    );
  }
}
