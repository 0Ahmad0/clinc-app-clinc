import '../../../l10n/app_localizations.dart';
import '../domain/clinic_specialty.dart';
import '../domain/lab_section.dart';
import '../domain/lab_test.dart';

/// The full lab-test catalog, localized. Codes stay constant across locales and
/// key the facility's per-test state; only names/subs come from [l10n].
Map<LabSection, List<LabTest>> localizedLabTests(AppLocalizations l10n) => {
  LabSection.marriage: [
    LabTest(code: 'SCD', name: l10n.testScd, sub: l10n.serviceSubHereditary),
    LabTest(code: 'THAL', name: l10n.testThal, sub: l10n.serviceSubGenetic),
    LabTest(code: 'HBV', name: l10n.testHbv, sub: l10n.serviceSubInfectious),
    LabTest(code: 'HCV', name: l10n.testHcv, sub: l10n.serviceSubInfectious),
    LabTest(code: 'HIV', name: l10n.testHiv, sub: l10n.serviceSubInfectious),
  ],
  LabSection.hormones: [
    LabTest(code: 'TSH', name: l10n.testTsh, sub: l10n.serviceSubThyroid),
    LabTest(
      code: 'TES',
      name: l10n.testTestosterone,
      sub: l10n.serviceSubSexHormone,
    ),
  ],
  LabSection.vitamins: [
    LabTest(code: 'D3', name: l10n.testVitaminD, sub: l10n.serviceSubVitaminD),
    LabTest(
      code: 'B12',
      name: l10n.testVitaminB12,
      sub: l10n.serviceSubVitaminB12,
    ),
  ],
};

/// Every specialty a clinic can offer — the add-specialty pool.
const List<ClinicSpecialty> kClinicSpecialties = ClinicSpecialty.values;
