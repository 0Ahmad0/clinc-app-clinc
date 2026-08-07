// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AuthState {

 AuthLayer get layer; AccountType get accountType; AuthAction get action; bool get isLoading; bool get isLoadingInsurances; List<ClinicInsuranceModel> get insurances; Set<int> get selectedInsuranceIds; ClinicLoginModel? get login; ClinicModel? get registeredClinic; ClinicOtpStatusModel? get otpStatus; ClinicOtpVerificationModel? get otpVerification; ClinicPasswordResetModel? get passwordReset; AuthLayer get otpOrigin; String get otpDestination; String? get resetToken; String? get message; NetworkExceptions? get failure;
/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AuthStateCopyWith<AuthState> get copyWith => _$AuthStateCopyWithImpl<AuthState>(this as AuthState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthState&&(identical(other.layer, layer) || other.layer == layer)&&(identical(other.accountType, accountType) || other.accountType == accountType)&&(identical(other.action, action) || other.action == action)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isLoadingInsurances, isLoadingInsurances) || other.isLoadingInsurances == isLoadingInsurances)&&const DeepCollectionEquality().equals(other.insurances, insurances)&&const DeepCollectionEquality().equals(other.selectedInsuranceIds, selectedInsuranceIds)&&(identical(other.login, login) || other.login == login)&&(identical(other.registeredClinic, registeredClinic) || other.registeredClinic == registeredClinic)&&(identical(other.otpStatus, otpStatus) || other.otpStatus == otpStatus)&&(identical(other.otpVerification, otpVerification) || other.otpVerification == otpVerification)&&(identical(other.passwordReset, passwordReset) || other.passwordReset == passwordReset)&&(identical(other.otpOrigin, otpOrigin) || other.otpOrigin == otpOrigin)&&(identical(other.otpDestination, otpDestination) || other.otpDestination == otpDestination)&&(identical(other.resetToken, resetToken) || other.resetToken == resetToken)&&(identical(other.message, message) || other.message == message)&&(identical(other.failure, failure) || other.failure == failure));
}


@override
int get hashCode => Object.hash(runtimeType,layer,accountType,action,isLoading,isLoadingInsurances,const DeepCollectionEquality().hash(insurances),const DeepCollectionEquality().hash(selectedInsuranceIds),login,registeredClinic,otpStatus,otpVerification,passwordReset,otpOrigin,otpDestination,resetToken,message,failure);

@override
String toString() {
  return 'AuthState(layer: $layer, accountType: $accountType, action: $action, isLoading: $isLoading, isLoadingInsurances: $isLoadingInsurances, insurances: $insurances, selectedInsuranceIds: $selectedInsuranceIds, login: $login, registeredClinic: $registeredClinic, otpStatus: $otpStatus, otpVerification: $otpVerification, passwordReset: $passwordReset, otpOrigin: $otpOrigin, otpDestination: $otpDestination, resetToken: $resetToken, message: $message, failure: $failure)';
}


}

/// @nodoc
abstract mixin class $AuthStateCopyWith<$Res>  {
  factory $AuthStateCopyWith(AuthState value, $Res Function(AuthState) _then) = _$AuthStateCopyWithImpl;
@useResult
$Res call({
 AuthLayer layer, AccountType accountType, AuthAction action, bool isLoading, bool isLoadingInsurances, List<ClinicInsuranceModel> insurances, Set<int> selectedInsuranceIds, ClinicLoginModel? login, ClinicModel? registeredClinic, ClinicOtpStatusModel? otpStatus, ClinicOtpVerificationModel? otpVerification, ClinicPasswordResetModel? passwordReset, AuthLayer otpOrigin, String otpDestination, String? resetToken, String? message, NetworkExceptions? failure
});


$ClinicLoginModelCopyWith<$Res>? get login;$ClinicModelCopyWith<$Res>? get registeredClinic;$ClinicOtpStatusModelCopyWith<$Res>? get otpStatus;$ClinicOtpVerificationModelCopyWith<$Res>? get otpVerification;$ClinicPasswordResetModelCopyWith<$Res>? get passwordReset;$NetworkExceptionsCopyWith<$Res>? get failure;

}
/// @nodoc
class _$AuthStateCopyWithImpl<$Res>
    implements $AuthStateCopyWith<$Res> {
  _$AuthStateCopyWithImpl(this._self, this._then);

  final AuthState _self;
  final $Res Function(AuthState) _then;

/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? layer = null,Object? accountType = null,Object? action = null,Object? isLoading = null,Object? isLoadingInsurances = null,Object? insurances = null,Object? selectedInsuranceIds = null,Object? login = freezed,Object? registeredClinic = freezed,Object? otpStatus = freezed,Object? otpVerification = freezed,Object? passwordReset = freezed,Object? otpOrigin = null,Object? otpDestination = null,Object? resetToken = freezed,Object? message = freezed,Object? failure = freezed,}) {
  return _then(_self.copyWith(
layer: null == layer ? _self.layer : layer // ignore: cast_nullable_to_non_nullable
as AuthLayer,accountType: null == accountType ? _self.accountType : accountType // ignore: cast_nullable_to_non_nullable
as AccountType,action: null == action ? _self.action : action // ignore: cast_nullable_to_non_nullable
as AuthAction,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isLoadingInsurances: null == isLoadingInsurances ? _self.isLoadingInsurances : isLoadingInsurances // ignore: cast_nullable_to_non_nullable
as bool,insurances: null == insurances ? _self.insurances : insurances // ignore: cast_nullable_to_non_nullable
as List<ClinicInsuranceModel>,selectedInsuranceIds: null == selectedInsuranceIds ? _self.selectedInsuranceIds : selectedInsuranceIds // ignore: cast_nullable_to_non_nullable
as Set<int>,login: freezed == login ? _self.login : login // ignore: cast_nullable_to_non_nullable
as ClinicLoginModel?,registeredClinic: freezed == registeredClinic ? _self.registeredClinic : registeredClinic // ignore: cast_nullable_to_non_nullable
as ClinicModel?,otpStatus: freezed == otpStatus ? _self.otpStatus : otpStatus // ignore: cast_nullable_to_non_nullable
as ClinicOtpStatusModel?,otpVerification: freezed == otpVerification ? _self.otpVerification : otpVerification // ignore: cast_nullable_to_non_nullable
as ClinicOtpVerificationModel?,passwordReset: freezed == passwordReset ? _self.passwordReset : passwordReset // ignore: cast_nullable_to_non_nullable
as ClinicPasswordResetModel?,otpOrigin: null == otpOrigin ? _self.otpOrigin : otpOrigin // ignore: cast_nullable_to_non_nullable
as AuthLayer,otpDestination: null == otpDestination ? _self.otpDestination : otpDestination // ignore: cast_nullable_to_non_nullable
as String,resetToken: freezed == resetToken ? _self.resetToken : resetToken // ignore: cast_nullable_to_non_nullable
as String?,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as NetworkExceptions?,
  ));
}
/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ClinicLoginModelCopyWith<$Res>? get login {
    if (_self.login == null) {
    return null;
  }

  return $ClinicLoginModelCopyWith<$Res>(_self.login!, (value) {
    return _then(_self.copyWith(login: value));
  });
}/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ClinicModelCopyWith<$Res>? get registeredClinic {
    if (_self.registeredClinic == null) {
    return null;
  }

  return $ClinicModelCopyWith<$Res>(_self.registeredClinic!, (value) {
    return _then(_self.copyWith(registeredClinic: value));
  });
}/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ClinicOtpStatusModelCopyWith<$Res>? get otpStatus {
    if (_self.otpStatus == null) {
    return null;
  }

  return $ClinicOtpStatusModelCopyWith<$Res>(_self.otpStatus!, (value) {
    return _then(_self.copyWith(otpStatus: value));
  });
}/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ClinicOtpVerificationModelCopyWith<$Res>? get otpVerification {
    if (_self.otpVerification == null) {
    return null;
  }

  return $ClinicOtpVerificationModelCopyWith<$Res>(_self.otpVerification!, (value) {
    return _then(_self.copyWith(otpVerification: value));
  });
}/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ClinicPasswordResetModelCopyWith<$Res>? get passwordReset {
    if (_self.passwordReset == null) {
    return null;
  }

  return $ClinicPasswordResetModelCopyWith<$Res>(_self.passwordReset!, (value) {
    return _then(_self.copyWith(passwordReset: value));
  });
}/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$NetworkExceptionsCopyWith<$Res>? get failure {
    if (_self.failure == null) {
    return null;
  }

  return $NetworkExceptionsCopyWith<$Res>(_self.failure!, (value) {
    return _then(_self.copyWith(failure: value));
  });
}
}


/// Adds pattern-matching-related methods to [AuthState].
extension AuthStatePatterns on AuthState {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AuthState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AuthState() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AuthState value)  $default,){
final _that = this;
switch (_that) {
case _AuthState():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AuthState value)?  $default,){
final _that = this;
switch (_that) {
case _AuthState() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( AuthLayer layer,  AccountType accountType,  AuthAction action,  bool isLoading,  bool isLoadingInsurances,  List<ClinicInsuranceModel> insurances,  Set<int> selectedInsuranceIds,  ClinicLoginModel? login,  ClinicModel? registeredClinic,  ClinicOtpStatusModel? otpStatus,  ClinicOtpVerificationModel? otpVerification,  ClinicPasswordResetModel? passwordReset,  AuthLayer otpOrigin,  String otpDestination,  String? resetToken,  String? message,  NetworkExceptions? failure)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AuthState() when $default != null:
return $default(_that.layer,_that.accountType,_that.action,_that.isLoading,_that.isLoadingInsurances,_that.insurances,_that.selectedInsuranceIds,_that.login,_that.registeredClinic,_that.otpStatus,_that.otpVerification,_that.passwordReset,_that.otpOrigin,_that.otpDestination,_that.resetToken,_that.message,_that.failure);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( AuthLayer layer,  AccountType accountType,  AuthAction action,  bool isLoading,  bool isLoadingInsurances,  List<ClinicInsuranceModel> insurances,  Set<int> selectedInsuranceIds,  ClinicLoginModel? login,  ClinicModel? registeredClinic,  ClinicOtpStatusModel? otpStatus,  ClinicOtpVerificationModel? otpVerification,  ClinicPasswordResetModel? passwordReset,  AuthLayer otpOrigin,  String otpDestination,  String? resetToken,  String? message,  NetworkExceptions? failure)  $default,) {final _that = this;
switch (_that) {
case _AuthState():
return $default(_that.layer,_that.accountType,_that.action,_that.isLoading,_that.isLoadingInsurances,_that.insurances,_that.selectedInsuranceIds,_that.login,_that.registeredClinic,_that.otpStatus,_that.otpVerification,_that.passwordReset,_that.otpOrigin,_that.otpDestination,_that.resetToken,_that.message,_that.failure);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( AuthLayer layer,  AccountType accountType,  AuthAction action,  bool isLoading,  bool isLoadingInsurances,  List<ClinicInsuranceModel> insurances,  Set<int> selectedInsuranceIds,  ClinicLoginModel? login,  ClinicModel? registeredClinic,  ClinicOtpStatusModel? otpStatus,  ClinicOtpVerificationModel? otpVerification,  ClinicPasswordResetModel? passwordReset,  AuthLayer otpOrigin,  String otpDestination,  String? resetToken,  String? message,  NetworkExceptions? failure)?  $default,) {final _that = this;
switch (_that) {
case _AuthState() when $default != null:
return $default(_that.layer,_that.accountType,_that.action,_that.isLoading,_that.isLoadingInsurances,_that.insurances,_that.selectedInsuranceIds,_that.login,_that.registeredClinic,_that.otpStatus,_that.otpVerification,_that.passwordReset,_that.otpOrigin,_that.otpDestination,_that.resetToken,_that.message,_that.failure);case _:
  return null;

}
}

}

/// @nodoc


class _AuthState implements AuthState {
  const _AuthState({this.layer = AuthLayer.login, this.accountType = AccountType.clinic, this.action = AuthAction.none, this.isLoading = false, this.isLoadingInsurances = false, final  List<ClinicInsuranceModel> insurances = const <ClinicInsuranceModel>[], final  Set<int> selectedInsuranceIds = const <int>{}, this.login, this.registeredClinic, this.otpStatus, this.otpVerification, this.passwordReset, this.otpOrigin = AuthLayer.forgot, this.otpDestination = '', this.resetToken, this.message, this.failure}): _insurances = insurances,_selectedInsuranceIds = selectedInsuranceIds;
  

@override@JsonKey() final  AuthLayer layer;
@override@JsonKey() final  AccountType accountType;
@override@JsonKey() final  AuthAction action;
@override@JsonKey() final  bool isLoading;
@override@JsonKey() final  bool isLoadingInsurances;
 final  List<ClinicInsuranceModel> _insurances;
@override@JsonKey() List<ClinicInsuranceModel> get insurances {
  if (_insurances is EqualUnmodifiableListView) return _insurances;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_insurances);
}

 final  Set<int> _selectedInsuranceIds;
@override@JsonKey() Set<int> get selectedInsuranceIds {
  if (_selectedInsuranceIds is EqualUnmodifiableSetView) return _selectedInsuranceIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableSetView(_selectedInsuranceIds);
}

@override final  ClinicLoginModel? login;
@override final  ClinicModel? registeredClinic;
@override final  ClinicOtpStatusModel? otpStatus;
@override final  ClinicOtpVerificationModel? otpVerification;
@override final  ClinicPasswordResetModel? passwordReset;
@override@JsonKey() final  AuthLayer otpOrigin;
@override@JsonKey() final  String otpDestination;
@override final  String? resetToken;
@override final  String? message;
@override final  NetworkExceptions? failure;

/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AuthStateCopyWith<_AuthState> get copyWith => __$AuthStateCopyWithImpl<_AuthState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AuthState&&(identical(other.layer, layer) || other.layer == layer)&&(identical(other.accountType, accountType) || other.accountType == accountType)&&(identical(other.action, action) || other.action == action)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isLoadingInsurances, isLoadingInsurances) || other.isLoadingInsurances == isLoadingInsurances)&&const DeepCollectionEquality().equals(other._insurances, _insurances)&&const DeepCollectionEquality().equals(other._selectedInsuranceIds, _selectedInsuranceIds)&&(identical(other.login, login) || other.login == login)&&(identical(other.registeredClinic, registeredClinic) || other.registeredClinic == registeredClinic)&&(identical(other.otpStatus, otpStatus) || other.otpStatus == otpStatus)&&(identical(other.otpVerification, otpVerification) || other.otpVerification == otpVerification)&&(identical(other.passwordReset, passwordReset) || other.passwordReset == passwordReset)&&(identical(other.otpOrigin, otpOrigin) || other.otpOrigin == otpOrigin)&&(identical(other.otpDestination, otpDestination) || other.otpDestination == otpDestination)&&(identical(other.resetToken, resetToken) || other.resetToken == resetToken)&&(identical(other.message, message) || other.message == message)&&(identical(other.failure, failure) || other.failure == failure));
}


@override
int get hashCode => Object.hash(runtimeType,layer,accountType,action,isLoading,isLoadingInsurances,const DeepCollectionEquality().hash(_insurances),const DeepCollectionEquality().hash(_selectedInsuranceIds),login,registeredClinic,otpStatus,otpVerification,passwordReset,otpOrigin,otpDestination,resetToken,message,failure);

@override
String toString() {
  return 'AuthState(layer: $layer, accountType: $accountType, action: $action, isLoading: $isLoading, isLoadingInsurances: $isLoadingInsurances, insurances: $insurances, selectedInsuranceIds: $selectedInsuranceIds, login: $login, registeredClinic: $registeredClinic, otpStatus: $otpStatus, otpVerification: $otpVerification, passwordReset: $passwordReset, otpOrigin: $otpOrigin, otpDestination: $otpDestination, resetToken: $resetToken, message: $message, failure: $failure)';
}


}

/// @nodoc
abstract mixin class _$AuthStateCopyWith<$Res> implements $AuthStateCopyWith<$Res> {
  factory _$AuthStateCopyWith(_AuthState value, $Res Function(_AuthState) _then) = __$AuthStateCopyWithImpl;
@override @useResult
$Res call({
 AuthLayer layer, AccountType accountType, AuthAction action, bool isLoading, bool isLoadingInsurances, List<ClinicInsuranceModel> insurances, Set<int> selectedInsuranceIds, ClinicLoginModel? login, ClinicModel? registeredClinic, ClinicOtpStatusModel? otpStatus, ClinicOtpVerificationModel? otpVerification, ClinicPasswordResetModel? passwordReset, AuthLayer otpOrigin, String otpDestination, String? resetToken, String? message, NetworkExceptions? failure
});


@override $ClinicLoginModelCopyWith<$Res>? get login;@override $ClinicModelCopyWith<$Res>? get registeredClinic;@override $ClinicOtpStatusModelCopyWith<$Res>? get otpStatus;@override $ClinicOtpVerificationModelCopyWith<$Res>? get otpVerification;@override $ClinicPasswordResetModelCopyWith<$Res>? get passwordReset;@override $NetworkExceptionsCopyWith<$Res>? get failure;

}
/// @nodoc
class __$AuthStateCopyWithImpl<$Res>
    implements _$AuthStateCopyWith<$Res> {
  __$AuthStateCopyWithImpl(this._self, this._then);

  final _AuthState _self;
  final $Res Function(_AuthState) _then;

/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? layer = null,Object? accountType = null,Object? action = null,Object? isLoading = null,Object? isLoadingInsurances = null,Object? insurances = null,Object? selectedInsuranceIds = null,Object? login = freezed,Object? registeredClinic = freezed,Object? otpStatus = freezed,Object? otpVerification = freezed,Object? passwordReset = freezed,Object? otpOrigin = null,Object? otpDestination = null,Object? resetToken = freezed,Object? message = freezed,Object? failure = freezed,}) {
  return _then(_AuthState(
layer: null == layer ? _self.layer : layer // ignore: cast_nullable_to_non_nullable
as AuthLayer,accountType: null == accountType ? _self.accountType : accountType // ignore: cast_nullable_to_non_nullable
as AccountType,action: null == action ? _self.action : action // ignore: cast_nullable_to_non_nullable
as AuthAction,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isLoadingInsurances: null == isLoadingInsurances ? _self.isLoadingInsurances : isLoadingInsurances // ignore: cast_nullable_to_non_nullable
as bool,insurances: null == insurances ? _self._insurances : insurances // ignore: cast_nullable_to_non_nullable
as List<ClinicInsuranceModel>,selectedInsuranceIds: null == selectedInsuranceIds ? _self._selectedInsuranceIds : selectedInsuranceIds // ignore: cast_nullable_to_non_nullable
as Set<int>,login: freezed == login ? _self.login : login // ignore: cast_nullable_to_non_nullable
as ClinicLoginModel?,registeredClinic: freezed == registeredClinic ? _self.registeredClinic : registeredClinic // ignore: cast_nullable_to_non_nullable
as ClinicModel?,otpStatus: freezed == otpStatus ? _self.otpStatus : otpStatus // ignore: cast_nullable_to_non_nullable
as ClinicOtpStatusModel?,otpVerification: freezed == otpVerification ? _self.otpVerification : otpVerification // ignore: cast_nullable_to_non_nullable
as ClinicOtpVerificationModel?,passwordReset: freezed == passwordReset ? _self.passwordReset : passwordReset // ignore: cast_nullable_to_non_nullable
as ClinicPasswordResetModel?,otpOrigin: null == otpOrigin ? _self.otpOrigin : otpOrigin // ignore: cast_nullable_to_non_nullable
as AuthLayer,otpDestination: null == otpDestination ? _self.otpDestination : otpDestination // ignore: cast_nullable_to_non_nullable
as String,resetToken: freezed == resetToken ? _self.resetToken : resetToken // ignore: cast_nullable_to_non_nullable
as String?,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as NetworkExceptions?,
  ));
}

/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ClinicLoginModelCopyWith<$Res>? get login {
    if (_self.login == null) {
    return null;
  }

  return $ClinicLoginModelCopyWith<$Res>(_self.login!, (value) {
    return _then(_self.copyWith(login: value));
  });
}/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ClinicModelCopyWith<$Res>? get registeredClinic {
    if (_self.registeredClinic == null) {
    return null;
  }

  return $ClinicModelCopyWith<$Res>(_self.registeredClinic!, (value) {
    return _then(_self.copyWith(registeredClinic: value));
  });
}/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ClinicOtpStatusModelCopyWith<$Res>? get otpStatus {
    if (_self.otpStatus == null) {
    return null;
  }

  return $ClinicOtpStatusModelCopyWith<$Res>(_self.otpStatus!, (value) {
    return _then(_self.copyWith(otpStatus: value));
  });
}/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ClinicOtpVerificationModelCopyWith<$Res>? get otpVerification {
    if (_self.otpVerification == null) {
    return null;
  }

  return $ClinicOtpVerificationModelCopyWith<$Res>(_self.otpVerification!, (value) {
    return _then(_self.copyWith(otpVerification: value));
  });
}/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ClinicPasswordResetModelCopyWith<$Res>? get passwordReset {
    if (_self.passwordReset == null) {
    return null;
  }

  return $ClinicPasswordResetModelCopyWith<$Res>(_self.passwordReset!, (value) {
    return _then(_self.copyWith(passwordReset: value));
  });
}/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$NetworkExceptionsCopyWith<$Res>? get failure {
    if (_self.failure == null) {
    return null;
  }

  return $NetworkExceptionsCopyWith<$Res>(_self.failure!, (value) {
    return _then(_self.copyWith(failure: value));
  });
}
}

// dart format on
