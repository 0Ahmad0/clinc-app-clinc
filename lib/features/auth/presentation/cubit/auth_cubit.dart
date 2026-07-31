import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:async';

import '../../../../core/data/base_model.dart';
import '../../../../core/data/remote/api_response.dart';
import '../../../../core/domain/error_handler/network_exceptions.dart';
import '../../../../core/services/fcm_token_sync_service.dart';
import '../../../../core/services/storage_service.dart';
import '../../../../shared/input/email_input.dart';
import '../../data/models/clinic_login_model.dart';
import '../../data/models/clinic_model.dart';
import '../../data/models/clinic_otp_status_model.dart';
import '../../data/models/clinic_otp_verification_model.dart';
import '../../data/models/clinic_password_reset_model.dart';
import '../../domain/account_type.dart';
import '../../domain/auth_layer.dart';
import '../../domain/clinic_auth_repository.dart';
import 'auth_state.dart';

/// Drives navigation between the auth layers and holds the selected account
/// type. Real submission/API belongs in a repository later — this only moves
/// between layers (e.g. signup lands on the pending-approval layer).
class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this._repository, [this._fcmTokenSyncService])
    : super(const AuthState());

  final ClinicAuthRepository _repository;
  final FcmTokenSyncService? _fcmTokenSyncService;

  void show(AuthLayer layer) => emit(state.copyWith(layer: layer));

  void selectAccountType(AccountType type) =>
      emit(state.copyWith(accountType: type));

  Future<void> login({
    required String identifier,
    required String password,
  }) async {
    if (state.isLoading) return;
    _start(AuthAction.login);

    final result = await _repository.login(
      email: normalizeEmailInput(identifier),
      password: password,
    );

    result.when(
      success: _handleLoginSuccess,
      failure: (exception) => _fail(AuthAction.login, exception),
    );
  }

  Future<void> register({
    required String name,
    required String licenseNumber,
    required String email,
    required String password,
  }) async {
    if (state.isLoading) return;
    _start(AuthAction.register);
    final fcmPayload =
        await _fcmTokenSyncService?.registerPayload() ?? const {};

    final result = await _repository.register(
      name: name.trim(),
      licenseNumber: licenseNumber.trim(),
      email: normalizeEmailInput(email),
      password: password,
      type: state.accountType.name,
      fcmPayload: fcmPayload,
    );

    result.when(
      success: _handleRegisterSuccess,
      failure: (exception) => _fail(AuthAction.register, exception),
    );
  }

  Future<void> forgotPassword({required String email}) async {
    if (state.isLoading) return;
    _start(AuthAction.forgotPassword);

    final result = await _repository.forgotPassword(
      email: normalizeEmailInput(email),
    );

    result.when(
      success: _handleForgotPasswordSuccess,
      failure: (exception) => _fail(AuthAction.forgotPassword, exception),
    );
  }

  Future<void> me() async {
    if (state.isLoading) return;
    _start(AuthAction.me);

    final result = await _repository.me();

    result.when(
      success: (response) => _handleLoginSuccess(response, AuthAction.me),
      failure: (exception) => _fail(AuthAction.me, exception),
    );
  }

  Future<void> verifyOtp({
    required String identifier,
    required String otp,
  }) async {
    if (state.isLoading) return;
    _start(AuthAction.verifyOtp);

    final result = await _repository.verifyOtp(
      identifier: normalizeEmailInput(identifier),
      otp: otp.trim(),
    );

    result.when(
      success: _handleVerifyOtpSuccess,
      failure: (exception) => _fail(AuthAction.verifyOtp, exception),
    );
  }

  Future<void> resendOtp({required String identifier}) async {
    if (state.isLoading) return;
    _start(AuthAction.resendOtp);

    final result = await _repository.resendOtp(
      identifier: normalizeEmailInput(identifier),
    );

    result.when(
      success: _handleForgotPasswordSuccess,
      failure: (exception) => _fail(AuthAction.resendOtp, exception),
    );
  }

  Future<void> resetPassword({
    required String resetToken,
    required String password,
    required String passwordConfirmation,
  }) async {
    if (state.isLoading) return;
    _start(AuthAction.resetPassword);

    final result = await _repository.resetPassword(
      resetToken: resetToken.trim(),
      password: password,
      passwordConfirmation: passwordConfirmation,
    );

    result.when(
      success: _handleResetPasswordSuccess,
      failure: (exception) => _fail(AuthAction.resetPassword, exception),
    );
  }

  Future<void> logout() async {
    if (state.isLoading) return;
    _start(AuthAction.logout);

    final result = await _repository.logout();

    result.when(
      success: (response) async {
        await StorageService.instance.depose();
        emit(const AuthState(action: AuthAction.logout, message: 'Logged out'));
      },
      failure: (exception) => _fail(AuthAction.logout, exception),
    );
  }

  void _start(AuthAction action) {
    emit(
      state.copyWith(
        action: action,
        isLoading: true,
        message: null,
        failure: null,
      ),
    );
  }

  Future<void> _handleLoginSuccess(
    BaseModel<ClinicLoginModel> response, [
    AuthAction action = AuthAction.login,
  ]) async {
    final payload = response.result;
    final token = payload?.token;

    if (response.isSuccess && payload != null && token != null) {
      await StorageService.instance.setAccessToken(token);
      await StorageService.instance.setGuestMode(false);
      await StorageService.instance.cacheClinic(payload.clinic?.toJson() ?? {});
      await StorageService.instance.setProfileCompleted(
        !payload.needsCompletion,
      );
      final fcmTokenSyncService = _fcmTokenSyncService;
      if (fcmTokenSyncService != null) {
        unawaited(fcmTokenSyncService.syncCurrentToken());
      }
    }

    emit(
      state.copyWith(
        action: action,
        isLoading: false,
        login: payload,
        message: response.message,
        failure: null,
      ),
    );
  }

  Future<void> _handleRegisterSuccess(BaseModel<ClinicModel> response) async {
    final clinic = response.result;
    if (clinic != null) {
      await StorageService.instance.cacheClinic(clinic.toJson());
      await StorageService.instance.setPendingRegistrationReference(
        clinic.clinicId,
      );
    }

    emit(
      state.copyWith(
        layer: AuthLayer.pending,
        action: AuthAction.register,
        isLoading: false,
        registeredClinic: clinic,
        message: response.message,
        failure: null,
      ),
    );
  }

  void _handleForgotPasswordSuccess(BaseModel<ClinicOtpStatusModel> response) {
    emit(
      state.copyWith(
        action: AuthAction.forgotPassword,
        isLoading: false,
        otpStatus: response.result,
        message: response.message,
        failure: null,
      ),
    );
  }

  void _handleVerifyOtpSuccess(BaseModel<ClinicOtpVerificationModel> response) {
    emit(
      state.copyWith(
        action: AuthAction.verifyOtp,
        isLoading: false,
        otpVerification: response.result,
        message: response.message,
        failure: null,
      ),
    );
  }

  void _handleResetPasswordSuccess(
    BaseModel<ClinicPasswordResetModel> response,
  ) {
    emit(
      state.copyWith(
        action: AuthAction.resetPassword,
        isLoading: false,
        passwordReset: response.result,
        message: response.message,
        failure: null,
      ),
    );
  }

  void _fail(AuthAction action, NetworkExceptions exception) {
    emit(
      state.copyWith(
        action: action,
        isLoading: false,
        failure: exception,
        message: null,
      ),
    );
  }
  /// Signup sends a code to [email] before the request reaches the admins.
  void submitSignup(String email) => _requestOtp(AuthLayer.signup, email);

  /// Forgot-password sends a code to the account's [identifier].
  void submitForgot(String identifier) =>
      _requestOtp(AuthLayer.forgot, identifier);

  /// A verified signup code ends on the pending-approval layer until an admin
  /// approves; a verified reset code goes on to choose a new password.
  void verifyOtp() => show(
    state.otpOrigin == AuthLayer.signup ? AuthLayer.pending : AuthLayer.reset,
  );

  /// The new password is saved — back to sign-in.
  void completeReset() => show(AuthLayer.login);

  void _requestOtp(AuthLayer origin, String destination) => emit(
    state.copyWith(
      layer: AuthLayer.otp,
      otpOrigin: origin,
      otpDestination: destination,
    ),
  );
}
