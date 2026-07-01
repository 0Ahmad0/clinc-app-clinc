import '../../../app/data/doctor_model.dart';
import 'doctors_list_model.dart';

class DoctorDetailsModel {
  const DoctorDetailsModel({
    required this.doctorId,
    required this.nameAr,
    required this.nameEn,
    required this.specialization,
    required this.isAvailable,
    required this.experienceYears,
    required this.consultationFee,
    required this.currency,
    required this.phone,
    required this.licenseNumber,
    required this.email,
    required this.biography,
    required this.qualificationFiles,
    required this.schedule,
    this.image,
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
  final String phone;
  final String licenseNumber;
  final String email;
  final String biography;
  final List<String> qualificationFiles;
  final List<DoctorScheduleModel> schedule;

  factory DoctorDetailsModel.fromJson(Map<String, dynamic> json) {
    return DoctorDetailsModel(
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
      phone: json['phone'] as String? ?? '',
      licenseNumber: json['license_number'] as String? ?? '',
      email: json['email'] as String? ?? '',
      biography: json['biography'] as String? ?? '',
      qualificationFiles: (json['qualification_files'] as List? ?? const [])
          .map((item) => item.toString())
          .toList(),
      schedule: (json['schedule'] as List? ?? const [])
          .map(
            (item) => DoctorScheduleModel.fromJson(
              Map<String, dynamic>.from(item as Map),
            ),
          )
          .toList(),
    );
  }

  DoctorModel toDoctorModel({bool isArabic = false}) {
    return DoctorModel(
      id: doctorId,
      imagePath: image ?? '',
      nameAr: nameAr,
      nameEn: nameEn,
      specialty: isArabic ? specialization.nameAr : specialization.nameEn,
      fee: consultationFee.toDouble(),
      gender: '',
      licenseNumber: licenseNumber,
      yearsOfExperience: experienceYears,
      about: biography,
      phone: phone,
      email: email,
      qualificationFiles: qualificationFiles,
      isAvailable: isAvailable,
      workingHours: schedule.map((item) => item.toWorkingHours()).toList(),
    );
  }
}

class DoctorScheduleModel {
  const DoctorScheduleModel({
    required this.day,
    required this.isActive,
    this.from,
    this.to,
  });

  final String day;
  final bool isActive;
  final String? from;
  final String? to;

  factory DoctorScheduleModel.fromJson(Map<String, dynamic> json) {
    return DoctorScheduleModel(
      day: json['day'] as String,
      isActive: json['is_active'] as bool? ?? false,
      from: json['from'] as String?,
      to: json['to'] as String?,
    );
  }

  WorkingHours toWorkingHours() {
    final normalizedDay = day.isEmpty
        ? day
        : '${day[0].toUpperCase()}${day.substring(1)}';
    return WorkingHours(
      day: normalizedDay,
      startTime: from,
      endTime: to,
      isDayOff: !isActive,
    );
  }
}
