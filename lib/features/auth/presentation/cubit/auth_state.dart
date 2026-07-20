import 'package:equatable/equatable.dart';

import '../../domain/account_type.dart';
import '../../domain/auth_layer.dart';

/// Which auth layer is showing and the currently chosen account type.
class AuthState extends Equatable {
  const AuthState({
    this.layer = AuthLayer.login,
    this.accountType = AccountType.clinic,
  });

  final AuthLayer layer;
  final AccountType accountType;

  AuthState copyWith({AuthLayer? layer, AccountType? accountType}) => AuthState(
    layer: layer ?? this.layer,
    accountType: accountType ?? this.accountType,
  );

  @override
  List<Object> get props => [layer, accountType];
}
