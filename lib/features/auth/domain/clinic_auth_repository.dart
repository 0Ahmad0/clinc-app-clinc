import '../../../core/data/base_model.dart';
import '../../../core/data/remote/api_response.dart';
import '../../../core/domain/error_handler/network_exceptions.dart';
import '../data/clinic_auth_remote_data_source.dart';
import '../data/models/clinic_login_model.dart';
import '../data/models/clinic_logout_model.dart';
import '../data/models/clinic_model.dart';
import '../data/models/clinic_otp_status_model.dart';
import '../data/models/clinic_otp_verification_model.dart';
import '../data/models/clinic_password_reset_model.dart';

class ClinicAuthRepository {
  ClinicAuthRepository(this._remoteDataSource);

  final ClinicAuthRemoteDataSource _remoteDataSource;

  Future<ApiResponse<BaseModel<ClinicLoginModel>>> login({
    required String email,
    required String password,
  }) {
    return _execute(
      () => _remoteDataSource.login(email: email, password: password),
    );
  }

  Future<ApiResponse<BaseModel<ClinicModel>>> register({
    required String name,
    required String licenseNumber,
    required String email,
    required String password,
    required String type,
    Map<String, dynamic> fcmPayload = const {},
  }) {
    return _execute(
      () => _remoteDataSource.register(
        name: name,
        licenseNumber: licenseNumber,
        email: email,
        password: password,
        type: type,
        fcmPayload: fcmPayload,
      ),
    );
  }

  Future<ApiResponse<BaseModel<ClinicLoginModel>>> me() {
    return _execute(_remoteDataSource.me);
  }

  Future<ApiResponse<BaseModel<ClinicLogoutModel>>> logout() {
    return _execute(_remoteDataSource.logout);
  }

  Future<ApiResponse<BaseModel<ClinicOtpStatusModel>>> forgotPassword({
    required String email,
  }) {
    return _execute(() => _remoteDataSource.forgotPassword(email: email));
  }

  Future<ApiResponse<BaseModel<ClinicOtpVerificationModel>>> verifyOtp({
    required String identifier,
    required String otp,
  }) {
    return _execute(
      () => _remoteDataSource.verifyOtp(identifier: identifier, otp: otp),
    );
  }

  Future<ApiResponse<BaseModel<ClinicOtpStatusModel>>> resendOtp({
    required String identifier,
  }) {
    return _execute(() => _remoteDataSource.resendOtp(identifier: identifier));
  }

  Future<ApiResponse<BaseModel<ClinicPasswordResetModel>>> resetPassword({
    required String resetToken,
    required String password,
    required String passwordConfirmation,
  }) {
    return _execute(
      () => _remoteDataSource.resetPassword(
        resetToken: resetToken,
        password: password,
        passwordConfirmation: passwordConfirmation,
      ),
    );
  }

  Future<ApiResponse<BaseModel<T>>> _execute<T>(
    Future<BaseModel<T>> Function() action,
  ) async {
    try {
      return ApiResponse.success(await action());
    } catch (error) {
      return ApiResponse.failure(NetworkExceptions.getException(error));
    }
  }
}
