import 'package:clinc_app_clinc/modules/auth/data/clinic_auth_model.dart';
import 'package:clinc_app_clinc/modules/auth/data/login_model.dart';
import 'package:clinc_app_clinc/modules/auth/data/mock/clinic_auth_mock_data_source.dart';
import 'package:clinc_app_clinc/modules/auth/data/mock/clinic_login_mock_data_source.dart';
import 'package:clinc_app_clinc/app/data/account_type.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test(
    'auth mock flows cover login registration otp social and reset',
    () async {
      final login = ClinicLoginMockDataSource();
      final auth = ClinicAuthMockDataSource();

      final passwordLogin = await login.login(
        const ClinicLoginRequest(
          identifier: 'info@nukhba-clinic.com',
          password: 'password',
        ),
      );
      expect(passwordLogin.isSuccess, isTrue);
      expect(passwordLogin.data?.needsCompletion, isFalse);

      final register = await auth.register(
        const ClinicRegisterRequest(
          name: 'Future Clinic',
          licenseNumber: 'CLN-NEW-2001',
          email: 'future@example.com',
          password: 'password123',
          passwordConfirmation: 'password123',
          type: AccountType.both,
        ),
      );
      expect(register.isSuccess, isTrue);
      expect(register.data?['clinic']?['status'], 'pending');

      final resend = await auth.resendOtp(
        const ResendOtpRequest(
          identifier: 'future@example.com',
          purpose: 'registration',
        ),
      );
      expect(resend.isSuccess, isTrue);

      final registrationOtp = await auth.verifyOtp(
        const VerifyOtpRequest(
          identifier: 'future@example.com',
          otp: '1234',
          purpose: 'registration',
        ),
      );
      expect(registrationOtp.isSuccess, isTrue);
      expect(registrationOtp.data?['reset_token'], isNull);

      final social = await login.socialLogin(
        const SocialLoginRequest(provider: 'google'),
      );
      expect(social.isSuccess, isTrue);
      expect(social.data?.token, isNotEmpty);

      final resetOtp = await auth.verifyOtp(
        const VerifyOtpRequest(
          identifier: 'info@nukhba-clinic.com',
          otp: '1234',
          purpose: 'password_reset',
        ),
      );
      expect(resetOtp.isSuccess, isTrue);
      expect(resetOtp.data?['reset_token'], 'mock-password-reset-token');

      final reset = await auth.resetPassword(
        const ResetPasswordRequest(
          identifier: 'info@nukhba-clinic.com',
          resetToken: 'mock-password-reset-token',
          password: 'password123',
          passwordConfirmation: 'password123',
        ),
      );
      expect(reset.isSuccess, isTrue);
    },
  );
}
