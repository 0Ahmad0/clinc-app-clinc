import '../../auth/domain/account_type.dart';

/// The two catalogs a facility manages: lab tests or medical specialties.
enum ServiceKind { lab, specialty }

/// Which service kinds a facility may manage, derived from its [AccountType] —
/// the single place role scoping lives, so no `if (role == …)` leaks into the
/// UI. A lab manages tests, a clinic manages specialties, `both` manages both.
List<ServiceKind> serviceKindsFor(AccountType type) => switch (type) {
  AccountType.lab => const [ServiceKind.lab],
  AccountType.clinic => const [ServiceKind.specialty],
  AccountType.both => const [ServiceKind.lab, ServiceKind.specialty],
};
