import '../clinic_auth_model.dart';

abstract class ClinicAuthDataSource {
  Future<ClinicAuthActionResponse> register(ClinicRegisterRequest request);

  Future<ClinicAuthActionResponse> forgotPassword(
    ForgotPasswordRequest request,
  );

  Future<ClinicAuthActionResponse> verifyOtp(VerifyOtpRequest request);

  Future<ClinicAuthActionResponse> resendOtp(ResendOtpRequest request);
}
