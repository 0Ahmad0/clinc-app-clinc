import 'package:equatable/equatable.dart';

import '../../domain/account_type.dart';
import '../../domain/auth_layer.dart';

/// Which auth layer is showing, the chosen account type, and where the OTP
/// layer was reached from / sent its code to.
class AuthState extends Equatable {
  const AuthState({
    this.layer = AuthLayer.login,
    this.accountType = AccountType.clinic,
    this.otpOrigin = AuthLayer.forgot,
    this.otpDestination = '',
  });

  final AuthLayer layer;
  final AccountType accountType;

  /// The layer that asked for a code — decides where verifying leads.
  final AuthLayer otpOrigin;

  /// Email or license the code was sent to, shown masked on the OTP layer.
  final String otpDestination;

  AuthState copyWith({
    AuthLayer? layer,
    AccountType? accountType,
    AuthLayer? otpOrigin,
    String? otpDestination,
  }) => AuthState(
    layer: layer ?? this.layer,
    accountType: accountType ?? this.accountType,
    otpOrigin: otpOrigin ?? this.otpOrigin,
    otpDestination: otpDestination ?? this.otpDestination,
  );

  @override
  List<Object> get props => [layer, accountType, otpOrigin, otpDestination];
}
