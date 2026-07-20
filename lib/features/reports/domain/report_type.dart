import '../../auth/domain/account_type.dart';

/// The kind of report being viewed.
enum ReportType { appointments, revenue, labs }

/// Which report types a facility may view, derived from its [AccountType] — the
/// single place role scoping lives, so no `if (role == …)` leaks into the UI.
/// Every facility has appointments; revenue is clinic-side, labs are lab-side.
List<ReportType> reportTypesFor(AccountType type) => switch (type) {
  AccountType.clinic => const [ReportType.appointments, ReportType.revenue],
  AccountType.lab => const [ReportType.appointments, ReportType.labs],
  AccountType.both => const [
    ReportType.appointments,
    ReportType.revenue,
    ReportType.labs,
  ],
};
