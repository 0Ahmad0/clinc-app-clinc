import '../../../core/data/base_model.dart';
import '../../../core/domain/services/api_service.dart';
import '../../../core/utils/app_url.dart';
import 'models/clinic_login_model.dart';
import 'models/clinic_logout_model.dart';
import 'models/clinic_model.dart';
import 'models/clinic_otp_status_model.dart';
import 'models/clinic_otp_verification_model.dart';
import 'models/clinic_password_reset_model.dart';

class ClinicAuthRemoteDataSource {
  ClinicAuthRemoteDataSource(this._apiServices);

  final ApiServices _apiServices;

  Future<BaseModel<ClinicLoginModel>> login({
    required String email,
    required String password,
  }) async {
    final response = await _apiServices.post(
      AppUrl.clinicLogin,
      body: {
        'email': email,
        'password': password,
        'device_name': 'clinic-flutter',
      },
      hasToken: false,
    );

    return BaseModel.fromJson(
      Map<String, dynamic>.from(response as Map),
      (json) =>
          ClinicLoginModel.fromJson(Map<String, dynamic>.from(json as Map)),
    );
  }

  Future<BaseModel<ClinicModel>> register({
    required String name,
    required String licenseNumber,
    required String email,
    required String password,
    required String type,
    Map<String, dynamic> fcmPayload = const {},
  }) async {
    final response = await _apiServices.post(
      AppUrl.clinicRegister,
      body: {
        'name': name,
        'license_number': licenseNumber,
        'email': email,
        'password': password,
        'type': type,
        ...fcmPayload,
      },
      hasToken: false,
    );

    return BaseModel.fromJson(
      Map<String, dynamic>.from(response as Map),
      (json) => ClinicModel.fromJson(Map<String, dynamic>.from(json as Map)),
    );
  }

  Future<BaseModel<ClinicLoginModel>> me() async {
    final response = await _apiServices.get(AppUrl.clinicMe);

    return BaseModel.fromJson(
      Map<String, dynamic>.from(response as Map),
      (json) =>
          ClinicLoginModel.fromJson(Map<String, dynamic>.from(json as Map)),
    );
  }

  Future<BaseModel<ClinicLogoutModel>> logout() async {
    final response = await _apiServices.post(AppUrl.clinicLogout);

    return BaseModel.fromJson(
      Map<String, dynamic>.from(response as Map),
      (json) =>
          ClinicLogoutModel.fromJson(Map<String, dynamic>.from(json as Map)),
    );
  }

  Future<BaseModel<ClinicOtpStatusModel>> forgotPassword({
    required String email,
  }) async {
    final response = await _apiServices.post(
      AppUrl.clinicForgotPassword,
      body: {'email': email},
      hasToken: false,
    );

    return BaseModel.fromJson(
      Map<String, dynamic>.from(response as Map),
      (json) =>
          ClinicOtpStatusModel.fromJson(Map<String, dynamic>.from(json as Map)),
    );
  }

  Future<BaseModel<ClinicOtpVerificationModel>> verifyOtp({
    required String identifier,
    required String otp,
  }) async {
    final response = await _apiServices.post(
      AppUrl.clinicVerifyOtp,
      body: {
        'identifier': identifier,
        'otp': otp,
        'purpose': 'clinic_password_reset',
      },
      hasToken: false,
    );

    return BaseModel.fromJson(
      Map<String, dynamic>.from(response as Map),
      (json) => ClinicOtpVerificationModel.fromJson(
        Map<String, dynamic>.from(json as Map),
      ),
    );
  }

  Future<BaseModel<ClinicOtpStatusModel>> resendOtp({
    required String identifier,
  }) async {
    final response = await _apiServices.post(
      AppUrl.clinicResendOtp,
      body: {'identifier': identifier, 'purpose': 'clinic_password_reset'},
      hasToken: false,
    );

    return BaseModel.fromJson(
      Map<String, dynamic>.from(response as Map),
      (json) =>
          ClinicOtpStatusModel.fromJson(Map<String, dynamic>.from(json as Map)),
    );
  }

  Future<BaseModel<ClinicPasswordResetModel>> resetPassword({
    required String resetToken,
    required String password,
    required String passwordConfirmation,
  }) async {
    final response = await _apiServices.post(
      AppUrl.clinicResetPassword,
      body: {
        'reset_token': resetToken,
        'password': password,
        'password_confirmation': passwordConfirmation,
      },
      hasToken: false,
    );

    return BaseModel.fromJson(
      Map<String, dynamic>.from(response as Map),
      (json) => ClinicPasswordResetModel.fromJson(
        Map<String, dynamic>.from(json as Map),
      ),
    );
  }
}
