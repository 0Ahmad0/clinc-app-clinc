// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'clinic_password_reset_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ClinicPasswordResetModel {

 bool get reset;
/// Create a copy of ClinicPasswordResetModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ClinicPasswordResetModelCopyWith<ClinicPasswordResetModel> get copyWith => _$ClinicPasswordResetModelCopyWithImpl<ClinicPasswordResetModel>(this as ClinicPasswordResetModel, _$identity);

  /// Serializes this ClinicPasswordResetModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ClinicPasswordResetModel&&(identical(other.reset, reset) || other.reset == reset));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,reset);

@override
String toString() {
  return 'ClinicPasswordResetModel(reset: $reset)';
}


}

/// @nodoc
abstract mixin class $ClinicPasswordResetModelCopyWith<$Res>  {
  factory $ClinicPasswordResetModelCopyWith(ClinicPasswordResetModel value, $Res Function(ClinicPasswordResetModel) _then) = _$ClinicPasswordResetModelCopyWithImpl;
@useResult
$Res call({
 bool reset
});




}
/// @nodoc
class _$ClinicPasswordResetModelCopyWithImpl<$Res>
    implements $ClinicPasswordResetModelCopyWith<$Res> {
  _$ClinicPasswordResetModelCopyWithImpl(this._self, this._then);

  final ClinicPasswordResetModel _self;
  final $Res Function(ClinicPasswordResetModel) _then;

/// Create a copy of ClinicPasswordResetModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? reset = null,}) {
  return _then(_self.copyWith(
reset: null == reset ? _self.reset : reset // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [ClinicPasswordResetModel].
extension ClinicPasswordResetModelPatterns on ClinicPasswordResetModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ClinicPasswordResetModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ClinicPasswordResetModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ClinicPasswordResetModel value)  $default,){
final _that = this;
switch (_that) {
case _ClinicPasswordResetModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ClinicPasswordResetModel value)?  $default,){
final _that = this;
switch (_that) {
case _ClinicPasswordResetModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool reset)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ClinicPasswordResetModel() when $default != null:
return $default(_that.reset);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool reset)  $default,) {final _that = this;
switch (_that) {
case _ClinicPasswordResetModel():
return $default(_that.reset);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool reset)?  $default,) {final _that = this;
switch (_that) {
case _ClinicPasswordResetModel() when $default != null:
return $default(_that.reset);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ClinicPasswordResetModel implements ClinicPasswordResetModel {
  const _ClinicPasswordResetModel({this.reset = false});
  factory _ClinicPasswordResetModel.fromJson(Map<String, dynamic> json) => _$ClinicPasswordResetModelFromJson(json);

@override@JsonKey() final  bool reset;

/// Create a copy of ClinicPasswordResetModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ClinicPasswordResetModelCopyWith<_ClinicPasswordResetModel> get copyWith => __$ClinicPasswordResetModelCopyWithImpl<_ClinicPasswordResetModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ClinicPasswordResetModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ClinicPasswordResetModel&&(identical(other.reset, reset) || other.reset == reset));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,reset);

@override
String toString() {
  return 'ClinicPasswordResetModel(reset: $reset)';
}


}

/// @nodoc
abstract mixin class _$ClinicPasswordResetModelCopyWith<$Res> implements $ClinicPasswordResetModelCopyWith<$Res> {
  factory _$ClinicPasswordResetModelCopyWith(_ClinicPasswordResetModel value, $Res Function(_ClinicPasswordResetModel) _then) = __$ClinicPasswordResetModelCopyWithImpl;
@override @useResult
$Res call({
 bool reset
});




}
/// @nodoc
class __$ClinicPasswordResetModelCopyWithImpl<$Res>
    implements _$ClinicPasswordResetModelCopyWith<$Res> {
  __$ClinicPasswordResetModelCopyWithImpl(this._self, this._then);

  final _ClinicPasswordResetModel _self;
  final $Res Function(_ClinicPasswordResetModel) _then;

/// Create a copy of ClinicPasswordResetModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? reset = null,}) {
  return _then(_ClinicPasswordResetModel(
reset: null == reset ? _self.reset : reset // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
