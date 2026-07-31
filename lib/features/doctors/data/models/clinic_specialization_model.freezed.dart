// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'clinic_specialization_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ClinicSpecializationModel {

@JsonKey(name: 'specialization_id', fromJson: _stringFromJson) String? get specializationId; String? get name;@JsonKey(name: 'name_ar') String? get nameAr;@JsonKey(name: 'name_en') String? get nameEn; String? get icon; String? get color;@JsonKey(name: 'is_active') bool get isActive;
/// Create a copy of ClinicSpecializationModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ClinicSpecializationModelCopyWith<ClinicSpecializationModel> get copyWith => _$ClinicSpecializationModelCopyWithImpl<ClinicSpecializationModel>(this as ClinicSpecializationModel, _$identity);

  /// Serializes this ClinicSpecializationModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ClinicSpecializationModel&&(identical(other.specializationId, specializationId) || other.specializationId == specializationId)&&(identical(other.name, name) || other.name == name)&&(identical(other.nameAr, nameAr) || other.nameAr == nameAr)&&(identical(other.nameEn, nameEn) || other.nameEn == nameEn)&&(identical(other.icon, icon) || other.icon == icon)&&(identical(other.color, color) || other.color == color)&&(identical(other.isActive, isActive) || other.isActive == isActive));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,specializationId,name,nameAr,nameEn,icon,color,isActive);

@override
String toString() {
  return 'ClinicSpecializationModel(specializationId: $specializationId, name: $name, nameAr: $nameAr, nameEn: $nameEn, icon: $icon, color: $color, isActive: $isActive)';
}


}

/// @nodoc
abstract mixin class $ClinicSpecializationModelCopyWith<$Res>  {
  factory $ClinicSpecializationModelCopyWith(ClinicSpecializationModel value, $Res Function(ClinicSpecializationModel) _then) = _$ClinicSpecializationModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'specialization_id', fromJson: _stringFromJson) String? specializationId, String? name,@JsonKey(name: 'name_ar') String? nameAr,@JsonKey(name: 'name_en') String? nameEn, String? icon, String? color,@JsonKey(name: 'is_active') bool isActive
});




}
/// @nodoc
class _$ClinicSpecializationModelCopyWithImpl<$Res>
    implements $ClinicSpecializationModelCopyWith<$Res> {
  _$ClinicSpecializationModelCopyWithImpl(this._self, this._then);

  final ClinicSpecializationModel _self;
  final $Res Function(ClinicSpecializationModel) _then;

/// Create a copy of ClinicSpecializationModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? specializationId = freezed,Object? name = freezed,Object? nameAr = freezed,Object? nameEn = freezed,Object? icon = freezed,Object? color = freezed,Object? isActive = null,}) {
  return _then(_self.copyWith(
specializationId: freezed == specializationId ? _self.specializationId : specializationId // ignore: cast_nullable_to_non_nullable
as String?,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,nameAr: freezed == nameAr ? _self.nameAr : nameAr // ignore: cast_nullable_to_non_nullable
as String?,nameEn: freezed == nameEn ? _self.nameEn : nameEn // ignore: cast_nullable_to_non_nullable
as String?,icon: freezed == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as String?,color: freezed == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as String?,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [ClinicSpecializationModel].
extension ClinicSpecializationModelPatterns on ClinicSpecializationModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ClinicSpecializationModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ClinicSpecializationModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ClinicSpecializationModel value)  $default,){
final _that = this;
switch (_that) {
case _ClinicSpecializationModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ClinicSpecializationModel value)?  $default,){
final _that = this;
switch (_that) {
case _ClinicSpecializationModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'specialization_id', fromJson: _stringFromJson)  String? specializationId,  String? name, @JsonKey(name: 'name_ar')  String? nameAr, @JsonKey(name: 'name_en')  String? nameEn,  String? icon,  String? color, @JsonKey(name: 'is_active')  bool isActive)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ClinicSpecializationModel() when $default != null:
return $default(_that.specializationId,_that.name,_that.nameAr,_that.nameEn,_that.icon,_that.color,_that.isActive);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'specialization_id', fromJson: _stringFromJson)  String? specializationId,  String? name, @JsonKey(name: 'name_ar')  String? nameAr, @JsonKey(name: 'name_en')  String? nameEn,  String? icon,  String? color, @JsonKey(name: 'is_active')  bool isActive)  $default,) {final _that = this;
switch (_that) {
case _ClinicSpecializationModel():
return $default(_that.specializationId,_that.name,_that.nameAr,_that.nameEn,_that.icon,_that.color,_that.isActive);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'specialization_id', fromJson: _stringFromJson)  String? specializationId,  String? name, @JsonKey(name: 'name_ar')  String? nameAr, @JsonKey(name: 'name_en')  String? nameEn,  String? icon,  String? color, @JsonKey(name: 'is_active')  bool isActive)?  $default,) {final _that = this;
switch (_that) {
case _ClinicSpecializationModel() when $default != null:
return $default(_that.specializationId,_that.name,_that.nameAr,_that.nameEn,_that.icon,_that.color,_that.isActive);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ClinicSpecializationModel implements ClinicSpecializationModel {
  const _ClinicSpecializationModel({@JsonKey(name: 'specialization_id', fromJson: _stringFromJson) this.specializationId, this.name, @JsonKey(name: 'name_ar') this.nameAr, @JsonKey(name: 'name_en') this.nameEn, this.icon, this.color, @JsonKey(name: 'is_active') this.isActive = false});
  factory _ClinicSpecializationModel.fromJson(Map<String, dynamic> json) => _$ClinicSpecializationModelFromJson(json);

@override@JsonKey(name: 'specialization_id', fromJson: _stringFromJson) final  String? specializationId;
@override final  String? name;
@override@JsonKey(name: 'name_ar') final  String? nameAr;
@override@JsonKey(name: 'name_en') final  String? nameEn;
@override final  String? icon;
@override final  String? color;
@override@JsonKey(name: 'is_active') final  bool isActive;

/// Create a copy of ClinicSpecializationModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ClinicSpecializationModelCopyWith<_ClinicSpecializationModel> get copyWith => __$ClinicSpecializationModelCopyWithImpl<_ClinicSpecializationModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ClinicSpecializationModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ClinicSpecializationModel&&(identical(other.specializationId, specializationId) || other.specializationId == specializationId)&&(identical(other.name, name) || other.name == name)&&(identical(other.nameAr, nameAr) || other.nameAr == nameAr)&&(identical(other.nameEn, nameEn) || other.nameEn == nameEn)&&(identical(other.icon, icon) || other.icon == icon)&&(identical(other.color, color) || other.color == color)&&(identical(other.isActive, isActive) || other.isActive == isActive));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,specializationId,name,nameAr,nameEn,icon,color,isActive);

@override
String toString() {
  return 'ClinicSpecializationModel(specializationId: $specializationId, name: $name, nameAr: $nameAr, nameEn: $nameEn, icon: $icon, color: $color, isActive: $isActive)';
}


}

/// @nodoc
abstract mixin class _$ClinicSpecializationModelCopyWith<$Res> implements $ClinicSpecializationModelCopyWith<$Res> {
  factory _$ClinicSpecializationModelCopyWith(_ClinicSpecializationModel value, $Res Function(_ClinicSpecializationModel) _then) = __$ClinicSpecializationModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'specialization_id', fromJson: _stringFromJson) String? specializationId, String? name,@JsonKey(name: 'name_ar') String? nameAr,@JsonKey(name: 'name_en') String? nameEn, String? icon, String? color,@JsonKey(name: 'is_active') bool isActive
});




}
/// @nodoc
class __$ClinicSpecializationModelCopyWithImpl<$Res>
    implements _$ClinicSpecializationModelCopyWith<$Res> {
  __$ClinicSpecializationModelCopyWithImpl(this._self, this._then);

  final _ClinicSpecializationModel _self;
  final $Res Function(_ClinicSpecializationModel) _then;

/// Create a copy of ClinicSpecializationModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? specializationId = freezed,Object? name = freezed,Object? nameAr = freezed,Object? nameEn = freezed,Object? icon = freezed,Object? color = freezed,Object? isActive = null,}) {
  return _then(_ClinicSpecializationModel(
specializationId: freezed == specializationId ? _self.specializationId : specializationId // ignore: cast_nullable_to_non_nullable
as String?,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,nameAr: freezed == nameAr ? _self.nameAr : nameAr // ignore: cast_nullable_to_non_nullable
as String?,nameEn: freezed == nameEn ? _self.nameEn : nameEn // ignore: cast_nullable_to_non_nullable
as String?,icon: freezed == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as String?,color: freezed == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as String?,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
