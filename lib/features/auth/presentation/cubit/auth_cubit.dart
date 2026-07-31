import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/account_type.dart';
import '../../domain/auth_layer.dart';
import 'auth_state.dart';

/// Drives navigation between the auth layers and holds the selected account
/// type. Real submission/API belongs in a repository later — this only moves
/// between layers (e.g. signup lands on the pending-approval layer).
class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(const AuthState());

  void show(AuthLayer layer) => emit(state.copyWith(layer: layer));

  void selectAccountType(AccountType type) =>
      emit(state.copyWith(accountType: type));

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
