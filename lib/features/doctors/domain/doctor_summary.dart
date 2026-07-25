import 'doctor_specialty.dart';

class DoctorSummary {
  const DoctorSummary({
    required this.id,
    required this.name,
    required this.initials,
    required this.specialty,
    required this.specialtyName,
    required this.experienceYears,
    required this.fee,
    this.imageUrl,
    this.rating = 4.8,
    this.patients = 340,
    this.doctorId,
  });

  final int id;
  final String name;
  final String initials;
  final DoctorSpecialty specialty;
  final String specialtyName;
  final int experienceYears;
  final int fee;

  /// Remote profile photo, cached when present; null falls back to [initials].
  final String? imageUrl;

  /// Profile stats (server-supplied; sensible defaults until then).
  final double rating;
  final int patients;

  final String? doctorId;
}
