import 'package:equatable/equatable.dart';

import '../../domain/clinic_specialty.dart';
import '../../domain/lab_section.dart';
import '../../domain/service_kind.dart';

/// Per-test facility settings, keyed by test code in [ServicesState.tests].
class LabTestState extends Equatable {
  const LabTestState({this.enabled = false, this.price = ''});

  final bool enabled;
  final String price;

  LabTestState copyWith({bool? enabled, String? price}) => LabTestState(
    enabled: enabled ?? this.enabled,
    price: price ?? this.price,
  );

  @override
  List<Object> get props => [enabled, price];
}

class ServicesState extends Equatable {
  const ServicesState({
    required this.kind,
    this.detail,
    this.sections = const [LabSection.marriage],
    this.specialties = const [],
    this.tests = const {},
  });

  /// Active tab.
  final ServiceKind kind;

  /// Non-null when the lab-section detail view is open.
  final LabSection? detail;

  /// Lab sections the facility has added.
  final List<LabSection> sections;

  /// Specialties the clinic has added.
  final List<ClinicSpecialty> specialties;

  /// Enabled/price state per test code.
  final Map<String, LabTestState> tests;

  bool get inDetail => detail != null;

  int get activeCount => tests.values.where((t) => t.enabled).length;

  LabTestState testState(String code) => tests[code] ?? const LabTestState();

  ServicesState copyWith({
    ServiceKind? kind,
    LabSection? detail,
    bool clearDetail = false,
    List<LabSection>? sections,
    List<ClinicSpecialty>? specialties,
    Map<String, LabTestState>? tests,
  }) => ServicesState(
    kind: kind ?? this.kind,
    detail: clearDetail ? null : (detail ?? this.detail),
    sections: sections ?? this.sections,
    specialties: specialties ?? this.specialties,
    tests: tests ?? this.tests,
  );

  @override
  List<Object?> get props => [kind, detail, sections, specialties, tests];
}
