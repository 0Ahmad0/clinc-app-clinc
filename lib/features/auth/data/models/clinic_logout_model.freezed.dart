// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'clinic_logout_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ClinicLogoutModel {

@JsonKey(name: 'logged_out') bool get loggedOut;
/// Create a copy of ClinicLogoutModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ClinicLogoutModelCopyWith<ClinicLogoutModel> get copyWith => _$ClinicLogoutModelCopyWithImpl<ClinicLogoutModel>(this as ClinicLogoutModel, _$identity);

  /// Serializes this ClinicLogoutModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ClinicLogoutModel&&(identical(other.loggedOut, loggedOut) || other.loggedOut == loggedOut));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,loggedOut);

@override
String toString() {
  return 'ClinicLogoutModel(loggedOut: $loggedOut)';
}


}

/// @nodoc
abstract mixin class $ClinicLogoutModelCopyWith<$Res>  {
  factory $ClinicLogoutModelCopyWith(ClinicLogoutModel value, $Res Function(ClinicLogoutModel) _then) = _$ClinicLogoutModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'logged_out') bool loggedOut
});




}
/// @nodoc
class _$ClinicLogoutModelCopyWithImpl<$Res>
    implements $ClinicLogoutModelCopyWith<$Res> {
  _$ClinicLogoutModelCopyWithImpl(this._self, this._then);

  final ClinicLogoutModel _self;
  final $Res Function(ClinicLogoutModel) _then;

/// Create a copy of ClinicLogoutModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? loggedOut = null,}) {
  return _then(_self.copyWith(
loggedOut: null == loggedOut ? _self.loggedOut : loggedOut // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [ClinicLogoutModel].
extension ClinicLogoutModelPatterns on ClinicLogoutModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ClinicLogoutModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ClinicLogoutModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ClinicLogoutModel value)  $default,){
final _that = this;
switch (_that) {
case _ClinicLogoutModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ClinicLogoutModel value)?  $default,){
final _that = this;
switch (_that) {
case _ClinicLogoutModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'logged_out')  bool loggedOut)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ClinicLogoutModel() when $default != null:
return $default(_that.loggedOut);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'logged_out')  bool loggedOut)  $default,) {final _that = this;
switch (_that) {
case _ClinicLogoutModel():
return $default(_that.loggedOut);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'logged_out')  bool loggedOut)?  $default,) {final _that = this;
switch (_that) {
case _ClinicLogoutModel() when $default != null:
return $default(_that.loggedOut);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ClinicLogoutModel implements ClinicLogoutModel {
  const _ClinicLogoutModel({@JsonKey(name: 'logged_out') this.loggedOut = false});
  factory _ClinicLogoutModel.fromJson(Map<String, dynamic> json) => _$ClinicLogoutModelFromJson(json);

@override@JsonKey(name: 'logged_out') final  bool loggedOut;

/// Create a copy of ClinicLogoutModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ClinicLogoutModelCopyWith<_ClinicLogoutModel> get copyWith => __$ClinicLogoutModelCopyWithImpl<_ClinicLogoutModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ClinicLogoutModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ClinicLogoutModel&&(identical(other.loggedOut, loggedOut) || other.loggedOut == loggedOut));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,loggedOut);

@override
String toString() {
  return 'ClinicLogoutModel(loggedOut: $loggedOut)';
}


}

/// @nodoc
abstract mixin class _$ClinicLogoutModelCopyWith<$Res> implements $ClinicLogoutModelCopyWith<$Res> {
  factory _$ClinicLogoutModelCopyWith(_ClinicLogoutModel value, $Res Function(_ClinicLogoutModel) _then) = __$ClinicLogoutModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'logged_out') bool loggedOut
});




}
/// @nodoc
class __$ClinicLogoutModelCopyWithImpl<$Res>
    implements _$ClinicLogoutModelCopyWith<$Res> {
  __$ClinicLogoutModelCopyWithImpl(this._self, this._then);

  final _ClinicLogoutModel _self;
  final $Res Function(_ClinicLogoutModel) _then;

/// Create a copy of ClinicLogoutModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? loggedOut = null,}) {
  return _then(_ClinicLogoutModel(
loggedOut: null == loggedOut ? _self.loggedOut : loggedOut // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
