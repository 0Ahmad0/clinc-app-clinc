import '../../../../app/data/remote/api_response.dart';
import '../../../../app/domain/error_handler/network_exceptions.dart';
import '../../data/clinic_auth_model.dart';
import '../../data/data_sources/clinic_auth_data_source.dart';

class ClinicAuthRepository {
  ClinicAuthRepository(this._dataSource);

  final ClinicAuthDataSource _dataSource;

  Future<ApiResponse<ClinicAuthActionResponse>> register(
    ClinicRegisterRequest request,
  ) => _execute(() => _dataSource.register(request));

  Future<ApiResponse<ClinicAuthActionResponse>> forgotPassword(
    ForgotPasswordRequest request,
  ) => _execute(() => _dataSource.forgotPassword(request));

  Future<ApiResponse<ClinicAuthActionResponse>> verifyOtp(
    VerifyOtpRequest request,
  ) => _execute(() => _dataSource.verifyOtp(request));

  Future<ApiResponse<ClinicAuthActionResponse>> resendOtp(
    ResendOtpRequest request,
  ) => _execute(() => _dataSource.resendOtp(request));

  Future<ApiResponse<ClinicAuthActionResponse>> resetPassword(
    ResetPasswordRequest request,
  ) => _execute(() => _dataSource.resetPassword(request));

  Future<ApiResponse<ClinicAuthActionResponse>> _execute(
    Future<ClinicAuthActionResponse> Function() action,
  ) async {
    try {
      return ApiResponse.success(await action());
    } catch (error) {
      return ApiResponse.failure(NetworkExceptions.getException(error));
    }
  }
}
