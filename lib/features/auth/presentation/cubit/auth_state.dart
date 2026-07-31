import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/domain/error_handler/network_exceptions.dart';
import '../../data/models/clinic_login_model.dart';
import '../../data/models/clinic_model.dart';
import '../../data/models/clinic_otp_status_model.dart';
import '../../data/models/clinic_otp_verification_model.dart';
import '../../data/models/clinic_password_reset_model.dart';
import '../../domain/account_type.dart';
import '../../domain/auth_layer.dart';

part 'auth_state.freezed.dart';

enum AuthAction {
  none,
  login,
  register,
  me,
  forgotPassword,
  verifyOtp,
  resendOtp,
  resetPassword,
  logout,
}

@freezed
abstract class AuthState with _$AuthState {
  const factory AuthState({
    @Default(AuthLayer.login) AuthLayer layer,
    @Default(AccountType.clinic) AccountType accountType,
    @Default(AuthAction.none) AuthAction action,
    @Default(false) bool isLoading,
    ClinicLoginModel? login,
    ClinicModel? registeredClinic,
    ClinicOtpStatusModel? otpStatus,
    ClinicOtpVerificationModel? otpVerification,
    ClinicPasswordResetModel? passwordReset,
    @Default(AuthLayer.forgot) AuthLayer otpOrigin,
    @Default('') String otpDestination,
    String? resetToken,
    String? message,
    NetworkExceptions? failure,
  }) = _AuthState;
}
