import 'package:flutter/widgets.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../../../config/theme/app_colors.dart';
import '../../../l10n/app_localizations.dart';
import '../../../shared/extensions/context_extensions.dart';
import '../../../shared/widgets/specialization_visual.dart';
import '../data/models/clinic_service_model.dart';
import '../domain/clinic_specialty.dart';
import '../domain/lab_section.dart';
import '../domain/service_kind.dart';

/// Localized label for a tab.
extension ServiceKindL10n on ServiceKind {
  String tabLabel(AppLocalizations l10n) => switch (this) {
    ServiceKind.lab => l10n.servicesLabTab,
    ServiceKind.specialty => l10n.servicesSpecialtyTab,
  };

  IconData get icon => switch (this) {
    ServiceKind.lab => Iconsax.chart_21,
    ServiceKind.specialty => Iconsax.hospital,
  };
}

/// Label, glyph and accent for each lab section — kept beside its data so grid
/// cards, headers and the add sheet all agree.
extension LabSectionL10n on LabSection {
  String label(AppLocalizations l10n) => switch (this) {
    LabSection.marriage => l10n.labSectionMarriage,
    LabSection.hormones => l10n.labSectionHormones,
    LabSection.vitamins => l10n.labSectionVitamins,
  };

  IconData get icon => switch (this) {
    LabSection.marriage => Iconsax.heart,
    LabSection.hormones => Iconsax.flash_1,
    LabSection.vitamins => Iconsax.sun_1,
  };

  Color accent(AppColorsTheme colors) => switch (this) {
    LabSection.marriage => colors.pink,
    LabSection.hormones => colors.purple,
    LabSection.vitamins => colors.warningFg,
  };
}

/// Label, glyph and accent for each clinic specialty. Labels reuse the shared
/// specialty strings the doctors feature also uses.
extension ClinicSpecialtyL10n on ClinicSpecialty {
  String label(AppLocalizations l10n) => switch (this) {
    ClinicSpecialty.pediatrics => l10n.specialtyPediatrics,
    ClinicSpecialty.cardiology => l10n.specialtyCardiology,
    ClinicSpecialty.ophthalmology => l10n.specialtyOphthalmology,
    ClinicSpecialty.orthopedics => l10n.specialtyOrthopedics,
    ClinicSpecialty.internal => l10n.specialtyInternal,
  };

  IconData get icon => switch (this) {
    ClinicSpecialty.pediatrics => Iconsax.emoji_happy,
    ClinicSpecialty.cardiology => Iconsax.heart,
    ClinicSpecialty.ophthalmology => Iconsax.eye,
    ClinicSpecialty.orthopedics => Iconsax.award,
    ClinicSpecialty.internal => Iconsax.hospital,
  };

  Color accent(AppColorsTheme colors) => switch (this) {
    ClinicSpecialty.pediatrics => colors.successFg,
    ClinicSpecialty.cardiology => colors.danger,
    ClinicSpecialty.ophthalmology => colors.primary600,
    ClinicSpecialty.orthopedics => colors.warningFg,
    ClinicSpecialty.internal => colors.teal,
  };
}

extension ClinicLabSectionModelL10n on ClinicLabSectionModel {
  String label(BuildContext context) {
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';
    return (isArabic ? nameAr : nameEn) ?? name ?? nameAr ?? nameEn ?? '-';
  }

  IconData get iconData {
    if ((icon ?? '').trim().isNotEmpty) {
      return SpecializationVisual.iconData(icon);
    }
    return switch (slug) {
      'marriage' || 'pre-marriage' => Iconsax.heart,
      'hormones' => Iconsax.flash_1,
      'vitamins' => Iconsax.sun_1,
      _ => Iconsax.chart_21,
    };
  }

  Color accent(AppColorsTheme colors) {
    final fallback = switch (slug) {
      'marriage' || 'pre-marriage' => colors.pink,
      'hormones' => colors.purple,
      'vitamins' => colors.warningFg,
      _ => colors.primary600,
    };
    return SpecializationVisual.color(color, fallback);
  }
}

extension ClinicAvailableLabTestModelL10n on ClinicAvailableLabTestModel {
  String label(BuildContext context) {
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';
    return (isArabic ? nameAr : nameEn) ?? name ?? nameAr ?? nameEn ?? '-';
  }

  String subtitle(BuildContext context) {
    if ((description ?? '').trim().isNotEmpty) return description!.trim();
    return sectionName ?? context.l10n.servicesLabTab;
  }

  IconData get iconData => SpecializationVisual.iconData(icon);

  Color accent(AppColorsTheme colors, {Color? fallback}) =>
      SpecializationVisual.color(color, fallback ?? colors.primary600);
}

extension ClinicEnabledLabTestModelL10n on ClinicEnabledLabTestModel {
  IconData get iconData => SpecializationVisual.iconData(icon);

  Color accent(AppColorsTheme colors, {Color? fallback}) =>
      SpecializationVisual.color(color, fallback ?? colors.primary600);
}

extension ClinicAvailableSpecializationModelL10n
    on ClinicAvailableSpecializationModel {
  String label(BuildContext context) {
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';
    return (isArabic ? nameAr : nameEn) ?? name ?? nameAr ?? nameEn ?? '-';
  }

  IconData get iconData => SpecializationVisual.iconData(icon);

  Color accent(AppColorsTheme colors) =>
      SpecializationVisual.color(color, colors.primary600);
}

extension ClinicEnabledSpecializationModelL10n
    on ClinicEnabledSpecializationModel {
  String label(BuildContext context) {
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';
    return (isArabic ? nameAr : nameEn) ?? name ?? nameAr ?? nameEn ?? '-';
  }

  IconData get iconData => SpecializationVisual.iconData(icon);

  Color accent(AppColorsTheme colors) =>
      SpecializationVisual.color(color, colors.primary600);
}
