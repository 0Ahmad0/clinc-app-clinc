// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'clinic_otp_status_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ClinicOtpStatusModel {

 String? get identifier; String? get purpose;@JsonKey(name: 'expires_in') int? get expiresIn;
/// Create a copy of ClinicOtpStatusModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ClinicOtpStatusModelCopyWith<ClinicOtpStatusModel> get copyWith => _$ClinicOtpStatusModelCopyWithImpl<ClinicOtpStatusModel>(this as ClinicOtpStatusModel, _$identity);

  /// Serializes this ClinicOtpStatusModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ClinicOtpStatusModel&&(identical(other.identifier, identifier) || other.identifier == identifier)&&(identical(other.purpose, purpose) || other.purpose == purpose)&&(identical(other.expiresIn, expiresIn) || other.expiresIn == expiresIn));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,identifier,purpose,expiresIn);

@override
String toString() {
  return 'ClinicOtpStatusModel(identifier: $identifier, purpose: $purpose, expiresIn: $expiresIn)';
}


}

/// @nodoc
abstract mixin class $ClinicOtpStatusModelCopyWith<$Res>  {
  factory $ClinicOtpStatusModelCopyWith(ClinicOtpStatusModel value, $Res Function(ClinicOtpStatusModel) _then) = _$ClinicOtpStatusModelCopyWithImpl;
@useResult
$Res call({
 String? identifier, String? purpose,@JsonKey(name: 'expires_in') int? expiresIn
});




}
/// @nodoc
class _$ClinicOtpStatusModelCopyWithImpl<$Res>
    implements $ClinicOtpStatusModelCopyWith<$Res> {
  _$ClinicOtpStatusModelCopyWithImpl(this._self, this._then);

  final ClinicOtpStatusModel _self;
  final $Res Function(ClinicOtpStatusModel) _then;

/// Create a copy of ClinicOtpStatusModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? identifier = freezed,Object? purpose = freezed,Object? expiresIn = freezed,}) {
  return _then(_self.copyWith(
identifier: freezed == identifier ? _self.identifier : identifier // ignore: cast_nullable_to_non_nullable
as String?,purpose: freezed == purpose ? _self.purpose : purpose // ignore: cast_nullable_to_non_nullable
as String?,expiresIn: freezed == expiresIn ? _self.expiresIn : expiresIn // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [ClinicOtpStatusModel].
extension ClinicOtpStatusModelPatterns on ClinicOtpStatusModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ClinicOtpStatusModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ClinicOtpStatusModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ClinicOtpStatusModel value)  $default,){
final _that = this;
switch (_that) {
case _ClinicOtpStatusModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ClinicOtpStatusModel value)?  $default,){
final _that = this;
switch (_that) {
case _ClinicOtpStatusModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? identifier,  String? purpose, @JsonKey(name: 'expires_in')  int? expiresIn)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ClinicOtpStatusModel() when $default != null:
return $default(_that.identifier,_that.purpose,_that.expiresIn);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? identifier,  String? purpose, @JsonKey(name: 'expires_in')  int? expiresIn)  $default,) {final _that = this;
switch (_that) {
case _ClinicOtpStatusModel():
return $default(_that.identifier,_that.purpose,_that.expiresIn);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? identifier,  String? purpose, @JsonKey(name: 'expires_in')  int? expiresIn)?  $default,) {final _that = this;
switch (_that) {
case _ClinicOtpStatusModel() when $default != null:
return $default(_that.identifier,_that.purpose,_that.expiresIn);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ClinicOtpStatusModel implements ClinicOtpStatusModel {
  const _ClinicOtpStatusModel({this.identifier, this.purpose, @JsonKey(name: 'expires_in') this.expiresIn});
  factory _ClinicOtpStatusModel.fromJson(Map<String, dynamic> json) => _$ClinicOtpStatusModelFromJson(json);

@override final  String? identifier;
@override final  String? purpose;
@override@JsonKey(name: 'expires_in') final  int? expiresIn;

/// Create a copy of ClinicOtpStatusModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ClinicOtpStatusModelCopyWith<_ClinicOtpStatusModel> get copyWith => __$ClinicOtpStatusModelCopyWithImpl<_ClinicOtpStatusModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ClinicOtpStatusModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ClinicOtpStatusModel&&(identical(other.identifier, identifier) || other.identifier == identifier)&&(identical(other.purpose, purpose) || other.purpose == purpose)&&(identical(other.expiresIn, expiresIn) || other.expiresIn == expiresIn));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,identifier,purpose,expiresIn);

@override
String toString() {
  return 'ClinicOtpStatusModel(identifier: $identifier, purpose: $purpose, expiresIn: $expiresIn)';
}


}

/// @nodoc
abstract mixin class _$ClinicOtpStatusModelCopyWith<$Res> implements $ClinicOtpStatusModelCopyWith<$Res> {
  factory _$ClinicOtpStatusModelCopyWith(_ClinicOtpStatusModel value, $Res Function(_ClinicOtpStatusModel) _then) = __$ClinicOtpStatusModelCopyWithImpl;
@override @useResult
$Res call({
 String? identifier, String? purpose,@JsonKey(name: 'expires_in') int? expiresIn
});




}
/// @nodoc
class __$ClinicOtpStatusModelCopyWithImpl<$Res>
    implements _$ClinicOtpStatusModelCopyWith<$Res> {
  __$ClinicOtpStatusModelCopyWithImpl(this._self, this._then);

  final _ClinicOtpStatusModel _self;
  final $Res Function(_ClinicOtpStatusModel) _then;

/// Create a copy of ClinicOtpStatusModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? identifier = freezed,Object? purpose = freezed,Object? expiresIn = freezed,}) {
  return _then(_ClinicOtpStatusModel(
identifier: freezed == identifier ? _self.identifier : identifier // ignore: cast_nullable_to_non_nullable
as String?,purpose: freezed == purpose ? _self.purpose : purpose // ignore: cast_nullable_to_non_nullable
as String?,expiresIn: freezed == expiresIn ? _self.expiresIn : expiresIn // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

// dart format on
