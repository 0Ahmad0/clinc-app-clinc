import 'package:clinic_app/core/data/base_model.dart';
import 'package:clinic_app/core/data/remote/api_response.dart';
import 'package:clinic_app/features/auth/data/models/clinic_otp_status_model.dart';
import 'package:clinic_app/features/auth/data/models/clinic_otp_verification_model.dart';
import 'package:clinic_app/features/auth/data/models/clinic_password_reset_model.dart';
import 'package:clinic_app/features/auth/domain/account_type.dart';
import 'package:clinic_app/features/auth/domain/auth_identifier.dart';
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

  test(
    'forgot password verifies a code before choosing a new password',
    () async {
      final cubit = AuthCubit(_FakeClinicAuthRepository());

      await cubit.forgotPassword(email: 'info@clinic.sa');
      expect(cubit.state.layer, AuthLayer.otp);
      expect(cubit.state.otpDestination, 'info@clinic.sa');

      await cubit.verifyOtp(
        identifier: cubit.state.otpDestination,
        otp: '1234',
      );
      expect(cubit.state.layer, AuthLayer.reset);
      expect(cubit.state.resetToken, 'reset-token');

      await cubit.resetPassword(
        resetToken: cubit.state.resetToken!,
        password: 'password123',
        passwordConfirmation: 'password123',
      );
      expect(cubit.state.layer, AuthLayer.login);
      cubit.close();
    },
  );

  test('the OTP destination is masked but stays recognizable', () {
    expect(maskIdentifier('info@clinic.sa'), 'in***@clinic.sa');
    expect(maskIdentifier('  ab@clinic.sa '), '***@clinic.sa');
    expect(maskIdentifier('1234567'), '12***');
  });
}

class _FakeClinicAuthRepository implements ClinicAuthRepository {
  @override
  Future<ApiResponse<BaseModel<ClinicOtpStatusModel>>> forgotPassword({
    required String email,
  }) async => ApiResponse.success(
    BaseModel(
      result: ClinicOtpStatusModel(
        identifier: email,
        purpose: 'clinic_password_reset',
        expiresIn: 300,
      ),
      message: 'OTP sent',
    ),
  );

  @override
  Future<ApiResponse<BaseModel<ClinicOtpVerificationModel>>> verifyOtp({
    required String identifier,
    required String otp,
  }) async => ApiResponse.success(
    BaseModel(
      result: const ClinicOtpVerificationModel(
        resetToken: 'reset-token',
        expiresIn: 300,
      ),
      message: 'OTP verified',
    ),
  );

  @override
  Future<ApiResponse<BaseModel<ClinicPasswordResetModel>>> resetPassword({
    required String resetToken,
    required String password,
    required String passwordConfirmation,
  }) async => ApiResponse.success(
    BaseModel(
      result: const ClinicPasswordResetModel(reset: true),
      message: 'Password reset',
    ),
  );

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
