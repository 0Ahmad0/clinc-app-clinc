import '../../../l10n/app_localizations.dart';
import '../domain/doctor_specialty.dart';
import '../domain/doctor_summary.dart';

List<DoctorSummary> localizedDoctors(AppLocalizations l10n) {
  final doctors = [
    (
      l10n.doctor1Name,
      DoctorSpecialty.cardiology,
      l10n.specialtyCardiology,
      12,
      150,
    ),
    (
      l10n.doctor2Name,
      DoctorSpecialty.dermatology,
      l10n.specialtyDermatology,
      7,
      200,
    ),
    (
      l10n.doctor3Name,
      DoctorSpecialty.pediatrics,
      l10n.specialtyPediatrics,
      9,
      120,
    ),
    (
      l10n.doctor4Name,
      DoctorSpecialty.ophthalmology,
      l10n.specialtyOphthalmology,
      15,
      180,
    ),
    (
      l10n.doctor5Name,
      DoctorSpecialty.dentistry,
      l10n.specialtyDentistry,
      5,
      100,
    ),
  ];
  return [
    for (var index = 0; index < doctors.length; index++)
      DoctorSummary(
        id: index,
        name: doctors[index].$1,
        initials: doctors[index].$1
            .replaceFirst(RegExp(r'^(د\.|Dr\.)\s*'), '')
            .split(' ')
            .where((part) => part.isNotEmpty)
            .take(2)
            .map((part) => part[0])
            .join(),
        specialty: doctors[index].$2,
        specialtyName: doctors[index].$3,
        experienceYears: doctors[index].$4,
        fee: doctors[index].$5,
      ),
  ];
}
