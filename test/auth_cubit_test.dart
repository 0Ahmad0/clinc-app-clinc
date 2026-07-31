import 'package:clinic_app/features/auth/domain/account_type.dart';
import 'package:clinic_app/features/auth/domain/auth_identifier.dart';
import 'package:clinic_app/features/auth/domain/auth_layer.dart';
import 'package:clinic_app/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('signup verifies a code before landing on pending approval', () {
    final cubit = AuthCubit();

    cubit.show(AuthLayer.signup);
    cubit.selectAccountType(AccountType.lab);
    cubit.submitSignup('info@clinic.sa');

    expect(cubit.state.layer, AuthLayer.otp);
    expect(cubit.state.otpDestination, 'info@clinic.sa');

    cubit.verifyOtp();

    expect(cubit.state.layer, AuthLayer.pending);
    expect(cubit.state.accountType, AccountType.lab);
    cubit.close();
  });

  test('forgot password verifies a code before choosing a new password', () {
    final cubit = AuthCubit();

    cubit.submitForgot('info@clinic.sa');
    expect(cubit.state.layer, AuthLayer.otp);

    cubit.verifyOtp();
    expect(cubit.state.layer, AuthLayer.reset);

    cubit.completeReset();
    expect(cubit.state.layer, AuthLayer.login);
    cubit.close();
  });

  test('the OTP destination is masked but stays recognizable', () {
    expect(maskIdentifier('info@clinic.sa'), 'in***@clinic.sa');
    expect(maskIdentifier('  ab@clinic.sa '), '***@clinic.sa');
    expect(maskIdentifier('1234567'), '12***');
  });
}
