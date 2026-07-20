import 'package:flutter/widgets.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../../../l10n/app_localizations.dart';
import '../domain/doctor_specialty.dart';

/// Localized labels for [DoctorSpecialty] plus the curated lists each surface
/// shows — kept in one place so filter chips and the add-doctor picker agree.
extension DoctorSpecialtyL10n on DoctorSpecialty {
  String label(AppLocalizations l10n) => switch (this) {
    DoctorSpecialty.all => l10n.doctorsAll,
    DoctorSpecialty.cardiology => l10n.specialtyCardiology,
    DoctorSpecialty.dermatology => l10n.specialtyDermatology,
    DoctorSpecialty.pediatrics => l10n.specialtyPediatrics,
    DoctorSpecialty.ophthalmology => l10n.specialtyOphthalmology,
    DoctorSpecialty.orthopedics => l10n.specialtyOrthopedics,
    DoctorSpecialty.internal => l10n.specialtyInternal,
    DoctorSpecialty.dentistry => l10n.specialtyDentistry,
  };

  /// Glyph shown on the filter chips so each specialty is scannable at a glance.
  IconData get icon => switch (this) {
    DoctorSpecialty.all => Iconsax.category,
    DoctorSpecialty.cardiology => Iconsax.heart,
    DoctorSpecialty.dermatology => Iconsax.health,
    DoctorSpecialty.pediatrics => Iconsax.emoji_happy,
    DoctorSpecialty.ophthalmology => Iconsax.eye,
    DoctorSpecialty.orthopedics => Iconsax.award,
    DoctorSpecialty.internal => Iconsax.hospital,
    DoctorSpecialty.dentistry => Iconsax.emoji_normal,
  };
}

/// Specialties shown as filter chips on the doctors list (design curates these
/// six — it omits orthopedics and internal).
const List<DoctorSpecialty> kFilterSpecialties = [
  DoctorSpecialty.all,
  DoctorSpecialty.cardiology,
  DoctorSpecialty.dermatology,
  DoctorSpecialty.pediatrics,
  DoctorSpecialty.ophthalmology,
  DoctorSpecialty.dentistry,
];

/// Real specialties a doctor can be assigned (everything except the `all`
/// filter sentinel) — used by the add-doctor picker.
const List<DoctorSpecialty> kPickableSpecialties = [
  DoctorSpecialty.cardiology,
  DoctorSpecialty.dermatology,
  DoctorSpecialty.pediatrics,
  DoctorSpecialty.ophthalmology,
  DoctorSpecialty.orthopedics,
  DoctorSpecialty.internal,
  DoctorSpecialty.dentistry,
];
