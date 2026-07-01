import '../data/account_type.dart';

extension AccountTypeX on AccountType {
  String key() {
    switch (this) {
      case AccountType.clinic:
        return 'register.account_type.clinic';
      case AccountType.both:
        return 'register.account_type.clinic_with_lab';
      case AccountType.lab:
        return 'register.account_type.lab';
    }
  }
}
