import 'package:clinic_app/features/auth/domain/account_type.dart';
import 'package:clinic_app/features/auth/domain/auth_layer.dart';
import 'package:clinic_app/features/auth/domain/clinic_auth_repository.dart';
import 'package:clinic_app/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('auth flow changes layers and keeps the selected account type', () {
    final cubit = AuthCubit(_FakeClinicAuthRepository());

    cubit.show(AuthLayer.signup);
    cubit.selectAccountType(AccountType.lab);

    expect(cubit.state.layer, AuthLayer.signup);
    expect(cubit.state.accountType, AccountType.lab);
    cubit.close();
  });
}

class _FakeClinicAuthRepository implements ClinicAuthRepository {
  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
