import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/account_type.dart';
import '../../domain/auth_layer.dart';
import 'auth_state.dart';

/// Drives navigation between the four auth layers and holds the selected account
/// type. Real submission/API belongs in a repository later — this only moves
/// between layers (e.g. signup lands on the pending-approval layer).
class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(const AuthState());

  void show(AuthLayer layer) => emit(state.copyWith(layer: layer));

  void selectAccountType(AccountType type) =>
      emit(state.copyWith(accountType: type));

  /// Signup ends on the pending-approval layer until an admin approves.
  void submitSignup() => show(AuthLayer.pending);
}
