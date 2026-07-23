import '../../auth/domain/account_type.dart';

/// The kind of report being viewed.
enum ReportType { appointments, clinic, revenue, doctors }

/// Which report types a facility may view, derived from its [AccountType] — the
/// single place role scoping lives, so no `if (role == …)` leaks into the UI.
List<ReportType> reportTypesFor(AccountType type) => switch (type) {
  AccountType.clinic => const [
    ReportType.appointments,
    ReportType.clinic,
    ReportType.revenue,
    ReportType.doctors,
  ],
  AccountType.lab => const [ReportType.appointments, ReportType.revenue],
  AccountType.both => const [
    ReportType.appointments,
    ReportType.clinic,
    ReportType.revenue,
    ReportType.doctors,
  ],
};

extension ReportTypeBackend on ReportType {
  String get backendValue => switch (this) {
    ReportType.appointments => 'appointments',
    ReportType.clinic => 'clinic',
    ReportType.revenue => 'revenue',
    ReportType.doctors => 'doctors',
  };
}

ReportType reportTypeFromBackend(String? value) => switch (value) {
  'clinic' => ReportType.clinic,
  'revenue' => ReportType.revenue,
  'doctors' => ReportType.doctors,
  _ => ReportType.appointments,
};
