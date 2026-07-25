// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'clinic_service_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ClinicLabSectionModel {

@JsonKey(name: 'section_id', fromJson: _intFromJson) int? get sectionId; String? get slug; String? get name;@JsonKey(name: 'name_ar') String? get nameAr;@JsonKey(name: 'name_en') String? get nameEn; String? get description; String? get icon; String? get color;@JsonKey(name: 'is_active', fromJson: _boolFromJson) bool get isActive;
/// Create a copy of ClinicLabSectionModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ClinicLabSectionModelCopyWith<ClinicLabSectionModel> get copyWith => _$ClinicLabSectionModelCopyWithImpl<ClinicLabSectionModel>(this as ClinicLabSectionModel, _$identity);

  /// Serializes this ClinicLabSectionModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ClinicLabSectionModel&&(identical(other.sectionId, sectionId) || other.sectionId == sectionId)&&(identical(other.slug, slug) || other.slug == slug)&&(identical(other.name, name) || other.name == name)&&(identical(other.nameAr, nameAr) || other.nameAr == nameAr)&&(identical(other.nameEn, nameEn) || other.nameEn == nameEn)&&(identical(other.description, description) || other.description == description)&&(identical(other.icon, icon) || other.icon == icon)&&(identical(other.color, color) || other.color == color)&&(identical(other.isActive, isActive) || other.isActive == isActive));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,sectionId,slug,name,nameAr,nameEn,description,icon,color,isActive);

@override
String toString() {
  return 'ClinicLabSectionModel(sectionId: $sectionId, slug: $slug, name: $name, nameAr: $nameAr, nameEn: $nameEn, description: $description, icon: $icon, color: $color, isActive: $isActive)';
}


}

/// @nodoc
abstract mixin class $ClinicLabSectionModelCopyWith<$Res>  {
  factory $ClinicLabSectionModelCopyWith(ClinicLabSectionModel value, $Res Function(ClinicLabSectionModel) _then) = _$ClinicLabSectionModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'section_id', fromJson: _intFromJson) int? sectionId, String? slug, String? name,@JsonKey(name: 'name_ar') String? nameAr,@JsonKey(name: 'name_en') String? nameEn, String? description, String? icon, String? color,@JsonKey(name: 'is_active', fromJson: _boolFromJson) bool isActive
});




}
/// @nodoc
class _$ClinicLabSectionModelCopyWithImpl<$Res>
    implements $ClinicLabSectionModelCopyWith<$Res> {
  _$ClinicLabSectionModelCopyWithImpl(this._self, this._then);

  final ClinicLabSectionModel _self;
  final $Res Function(ClinicLabSectionModel) _then;

/// Create a copy of ClinicLabSectionModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? sectionId = freezed,Object? slug = freezed,Object? name = freezed,Object? nameAr = freezed,Object? nameEn = freezed,Object? description = freezed,Object? icon = freezed,Object? color = freezed,Object? isActive = null,}) {
  return _then(_self.copyWith(
sectionId: freezed == sectionId ? _self.sectionId : sectionId // ignore: cast_nullable_to_non_nullable
as int?,slug: freezed == slug ? _self.slug : slug // ignore: cast_nullable_to_non_nullable
as String?,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,nameAr: freezed == nameAr ? _self.nameAr : nameAr // ignore: cast_nullable_to_non_nullable
as String?,nameEn: freezed == nameEn ? _self.nameEn : nameEn // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,icon: freezed == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as String?,color: freezed == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as String?,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [ClinicLabSectionModel].
extension ClinicLabSectionModelPatterns on ClinicLabSectionModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ClinicLabSectionModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ClinicLabSectionModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ClinicLabSectionModel value)  $default,){
final _that = this;
switch (_that) {
case _ClinicLabSectionModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ClinicLabSectionModel value)?  $default,){
final _that = this;
switch (_that) {
case _ClinicLabSectionModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'section_id', fromJson: _intFromJson)  int? sectionId,  String? slug,  String? name, @JsonKey(name: 'name_ar')  String? nameAr, @JsonKey(name: 'name_en')  String? nameEn,  String? description,  String? icon,  String? color, @JsonKey(name: 'is_active', fromJson: _boolFromJson)  bool isActive)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ClinicLabSectionModel() when $default != null:
return $default(_that.sectionId,_that.slug,_that.name,_that.nameAr,_that.nameEn,_that.description,_that.icon,_that.color,_that.isActive);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'section_id', fromJson: _intFromJson)  int? sectionId,  String? slug,  String? name, @JsonKey(name: 'name_ar')  String? nameAr, @JsonKey(name: 'name_en')  String? nameEn,  String? description,  String? icon,  String? color, @JsonKey(name: 'is_active', fromJson: _boolFromJson)  bool isActive)  $default,) {final _that = this;
switch (_that) {
case _ClinicLabSectionModel():
return $default(_that.sectionId,_that.slug,_that.name,_that.nameAr,_that.nameEn,_that.description,_that.icon,_that.color,_that.isActive);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'section_id', fromJson: _intFromJson)  int? sectionId,  String? slug,  String? name, @JsonKey(name: 'name_ar')  String? nameAr, @JsonKey(name: 'name_en')  String? nameEn,  String? description,  String? icon,  String? color, @JsonKey(name: 'is_active', fromJson: _boolFromJson)  bool isActive)?  $default,) {final _that = this;
switch (_that) {
case _ClinicLabSectionModel() when $default != null:
return $default(_that.sectionId,_that.slug,_that.name,_that.nameAr,_that.nameEn,_that.description,_that.icon,_that.color,_that.isActive);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ClinicLabSectionModel implements ClinicLabSectionModel {
  const _ClinicLabSectionModel({@JsonKey(name: 'section_id', fromJson: _intFromJson) this.sectionId, this.slug, this.name, @JsonKey(name: 'name_ar') this.nameAr, @JsonKey(name: 'name_en') this.nameEn, this.description, this.icon, this.color, @JsonKey(name: 'is_active', fromJson: _boolFromJson) this.isActive = false});
  factory _ClinicLabSectionModel.fromJson(Map<String, dynamic> json) => _$ClinicLabSectionModelFromJson(json);

@override@JsonKey(name: 'section_id', fromJson: _intFromJson) final  int? sectionId;
@override final  String? slug;
@override final  String? name;
@override@JsonKey(name: 'name_ar') final  String? nameAr;
@override@JsonKey(name: 'name_en') final  String? nameEn;
@override final  String? description;
@override final  String? icon;
@override final  String? color;
@override@JsonKey(name: 'is_active', fromJson: _boolFromJson) final  bool isActive;

/// Create a copy of ClinicLabSectionModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ClinicLabSectionModelCopyWith<_ClinicLabSectionModel> get copyWith => __$ClinicLabSectionModelCopyWithImpl<_ClinicLabSectionModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ClinicLabSectionModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ClinicLabSectionModel&&(identical(other.sectionId, sectionId) || other.sectionId == sectionId)&&(identical(other.slug, slug) || other.slug == slug)&&(identical(other.name, name) || other.name == name)&&(identical(other.nameAr, nameAr) || other.nameAr == nameAr)&&(identical(other.nameEn, nameEn) || other.nameEn == nameEn)&&(identical(other.description, description) || other.description == description)&&(identical(other.icon, icon) || other.icon == icon)&&(identical(other.color, color) || other.color == color)&&(identical(other.isActive, isActive) || other.isActive == isActive));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,sectionId,slug,name,nameAr,nameEn,description,icon,color,isActive);

@override
String toString() {
  return 'ClinicLabSectionModel(sectionId: $sectionId, slug: $slug, name: $name, nameAr: $nameAr, nameEn: $nameEn, description: $description, icon: $icon, color: $color, isActive: $isActive)';
}


}

/// @nodoc
abstract mixin class _$ClinicLabSectionModelCopyWith<$Res> implements $ClinicLabSectionModelCopyWith<$Res> {
  factory _$ClinicLabSectionModelCopyWith(_ClinicLabSectionModel value, $Res Function(_ClinicLabSectionModel) _then) = __$ClinicLabSectionModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'section_id', fromJson: _intFromJson) int? sectionId, String? slug, String? name,@JsonKey(name: 'name_ar') String? nameAr,@JsonKey(name: 'name_en') String? nameEn, String? description, String? icon, String? color,@JsonKey(name: 'is_active', fromJson: _boolFromJson) bool isActive
});




}
/// @nodoc
class __$ClinicLabSectionModelCopyWithImpl<$Res>
    implements _$ClinicLabSectionModelCopyWith<$Res> {
  __$ClinicLabSectionModelCopyWithImpl(this._self, this._then);

  final _ClinicLabSectionModel _self;
  final $Res Function(_ClinicLabSectionModel) _then;

/// Create a copy of ClinicLabSectionModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? sectionId = freezed,Object? slug = freezed,Object? name = freezed,Object? nameAr = freezed,Object? nameEn = freezed,Object? description = freezed,Object? icon = freezed,Object? color = freezed,Object? isActive = null,}) {
  return _then(_ClinicLabSectionModel(
sectionId: freezed == sectionId ? _self.sectionId : sectionId // ignore: cast_nullable_to_non_nullable
as int?,slug: freezed == slug ? _self.slug : slug // ignore: cast_nullable_to_non_nullable
as String?,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,nameAr: freezed == nameAr ? _self.nameAr : nameAr // ignore: cast_nullable_to_non_nullable
as String?,nameEn: freezed == nameEn ? _self.nameEn : nameEn // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,icon: freezed == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as String?,color: freezed == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as String?,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$ClinicAvailableLabTestModel {

@JsonKey(name: 'lab_test_id', fromJson: _intFromJson) int? get labTestId; String? get code; String? get name;@JsonKey(name: 'name_ar') String? get nameAr;@JsonKey(name: 'name_en') String? get nameEn; String? get description;@JsonKey(name: 'section_id', fromJson: _intFromJson) int? get sectionId;@JsonKey(name: 'section_slug') String? get sectionSlug;@JsonKey(name: 'section_name') String? get sectionName;@JsonKey(name: 'section_icon') String? get icon;@JsonKey(name: 'section_color') String? get color;@JsonKey(name: 'default_price', fromJson: _numFromJson) num? get defaultPrice;@JsonKey(name: 'is_active', fromJson: _boolFromJson) bool get isActive;
/// Create a copy of ClinicAvailableLabTestModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ClinicAvailableLabTestModelCopyWith<ClinicAvailableLabTestModel> get copyWith => _$ClinicAvailableLabTestModelCopyWithImpl<ClinicAvailableLabTestModel>(this as ClinicAvailableLabTestModel, _$identity);

  /// Serializes this ClinicAvailableLabTestModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ClinicAvailableLabTestModel&&(identical(other.labTestId, labTestId) || other.labTestId == labTestId)&&(identical(other.code, code) || other.code == code)&&(identical(other.name, name) || other.name == name)&&(identical(other.nameAr, nameAr) || other.nameAr == nameAr)&&(identical(other.nameEn, nameEn) || other.nameEn == nameEn)&&(identical(other.description, description) || other.description == description)&&(identical(other.sectionId, sectionId) || other.sectionId == sectionId)&&(identical(other.sectionSlug, sectionSlug) || other.sectionSlug == sectionSlug)&&(identical(other.sectionName, sectionName) || other.sectionName == sectionName)&&(identical(other.icon, icon) || other.icon == icon)&&(identical(other.color, color) || other.color == color)&&(identical(other.defaultPrice, defaultPrice) || other.defaultPrice == defaultPrice)&&(identical(other.isActive, isActive) || other.isActive == isActive));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,labTestId,code,name,nameAr,nameEn,description,sectionId,sectionSlug,sectionName,icon,color,defaultPrice,isActive);

@override
String toString() {
  return 'ClinicAvailableLabTestModel(labTestId: $labTestId, code: $code, name: $name, nameAr: $nameAr, nameEn: $nameEn, description: $description, sectionId: $sectionId, sectionSlug: $sectionSlug, sectionName: $sectionName, icon: $icon, color: $color, defaultPrice: $defaultPrice, isActive: $isActive)';
}


}

/// @nodoc
abstract mixin class $ClinicAvailableLabTestModelCopyWith<$Res>  {
  factory $ClinicAvailableLabTestModelCopyWith(ClinicAvailableLabTestModel value, $Res Function(ClinicAvailableLabTestModel) _then) = _$ClinicAvailableLabTestModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'lab_test_id', fromJson: _intFromJson) int? labTestId, String? code, String? name,@JsonKey(name: 'name_ar') String? nameAr,@JsonKey(name: 'name_en') String? nameEn, String? description,@JsonKey(name: 'section_id', fromJson: _intFromJson) int? sectionId,@JsonKey(name: 'section_slug') String? sectionSlug,@JsonKey(name: 'section_name') String? sectionName,@JsonKey(name: 'section_icon') String? icon,@JsonKey(name: 'section_color') String? color,@JsonKey(name: 'default_price', fromJson: _numFromJson) num? defaultPrice,@JsonKey(name: 'is_active', fromJson: _boolFromJson) bool isActive
});




}
/// @nodoc
class _$ClinicAvailableLabTestModelCopyWithImpl<$Res>
    implements $ClinicAvailableLabTestModelCopyWith<$Res> {
  _$ClinicAvailableLabTestModelCopyWithImpl(this._self, this._then);

  final ClinicAvailableLabTestModel _self;
  final $Res Function(ClinicAvailableLabTestModel) _then;

/// Create a copy of ClinicAvailableLabTestModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? labTestId = freezed,Object? code = freezed,Object? name = freezed,Object? nameAr = freezed,Object? nameEn = freezed,Object? description = freezed,Object? sectionId = freezed,Object? sectionSlug = freezed,Object? sectionName = freezed,Object? icon = freezed,Object? color = freezed,Object? defaultPrice = freezed,Object? isActive = null,}) {
  return _then(_self.copyWith(
labTestId: freezed == labTestId ? _self.labTestId : labTestId // ignore: cast_nullable_to_non_nullable
as int?,code: freezed == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String?,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,nameAr: freezed == nameAr ? _self.nameAr : nameAr // ignore: cast_nullable_to_non_nullable
as String?,nameEn: freezed == nameEn ? _self.nameEn : nameEn // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,sectionId: freezed == sectionId ? _self.sectionId : sectionId // ignore: cast_nullable_to_non_nullable
as int?,sectionSlug: freezed == sectionSlug ? _self.sectionSlug : sectionSlug // ignore: cast_nullable_to_non_nullable
as String?,sectionName: freezed == sectionName ? _self.sectionName : sectionName // ignore: cast_nullable_to_non_nullable
as String?,icon: freezed == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as String?,color: freezed == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as String?,defaultPrice: freezed == defaultPrice ? _self.defaultPrice : defaultPrice // ignore: cast_nullable_to_non_nullable
as num?,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [ClinicAvailableLabTestModel].
extension ClinicAvailableLabTestModelPatterns on ClinicAvailableLabTestModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ClinicAvailableLabTestModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ClinicAvailableLabTestModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ClinicAvailableLabTestModel value)  $default,){
final _that = this;
switch (_that) {
case _ClinicAvailableLabTestModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ClinicAvailableLabTestModel value)?  $default,){
final _that = this;
switch (_that) {
case _ClinicAvailableLabTestModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'lab_test_id', fromJson: _intFromJson)  int? labTestId,  String? code,  String? name, @JsonKey(name: 'name_ar')  String? nameAr, @JsonKey(name: 'name_en')  String? nameEn,  String? description, @JsonKey(name: 'section_id', fromJson: _intFromJson)  int? sectionId, @JsonKey(name: 'section_slug')  String? sectionSlug, @JsonKey(name: 'section_name')  String? sectionName, @JsonKey(name: 'section_icon')  String? icon, @JsonKey(name: 'section_color')  String? color, @JsonKey(name: 'default_price', fromJson: _numFromJson)  num? defaultPrice, @JsonKey(name: 'is_active', fromJson: _boolFromJson)  bool isActive)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ClinicAvailableLabTestModel() when $default != null:
return $default(_that.labTestId,_that.code,_that.name,_that.nameAr,_that.nameEn,_that.description,_that.sectionId,_that.sectionSlug,_that.sectionName,_that.icon,_that.color,_that.defaultPrice,_that.isActive);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'lab_test_id', fromJson: _intFromJson)  int? labTestId,  String? code,  String? name, @JsonKey(name: 'name_ar')  String? nameAr, @JsonKey(name: 'name_en')  String? nameEn,  String? description, @JsonKey(name: 'section_id', fromJson: _intFromJson)  int? sectionId, @JsonKey(name: 'section_slug')  String? sectionSlug, @JsonKey(name: 'section_name')  String? sectionName, @JsonKey(name: 'section_icon')  String? icon, @JsonKey(name: 'section_color')  String? color, @JsonKey(name: 'default_price', fromJson: _numFromJson)  num? defaultPrice, @JsonKey(name: 'is_active', fromJson: _boolFromJson)  bool isActive)  $default,) {final _that = this;
switch (_that) {
case _ClinicAvailableLabTestModel():
return $default(_that.labTestId,_that.code,_that.name,_that.nameAr,_that.nameEn,_that.description,_that.sectionId,_that.sectionSlug,_that.sectionName,_that.icon,_that.color,_that.defaultPrice,_that.isActive);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'lab_test_id', fromJson: _intFromJson)  int? labTestId,  String? code,  String? name, @JsonKey(name: 'name_ar')  String? nameAr, @JsonKey(name: 'name_en')  String? nameEn,  String? description, @JsonKey(name: 'section_id', fromJson: _intFromJson)  int? sectionId, @JsonKey(name: 'section_slug')  String? sectionSlug, @JsonKey(name: 'section_name')  String? sectionName, @JsonKey(name: 'section_icon')  String? icon, @JsonKey(name: 'section_color')  String? color, @JsonKey(name: 'default_price', fromJson: _numFromJson)  num? defaultPrice, @JsonKey(name: 'is_active', fromJson: _boolFromJson)  bool isActive)?  $default,) {final _that = this;
switch (_that) {
case _ClinicAvailableLabTestModel() when $default != null:
return $default(_that.labTestId,_that.code,_that.name,_that.nameAr,_that.nameEn,_that.description,_that.sectionId,_that.sectionSlug,_that.sectionName,_that.icon,_that.color,_that.defaultPrice,_that.isActive);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ClinicAvailableLabTestModel implements ClinicAvailableLabTestModel {
  const _ClinicAvailableLabTestModel({@JsonKey(name: 'lab_test_id', fromJson: _intFromJson) this.labTestId, this.code, this.name, @JsonKey(name: 'name_ar') this.nameAr, @JsonKey(name: 'name_en') this.nameEn, this.description, @JsonKey(name: 'section_id', fromJson: _intFromJson) this.sectionId, @JsonKey(name: 'section_slug') this.sectionSlug, @JsonKey(name: 'section_name') this.sectionName, @JsonKey(name: 'section_icon') this.icon, @JsonKey(name: 'section_color') this.color, @JsonKey(name: 'default_price', fromJson: _numFromJson) this.defaultPrice, @JsonKey(name: 'is_active', fromJson: _boolFromJson) this.isActive = false});
  factory _ClinicAvailableLabTestModel.fromJson(Map<String, dynamic> json) => _$ClinicAvailableLabTestModelFromJson(json);

@override@JsonKey(name: 'lab_test_id', fromJson: _intFromJson) final  int? labTestId;
@override final  String? code;
@override final  String? name;
@override@JsonKey(name: 'name_ar') final  String? nameAr;
@override@JsonKey(name: 'name_en') final  String? nameEn;
@override final  String? description;
@override@JsonKey(name: 'section_id', fromJson: _intFromJson) final  int? sectionId;
@override@JsonKey(name: 'section_slug') final  String? sectionSlug;
@override@JsonKey(name: 'section_name') final  String? sectionName;
@override@JsonKey(name: 'section_icon') final  String? icon;
@override@JsonKey(name: 'section_color') final  String? color;
@override@JsonKey(name: 'default_price', fromJson: _numFromJson) final  num? defaultPrice;
@override@JsonKey(name: 'is_active', fromJson: _boolFromJson) final  bool isActive;

/// Create a copy of ClinicAvailableLabTestModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ClinicAvailableLabTestModelCopyWith<_ClinicAvailableLabTestModel> get copyWith => __$ClinicAvailableLabTestModelCopyWithImpl<_ClinicAvailableLabTestModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ClinicAvailableLabTestModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ClinicAvailableLabTestModel&&(identical(other.labTestId, labTestId) || other.labTestId == labTestId)&&(identical(other.code, code) || other.code == code)&&(identical(other.name, name) || other.name == name)&&(identical(other.nameAr, nameAr) || other.nameAr == nameAr)&&(identical(other.nameEn, nameEn) || other.nameEn == nameEn)&&(identical(other.description, description) || other.description == description)&&(identical(other.sectionId, sectionId) || other.sectionId == sectionId)&&(identical(other.sectionSlug, sectionSlug) || other.sectionSlug == sectionSlug)&&(identical(other.sectionName, sectionName) || other.sectionName == sectionName)&&(identical(other.icon, icon) || other.icon == icon)&&(identical(other.color, color) || other.color == color)&&(identical(other.defaultPrice, defaultPrice) || other.defaultPrice == defaultPrice)&&(identical(other.isActive, isActive) || other.isActive == isActive));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,labTestId,code,name,nameAr,nameEn,description,sectionId,sectionSlug,sectionName,icon,color,defaultPrice,isActive);

@override
String toString() {
  return 'ClinicAvailableLabTestModel(labTestId: $labTestId, code: $code, name: $name, nameAr: $nameAr, nameEn: $nameEn, description: $description, sectionId: $sectionId, sectionSlug: $sectionSlug, sectionName: $sectionName, icon: $icon, color: $color, defaultPrice: $defaultPrice, isActive: $isActive)';
}


}

/// @nodoc
abstract mixin class _$ClinicAvailableLabTestModelCopyWith<$Res> implements $ClinicAvailableLabTestModelCopyWith<$Res> {
  factory _$ClinicAvailableLabTestModelCopyWith(_ClinicAvailableLabTestModel value, $Res Function(_ClinicAvailableLabTestModel) _then) = __$ClinicAvailableLabTestModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'lab_test_id', fromJson: _intFromJson) int? labTestId, String? code, String? name,@JsonKey(name: 'name_ar') String? nameAr,@JsonKey(name: 'name_en') String? nameEn, String? description,@JsonKey(name: 'section_id', fromJson: _intFromJson) int? sectionId,@JsonKey(name: 'section_slug') String? sectionSlug,@JsonKey(name: 'section_name') String? sectionName,@JsonKey(name: 'section_icon') String? icon,@JsonKey(name: 'section_color') String? color,@JsonKey(name: 'default_price', fromJson: _numFromJson) num? defaultPrice,@JsonKey(name: 'is_active', fromJson: _boolFromJson) bool isActive
});




}
/// @nodoc
class __$ClinicAvailableLabTestModelCopyWithImpl<$Res>
    implements _$ClinicAvailableLabTestModelCopyWith<$Res> {
  __$ClinicAvailableLabTestModelCopyWithImpl(this._self, this._then);

  final _ClinicAvailableLabTestModel _self;
  final $Res Function(_ClinicAvailableLabTestModel) _then;

/// Create a copy of ClinicAvailableLabTestModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? labTestId = freezed,Object? code = freezed,Object? name = freezed,Object? nameAr = freezed,Object? nameEn = freezed,Object? description = freezed,Object? sectionId = freezed,Object? sectionSlug = freezed,Object? sectionName = freezed,Object? icon = freezed,Object? color = freezed,Object? defaultPrice = freezed,Object? isActive = null,}) {
  return _then(_ClinicAvailableLabTestModel(
labTestId: freezed == labTestId ? _self.labTestId : labTestId // ignore: cast_nullable_to_non_nullable
as int?,code: freezed == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String?,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,nameAr: freezed == nameAr ? _self.nameAr : nameAr // ignore: cast_nullable_to_non_nullable
as String?,nameEn: freezed == nameEn ? _self.nameEn : nameEn // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,sectionId: freezed == sectionId ? _self.sectionId : sectionId // ignore: cast_nullable_to_non_nullable
as int?,sectionSlug: freezed == sectionSlug ? _self.sectionSlug : sectionSlug // ignore: cast_nullable_to_non_nullable
as String?,sectionName: freezed == sectionName ? _self.sectionName : sectionName // ignore: cast_nullable_to_non_nullable
as String?,icon: freezed == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as String?,color: freezed == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as String?,defaultPrice: freezed == defaultPrice ? _self.defaultPrice : defaultPrice // ignore: cast_nullable_to_non_nullable
as num?,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$ClinicEnabledLabTestModel {

@JsonKey(name: 'clinic_lab_test_id', fromJson: _intFromJson) int? get clinicLabTestId;@JsonKey(name: 'lab_test_id', fromJson: _intFromJson) int? get labTestId; String? get code; String? get name;@JsonKey(name: 'name_ar') String? get nameAr;@JsonKey(name: 'name_en') String? get nameEn;@JsonKey(name: 'section_id', fromJson: _intFromJson) int? get sectionId;@JsonKey(name: 'section_slug') String? get sectionSlug;@JsonKey(name: 'section_name') String? get sectionName;@JsonKey(name: 'section_icon') String? get icon;@JsonKey(name: 'section_color') String? get color;@JsonKey(fromJson: _numFromJson) num? get price;@JsonKey(name: 'default_price', fromJson: _numFromJson) num? get defaultPrice;@JsonKey(name: 'is_active', fromJson: _boolFromJson) bool get isActive;
/// Create a copy of ClinicEnabledLabTestModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ClinicEnabledLabTestModelCopyWith<ClinicEnabledLabTestModel> get copyWith => _$ClinicEnabledLabTestModelCopyWithImpl<ClinicEnabledLabTestModel>(this as ClinicEnabledLabTestModel, _$identity);

  /// Serializes this ClinicEnabledLabTestModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ClinicEnabledLabTestModel&&(identical(other.clinicLabTestId, clinicLabTestId) || other.clinicLabTestId == clinicLabTestId)&&(identical(other.labTestId, labTestId) || other.labTestId == labTestId)&&(identical(other.code, code) || other.code == code)&&(identical(other.name, name) || other.name == name)&&(identical(other.nameAr, nameAr) || other.nameAr == nameAr)&&(identical(other.nameEn, nameEn) || other.nameEn == nameEn)&&(identical(other.sectionId, sectionId) || other.sectionId == sectionId)&&(identical(other.sectionSlug, sectionSlug) || other.sectionSlug == sectionSlug)&&(identical(other.sectionName, sectionName) || other.sectionName == sectionName)&&(identical(other.icon, icon) || other.icon == icon)&&(identical(other.color, color) || other.color == color)&&(identical(other.price, price) || other.price == price)&&(identical(other.defaultPrice, defaultPrice) || other.defaultPrice == defaultPrice)&&(identical(other.isActive, isActive) || other.isActive == isActive));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,clinicLabTestId,labTestId,code,name,nameAr,nameEn,sectionId,sectionSlug,sectionName,icon,color,price,defaultPrice,isActive);

@override
String toString() {
  return 'ClinicEnabledLabTestModel(clinicLabTestId: $clinicLabTestId, labTestId: $labTestId, code: $code, name: $name, nameAr: $nameAr, nameEn: $nameEn, sectionId: $sectionId, sectionSlug: $sectionSlug, sectionName: $sectionName, icon: $icon, color: $color, price: $price, defaultPrice: $defaultPrice, isActive: $isActive)';
}


}

/// @nodoc
abstract mixin class $ClinicEnabledLabTestModelCopyWith<$Res>  {
  factory $ClinicEnabledLabTestModelCopyWith(ClinicEnabledLabTestModel value, $Res Function(ClinicEnabledLabTestModel) _then) = _$ClinicEnabledLabTestModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'clinic_lab_test_id', fromJson: _intFromJson) int? clinicLabTestId,@JsonKey(name: 'lab_test_id', fromJson: _intFromJson) int? labTestId, String? code, String? name,@JsonKey(name: 'name_ar') String? nameAr,@JsonKey(name: 'name_en') String? nameEn,@JsonKey(name: 'section_id', fromJson: _intFromJson) int? sectionId,@JsonKey(name: 'section_slug') String? sectionSlug,@JsonKey(name: 'section_name') String? sectionName,@JsonKey(name: 'section_icon') String? icon,@JsonKey(name: 'section_color') String? color,@JsonKey(fromJson: _numFromJson) num? price,@JsonKey(name: 'default_price', fromJson: _numFromJson) num? defaultPrice,@JsonKey(name: 'is_active', fromJson: _boolFromJson) bool isActive
});




}
/// @nodoc
class _$ClinicEnabledLabTestModelCopyWithImpl<$Res>
    implements $ClinicEnabledLabTestModelCopyWith<$Res> {
  _$ClinicEnabledLabTestModelCopyWithImpl(this._self, this._then);

  final ClinicEnabledLabTestModel _self;
  final $Res Function(ClinicEnabledLabTestModel) _then;

/// Create a copy of ClinicEnabledLabTestModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? clinicLabTestId = freezed,Object? labTestId = freezed,Object? code = freezed,Object? name = freezed,Object? nameAr = freezed,Object? nameEn = freezed,Object? sectionId = freezed,Object? sectionSlug = freezed,Object? sectionName = freezed,Object? icon = freezed,Object? color = freezed,Object? price = freezed,Object? defaultPrice = freezed,Object? isActive = null,}) {
  return _then(_self.copyWith(
clinicLabTestId: freezed == clinicLabTestId ? _self.clinicLabTestId : clinicLabTestId // ignore: cast_nullable_to_non_nullable
as int?,labTestId: freezed == labTestId ? _self.labTestId : labTestId // ignore: cast_nullable_to_non_nullable
as int?,code: freezed == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String?,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,nameAr: freezed == nameAr ? _self.nameAr : nameAr // ignore: cast_nullable_to_non_nullable
as String?,nameEn: freezed == nameEn ? _self.nameEn : nameEn // ignore: cast_nullable_to_non_nullable
as String?,sectionId: freezed == sectionId ? _self.sectionId : sectionId // ignore: cast_nullable_to_non_nullable
as int?,sectionSlug: freezed == sectionSlug ? _self.sectionSlug : sectionSlug // ignore: cast_nullable_to_non_nullable
as String?,sectionName: freezed == sectionName ? _self.sectionName : sectionName // ignore: cast_nullable_to_non_nullable
as String?,icon: freezed == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as String?,color: freezed == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as String?,price: freezed == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as num?,defaultPrice: freezed == defaultPrice ? _self.defaultPrice : defaultPrice // ignore: cast_nullable_to_non_nullable
as num?,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [ClinicEnabledLabTestModel].
extension ClinicEnabledLabTestModelPatterns on ClinicEnabledLabTestModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ClinicEnabledLabTestModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ClinicEnabledLabTestModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ClinicEnabledLabTestModel value)  $default,){
final _that = this;
switch (_that) {
case _ClinicEnabledLabTestModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ClinicEnabledLabTestModel value)?  $default,){
final _that = this;
switch (_that) {
case _ClinicEnabledLabTestModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'clinic_lab_test_id', fromJson: _intFromJson)  int? clinicLabTestId, @JsonKey(name: 'lab_test_id', fromJson: _intFromJson)  int? labTestId,  String? code,  String? name, @JsonKey(name: 'name_ar')  String? nameAr, @JsonKey(name: 'name_en')  String? nameEn, @JsonKey(name: 'section_id', fromJson: _intFromJson)  int? sectionId, @JsonKey(name: 'section_slug')  String? sectionSlug, @JsonKey(name: 'section_name')  String? sectionName, @JsonKey(name: 'section_icon')  String? icon, @JsonKey(name: 'section_color')  String? color, @JsonKey(fromJson: _numFromJson)  num? price, @JsonKey(name: 'default_price', fromJson: _numFromJson)  num? defaultPrice, @JsonKey(name: 'is_active', fromJson: _boolFromJson)  bool isActive)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ClinicEnabledLabTestModel() when $default != null:
return $default(_that.clinicLabTestId,_that.labTestId,_that.code,_that.name,_that.nameAr,_that.nameEn,_that.sectionId,_that.sectionSlug,_that.sectionName,_that.icon,_that.color,_that.price,_that.defaultPrice,_that.isActive);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'clinic_lab_test_id', fromJson: _intFromJson)  int? clinicLabTestId, @JsonKey(name: 'lab_test_id', fromJson: _intFromJson)  int? labTestId,  String? code,  String? name, @JsonKey(name: 'name_ar')  String? nameAr, @JsonKey(name: 'name_en')  String? nameEn, @JsonKey(name: 'section_id', fromJson: _intFromJson)  int? sectionId, @JsonKey(name: 'section_slug')  String? sectionSlug, @JsonKey(name: 'section_name')  String? sectionName, @JsonKey(name: 'section_icon')  String? icon, @JsonKey(name: 'section_color')  String? color, @JsonKey(fromJson: _numFromJson)  num? price, @JsonKey(name: 'default_price', fromJson: _numFromJson)  num? defaultPrice, @JsonKey(name: 'is_active', fromJson: _boolFromJson)  bool isActive)  $default,) {final _that = this;
switch (_that) {
case _ClinicEnabledLabTestModel():
return $default(_that.clinicLabTestId,_that.labTestId,_that.code,_that.name,_that.nameAr,_that.nameEn,_that.sectionId,_that.sectionSlug,_that.sectionName,_that.icon,_that.color,_that.price,_that.defaultPrice,_that.isActive);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'clinic_lab_test_id', fromJson: _intFromJson)  int? clinicLabTestId, @JsonKey(name: 'lab_test_id', fromJson: _intFromJson)  int? labTestId,  String? code,  String? name, @JsonKey(name: 'name_ar')  String? nameAr, @JsonKey(name: 'name_en')  String? nameEn, @JsonKey(name: 'section_id', fromJson: _intFromJson)  int? sectionId, @JsonKey(name: 'section_slug')  String? sectionSlug, @JsonKey(name: 'section_name')  String? sectionName, @JsonKey(name: 'section_icon')  String? icon, @JsonKey(name: 'section_color')  String? color, @JsonKey(fromJson: _numFromJson)  num? price, @JsonKey(name: 'default_price', fromJson: _numFromJson)  num? defaultPrice, @JsonKey(name: 'is_active', fromJson: _boolFromJson)  bool isActive)?  $default,) {final _that = this;
switch (_that) {
case _ClinicEnabledLabTestModel() when $default != null:
return $default(_that.clinicLabTestId,_that.labTestId,_that.code,_that.name,_that.nameAr,_that.nameEn,_that.sectionId,_that.sectionSlug,_that.sectionName,_that.icon,_that.color,_that.price,_that.defaultPrice,_that.isActive);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ClinicEnabledLabTestModel implements ClinicEnabledLabTestModel {
  const _ClinicEnabledLabTestModel({@JsonKey(name: 'clinic_lab_test_id', fromJson: _intFromJson) this.clinicLabTestId, @JsonKey(name: 'lab_test_id', fromJson: _intFromJson) this.labTestId, this.code, this.name, @JsonKey(name: 'name_ar') this.nameAr, @JsonKey(name: 'name_en') this.nameEn, @JsonKey(name: 'section_id', fromJson: _intFromJson) this.sectionId, @JsonKey(name: 'section_slug') this.sectionSlug, @JsonKey(name: 'section_name') this.sectionName, @JsonKey(name: 'section_icon') this.icon, @JsonKey(name: 'section_color') this.color, @JsonKey(fromJson: _numFromJson) this.price, @JsonKey(name: 'default_price', fromJson: _numFromJson) this.defaultPrice, @JsonKey(name: 'is_active', fromJson: _boolFromJson) this.isActive = false});
  factory _ClinicEnabledLabTestModel.fromJson(Map<String, dynamic> json) => _$ClinicEnabledLabTestModelFromJson(json);

@override@JsonKey(name: 'clinic_lab_test_id', fromJson: _intFromJson) final  int? clinicLabTestId;
@override@JsonKey(name: 'lab_test_id', fromJson: _intFromJson) final  int? labTestId;
@override final  String? code;
@override final  String? name;
@override@JsonKey(name: 'name_ar') final  String? nameAr;
@override@JsonKey(name: 'name_en') final  String? nameEn;
@override@JsonKey(name: 'section_id', fromJson: _intFromJson) final  int? sectionId;
@override@JsonKey(name: 'section_slug') final  String? sectionSlug;
@override@JsonKey(name: 'section_name') final  String? sectionName;
@override@JsonKey(name: 'section_icon') final  String? icon;
@override@JsonKey(name: 'section_color') final  String? color;
@override@JsonKey(fromJson: _numFromJson) final  num? price;
@override@JsonKey(name: 'default_price', fromJson: _numFromJson) final  num? defaultPrice;
@override@JsonKey(name: 'is_active', fromJson: _boolFromJson) final  bool isActive;

/// Create a copy of ClinicEnabledLabTestModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ClinicEnabledLabTestModelCopyWith<_ClinicEnabledLabTestModel> get copyWith => __$ClinicEnabledLabTestModelCopyWithImpl<_ClinicEnabledLabTestModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ClinicEnabledLabTestModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ClinicEnabledLabTestModel&&(identical(other.clinicLabTestId, clinicLabTestId) || other.clinicLabTestId == clinicLabTestId)&&(identical(other.labTestId, labTestId) || other.labTestId == labTestId)&&(identical(other.code, code) || other.code == code)&&(identical(other.name, name) || other.name == name)&&(identical(other.nameAr, nameAr) || other.nameAr == nameAr)&&(identical(other.nameEn, nameEn) || other.nameEn == nameEn)&&(identical(other.sectionId, sectionId) || other.sectionId == sectionId)&&(identical(other.sectionSlug, sectionSlug) || other.sectionSlug == sectionSlug)&&(identical(other.sectionName, sectionName) || other.sectionName == sectionName)&&(identical(other.icon, icon) || other.icon == icon)&&(identical(other.color, color) || other.color == color)&&(identical(other.price, price) || other.price == price)&&(identical(other.defaultPrice, defaultPrice) || other.defaultPrice == defaultPrice)&&(identical(other.isActive, isActive) || other.isActive == isActive));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,clinicLabTestId,labTestId,code,name,nameAr,nameEn,sectionId,sectionSlug,sectionName,icon,color,price,defaultPrice,isActive);

@override
String toString() {
  return 'ClinicEnabledLabTestModel(clinicLabTestId: $clinicLabTestId, labTestId: $labTestId, code: $code, name: $name, nameAr: $nameAr, nameEn: $nameEn, sectionId: $sectionId, sectionSlug: $sectionSlug, sectionName: $sectionName, icon: $icon, color: $color, price: $price, defaultPrice: $defaultPrice, isActive: $isActive)';
}


}

/// @nodoc
abstract mixin class _$ClinicEnabledLabTestModelCopyWith<$Res> implements $ClinicEnabledLabTestModelCopyWith<$Res> {
  factory _$ClinicEnabledLabTestModelCopyWith(_ClinicEnabledLabTestModel value, $Res Function(_ClinicEnabledLabTestModel) _then) = __$ClinicEnabledLabTestModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'clinic_lab_test_id', fromJson: _intFromJson) int? clinicLabTestId,@JsonKey(name: 'lab_test_id', fromJson: _intFromJson) int? labTestId, String? code, String? name,@JsonKey(name: 'name_ar') String? nameAr,@JsonKey(name: 'name_en') String? nameEn,@JsonKey(name: 'section_id', fromJson: _intFromJson) int? sectionId,@JsonKey(name: 'section_slug') String? sectionSlug,@JsonKey(name: 'section_name') String? sectionName,@JsonKey(name: 'section_icon') String? icon,@JsonKey(name: 'section_color') String? color,@JsonKey(fromJson: _numFromJson) num? price,@JsonKey(name: 'default_price', fromJson: _numFromJson) num? defaultPrice,@JsonKey(name: 'is_active', fromJson: _boolFromJson) bool isActive
});




}
/// @nodoc
class __$ClinicEnabledLabTestModelCopyWithImpl<$Res>
    implements _$ClinicEnabledLabTestModelCopyWith<$Res> {
  __$ClinicEnabledLabTestModelCopyWithImpl(this._self, this._then);

  final _ClinicEnabledLabTestModel _self;
  final $Res Function(_ClinicEnabledLabTestModel) _then;

/// Create a copy of ClinicEnabledLabTestModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? clinicLabTestId = freezed,Object? labTestId = freezed,Object? code = freezed,Object? name = freezed,Object? nameAr = freezed,Object? nameEn = freezed,Object? sectionId = freezed,Object? sectionSlug = freezed,Object? sectionName = freezed,Object? icon = freezed,Object? color = freezed,Object? price = freezed,Object? defaultPrice = freezed,Object? isActive = null,}) {
  return _then(_ClinicEnabledLabTestModel(
clinicLabTestId: freezed == clinicLabTestId ? _self.clinicLabTestId : clinicLabTestId // ignore: cast_nullable_to_non_nullable
as int?,labTestId: freezed == labTestId ? _self.labTestId : labTestId // ignore: cast_nullable_to_non_nullable
as int?,code: freezed == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String?,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,nameAr: freezed == nameAr ? _self.nameAr : nameAr // ignore: cast_nullable_to_non_nullable
as String?,nameEn: freezed == nameEn ? _self.nameEn : nameEn // ignore: cast_nullable_to_non_nullable
as String?,sectionId: freezed == sectionId ? _self.sectionId : sectionId // ignore: cast_nullable_to_non_nullable
as int?,sectionSlug: freezed == sectionSlug ? _self.sectionSlug : sectionSlug // ignore: cast_nullable_to_non_nullable
as String?,sectionName: freezed == sectionName ? _self.sectionName : sectionName // ignore: cast_nullable_to_non_nullable
as String?,icon: freezed == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as String?,color: freezed == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as String?,price: freezed == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as num?,defaultPrice: freezed == defaultPrice ? _self.defaultPrice : defaultPrice // ignore: cast_nullable_to_non_nullable
as num?,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$ClinicAvailableSpecializationModel {

@JsonKey(name: 'specialization_id', fromJson: _intFromJson) int? get specializationId; String? get slug; String? get name;@JsonKey(name: 'name_ar') String? get nameAr;@JsonKey(name: 'name_en') String? get nameEn; String? get description; String? get icon; String? get color;@JsonKey(name: 'is_active', fromJson: _boolFromJson) bool get isActive;
/// Create a copy of ClinicAvailableSpecializationModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ClinicAvailableSpecializationModelCopyWith<ClinicAvailableSpecializationModel> get copyWith => _$ClinicAvailableSpecializationModelCopyWithImpl<ClinicAvailableSpecializationModel>(this as ClinicAvailableSpecializationModel, _$identity);

  /// Serializes this ClinicAvailableSpecializationModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ClinicAvailableSpecializationModel&&(identical(other.specializationId, specializationId) || other.specializationId == specializationId)&&(identical(other.slug, slug) || other.slug == slug)&&(identical(other.name, name) || other.name == name)&&(identical(other.nameAr, nameAr) || other.nameAr == nameAr)&&(identical(other.nameEn, nameEn) || other.nameEn == nameEn)&&(identical(other.description, description) || other.description == description)&&(identical(other.icon, icon) || other.icon == icon)&&(identical(other.color, color) || other.color == color)&&(identical(other.isActive, isActive) || other.isActive == isActive));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,specializationId,slug,name,nameAr,nameEn,description,icon,color,isActive);

@override
String toString() {
  return 'ClinicAvailableSpecializationModel(specializationId: $specializationId, slug: $slug, name: $name, nameAr: $nameAr, nameEn: $nameEn, description: $description, icon: $icon, color: $color, isActive: $isActive)';
}


}

/// @nodoc
abstract mixin class $ClinicAvailableSpecializationModelCopyWith<$Res>  {
  factory $ClinicAvailableSpecializationModelCopyWith(ClinicAvailableSpecializationModel value, $Res Function(ClinicAvailableSpecializationModel) _then) = _$ClinicAvailableSpecializationModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'specialization_id', fromJson: _intFromJson) int? specializationId, String? slug, String? name,@JsonKey(name: 'name_ar') String? nameAr,@JsonKey(name: 'name_en') String? nameEn, String? description, String? icon, String? color,@JsonKey(name: 'is_active', fromJson: _boolFromJson) bool isActive
});




}
/// @nodoc
class _$ClinicAvailableSpecializationModelCopyWithImpl<$Res>
    implements $ClinicAvailableSpecializationModelCopyWith<$Res> {
  _$ClinicAvailableSpecializationModelCopyWithImpl(this._self, this._then);

  final ClinicAvailableSpecializationModel _self;
  final $Res Function(ClinicAvailableSpecializationModel) _then;

/// Create a copy of ClinicAvailableSpecializationModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? specializationId = freezed,Object? slug = freezed,Object? name = freezed,Object? nameAr = freezed,Object? nameEn = freezed,Object? description = freezed,Object? icon = freezed,Object? color = freezed,Object? isActive = null,}) {
  return _then(_self.copyWith(
specializationId: freezed == specializationId ? _self.specializationId : specializationId // ignore: cast_nullable_to_non_nullable
as int?,slug: freezed == slug ? _self.slug : slug // ignore: cast_nullable_to_non_nullable
as String?,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,nameAr: freezed == nameAr ? _self.nameAr : nameAr // ignore: cast_nullable_to_non_nullable
as String?,nameEn: freezed == nameEn ? _self.nameEn : nameEn // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,icon: freezed == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as String?,color: freezed == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as String?,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [ClinicAvailableSpecializationModel].
extension ClinicAvailableSpecializationModelPatterns on ClinicAvailableSpecializationModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ClinicAvailableSpecializationModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ClinicAvailableSpecializationModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ClinicAvailableSpecializationModel value)  $default,){
final _that = this;
switch (_that) {
case _ClinicAvailableSpecializationModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ClinicAvailableSpecializationModel value)?  $default,){
final _that = this;
switch (_that) {
case _ClinicAvailableSpecializationModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'specialization_id', fromJson: _intFromJson)  int? specializationId,  String? slug,  String? name, @JsonKey(name: 'name_ar')  String? nameAr, @JsonKey(name: 'name_en')  String? nameEn,  String? description,  String? icon,  String? color, @JsonKey(name: 'is_active', fromJson: _boolFromJson)  bool isActive)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ClinicAvailableSpecializationModel() when $default != null:
return $default(_that.specializationId,_that.slug,_that.name,_that.nameAr,_that.nameEn,_that.description,_that.icon,_that.color,_that.isActive);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'specialization_id', fromJson: _intFromJson)  int? specializationId,  String? slug,  String? name, @JsonKey(name: 'name_ar')  String? nameAr, @JsonKey(name: 'name_en')  String? nameEn,  String? description,  String? icon,  String? color, @JsonKey(name: 'is_active', fromJson: _boolFromJson)  bool isActive)  $default,) {final _that = this;
switch (_that) {
case _ClinicAvailableSpecializationModel():
return $default(_that.specializationId,_that.slug,_that.name,_that.nameAr,_that.nameEn,_that.description,_that.icon,_that.color,_that.isActive);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'specialization_id', fromJson: _intFromJson)  int? specializationId,  String? slug,  String? name, @JsonKey(name: 'name_ar')  String? nameAr, @JsonKey(name: 'name_en')  String? nameEn,  String? description,  String? icon,  String? color, @JsonKey(name: 'is_active', fromJson: _boolFromJson)  bool isActive)?  $default,) {final _that = this;
switch (_that) {
case _ClinicAvailableSpecializationModel() when $default != null:
return $default(_that.specializationId,_that.slug,_that.name,_that.nameAr,_that.nameEn,_that.description,_that.icon,_that.color,_that.isActive);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ClinicAvailableSpecializationModel implements ClinicAvailableSpecializationModel {
  const _ClinicAvailableSpecializationModel({@JsonKey(name: 'specialization_id', fromJson: _intFromJson) this.specializationId, this.slug, this.name, @JsonKey(name: 'name_ar') this.nameAr, @JsonKey(name: 'name_en') this.nameEn, this.description, this.icon, this.color, @JsonKey(name: 'is_active', fromJson: _boolFromJson) this.isActive = false});
  factory _ClinicAvailableSpecializationModel.fromJson(Map<String, dynamic> json) => _$ClinicAvailableSpecializationModelFromJson(json);

@override@JsonKey(name: 'specialization_id', fromJson: _intFromJson) final  int? specializationId;
@override final  String? slug;
@override final  String? name;
@override@JsonKey(name: 'name_ar') final  String? nameAr;
@override@JsonKey(name: 'name_en') final  String? nameEn;
@override final  String? description;
@override final  String? icon;
@override final  String? color;
@override@JsonKey(name: 'is_active', fromJson: _boolFromJson) final  bool isActive;

/// Create a copy of ClinicAvailableSpecializationModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ClinicAvailableSpecializationModelCopyWith<_ClinicAvailableSpecializationModel> get copyWith => __$ClinicAvailableSpecializationModelCopyWithImpl<_ClinicAvailableSpecializationModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ClinicAvailableSpecializationModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ClinicAvailableSpecializationModel&&(identical(other.specializationId, specializationId) || other.specializationId == specializationId)&&(identical(other.slug, slug) || other.slug == slug)&&(identical(other.name, name) || other.name == name)&&(identical(other.nameAr, nameAr) || other.nameAr == nameAr)&&(identical(other.nameEn, nameEn) || other.nameEn == nameEn)&&(identical(other.description, description) || other.description == description)&&(identical(other.icon, icon) || other.icon == icon)&&(identical(other.color, color) || other.color == color)&&(identical(other.isActive, isActive) || other.isActive == isActive));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,specializationId,slug,name,nameAr,nameEn,description,icon,color,isActive);

@override
String toString() {
  return 'ClinicAvailableSpecializationModel(specializationId: $specializationId, slug: $slug, name: $name, nameAr: $nameAr, nameEn: $nameEn, description: $description, icon: $icon, color: $color, isActive: $isActive)';
}


}

/// @nodoc
abstract mixin class _$ClinicAvailableSpecializationModelCopyWith<$Res> implements $ClinicAvailableSpecializationModelCopyWith<$Res> {
  factory _$ClinicAvailableSpecializationModelCopyWith(_ClinicAvailableSpecializationModel value, $Res Function(_ClinicAvailableSpecializationModel) _then) = __$ClinicAvailableSpecializationModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'specialization_id', fromJson: _intFromJson) int? specializationId, String? slug, String? name,@JsonKey(name: 'name_ar') String? nameAr,@JsonKey(name: 'name_en') String? nameEn, String? description, String? icon, String? color,@JsonKey(name: 'is_active', fromJson: _boolFromJson) bool isActive
});




}
/// @nodoc
class __$ClinicAvailableSpecializationModelCopyWithImpl<$Res>
    implements _$ClinicAvailableSpecializationModelCopyWith<$Res> {
  __$ClinicAvailableSpecializationModelCopyWithImpl(this._self, this._then);

  final _ClinicAvailableSpecializationModel _self;
  final $Res Function(_ClinicAvailableSpecializationModel) _then;

/// Create a copy of ClinicAvailableSpecializationModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? specializationId = freezed,Object? slug = freezed,Object? name = freezed,Object? nameAr = freezed,Object? nameEn = freezed,Object? description = freezed,Object? icon = freezed,Object? color = freezed,Object? isActive = null,}) {
  return _then(_ClinicAvailableSpecializationModel(
specializationId: freezed == specializationId ? _self.specializationId : specializationId // ignore: cast_nullable_to_non_nullable
as int?,slug: freezed == slug ? _self.slug : slug // ignore: cast_nullable_to_non_nullable
as String?,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,nameAr: freezed == nameAr ? _self.nameAr : nameAr // ignore: cast_nullable_to_non_nullable
as String?,nameEn: freezed == nameEn ? _self.nameEn : nameEn // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,icon: freezed == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as String?,color: freezed == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as String?,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$ClinicEnabledSpecializationModel {

@JsonKey(name: 'clinic_specialization_id', fromJson: _intFromJson) int? get clinicSpecializationId;@JsonKey(name: 'specialization_id', fromJson: _intFromJson) int? get specializationId; String? get slug; String? get name;@JsonKey(name: 'name_ar') String? get nameAr;@JsonKey(name: 'name_en') String? get nameEn; String? get icon; String? get color;@JsonKey(name: 'is_active', fromJson: _boolFromJson) bool get isActive;
/// Create a copy of ClinicEnabledSpecializationModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ClinicEnabledSpecializationModelCopyWith<ClinicEnabledSpecializationModel> get copyWith => _$ClinicEnabledSpecializationModelCopyWithImpl<ClinicEnabledSpecializationModel>(this as ClinicEnabledSpecializationModel, _$identity);

  /// Serializes this ClinicEnabledSpecializationModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ClinicEnabledSpecializationModel&&(identical(other.clinicSpecializationId, clinicSpecializationId) || other.clinicSpecializationId == clinicSpecializationId)&&(identical(other.specializationId, specializationId) || other.specializationId == specializationId)&&(identical(other.slug, slug) || other.slug == slug)&&(identical(other.name, name) || other.name == name)&&(identical(other.nameAr, nameAr) || other.nameAr == nameAr)&&(identical(other.nameEn, nameEn) || other.nameEn == nameEn)&&(identical(other.icon, icon) || other.icon == icon)&&(identical(other.color, color) || other.color == color)&&(identical(other.isActive, isActive) || other.isActive == isActive));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,clinicSpecializationId,specializationId,slug,name,nameAr,nameEn,icon,color,isActive);

@override
String toString() {
  return 'ClinicEnabledSpecializationModel(clinicSpecializationId: $clinicSpecializationId, specializationId: $specializationId, slug: $slug, name: $name, nameAr: $nameAr, nameEn: $nameEn, icon: $icon, color: $color, isActive: $isActive)';
}


}

/// @nodoc
abstract mixin class $ClinicEnabledSpecializationModelCopyWith<$Res>  {
  factory $ClinicEnabledSpecializationModelCopyWith(ClinicEnabledSpecializationModel value, $Res Function(ClinicEnabledSpecializationModel) _then) = _$ClinicEnabledSpecializationModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'clinic_specialization_id', fromJson: _intFromJson) int? clinicSpecializationId,@JsonKey(name: 'specialization_id', fromJson: _intFromJson) int? specializationId, String? slug, String? name,@JsonKey(name: 'name_ar') String? nameAr,@JsonKey(name: 'name_en') String? nameEn, String? icon, String? color,@JsonKey(name: 'is_active', fromJson: _boolFromJson) bool isActive
});




}
/// @nodoc
class _$ClinicEnabledSpecializationModelCopyWithImpl<$Res>
    implements $ClinicEnabledSpecializationModelCopyWith<$Res> {
  _$ClinicEnabledSpecializationModelCopyWithImpl(this._self, this._then);

  final ClinicEnabledSpecializationModel _self;
  final $Res Function(ClinicEnabledSpecializationModel) _then;

/// Create a copy of ClinicEnabledSpecializationModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? clinicSpecializationId = freezed,Object? specializationId = freezed,Object? slug = freezed,Object? name = freezed,Object? nameAr = freezed,Object? nameEn = freezed,Object? icon = freezed,Object? color = freezed,Object? isActive = null,}) {
  return _then(_self.copyWith(
clinicSpecializationId: freezed == clinicSpecializationId ? _self.clinicSpecializationId : clinicSpecializationId // ignore: cast_nullable_to_non_nullable
as int?,specializationId: freezed == specializationId ? _self.specializationId : specializationId // ignore: cast_nullable_to_non_nullable
as int?,slug: freezed == slug ? _self.slug : slug // ignore: cast_nullable_to_non_nullable
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


/// Adds pattern-matching-related methods to [ClinicEnabledSpecializationModel].
extension ClinicEnabledSpecializationModelPatterns on ClinicEnabledSpecializationModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ClinicEnabledSpecializationModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ClinicEnabledSpecializationModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ClinicEnabledSpecializationModel value)  $default,){
final _that = this;
switch (_that) {
case _ClinicEnabledSpecializationModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ClinicEnabledSpecializationModel value)?  $default,){
final _that = this;
switch (_that) {
case _ClinicEnabledSpecializationModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'clinic_specialization_id', fromJson: _intFromJson)  int? clinicSpecializationId, @JsonKey(name: 'specialization_id', fromJson: _intFromJson)  int? specializationId,  String? slug,  String? name, @JsonKey(name: 'name_ar')  String? nameAr, @JsonKey(name: 'name_en')  String? nameEn,  String? icon,  String? color, @JsonKey(name: 'is_active', fromJson: _boolFromJson)  bool isActive)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ClinicEnabledSpecializationModel() when $default != null:
return $default(_that.clinicSpecializationId,_that.specializationId,_that.slug,_that.name,_that.nameAr,_that.nameEn,_that.icon,_that.color,_that.isActive);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'clinic_specialization_id', fromJson: _intFromJson)  int? clinicSpecializationId, @JsonKey(name: 'specialization_id', fromJson: _intFromJson)  int? specializationId,  String? slug,  String? name, @JsonKey(name: 'name_ar')  String? nameAr, @JsonKey(name: 'name_en')  String? nameEn,  String? icon,  String? color, @JsonKey(name: 'is_active', fromJson: _boolFromJson)  bool isActive)  $default,) {final _that = this;
switch (_that) {
case _ClinicEnabledSpecializationModel():
return $default(_that.clinicSpecializationId,_that.specializationId,_that.slug,_that.name,_that.nameAr,_that.nameEn,_that.icon,_that.color,_that.isActive);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'clinic_specialization_id', fromJson: _intFromJson)  int? clinicSpecializationId, @JsonKey(name: 'specialization_id', fromJson: _intFromJson)  int? specializationId,  String? slug,  String? name, @JsonKey(name: 'name_ar')  String? nameAr, @JsonKey(name: 'name_en')  String? nameEn,  String? icon,  String? color, @JsonKey(name: 'is_active', fromJson: _boolFromJson)  bool isActive)?  $default,) {final _that = this;
switch (_that) {
case _ClinicEnabledSpecializationModel() when $default != null:
return $default(_that.clinicSpecializationId,_that.specializationId,_that.slug,_that.name,_that.nameAr,_that.nameEn,_that.icon,_that.color,_that.isActive);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ClinicEnabledSpecializationModel implements ClinicEnabledSpecializationModel {
  const _ClinicEnabledSpecializationModel({@JsonKey(name: 'clinic_specialization_id', fromJson: _intFromJson) this.clinicSpecializationId, @JsonKey(name: 'specialization_id', fromJson: _intFromJson) this.specializationId, this.slug, this.name, @JsonKey(name: 'name_ar') this.nameAr, @JsonKey(name: 'name_en') this.nameEn, this.icon, this.color, @JsonKey(name: 'is_active', fromJson: _boolFromJson) this.isActive = false});
  factory _ClinicEnabledSpecializationModel.fromJson(Map<String, dynamic> json) => _$ClinicEnabledSpecializationModelFromJson(json);

@override@JsonKey(name: 'clinic_specialization_id', fromJson: _intFromJson) final  int? clinicSpecializationId;
@override@JsonKey(name: 'specialization_id', fromJson: _intFromJson) final  int? specializationId;
@override final  String? slug;
@override final  String? name;
@override@JsonKey(name: 'name_ar') final  String? nameAr;
@override@JsonKey(name: 'name_en') final  String? nameEn;
@override final  String? icon;
@override final  String? color;
@override@JsonKey(name: 'is_active', fromJson: _boolFromJson) final  bool isActive;

/// Create a copy of ClinicEnabledSpecializationModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ClinicEnabledSpecializationModelCopyWith<_ClinicEnabledSpecializationModel> get copyWith => __$ClinicEnabledSpecializationModelCopyWithImpl<_ClinicEnabledSpecializationModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ClinicEnabledSpecializationModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ClinicEnabledSpecializationModel&&(identical(other.clinicSpecializationId, clinicSpecializationId) || other.clinicSpecializationId == clinicSpecializationId)&&(identical(other.specializationId, specializationId) || other.specializationId == specializationId)&&(identical(other.slug, slug) || other.slug == slug)&&(identical(other.name, name) || other.name == name)&&(identical(other.nameAr, nameAr) || other.nameAr == nameAr)&&(identical(other.nameEn, nameEn) || other.nameEn == nameEn)&&(identical(other.icon, icon) || other.icon == icon)&&(identical(other.color, color) || other.color == color)&&(identical(other.isActive, isActive) || other.isActive == isActive));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,clinicSpecializationId,specializationId,slug,name,nameAr,nameEn,icon,color,isActive);

@override
String toString() {
  return 'ClinicEnabledSpecializationModel(clinicSpecializationId: $clinicSpecializationId, specializationId: $specializationId, slug: $slug, name: $name, nameAr: $nameAr, nameEn: $nameEn, icon: $icon, color: $color, isActive: $isActive)';
}


}

/// @nodoc
abstract mixin class _$ClinicEnabledSpecializationModelCopyWith<$Res> implements $ClinicEnabledSpecializationModelCopyWith<$Res> {
  factory _$ClinicEnabledSpecializationModelCopyWith(_ClinicEnabledSpecializationModel value, $Res Function(_ClinicEnabledSpecializationModel) _then) = __$ClinicEnabledSpecializationModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'clinic_specialization_id', fromJson: _intFromJson) int? clinicSpecializationId,@JsonKey(name: 'specialization_id', fromJson: _intFromJson) int? specializationId, String? slug, String? name,@JsonKey(name: 'name_ar') String? nameAr,@JsonKey(name: 'name_en') String? nameEn, String? icon, String? color,@JsonKey(name: 'is_active', fromJson: _boolFromJson) bool isActive
});




}
/// @nodoc
class __$ClinicEnabledSpecializationModelCopyWithImpl<$Res>
    implements _$ClinicEnabledSpecializationModelCopyWith<$Res> {
  __$ClinicEnabledSpecializationModelCopyWithImpl(this._self, this._then);

  final _ClinicEnabledSpecializationModel _self;
  final $Res Function(_ClinicEnabledSpecializationModel) _then;

/// Create a copy of ClinicEnabledSpecializationModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? clinicSpecializationId = freezed,Object? specializationId = freezed,Object? slug = freezed,Object? name = freezed,Object? nameAr = freezed,Object? nameEn = freezed,Object? icon = freezed,Object? color = freezed,Object? isActive = null,}) {
  return _then(_ClinicEnabledSpecializationModel(
clinicSpecializationId: freezed == clinicSpecializationId ? _self.clinicSpecializationId : clinicSpecializationId // ignore: cast_nullable_to_non_nullable
as int?,specializationId: freezed == specializationId ? _self.specializationId : specializationId // ignore: cast_nullable_to_non_nullable
as int?,slug: freezed == slug ? _self.slug : slug // ignore: cast_nullable_to_non_nullable
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


/// @nodoc
mixin _$ClinicServiceRemovalModel {

 bool get removed;
/// Create a copy of ClinicServiceRemovalModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ClinicServiceRemovalModelCopyWith<ClinicServiceRemovalModel> get copyWith => _$ClinicServiceRemovalModelCopyWithImpl<ClinicServiceRemovalModel>(this as ClinicServiceRemovalModel, _$identity);

  /// Serializes this ClinicServiceRemovalModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ClinicServiceRemovalModel&&(identical(other.removed, removed) || other.removed == removed));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,removed);

@override
String toString() {
  return 'ClinicServiceRemovalModel(removed: $removed)';
}


}

/// @nodoc
abstract mixin class $ClinicServiceRemovalModelCopyWith<$Res>  {
  factory $ClinicServiceRemovalModelCopyWith(ClinicServiceRemovalModel value, $Res Function(ClinicServiceRemovalModel) _then) = _$ClinicServiceRemovalModelCopyWithImpl;
@useResult
$Res call({
 bool removed
});




}
/// @nodoc
class _$ClinicServiceRemovalModelCopyWithImpl<$Res>
    implements $ClinicServiceRemovalModelCopyWith<$Res> {
  _$ClinicServiceRemovalModelCopyWithImpl(this._self, this._then);

  final ClinicServiceRemovalModel _self;
  final $Res Function(ClinicServiceRemovalModel) _then;

/// Create a copy of ClinicServiceRemovalModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? removed = null,}) {
  return _then(_self.copyWith(
removed: null == removed ? _self.removed : removed // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [ClinicServiceRemovalModel].
extension ClinicServiceRemovalModelPatterns on ClinicServiceRemovalModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ClinicServiceRemovalModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ClinicServiceRemovalModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ClinicServiceRemovalModel value)  $default,){
final _that = this;
switch (_that) {
case _ClinicServiceRemovalModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ClinicServiceRemovalModel value)?  $default,){
final _that = this;
switch (_that) {
case _ClinicServiceRemovalModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool removed)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ClinicServiceRemovalModel() when $default != null:
return $default(_that.removed);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool removed)  $default,) {final _that = this;
switch (_that) {
case _ClinicServiceRemovalModel():
return $default(_that.removed);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool removed)?  $default,) {final _that = this;
switch (_that) {
case _ClinicServiceRemovalModel() when $default != null:
return $default(_that.removed);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ClinicServiceRemovalModel implements ClinicServiceRemovalModel {
  const _ClinicServiceRemovalModel({this.removed = false});
  factory _ClinicServiceRemovalModel.fromJson(Map<String, dynamic> json) => _$ClinicServiceRemovalModelFromJson(json);

@override@JsonKey() final  bool removed;

/// Create a copy of ClinicServiceRemovalModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ClinicServiceRemovalModelCopyWith<_ClinicServiceRemovalModel> get copyWith => __$ClinicServiceRemovalModelCopyWithImpl<_ClinicServiceRemovalModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ClinicServiceRemovalModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ClinicServiceRemovalModel&&(identical(other.removed, removed) || other.removed == removed));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,removed);

@override
String toString() {
  return 'ClinicServiceRemovalModel(removed: $removed)';
}


}

/// @nodoc
abstract mixin class _$ClinicServiceRemovalModelCopyWith<$Res> implements $ClinicServiceRemovalModelCopyWith<$Res> {
  factory _$ClinicServiceRemovalModelCopyWith(_ClinicServiceRemovalModel value, $Res Function(_ClinicServiceRemovalModel) _then) = __$ClinicServiceRemovalModelCopyWithImpl;
@override @useResult
$Res call({
 bool removed
});




}
/// @nodoc
class __$ClinicServiceRemovalModelCopyWithImpl<$Res>
    implements _$ClinicServiceRemovalModelCopyWith<$Res> {
  __$ClinicServiceRemovalModelCopyWithImpl(this._self, this._then);

  final _ClinicServiceRemovalModel _self;
  final $Res Function(_ClinicServiceRemovalModel) _then;

/// Create a copy of ClinicServiceRemovalModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? removed = null,}) {
  return _then(_ClinicServiceRemovalModel(
removed: null == removed ? _self.removed : removed // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
