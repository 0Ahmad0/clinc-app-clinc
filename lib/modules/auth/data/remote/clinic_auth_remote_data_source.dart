import '../../../../app/core/utils/app_url.dart';
import '../../../../app/domain/services/api_service.dart';
import '../clinic_auth_model.dart';
import '../data_sources/clinic_auth_data_source.dart';

class ClinicAuthRemoteDataSource implements ClinicAuthDataSource {
  ClinicAuthRemoteDataSource(this._apiServices);

  final ApiServices _apiServices;

  @override
  Future<ClinicAuthActionResponse> register(
    ClinicRegisterRequest request,
  ) async {
    final response = await _apiServices.post(
      AppUrl.clinicRegister,
      body: request.toJson(),
      hasToken: false,
    );
    return ClinicAuthActionResponse.fromJson(response);
  }

  @override
  Future<ClinicAuthActionResponse> forgotPassword(
    ForgotPasswordRequest request,
  ) async {
    final response = await _apiServices.post(
      AppUrl.clinicForgotPassword,
      body: request.toJson(),
      hasToken: false,
    );
    return ClinicAuthActionResponse.fromJson(response);
  }

  @override
  Future<ClinicAuthActionResponse> verifyOtp(VerifyOtpRequest request) async {
    final response = await _apiServices.post(
      AppUrl.clinicVerifyOtp,
      body: request.toJson(),
      hasToken: false,
    );
    return ClinicAuthActionResponse.fromJson(response);
  }

  @override
  Future<ClinicAuthActionResponse> resendOtp(ResendOtpRequest request) async {
    final response = await _apiServices.post(
      AppUrl.clinicResendOtp,
      body: request.toJson(),
      hasToken: false,
    );
    return ClinicAuthActionResponse.fromJson(response);
  }

  @override
  Future<ClinicAuthActionResponse> resetPassword(
    ResetPasswordRequest request,
  ) async {
    final response = await _apiServices.post(
      AppUrl.clinicResetPassword,
      body: request.toJson(),
      hasToken: false,
    );
    return ClinicAuthActionResponse.fromJson(response);
  }
}
