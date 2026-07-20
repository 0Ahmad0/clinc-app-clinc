import 'package:clinic_app/features/auth/domain/account_type.dart';
import 'package:clinic_app/features/auth/domain/auth_layer.dart';
import 'package:clinic_app/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('auth flow changes layers and keeps the selected account type', () {
    final cubit = AuthCubit();

    cubit.show(AuthLayer.signup);
    cubit.selectAccountType(AccountType.lab);
    cubit.submitSignup();

    expect(cubit.state.layer, AuthLayer.pending);
    expect(cubit.state.accountType, AccountType.lab);
    cubit.close();
  });
}
