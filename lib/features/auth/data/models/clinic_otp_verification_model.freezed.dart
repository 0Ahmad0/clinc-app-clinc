// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'clinic_otp_verification_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ClinicOtpVerificationModel {

@JsonKey(name: 'reset_token') String? get resetToken;@JsonKey(name: 'expires_in') int? get expiresIn;
/// Create a copy of ClinicOtpVerificationModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ClinicOtpVerificationModelCopyWith<ClinicOtpVerificationModel> get copyWith => _$ClinicOtpVerificationModelCopyWithImpl<ClinicOtpVerificationModel>(this as ClinicOtpVerificationModel, _$identity);

  /// Serializes this ClinicOtpVerificationModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ClinicOtpVerificationModel&&(identical(other.resetToken, resetToken) || other.resetToken == resetToken)&&(identical(other.expiresIn, expiresIn) || other.expiresIn == expiresIn));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,resetToken,expiresIn);

@override
String toString() {
  return 'ClinicOtpVerificationModel(resetToken: $resetToken, expiresIn: $expiresIn)';
}


}

/// @nodoc
abstract mixin class $ClinicOtpVerificationModelCopyWith<$Res>  {
  factory $ClinicOtpVerificationModelCopyWith(ClinicOtpVerificationModel value, $Res Function(ClinicOtpVerificationModel) _then) = _$ClinicOtpVerificationModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'reset_token') String? resetToken,@JsonKey(name: 'expires_in') int? expiresIn
});




}
/// @nodoc
class _$ClinicOtpVerificationModelCopyWithImpl<$Res>
    implements $ClinicOtpVerificationModelCopyWith<$Res> {
  _$ClinicOtpVerificationModelCopyWithImpl(this._self, this._then);

  final ClinicOtpVerificationModel _self;
  final $Res Function(ClinicOtpVerificationModel) _then;

/// Create a copy of ClinicOtpVerificationModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? resetToken = freezed,Object? expiresIn = freezed,}) {
  return _then(_self.copyWith(
resetToken: freezed == resetToken ? _self.resetToken : resetToken // ignore: cast_nullable_to_non_nullable
as String?,expiresIn: freezed == expiresIn ? _self.expiresIn : expiresIn // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [ClinicOtpVerificationModel].
extension ClinicOtpVerificationModelPatterns on ClinicOtpVerificationModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ClinicOtpVerificationModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ClinicOtpVerificationModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ClinicOtpVerificationModel value)  $default,){
final _that = this;
switch (_that) {
case _ClinicOtpVerificationModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ClinicOtpVerificationModel value)?  $default,){
final _that = this;
switch (_that) {
case _ClinicOtpVerificationModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'reset_token')  String? resetToken, @JsonKey(name: 'expires_in')  int? expiresIn)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ClinicOtpVerificationModel() when $default != null:
return $default(_that.resetToken,_that.expiresIn);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'reset_token')  String? resetToken, @JsonKey(name: 'expires_in')  int? expiresIn)  $default,) {final _that = this;
switch (_that) {
case _ClinicOtpVerificationModel():
return $default(_that.resetToken,_that.expiresIn);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'reset_token')  String? resetToken, @JsonKey(name: 'expires_in')  int? expiresIn)?  $default,) {final _that = this;
switch (_that) {
case _ClinicOtpVerificationModel() when $default != null:
return $default(_that.resetToken,_that.expiresIn);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ClinicOtpVerificationModel implements ClinicOtpVerificationModel {
  const _ClinicOtpVerificationModel({@JsonKey(name: 'reset_token') this.resetToken, @JsonKey(name: 'expires_in') this.expiresIn});
  factory _ClinicOtpVerificationModel.fromJson(Map<String, dynamic> json) => _$ClinicOtpVerificationModelFromJson(json);

@override@JsonKey(name: 'reset_token') final  String? resetToken;
@override@JsonKey(name: 'expires_in') final  int? expiresIn;

/// Create a copy of ClinicOtpVerificationModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ClinicOtpVerificationModelCopyWith<_ClinicOtpVerificationModel> get copyWith => __$ClinicOtpVerificationModelCopyWithImpl<_ClinicOtpVerificationModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ClinicOtpVerificationModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ClinicOtpVerificationModel&&(identical(other.resetToken, resetToken) || other.resetToken == resetToken)&&(identical(other.expiresIn, expiresIn) || other.expiresIn == expiresIn));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,resetToken,expiresIn);

@override
String toString() {
  return 'ClinicOtpVerificationModel(resetToken: $resetToken, expiresIn: $expiresIn)';
}


}

/// @nodoc
abstract mixin class _$ClinicOtpVerificationModelCopyWith<$Res> implements $ClinicOtpVerificationModelCopyWith<$Res> {
  factory _$ClinicOtpVerificationModelCopyWith(_ClinicOtpVerificationModel value, $Res Function(_ClinicOtpVerificationModel) _then) = __$ClinicOtpVerificationModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'reset_token') String? resetToken,@JsonKey(name: 'expires_in') int? expiresIn
});




}
/// @nodoc
class __$ClinicOtpVerificationModelCopyWithImpl<$Res>
    implements _$ClinicOtpVerificationModelCopyWith<$Res> {
  __$ClinicOtpVerificationModelCopyWithImpl(this._self, this._then);

  final _ClinicOtpVerificationModel _self;
  final $Res Function(_ClinicOtpVerificationModel) _then;

/// Create a copy of ClinicOtpVerificationModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? resetToken = freezed,Object? expiresIn = freezed,}) {
  return _then(_ClinicOtpVerificationModel(
resetToken: freezed == resetToken ? _self.resetToken : resetToken // ignore: cast_nullable_to_non_nullable
as String?,expiresIn: freezed == expiresIn ? _self.expiresIn : expiresIn // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

// dart format on
