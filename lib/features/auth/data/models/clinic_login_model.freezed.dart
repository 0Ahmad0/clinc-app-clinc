// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'clinic_login_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ClinicLoginModel {

 ClinicModel? get clinic; String? get token;@JsonKey(name: 'token_type') String? get tokenType;@JsonKey(name: 'expires_at') String? get expiresAt;@JsonKey(name: 'needs_completion') bool get needsCompletion;@JsonKey(name: 'missing_fields') List<String> get missingFields;
/// Create a copy of ClinicLoginModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ClinicLoginModelCopyWith<ClinicLoginModel> get copyWith => _$ClinicLoginModelCopyWithImpl<ClinicLoginModel>(this as ClinicLoginModel, _$identity);

  /// Serializes this ClinicLoginModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ClinicLoginModel&&(identical(other.clinic, clinic) || other.clinic == clinic)&&(identical(other.token, token) || other.token == token)&&(identical(other.tokenType, tokenType) || other.tokenType == tokenType)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt)&&(identical(other.needsCompletion, needsCompletion) || other.needsCompletion == needsCompletion)&&const DeepCollectionEquality().equals(other.missingFields, missingFields));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,clinic,token,tokenType,expiresAt,needsCompletion,const DeepCollectionEquality().hash(missingFields));

@override
String toString() {
  return 'ClinicLoginModel(clinic: $clinic, token: $token, tokenType: $tokenType, expiresAt: $expiresAt, needsCompletion: $needsCompletion, missingFields: $missingFields)';
}


}

/// @nodoc
abstract mixin class $ClinicLoginModelCopyWith<$Res>  {
  factory $ClinicLoginModelCopyWith(ClinicLoginModel value, $Res Function(ClinicLoginModel) _then) = _$ClinicLoginModelCopyWithImpl;
@useResult
$Res call({
 ClinicModel? clinic, String? token,@JsonKey(name: 'token_type') String? tokenType,@JsonKey(name: 'expires_at') String? expiresAt,@JsonKey(name: 'needs_completion') bool needsCompletion,@JsonKey(name: 'missing_fields') List<String> missingFields
});


$ClinicModelCopyWith<$Res>? get clinic;

}
/// @nodoc
class _$ClinicLoginModelCopyWithImpl<$Res>
    implements $ClinicLoginModelCopyWith<$Res> {
  _$ClinicLoginModelCopyWithImpl(this._self, this._then);

  final ClinicLoginModel _self;
  final $Res Function(ClinicLoginModel) _then;

/// Create a copy of ClinicLoginModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? clinic = freezed,Object? token = freezed,Object? tokenType = freezed,Object? expiresAt = freezed,Object? needsCompletion = null,Object? missingFields = null,}) {
  return _then(_self.copyWith(
clinic: freezed == clinic ? _self.clinic : clinic // ignore: cast_nullable_to_non_nullable
as ClinicModel?,token: freezed == token ? _self.token : token // ignore: cast_nullable_to_non_nullable
as String?,tokenType: freezed == tokenType ? _self.tokenType : tokenType // ignore: cast_nullable_to_non_nullable
as String?,expiresAt: freezed == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as String?,needsCompletion: null == needsCompletion ? _self.needsCompletion : needsCompletion // ignore: cast_nullable_to_non_nullable
as bool,missingFields: null == missingFields ? _self.missingFields : missingFields // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}
/// Create a copy of ClinicLoginModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ClinicModelCopyWith<$Res>? get clinic {
    if (_self.clinic == null) {
    return null;
  }

  return $ClinicModelCopyWith<$Res>(_self.clinic!, (value) {
    return _then(_self.copyWith(clinic: value));
  });
}
}


/// Adds pattern-matching-related methods to [ClinicLoginModel].
extension ClinicLoginModelPatterns on ClinicLoginModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ClinicLoginModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ClinicLoginModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ClinicLoginModel value)  $default,){
final _that = this;
switch (_that) {
case _ClinicLoginModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ClinicLoginModel value)?  $default,){
final _that = this;
switch (_that) {
case _ClinicLoginModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( ClinicModel? clinic,  String? token, @JsonKey(name: 'token_type')  String? tokenType, @JsonKey(name: 'expires_at')  String? expiresAt, @JsonKey(name: 'needs_completion')  bool needsCompletion, @JsonKey(name: 'missing_fields')  List<String> missingFields)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ClinicLoginModel() when $default != null:
return $default(_that.clinic,_that.token,_that.tokenType,_that.expiresAt,_that.needsCompletion,_that.missingFields);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( ClinicModel? clinic,  String? token, @JsonKey(name: 'token_type')  String? tokenType, @JsonKey(name: 'expires_at')  String? expiresAt, @JsonKey(name: 'needs_completion')  bool needsCompletion, @JsonKey(name: 'missing_fields')  List<String> missingFields)  $default,) {final _that = this;
switch (_that) {
case _ClinicLoginModel():
return $default(_that.clinic,_that.token,_that.tokenType,_that.expiresAt,_that.needsCompletion,_that.missingFields);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( ClinicModel? clinic,  String? token, @JsonKey(name: 'token_type')  String? tokenType, @JsonKey(name: 'expires_at')  String? expiresAt, @JsonKey(name: 'needs_completion')  bool needsCompletion, @JsonKey(name: 'missing_fields')  List<String> missingFields)?  $default,) {final _that = this;
switch (_that) {
case _ClinicLoginModel() when $default != null:
return $default(_that.clinic,_that.token,_that.tokenType,_that.expiresAt,_that.needsCompletion,_that.missingFields);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ClinicLoginModel implements ClinicLoginModel {
  const _ClinicLoginModel({this.clinic, this.token, @JsonKey(name: 'token_type') this.tokenType, @JsonKey(name: 'expires_at') this.expiresAt, @JsonKey(name: 'needs_completion') this.needsCompletion = false, @JsonKey(name: 'missing_fields') final  List<String> missingFields = const <String>[]}): _missingFields = missingFields;
  factory _ClinicLoginModel.fromJson(Map<String, dynamic> json) => _$ClinicLoginModelFromJson(json);

@override final  ClinicModel? clinic;
@override final  String? token;
@override@JsonKey(name: 'token_type') final  String? tokenType;
@override@JsonKey(name: 'expires_at') final  String? expiresAt;
@override@JsonKey(name: 'needs_completion') final  bool needsCompletion;
 final  List<String> _missingFields;
@override@JsonKey(name: 'missing_fields') List<String> get missingFields {
  if (_missingFields is EqualUnmodifiableListView) return _missingFields;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_missingFields);
}


/// Create a copy of ClinicLoginModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ClinicLoginModelCopyWith<_ClinicLoginModel> get copyWith => __$ClinicLoginModelCopyWithImpl<_ClinicLoginModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ClinicLoginModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ClinicLoginModel&&(identical(other.clinic, clinic) || other.clinic == clinic)&&(identical(other.token, token) || other.token == token)&&(identical(other.tokenType, tokenType) || other.tokenType == tokenType)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt)&&(identical(other.needsCompletion, needsCompletion) || other.needsCompletion == needsCompletion)&&const DeepCollectionEquality().equals(other._missingFields, _missingFields));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,clinic,token,tokenType,expiresAt,needsCompletion,const DeepCollectionEquality().hash(_missingFields));

@override
String toString() {
  return 'ClinicLoginModel(clinic: $clinic, token: $token, tokenType: $tokenType, expiresAt: $expiresAt, needsCompletion: $needsCompletion, missingFields: $missingFields)';
}


}

/// @nodoc
abstract mixin class _$ClinicLoginModelCopyWith<$Res> implements $ClinicLoginModelCopyWith<$Res> {
  factory _$ClinicLoginModelCopyWith(_ClinicLoginModel value, $Res Function(_ClinicLoginModel) _then) = __$ClinicLoginModelCopyWithImpl;
@override @useResult
$Res call({
 ClinicModel? clinic, String? token,@JsonKey(name: 'token_type') String? tokenType,@JsonKey(name: 'expires_at') String? expiresAt,@JsonKey(name: 'needs_completion') bool needsCompletion,@JsonKey(name: 'missing_fields') List<String> missingFields
});


@override $ClinicModelCopyWith<$Res>? get clinic;

}
/// @nodoc
class __$ClinicLoginModelCopyWithImpl<$Res>
    implements _$ClinicLoginModelCopyWith<$Res> {
  __$ClinicLoginModelCopyWithImpl(this._self, this._then);

  final _ClinicLoginModel _self;
  final $Res Function(_ClinicLoginModel) _then;

/// Create a copy of ClinicLoginModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? clinic = freezed,Object? token = freezed,Object? tokenType = freezed,Object? expiresAt = freezed,Object? needsCompletion = null,Object? missingFields = null,}) {
  return _then(_ClinicLoginModel(
clinic: freezed == clinic ? _self.clinic : clinic // ignore: cast_nullable_to_non_nullable
as ClinicModel?,token: freezed == token ? _self.token : token // ignore: cast_nullable_to_non_nullable
as String?,tokenType: freezed == tokenType ? _self.tokenType : tokenType // ignore: cast_nullable_to_non_nullable
as String?,expiresAt: freezed == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as String?,needsCompletion: null == needsCompletion ? _self.needsCompletion : needsCompletion // ignore: cast_nullable_to_non_nullable
as bool,missingFields: null == missingFields ? _self._missingFields : missingFields // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

/// Create a copy of ClinicLoginModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ClinicModelCopyWith<$Res>? get clinic {
    if (_self.clinic == null) {
    return null;
  }

  return $ClinicModelCopyWith<$Res>(_self.clinic!, (value) {
    return _then(_self.copyWith(clinic: value));
  });
}
}

// dart format on
