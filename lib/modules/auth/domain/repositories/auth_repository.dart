import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../app/data/base_model.dart';
import '../../../../app/data/remote/api_response.dart';
import '../../../../app/data/user.dart';
import '../../../../app/domain/error_handler/network_exceptions.dart';
import '../../data/remote/auth_remote_data_source.dart';

class AuthRepository {
  final AuthRemoteDataSource _remoteDataSource;

  AuthRepository(this._remoteDataSource);

  Future<ApiResponse<BaseModel>> login(String email, String password) async {
    try {
      final response = await _remoteDataSource.login(email, password);
      if (response.status == 'error') {
        return ApiResponse.failure(
          NetworkExceptions.defaultError(response.message ?? ''),
        );
      }

      return ApiResponse.success(response);
    } catch (error) {
      return ApiResponse.failure(NetworkExceptions.getException(error));
    }
  }

  Future<ApiResponse<BaseModel>> loginWithGoogle({
    required String idToken,
    required String role,
  }) async {
    try {
      final response = await _remoteDataSource.loginWithGoogle(
        idToken: idToken,
        role: role,
      );
      if (response.status == 'error') {
        return ApiResponse.failure(
          NetworkExceptions.defaultError(response.message ?? ''),
        );
      }

      return ApiResponse.success(response);
    } catch (error) {
      return ApiResponse.failure(NetworkExceptions.getException(error));
    }
  }

  Future<ApiResponse<BaseModel>> register({
    required String email,
    required String password,
    required String passwordConfirmation,
    required String firstName,
    required String lastName,
    required String phone,
    required String gender,
    required DateTime birthDay,
    required int countryId,
    required int cityId,
    required String role,
    String? userName,
  }) async {
    try {
      final response = await _remoteDataSource.register(
        email: email,
        password: password,
        passwordConfirmation: passwordConfirmation,
        firstName: firstName,
        lastName: lastName,
        phone: phone,
        gender: gender,
        birthDay: birthDay,
        countryId: countryId,
        cityId: cityId,
        role: role,
        userName: userName,
      );

      return ApiResponse.success(response);
    } catch (error) {
      return ApiResponse.failure(NetworkExceptions.getException(error));
    }
  }

  Future<ApiResponse<BaseModel>> getProfile() async {
    try {
      final response = await _remoteDataSource.getProfile();

      return ApiResponse.success(response);
    } catch (error) {
      return ApiResponse.failure(NetworkExceptions.getException(error));
    }
  }

  Future<ApiResponse<BaseModel>> updateProfile(
    UserModel user, {
    XFile? userImage,
  }) async {
    try {
      final response = await _remoteDataSource.updateProfile(
        user,
        userImage: userImage,
      );

      return ApiResponse.success(response);
    } catch (error) {
      return ApiResponse.failure(NetworkExceptions.getException(error));
    }
  }

  Future<ApiResponse<BaseModel>> verifyEmail({
    String? email,
    String? code,
  }) async {
    try {
      final response = await _remoteDataSource.verifyEmail(
        email: email,
        code: code,
      );

      return ApiResponse.success(response);
    } catch (error) {
      return ApiResponse.failure(NetworkExceptions.getException(error));
    }
  }

  Future<ApiResponse<BaseModel>> verifyOtp({
    String? email,
    String? code,
  }) async {
    try {
      final response = await _remoteDataSource.verifyOtp(
        email: email,
        code: code,
      );

      return ApiResponse.success(response);
    } catch (error) {
      return ApiResponse.failure(NetworkExceptions.getException(error));
    }
  }

  Future<ApiResponse<BaseModel>> forgotPassword(String? email) async {
    try {
      final response = await _remoteDataSource.forgotPassword(email);

      return ApiResponse.success(response);
    } catch (error) {
      return ApiResponse.failure(NetworkExceptions.getException(error));
    }
  }

  Future<ApiResponse<BaseModel>> requestAppPasswordReset(String? email) async {
    try {
      final response = await _remoteDataSource.requestAppPasswordReset(email);
      if (response.status == 'error') {
        return ApiResponse.failure(
          NetworkExceptions.defaultError(response.message ?? ''),
        );
      }

      return ApiResponse.success(response);
    } catch (error) {
      return ApiResponse.failure(NetworkExceptions.getException(error));
    }
  }

  Future<ApiResponse<BaseModel>> verifyPasswordResetOtp({
    String? email,
    String? code,
  }) async {
    try {
      final response = await _remoteDataSource.verifyPasswordResetOtp(
        email: email,
        code: code,
      );
      if (response.status == 'error') {
        return ApiResponse.failure(
          NetworkExceptions.defaultError(response.message ?? ''),
        );
      }

      return ApiResponse.success(response);
    } catch (error) {
      return ApiResponse.failure(NetworkExceptions.getException(error));
    }
  }

  Future<ApiResponse<BaseModel>> resendPasswordResetOtp(String? email) async {
    try {
      final response = await _remoteDataSource.resendPasswordResetOtp(email);
      if (response.status == 'error') {
        return ApiResponse.failure(
          NetworkExceptions.defaultError(response.message ?? ''),
        );
      }

      return ApiResponse.success(response);
    } catch (error) {
      return ApiResponse.failure(NetworkExceptions.getException(error));
    }
  }

  Future<ApiResponse<BaseModel>> changePassword({
    required String currentPassword,
    required String newPassword,
    required String confirmPassword,
  }) async {
    try {
      final response = await _remoteDataSource.changePassword(
        currentPassword: currentPassword,
        newPassword: newPassword,
        confirmPassword: confirmPassword,
      );

      if (response.status == 'error') {
        return ApiResponse.failure(
          NetworkExceptions.defaultError(response.message ?? ''),
        );
      }

      return ApiResponse.success(response);
    } catch (error) {
      return ApiResponse.failure(NetworkExceptions.getException(error));
    }
  }

  Future<ApiResponse<BaseModel>> resetPassword({
    String? tempToken,
    String? newPassword,
  }) async {
    try {
      final response = await _remoteDataSource.resetPassword(
        tempToken: tempToken,
        newPassword: newPassword,
      );

      return ApiResponse.success(response);
    } catch (error) {
      return ApiResponse.failure(NetworkExceptions.getException(error));
    }
  }

  Future<ApiResponse<BaseModel>> appResetPassword({
    String? resetToken,
    String? password,
    String? passwordConfirmation,
  }) async {
    try {
      final response = await _remoteDataSource.appResetPassword(
        resetToken: resetToken,
        password: password,
        passwordConfirmation: passwordConfirmation,
      );
      if (response.status == 'error') {
        return ApiResponse.failure(
          NetworkExceptions.defaultError(response.message ?? ''),
        );
      }

      return ApiResponse.success(response);
    } catch (error) {
      return ApiResponse.failure(NetworkExceptions.getException(error));
    }
  }

  Future<ApiResponse<BaseModel>> requestPasswordReset(String? email) async {
    try {
      final response = await _remoteDataSource.requestPasswordReset(email);

      return ApiResponse.success(response);
    } catch (error) {
      return ApiResponse.failure(NetworkExceptions.getException(error));
    }
  }

  Future<ApiResponse<BaseModel>> resendResetPasswordCode(String? email) async {
    try {
      final response = await _remoteDataSource.resendResetPasswordCode(email);

      return ApiResponse.success(response);
    } catch (error) {
      return ApiResponse.failure(NetworkExceptions.getException(error));
    }
  }

  Future<ApiResponse<BaseModel>> resendEmailOtpCode(String? email) async {
    try {
      final response = await _remoteDataSource.resendEmailOtpCode(email);

      return ApiResponse.success(response);
    } catch (error) {
      return ApiResponse.failure(NetworkExceptions.getException(error));
    }
  }

  Future<ApiResponse<BaseModel>> logout({String? accountType}) async {
    try {
      final response = await _remoteDataSource.logout();
      return ApiResponse.success(response);
    } catch (error) {
      return ApiResponse.failure(NetworkExceptions.getException(error));
    }
  }

  // في auth_repository.dart أضف:
  Future<ApiResponse<BaseModel>> linkGuardian({
    required String guardianEmail,
  }) async {
    try {
      final response = await _remoteDataSource.linkGuardian(
        guardianEmail: guardianEmail,
      );
      return ApiResponse.success(response);
    } catch (error) {
      return ApiResponse.failure(NetworkExceptions.getException(error));
    }
  }

  Future<ApiResponse<BaseModel>> deleteAccount() async {
    try {
      final response = await _remoteDataSource.deleteAccount();
      return ApiResponse.success(response);
    } on Exception catch (error) {
      return ApiResponse.failure(NetworkExceptions.getException(error));
    }
  }

  Future<ApiResponse<BaseModel>> restoreAccount({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _remoteDataSource.restoreAccount(
        email: email,
        password: password,
      );
      return ApiResponse.success(response);
    } catch (error) {
      if (error is DioException && error.response?.statusCode == 409) {
        return ApiResponse.failure(
          NetworkExceptions.unexpectedError('auth.account_not_deleted'.tr),
        );
      }
      return ApiResponse.failure(NetworkExceptions.getException(error));
    }
  }
}
