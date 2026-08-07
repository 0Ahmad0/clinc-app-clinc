// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'clinic_settings_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ClinicSettingsProfileModel {

 ClinicSettingsClinicModel? get clinic;@JsonKey(name: 'pending_update') bool get pendingUpdate;
/// Create a copy of ClinicSettingsProfileModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ClinicSettingsProfileModelCopyWith<ClinicSettingsProfileModel> get copyWith => _$ClinicSettingsProfileModelCopyWithImpl<ClinicSettingsProfileModel>(this as ClinicSettingsProfileModel, _$identity);

  /// Serializes this ClinicSettingsProfileModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ClinicSettingsProfileModel&&(identical(other.clinic, clinic) || other.clinic == clinic)&&(identical(other.pendingUpdate, pendingUpdate) || other.pendingUpdate == pendingUpdate));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,clinic,pendingUpdate);

@override
String toString() {
  return 'ClinicSettingsProfileModel(clinic: $clinic, pendingUpdate: $pendingUpdate)';
}


}

/// @nodoc
abstract mixin class $ClinicSettingsProfileModelCopyWith<$Res>  {
  factory $ClinicSettingsProfileModelCopyWith(ClinicSettingsProfileModel value, $Res Function(ClinicSettingsProfileModel) _then) = _$ClinicSettingsProfileModelCopyWithImpl;
@useResult
$Res call({
 ClinicSettingsClinicModel? clinic,@JsonKey(name: 'pending_update') bool pendingUpdate
});


$ClinicSettingsClinicModelCopyWith<$Res>? get clinic;

}
/// @nodoc
class _$ClinicSettingsProfileModelCopyWithImpl<$Res>
    implements $ClinicSettingsProfileModelCopyWith<$Res> {
  _$ClinicSettingsProfileModelCopyWithImpl(this._self, this._then);

  final ClinicSettingsProfileModel _self;
  final $Res Function(ClinicSettingsProfileModel) _then;

/// Create a copy of ClinicSettingsProfileModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? clinic = freezed,Object? pendingUpdate = null,}) {
  return _then(_self.copyWith(
clinic: freezed == clinic ? _self.clinic : clinic // ignore: cast_nullable_to_non_nullable
as ClinicSettingsClinicModel?,pendingUpdate: null == pendingUpdate ? _self.pendingUpdate : pendingUpdate // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}
/// Create a copy of ClinicSettingsProfileModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ClinicSettingsClinicModelCopyWith<$Res>? get clinic {
    if (_self.clinic == null) {
    return null;
  }

  return $ClinicSettingsClinicModelCopyWith<$Res>(_self.clinic!, (value) {
    return _then(_self.copyWith(clinic: value));
  });
}
}


/// Adds pattern-matching-related methods to [ClinicSettingsProfileModel].
extension ClinicSettingsProfileModelPatterns on ClinicSettingsProfileModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ClinicSettingsProfileModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ClinicSettingsProfileModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ClinicSettingsProfileModel value)  $default,){
final _that = this;
switch (_that) {
case _ClinicSettingsProfileModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ClinicSettingsProfileModel value)?  $default,){
final _that = this;
switch (_that) {
case _ClinicSettingsProfileModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( ClinicSettingsClinicModel? clinic, @JsonKey(name: 'pending_update')  bool pendingUpdate)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ClinicSettingsProfileModel() when $default != null:
return $default(_that.clinic,_that.pendingUpdate);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( ClinicSettingsClinicModel? clinic, @JsonKey(name: 'pending_update')  bool pendingUpdate)  $default,) {final _that = this;
switch (_that) {
case _ClinicSettingsProfileModel():
return $default(_that.clinic,_that.pendingUpdate);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( ClinicSettingsClinicModel? clinic, @JsonKey(name: 'pending_update')  bool pendingUpdate)?  $default,) {final _that = this;
switch (_that) {
case _ClinicSettingsProfileModel() when $default != null:
return $default(_that.clinic,_that.pendingUpdate);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ClinicSettingsProfileModel implements ClinicSettingsProfileModel {
  const _ClinicSettingsProfileModel({this.clinic, @JsonKey(name: 'pending_update') this.pendingUpdate = false});
  factory _ClinicSettingsProfileModel.fromJson(Map<String, dynamic> json) => _$ClinicSettingsProfileModelFromJson(json);

@override final  ClinicSettingsClinicModel? clinic;
@override@JsonKey(name: 'pending_update') final  bool pendingUpdate;

/// Create a copy of ClinicSettingsProfileModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ClinicSettingsProfileModelCopyWith<_ClinicSettingsProfileModel> get copyWith => __$ClinicSettingsProfileModelCopyWithImpl<_ClinicSettingsProfileModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ClinicSettingsProfileModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ClinicSettingsProfileModel&&(identical(other.clinic, clinic) || other.clinic == clinic)&&(identical(other.pendingUpdate, pendingUpdate) || other.pendingUpdate == pendingUpdate));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,clinic,pendingUpdate);

@override
String toString() {
  return 'ClinicSettingsProfileModel(clinic: $clinic, pendingUpdate: $pendingUpdate)';
}


}

/// @nodoc
abstract mixin class _$ClinicSettingsProfileModelCopyWith<$Res> implements $ClinicSettingsProfileModelCopyWith<$Res> {
  factory _$ClinicSettingsProfileModelCopyWith(_ClinicSettingsProfileModel value, $Res Function(_ClinicSettingsProfileModel) _then) = __$ClinicSettingsProfileModelCopyWithImpl;
@override @useResult
$Res call({
 ClinicSettingsClinicModel? clinic,@JsonKey(name: 'pending_update') bool pendingUpdate
});


@override $ClinicSettingsClinicModelCopyWith<$Res>? get clinic;

}
/// @nodoc
class __$ClinicSettingsProfileModelCopyWithImpl<$Res>
    implements _$ClinicSettingsProfileModelCopyWith<$Res> {
  __$ClinicSettingsProfileModelCopyWithImpl(this._self, this._then);

  final _ClinicSettingsProfileModel _self;
  final $Res Function(_ClinicSettingsProfileModel) _then;

/// Create a copy of ClinicSettingsProfileModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? clinic = freezed,Object? pendingUpdate = null,}) {
  return _then(_ClinicSettingsProfileModel(
clinic: freezed == clinic ? _self.clinic : clinic // ignore: cast_nullable_to_non_nullable
as ClinicSettingsClinicModel?,pendingUpdate: null == pendingUpdate ? _self.pendingUpdate : pendingUpdate // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

/// Create a copy of ClinicSettingsProfileModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ClinicSettingsClinicModelCopyWith<$Res>? get clinic {
    if (_self.clinic == null) {
    return null;
  }

  return $ClinicSettingsClinicModelCopyWith<$Res>(_self.clinic!, (value) {
    return _then(_self.copyWith(clinic: value));
  });
}
}


/// @nodoc
mixin _$ClinicSettingsProfileUpdateModel {

@JsonKey(name: 'submitted_for_review') bool get submittedForReview; ClinicSettingsClinicModel? get clinic;
/// Create a copy of ClinicSettingsProfileUpdateModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ClinicSettingsProfileUpdateModelCopyWith<ClinicSettingsProfileUpdateModel> get copyWith => _$ClinicSettingsProfileUpdateModelCopyWithImpl<ClinicSettingsProfileUpdateModel>(this as ClinicSettingsProfileUpdateModel, _$identity);

  /// Serializes this ClinicSettingsProfileUpdateModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ClinicSettingsProfileUpdateModel&&(identical(other.submittedForReview, submittedForReview) || other.submittedForReview == submittedForReview)&&(identical(other.clinic, clinic) || other.clinic == clinic));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,submittedForReview,clinic);

@override
String toString() {
  return 'ClinicSettingsProfileUpdateModel(submittedForReview: $submittedForReview, clinic: $clinic)';
}


}

/// @nodoc
abstract mixin class $ClinicSettingsProfileUpdateModelCopyWith<$Res>  {
  factory $ClinicSettingsProfileUpdateModelCopyWith(ClinicSettingsProfileUpdateModel value, $Res Function(ClinicSettingsProfileUpdateModel) _then) = _$ClinicSettingsProfileUpdateModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'submitted_for_review') bool submittedForReview, ClinicSettingsClinicModel? clinic
});


$ClinicSettingsClinicModelCopyWith<$Res>? get clinic;

}
/// @nodoc
class _$ClinicSettingsProfileUpdateModelCopyWithImpl<$Res>
    implements $ClinicSettingsProfileUpdateModelCopyWith<$Res> {
  _$ClinicSettingsProfileUpdateModelCopyWithImpl(this._self, this._then);

  final ClinicSettingsProfileUpdateModel _self;
  final $Res Function(ClinicSettingsProfileUpdateModel) _then;

/// Create a copy of ClinicSettingsProfileUpdateModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? submittedForReview = null,Object? clinic = freezed,}) {
  return _then(_self.copyWith(
submittedForReview: null == submittedForReview ? _self.submittedForReview : submittedForReview // ignore: cast_nullable_to_non_nullable
as bool,clinic: freezed == clinic ? _self.clinic : clinic // ignore: cast_nullable_to_non_nullable
as ClinicSettingsClinicModel?,
  ));
}
/// Create a copy of ClinicSettingsProfileUpdateModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ClinicSettingsClinicModelCopyWith<$Res>? get clinic {
    if (_self.clinic == null) {
    return null;
  }

  return $ClinicSettingsClinicModelCopyWith<$Res>(_self.clinic!, (value) {
    return _then(_self.copyWith(clinic: value));
  });
}
}


/// Adds pattern-matching-related methods to [ClinicSettingsProfileUpdateModel].
extension ClinicSettingsProfileUpdateModelPatterns on ClinicSettingsProfileUpdateModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ClinicSettingsProfileUpdateModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ClinicSettingsProfileUpdateModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ClinicSettingsProfileUpdateModel value)  $default,){
final _that = this;
switch (_that) {
case _ClinicSettingsProfileUpdateModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ClinicSettingsProfileUpdateModel value)?  $default,){
final _that = this;
switch (_that) {
case _ClinicSettingsProfileUpdateModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'submitted_for_review')  bool submittedForReview,  ClinicSettingsClinicModel? clinic)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ClinicSettingsProfileUpdateModel() when $default != null:
return $default(_that.submittedForReview,_that.clinic);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'submitted_for_review')  bool submittedForReview,  ClinicSettingsClinicModel? clinic)  $default,) {final _that = this;
switch (_that) {
case _ClinicSettingsProfileUpdateModel():
return $default(_that.submittedForReview,_that.clinic);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'submitted_for_review')  bool submittedForReview,  ClinicSettingsClinicModel? clinic)?  $default,) {final _that = this;
switch (_that) {
case _ClinicSettingsProfileUpdateModel() when $default != null:
return $default(_that.submittedForReview,_that.clinic);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ClinicSettingsProfileUpdateModel implements ClinicSettingsProfileUpdateModel {
  const _ClinicSettingsProfileUpdateModel({@JsonKey(name: 'submitted_for_review') this.submittedForReview = false, this.clinic});
  factory _ClinicSettingsProfileUpdateModel.fromJson(Map<String, dynamic> json) => _$ClinicSettingsProfileUpdateModelFromJson(json);

@override@JsonKey(name: 'submitted_for_review') final  bool submittedForReview;
@override final  ClinicSettingsClinicModel? clinic;

/// Create a copy of ClinicSettingsProfileUpdateModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ClinicSettingsProfileUpdateModelCopyWith<_ClinicSettingsProfileUpdateModel> get copyWith => __$ClinicSettingsProfileUpdateModelCopyWithImpl<_ClinicSettingsProfileUpdateModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ClinicSettingsProfileUpdateModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ClinicSettingsProfileUpdateModel&&(identical(other.submittedForReview, submittedForReview) || other.submittedForReview == submittedForReview)&&(identical(other.clinic, clinic) || other.clinic == clinic));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,submittedForReview,clinic);

@override
String toString() {
  return 'ClinicSettingsProfileUpdateModel(submittedForReview: $submittedForReview, clinic: $clinic)';
}


}

/// @nodoc
abstract mixin class _$ClinicSettingsProfileUpdateModelCopyWith<$Res> implements $ClinicSettingsProfileUpdateModelCopyWith<$Res> {
  factory _$ClinicSettingsProfileUpdateModelCopyWith(_ClinicSettingsProfileUpdateModel value, $Res Function(_ClinicSettingsProfileUpdateModel) _then) = __$ClinicSettingsProfileUpdateModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'submitted_for_review') bool submittedForReview, ClinicSettingsClinicModel? clinic
});


@override $ClinicSettingsClinicModelCopyWith<$Res>? get clinic;

}
/// @nodoc
class __$ClinicSettingsProfileUpdateModelCopyWithImpl<$Res>
    implements _$ClinicSettingsProfileUpdateModelCopyWith<$Res> {
  __$ClinicSettingsProfileUpdateModelCopyWithImpl(this._self, this._then);

  final _ClinicSettingsProfileUpdateModel _self;
  final $Res Function(_ClinicSettingsProfileUpdateModel) _then;

/// Create a copy of ClinicSettingsProfileUpdateModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? submittedForReview = null,Object? clinic = freezed,}) {
  return _then(_ClinicSettingsProfileUpdateModel(
submittedForReview: null == submittedForReview ? _self.submittedForReview : submittedForReview // ignore: cast_nullable_to_non_nullable
as bool,clinic: freezed == clinic ? _self.clinic : clinic // ignore: cast_nullable_to_non_nullable
as ClinicSettingsClinicModel?,
  ));
}

/// Create a copy of ClinicSettingsProfileUpdateModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ClinicSettingsClinicModelCopyWith<$Res>? get clinic {
    if (_self.clinic == null) {
    return null;
  }

  return $ClinicSettingsClinicModelCopyWith<$Res>(_self.clinic!, (value) {
    return _then(_self.copyWith(clinic: value));
  });
}
}


/// @nodoc
mixin _$ClinicSettingsClinicModel {

@JsonKey(name: 'clinic_id') int? get clinicId; String? get name; String? get email; String? get phone; String? get location;@JsonKey(name: 'license_number') String? get licenseNumber; String? get description; String? get website; String? get logo; String? get cover; Object? get lat; Object? get lng; String? get status;@JsonKey(name: 'is_active') bool? get isActive; String? get type;@JsonKey(name: 'working_hours') List<dynamic> get workingHours;
/// Create a copy of ClinicSettingsClinicModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ClinicSettingsClinicModelCopyWith<ClinicSettingsClinicModel> get copyWith => _$ClinicSettingsClinicModelCopyWithImpl<ClinicSettingsClinicModel>(this as ClinicSettingsClinicModel, _$identity);

  /// Serializes this ClinicSettingsClinicModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ClinicSettingsClinicModel&&(identical(other.clinicId, clinicId) || other.clinicId == clinicId)&&(identical(other.name, name) || other.name == name)&&(identical(other.email, email) || other.email == email)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.location, location) || other.location == location)&&(identical(other.licenseNumber, licenseNumber) || other.licenseNumber == licenseNumber)&&(identical(other.description, description) || other.description == description)&&(identical(other.website, website) || other.website == website)&&(identical(other.logo, logo) || other.logo == logo)&&(identical(other.cover, cover) || other.cover == cover)&&const DeepCollectionEquality().equals(other.lat, lat)&&const DeepCollectionEquality().equals(other.lng, lng)&&(identical(other.status, status) || other.status == status)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.type, type) || other.type == type)&&const DeepCollectionEquality().equals(other.workingHours, workingHours));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,clinicId,name,email,phone,location,licenseNumber,description,website,logo,cover,const DeepCollectionEquality().hash(lat),const DeepCollectionEquality().hash(lng),status,isActive,type,const DeepCollectionEquality().hash(workingHours));

@override
String toString() {
  return 'ClinicSettingsClinicModel(clinicId: $clinicId, name: $name, email: $email, phone: $phone, location: $location, licenseNumber: $licenseNumber, description: $description, website: $website, logo: $logo, cover: $cover, lat: $lat, lng: $lng, status: $status, isActive: $isActive, type: $type, workingHours: $workingHours)';
}


}

/// @nodoc
abstract mixin class $ClinicSettingsClinicModelCopyWith<$Res>  {
  factory $ClinicSettingsClinicModelCopyWith(ClinicSettingsClinicModel value, $Res Function(ClinicSettingsClinicModel) _then) = _$ClinicSettingsClinicModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'clinic_id') int? clinicId, String? name, String? email, String? phone, String? location,@JsonKey(name: 'license_number') String? licenseNumber, String? description, String? website, String? logo, String? cover, Object? lat, Object? lng, String? status,@JsonKey(name: 'is_active') bool? isActive, String? type,@JsonKey(name: 'working_hours') List<dynamic> workingHours
});




}
/// @nodoc
class _$ClinicSettingsClinicModelCopyWithImpl<$Res>
    implements $ClinicSettingsClinicModelCopyWith<$Res> {
  _$ClinicSettingsClinicModelCopyWithImpl(this._self, this._then);

  final ClinicSettingsClinicModel _self;
  final $Res Function(ClinicSettingsClinicModel) _then;

/// Create a copy of ClinicSettingsClinicModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? clinicId = freezed,Object? name = freezed,Object? email = freezed,Object? phone = freezed,Object? location = freezed,Object? licenseNumber = freezed,Object? description = freezed,Object? website = freezed,Object? logo = freezed,Object? cover = freezed,Object? lat = freezed,Object? lng = freezed,Object? status = freezed,Object? isActive = freezed,Object? type = freezed,Object? workingHours = null,}) {
  return _then(_self.copyWith(
clinicId: freezed == clinicId ? _self.clinicId : clinicId // ignore: cast_nullable_to_non_nullable
as int?,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,phone: freezed == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String?,location: freezed == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String?,licenseNumber: freezed == licenseNumber ? _self.licenseNumber : licenseNumber // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,website: freezed == website ? _self.website : website // ignore: cast_nullable_to_non_nullable
as String?,logo: freezed == logo ? _self.logo : logo // ignore: cast_nullable_to_non_nullable
as String?,cover: freezed == cover ? _self.cover : cover // ignore: cast_nullable_to_non_nullable
as String?,lat: freezed == lat ? _self.lat : lat ,lng: freezed == lng ? _self.lng : lng ,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,isActive: freezed == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool?,type: freezed == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String?,workingHours: null == workingHours ? _self.workingHours : workingHours // ignore: cast_nullable_to_non_nullable
as List<dynamic>,
  ));
}

}


/// Adds pattern-matching-related methods to [ClinicSettingsClinicModel].
extension ClinicSettingsClinicModelPatterns on ClinicSettingsClinicModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ClinicSettingsClinicModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ClinicSettingsClinicModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ClinicSettingsClinicModel value)  $default,){
final _that = this;
switch (_that) {
case _ClinicSettingsClinicModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ClinicSettingsClinicModel value)?  $default,){
final _that = this;
switch (_that) {
case _ClinicSettingsClinicModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'clinic_id')  int? clinicId,  String? name,  String? email,  String? phone,  String? location, @JsonKey(name: 'license_number')  String? licenseNumber,  String? description,  String? website,  String? logo,  String? cover,  Object? lat,  Object? lng,  String? status, @JsonKey(name: 'is_active')  bool? isActive,  String? type, @JsonKey(name: 'working_hours')  List<dynamic> workingHours)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ClinicSettingsClinicModel() when $default != null:
return $default(_that.clinicId,_that.name,_that.email,_that.phone,_that.location,_that.licenseNumber,_that.description,_that.website,_that.logo,_that.cover,_that.lat,_that.lng,_that.status,_that.isActive,_that.type,_that.workingHours);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'clinic_id')  int? clinicId,  String? name,  String? email,  String? phone,  String? location, @JsonKey(name: 'license_number')  String? licenseNumber,  String? description,  String? website,  String? logo,  String? cover,  Object? lat,  Object? lng,  String? status, @JsonKey(name: 'is_active')  bool? isActive,  String? type, @JsonKey(name: 'working_hours')  List<dynamic> workingHours)  $default,) {final _that = this;
switch (_that) {
case _ClinicSettingsClinicModel():
return $default(_that.clinicId,_that.name,_that.email,_that.phone,_that.location,_that.licenseNumber,_that.description,_that.website,_that.logo,_that.cover,_that.lat,_that.lng,_that.status,_that.isActive,_that.type,_that.workingHours);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'clinic_id')  int? clinicId,  String? name,  String? email,  String? phone,  String? location, @JsonKey(name: 'license_number')  String? licenseNumber,  String? description,  String? website,  String? logo,  String? cover,  Object? lat,  Object? lng,  String? status, @JsonKey(name: 'is_active')  bool? isActive,  String? type, @JsonKey(name: 'working_hours')  List<dynamic> workingHours)?  $default,) {final _that = this;
switch (_that) {
case _ClinicSettingsClinicModel() when $default != null:
return $default(_that.clinicId,_that.name,_that.email,_that.phone,_that.location,_that.licenseNumber,_that.description,_that.website,_that.logo,_that.cover,_that.lat,_that.lng,_that.status,_that.isActive,_that.type,_that.workingHours);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ClinicSettingsClinicModel implements ClinicSettingsClinicModel {
  const _ClinicSettingsClinicModel({@JsonKey(name: 'clinic_id') this.clinicId, this.name, this.email, this.phone, this.location, @JsonKey(name: 'license_number') this.licenseNumber, this.description, this.website, this.logo, this.cover, this.lat, this.lng, this.status, @JsonKey(name: 'is_active') this.isActive, this.type, @JsonKey(name: 'working_hours') final  List<dynamic> workingHours = const []}): _workingHours = workingHours;
  factory _ClinicSettingsClinicModel.fromJson(Map<String, dynamic> json) => _$ClinicSettingsClinicModelFromJson(json);

@override@JsonKey(name: 'clinic_id') final  int? clinicId;
@override final  String? name;
@override final  String? email;
@override final  String? phone;
@override final  String? location;
@override@JsonKey(name: 'license_number') final  String? licenseNumber;
@override final  String? description;
@override final  String? website;
@override final  String? logo;
@override final  String? cover;
@override final  Object? lat;
@override final  Object? lng;
@override final  String? status;
@override@JsonKey(name: 'is_active') final  bool? isActive;
@override final  String? type;
 final  List<dynamic> _workingHours;
@override@JsonKey(name: 'working_hours') List<dynamic> get workingHours {
  if (_workingHours is EqualUnmodifiableListView) return _workingHours;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_workingHours);
}


/// Create a copy of ClinicSettingsClinicModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ClinicSettingsClinicModelCopyWith<_ClinicSettingsClinicModel> get copyWith => __$ClinicSettingsClinicModelCopyWithImpl<_ClinicSettingsClinicModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ClinicSettingsClinicModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ClinicSettingsClinicModel&&(identical(other.clinicId, clinicId) || other.clinicId == clinicId)&&(identical(other.name, name) || other.name == name)&&(identical(other.email, email) || other.email == email)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.location, location) || other.location == location)&&(identical(other.licenseNumber, licenseNumber) || other.licenseNumber == licenseNumber)&&(identical(other.description, description) || other.description == description)&&(identical(other.website, website) || other.website == website)&&(identical(other.logo, logo) || other.logo == logo)&&(identical(other.cover, cover) || other.cover == cover)&&const DeepCollectionEquality().equals(other.lat, lat)&&const DeepCollectionEquality().equals(other.lng, lng)&&(identical(other.status, status) || other.status == status)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.type, type) || other.type == type)&&const DeepCollectionEquality().equals(other._workingHours, _workingHours));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,clinicId,name,email,phone,location,licenseNumber,description,website,logo,cover,const DeepCollectionEquality().hash(lat),const DeepCollectionEquality().hash(lng),status,isActive,type,const DeepCollectionEquality().hash(_workingHours));

@override
String toString() {
  return 'ClinicSettingsClinicModel(clinicId: $clinicId, name: $name, email: $email, phone: $phone, location: $location, licenseNumber: $licenseNumber, description: $description, website: $website, logo: $logo, cover: $cover, lat: $lat, lng: $lng, status: $status, isActive: $isActive, type: $type, workingHours: $workingHours)';
}


}

/// @nodoc
abstract mixin class _$ClinicSettingsClinicModelCopyWith<$Res> implements $ClinicSettingsClinicModelCopyWith<$Res> {
  factory _$ClinicSettingsClinicModelCopyWith(_ClinicSettingsClinicModel value, $Res Function(_ClinicSettingsClinicModel) _then) = __$ClinicSettingsClinicModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'clinic_id') int? clinicId, String? name, String? email, String? phone, String? location,@JsonKey(name: 'license_number') String? licenseNumber, String? description, String? website, String? logo, String? cover, Object? lat, Object? lng, String? status,@JsonKey(name: 'is_active') bool? isActive, String? type,@JsonKey(name: 'working_hours') List<dynamic> workingHours
});




}
/// @nodoc
class __$ClinicSettingsClinicModelCopyWithImpl<$Res>
    implements _$ClinicSettingsClinicModelCopyWith<$Res> {
  __$ClinicSettingsClinicModelCopyWithImpl(this._self, this._then);

  final _ClinicSettingsClinicModel _self;
  final $Res Function(_ClinicSettingsClinicModel) _then;

/// Create a copy of ClinicSettingsClinicModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? clinicId = freezed,Object? name = freezed,Object? email = freezed,Object? phone = freezed,Object? location = freezed,Object? licenseNumber = freezed,Object? description = freezed,Object? website = freezed,Object? logo = freezed,Object? cover = freezed,Object? lat = freezed,Object? lng = freezed,Object? status = freezed,Object? isActive = freezed,Object? type = freezed,Object? workingHours = null,}) {
  return _then(_ClinicSettingsClinicModel(
clinicId: freezed == clinicId ? _self.clinicId : clinicId // ignore: cast_nullable_to_non_nullable
as int?,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,phone: freezed == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String?,location: freezed == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String?,licenseNumber: freezed == licenseNumber ? _self.licenseNumber : licenseNumber // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,website: freezed == website ? _self.website : website // ignore: cast_nullable_to_non_nullable
as String?,logo: freezed == logo ? _self.logo : logo // ignore: cast_nullable_to_non_nullable
as String?,cover: freezed == cover ? _self.cover : cover // ignore: cast_nullable_to_non_nullable
as String?,lat: freezed == lat ? _self.lat : lat ,lng: freezed == lng ? _self.lng : lng ,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,isActive: freezed == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool?,type: freezed == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String?,workingHours: null == workingHours ? _self._workingHours : workingHours // ignore: cast_nullable_to_non_nullable
as List<dynamic>,
  ));
}


}


/// @nodoc
mixin _$ClinicInsuranceModel {

@JsonKey(fromJson: _intFromJson) int get id; String? get name;@JsonKey(name: 'name_ar') String? get nameAr;@JsonKey(name: 'name_en') String? get nameEn; String? get code; String? get logo;@JsonKey(name: 'is_active') bool get isActive;@JsonKey(name: 'is_selected') bool get isSelected;
/// Create a copy of ClinicInsuranceModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ClinicInsuranceModelCopyWith<ClinicInsuranceModel> get copyWith => _$ClinicInsuranceModelCopyWithImpl<ClinicInsuranceModel>(this as ClinicInsuranceModel, _$identity);

  /// Serializes this ClinicInsuranceModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ClinicInsuranceModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.nameAr, nameAr) || other.nameAr == nameAr)&&(identical(other.nameEn, nameEn) || other.nameEn == nameEn)&&(identical(other.code, code) || other.code == code)&&(identical(other.logo, logo) || other.logo == logo)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.isSelected, isSelected) || other.isSelected == isSelected));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,nameAr,nameEn,code,logo,isActive,isSelected);

@override
String toString() {
  return 'ClinicInsuranceModel(id: $id, name: $name, nameAr: $nameAr, nameEn: $nameEn, code: $code, logo: $logo, isActive: $isActive, isSelected: $isSelected)';
}


}

/// @nodoc
abstract mixin class $ClinicInsuranceModelCopyWith<$Res>  {
  factory $ClinicInsuranceModelCopyWith(ClinicInsuranceModel value, $Res Function(ClinicInsuranceModel) _then) = _$ClinicInsuranceModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(fromJson: _intFromJson) int id, String? name,@JsonKey(name: 'name_ar') String? nameAr,@JsonKey(name: 'name_en') String? nameEn, String? code, String? logo,@JsonKey(name: 'is_active') bool isActive,@JsonKey(name: 'is_selected') bool isSelected
});




}
/// @nodoc
class _$ClinicInsuranceModelCopyWithImpl<$Res>
    implements $ClinicInsuranceModelCopyWith<$Res> {
  _$ClinicInsuranceModelCopyWithImpl(this._self, this._then);

  final ClinicInsuranceModel _self;
  final $Res Function(ClinicInsuranceModel) _then;

/// Create a copy of ClinicInsuranceModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = freezed,Object? nameAr = freezed,Object? nameEn = freezed,Object? code = freezed,Object? logo = freezed,Object? isActive = null,Object? isSelected = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,nameAr: freezed == nameAr ? _self.nameAr : nameAr // ignore: cast_nullable_to_non_nullable
as String?,nameEn: freezed == nameEn ? _self.nameEn : nameEn // ignore: cast_nullable_to_non_nullable
as String?,code: freezed == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String?,logo: freezed == logo ? _self.logo : logo // ignore: cast_nullable_to_non_nullable
as String?,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,isSelected: null == isSelected ? _self.isSelected : isSelected // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [ClinicInsuranceModel].
extension ClinicInsuranceModelPatterns on ClinicInsuranceModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ClinicInsuranceModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ClinicInsuranceModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ClinicInsuranceModel value)  $default,){
final _that = this;
switch (_that) {
case _ClinicInsuranceModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ClinicInsuranceModel value)?  $default,){
final _that = this;
switch (_that) {
case _ClinicInsuranceModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(fromJson: _intFromJson)  int id,  String? name, @JsonKey(name: 'name_ar')  String? nameAr, @JsonKey(name: 'name_en')  String? nameEn,  String? code,  String? logo, @JsonKey(name: 'is_active')  bool isActive, @JsonKey(name: 'is_selected')  bool isSelected)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ClinicInsuranceModel() when $default != null:
return $default(_that.id,_that.name,_that.nameAr,_that.nameEn,_that.code,_that.logo,_that.isActive,_that.isSelected);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(fromJson: _intFromJson)  int id,  String? name, @JsonKey(name: 'name_ar')  String? nameAr, @JsonKey(name: 'name_en')  String? nameEn,  String? code,  String? logo, @JsonKey(name: 'is_active')  bool isActive, @JsonKey(name: 'is_selected')  bool isSelected)  $default,) {final _that = this;
switch (_that) {
case _ClinicInsuranceModel():
return $default(_that.id,_that.name,_that.nameAr,_that.nameEn,_that.code,_that.logo,_that.isActive,_that.isSelected);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(fromJson: _intFromJson)  int id,  String? name, @JsonKey(name: 'name_ar')  String? nameAr, @JsonKey(name: 'name_en')  String? nameEn,  String? code,  String? logo, @JsonKey(name: 'is_active')  bool isActive, @JsonKey(name: 'is_selected')  bool isSelected)?  $default,) {final _that = this;
switch (_that) {
case _ClinicInsuranceModel() when $default != null:
return $default(_that.id,_that.name,_that.nameAr,_that.nameEn,_that.code,_that.logo,_that.isActive,_that.isSelected);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ClinicInsuranceModel implements ClinicInsuranceModel {
  const _ClinicInsuranceModel({@JsonKey(fromJson: _intFromJson) required this.id, this.name, @JsonKey(name: 'name_ar') this.nameAr, @JsonKey(name: 'name_en') this.nameEn, this.code, this.logo, @JsonKey(name: 'is_active') this.isActive = true, @JsonKey(name: 'is_selected') this.isSelected = false});
  factory _ClinicInsuranceModel.fromJson(Map<String, dynamic> json) => _$ClinicInsuranceModelFromJson(json);

@override@JsonKey(fromJson: _intFromJson) final  int id;
@override final  String? name;
@override@JsonKey(name: 'name_ar') final  String? nameAr;
@override@JsonKey(name: 'name_en') final  String? nameEn;
@override final  String? code;
@override final  String? logo;
@override@JsonKey(name: 'is_active') final  bool isActive;
@override@JsonKey(name: 'is_selected') final  bool isSelected;

/// Create a copy of ClinicInsuranceModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ClinicInsuranceModelCopyWith<_ClinicInsuranceModel> get copyWith => __$ClinicInsuranceModelCopyWithImpl<_ClinicInsuranceModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ClinicInsuranceModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ClinicInsuranceModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.nameAr, nameAr) || other.nameAr == nameAr)&&(identical(other.nameEn, nameEn) || other.nameEn == nameEn)&&(identical(other.code, code) || other.code == code)&&(identical(other.logo, logo) || other.logo == logo)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.isSelected, isSelected) || other.isSelected == isSelected));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,nameAr,nameEn,code,logo,isActive,isSelected);

@override
String toString() {
  return 'ClinicInsuranceModel(id: $id, name: $name, nameAr: $nameAr, nameEn: $nameEn, code: $code, logo: $logo, isActive: $isActive, isSelected: $isSelected)';
}


}

/// @nodoc
abstract mixin class _$ClinicInsuranceModelCopyWith<$Res> implements $ClinicInsuranceModelCopyWith<$Res> {
  factory _$ClinicInsuranceModelCopyWith(_ClinicInsuranceModel value, $Res Function(_ClinicInsuranceModel) _then) = __$ClinicInsuranceModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(fromJson: _intFromJson) int id, String? name,@JsonKey(name: 'name_ar') String? nameAr,@JsonKey(name: 'name_en') String? nameEn, String? code, String? logo,@JsonKey(name: 'is_active') bool isActive,@JsonKey(name: 'is_selected') bool isSelected
});




}
/// @nodoc
class __$ClinicInsuranceModelCopyWithImpl<$Res>
    implements _$ClinicInsuranceModelCopyWith<$Res> {
  __$ClinicInsuranceModelCopyWithImpl(this._self, this._then);

  final _ClinicInsuranceModel _self;
  final $Res Function(_ClinicInsuranceModel) _then;

/// Create a copy of ClinicInsuranceModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = freezed,Object? nameAr = freezed,Object? nameEn = freezed,Object? code = freezed,Object? logo = freezed,Object? isActive = null,Object? isSelected = null,}) {
  return _then(_ClinicInsuranceModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,nameAr: freezed == nameAr ? _self.nameAr : nameAr // ignore: cast_nullable_to_non_nullable
as String?,nameEn: freezed == nameEn ? _self.nameEn : nameEn // ignore: cast_nullable_to_non_nullable
as String?,code: freezed == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String?,logo: freezed == logo ? _self.logo : logo // ignore: cast_nullable_to_non_nullable
as String?,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,isSelected: null == isSelected ? _self.isSelected : isSelected // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$ClinicNotificationSettingsModel {

@JsonKey(name: 'app_notifications') bool get appNotifications;@JsonKey(name: 'email_notifications') bool get emailNotifications;@JsonKey(name: 'sms_notifications') bool get smsNotifications;
/// Create a copy of ClinicNotificationSettingsModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ClinicNotificationSettingsModelCopyWith<ClinicNotificationSettingsModel> get copyWith => _$ClinicNotificationSettingsModelCopyWithImpl<ClinicNotificationSettingsModel>(this as ClinicNotificationSettingsModel, _$identity);

  /// Serializes this ClinicNotificationSettingsModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ClinicNotificationSettingsModel&&(identical(other.appNotifications, appNotifications) || other.appNotifications == appNotifications)&&(identical(other.emailNotifications, emailNotifications) || other.emailNotifications == emailNotifications)&&(identical(other.smsNotifications, smsNotifications) || other.smsNotifications == smsNotifications));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,appNotifications,emailNotifications,smsNotifications);

@override
String toString() {
  return 'ClinicNotificationSettingsModel(appNotifications: $appNotifications, emailNotifications: $emailNotifications, smsNotifications: $smsNotifications)';
}


}

/// @nodoc
abstract mixin class $ClinicNotificationSettingsModelCopyWith<$Res>  {
  factory $ClinicNotificationSettingsModelCopyWith(ClinicNotificationSettingsModel value, $Res Function(ClinicNotificationSettingsModel) _then) = _$ClinicNotificationSettingsModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'app_notifications') bool appNotifications,@JsonKey(name: 'email_notifications') bool emailNotifications,@JsonKey(name: 'sms_notifications') bool smsNotifications
});




}
/// @nodoc
class _$ClinicNotificationSettingsModelCopyWithImpl<$Res>
    implements $ClinicNotificationSettingsModelCopyWith<$Res> {
  _$ClinicNotificationSettingsModelCopyWithImpl(this._self, this._then);

  final ClinicNotificationSettingsModel _self;
  final $Res Function(ClinicNotificationSettingsModel) _then;

/// Create a copy of ClinicNotificationSettingsModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? appNotifications = null,Object? emailNotifications = null,Object? smsNotifications = null,}) {
  return _then(_self.copyWith(
appNotifications: null == appNotifications ? _self.appNotifications : appNotifications // ignore: cast_nullable_to_non_nullable
as bool,emailNotifications: null == emailNotifications ? _self.emailNotifications : emailNotifications // ignore: cast_nullable_to_non_nullable
as bool,smsNotifications: null == smsNotifications ? _self.smsNotifications : smsNotifications // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [ClinicNotificationSettingsModel].
extension ClinicNotificationSettingsModelPatterns on ClinicNotificationSettingsModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ClinicNotificationSettingsModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ClinicNotificationSettingsModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ClinicNotificationSettingsModel value)  $default,){
final _that = this;
switch (_that) {
case _ClinicNotificationSettingsModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ClinicNotificationSettingsModel value)?  $default,){
final _that = this;
switch (_that) {
case _ClinicNotificationSettingsModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'app_notifications')  bool appNotifications, @JsonKey(name: 'email_notifications')  bool emailNotifications, @JsonKey(name: 'sms_notifications')  bool smsNotifications)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ClinicNotificationSettingsModel() when $default != null:
return $default(_that.appNotifications,_that.emailNotifications,_that.smsNotifications);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'app_notifications')  bool appNotifications, @JsonKey(name: 'email_notifications')  bool emailNotifications, @JsonKey(name: 'sms_notifications')  bool smsNotifications)  $default,) {final _that = this;
switch (_that) {
case _ClinicNotificationSettingsModel():
return $default(_that.appNotifications,_that.emailNotifications,_that.smsNotifications);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'app_notifications')  bool appNotifications, @JsonKey(name: 'email_notifications')  bool emailNotifications, @JsonKey(name: 'sms_notifications')  bool smsNotifications)?  $default,) {final _that = this;
switch (_that) {
case _ClinicNotificationSettingsModel() when $default != null:
return $default(_that.appNotifications,_that.emailNotifications,_that.smsNotifications);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ClinicNotificationSettingsModel implements ClinicNotificationSettingsModel {
  const _ClinicNotificationSettingsModel({@JsonKey(name: 'app_notifications') this.appNotifications = false, @JsonKey(name: 'email_notifications') this.emailNotifications = false, @JsonKey(name: 'sms_notifications') this.smsNotifications = false});
  factory _ClinicNotificationSettingsModel.fromJson(Map<String, dynamic> json) => _$ClinicNotificationSettingsModelFromJson(json);

@override@JsonKey(name: 'app_notifications') final  bool appNotifications;
@override@JsonKey(name: 'email_notifications') final  bool emailNotifications;
@override@JsonKey(name: 'sms_notifications') final  bool smsNotifications;

/// Create a copy of ClinicNotificationSettingsModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ClinicNotificationSettingsModelCopyWith<_ClinicNotificationSettingsModel> get copyWith => __$ClinicNotificationSettingsModelCopyWithImpl<_ClinicNotificationSettingsModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ClinicNotificationSettingsModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ClinicNotificationSettingsModel&&(identical(other.appNotifications, appNotifications) || other.appNotifications == appNotifications)&&(identical(other.emailNotifications, emailNotifications) || other.emailNotifications == emailNotifications)&&(identical(other.smsNotifications, smsNotifications) || other.smsNotifications == smsNotifications));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,appNotifications,emailNotifications,smsNotifications);

@override
String toString() {
  return 'ClinicNotificationSettingsModel(appNotifications: $appNotifications, emailNotifications: $emailNotifications, smsNotifications: $smsNotifications)';
}


}

/// @nodoc
abstract mixin class _$ClinicNotificationSettingsModelCopyWith<$Res> implements $ClinicNotificationSettingsModelCopyWith<$Res> {
  factory _$ClinicNotificationSettingsModelCopyWith(_ClinicNotificationSettingsModel value, $Res Function(_ClinicNotificationSettingsModel) _then) = __$ClinicNotificationSettingsModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'app_notifications') bool appNotifications,@JsonKey(name: 'email_notifications') bool emailNotifications,@JsonKey(name: 'sms_notifications') bool smsNotifications
});




}
/// @nodoc
class __$ClinicNotificationSettingsModelCopyWithImpl<$Res>
    implements _$ClinicNotificationSettingsModelCopyWith<$Res> {
  __$ClinicNotificationSettingsModelCopyWithImpl(this._self, this._then);

  final _ClinicNotificationSettingsModel _self;
  final $Res Function(_ClinicNotificationSettingsModel) _then;

/// Create a copy of ClinicNotificationSettingsModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? appNotifications = null,Object? emailNotifications = null,Object? smsNotifications = null,}) {
  return _then(_ClinicNotificationSettingsModel(
appNotifications: null == appNotifications ? _self.appNotifications : appNotifications // ignore: cast_nullable_to_non_nullable
as bool,emailNotifications: null == emailNotifications ? _self.emailNotifications : emailNotifications // ignore: cast_nullable_to_non_nullable
as bool,smsNotifications: null == smsNotifications ? _self.smsNotifications : smsNotifications // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$ClinicPasswordChangeModel {

@JsonKey(name: 'password_changed') bool get passwordChanged;
/// Create a copy of ClinicPasswordChangeModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ClinicPasswordChangeModelCopyWith<ClinicPasswordChangeModel> get copyWith => _$ClinicPasswordChangeModelCopyWithImpl<ClinicPasswordChangeModel>(this as ClinicPasswordChangeModel, _$identity);

  /// Serializes this ClinicPasswordChangeModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ClinicPasswordChangeModel&&(identical(other.passwordChanged, passwordChanged) || other.passwordChanged == passwordChanged));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,passwordChanged);

@override
String toString() {
  return 'ClinicPasswordChangeModel(passwordChanged: $passwordChanged)';
}


}

/// @nodoc
abstract mixin class $ClinicPasswordChangeModelCopyWith<$Res>  {
  factory $ClinicPasswordChangeModelCopyWith(ClinicPasswordChangeModel value, $Res Function(ClinicPasswordChangeModel) _then) = _$ClinicPasswordChangeModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'password_changed') bool passwordChanged
});




}
/// @nodoc
class _$ClinicPasswordChangeModelCopyWithImpl<$Res>
    implements $ClinicPasswordChangeModelCopyWith<$Res> {
  _$ClinicPasswordChangeModelCopyWithImpl(this._self, this._then);

  final ClinicPasswordChangeModel _self;
  final $Res Function(ClinicPasswordChangeModel) _then;

/// Create a copy of ClinicPasswordChangeModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? passwordChanged = null,}) {
  return _then(_self.copyWith(
passwordChanged: null == passwordChanged ? _self.passwordChanged : passwordChanged // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [ClinicPasswordChangeModel].
extension ClinicPasswordChangeModelPatterns on ClinicPasswordChangeModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ClinicPasswordChangeModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ClinicPasswordChangeModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ClinicPasswordChangeModel value)  $default,){
final _that = this;
switch (_that) {
case _ClinicPasswordChangeModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ClinicPasswordChangeModel value)?  $default,){
final _that = this;
switch (_that) {
case _ClinicPasswordChangeModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'password_changed')  bool passwordChanged)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ClinicPasswordChangeModel() when $default != null:
return $default(_that.passwordChanged);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'password_changed')  bool passwordChanged)  $default,) {final _that = this;
switch (_that) {
case _ClinicPasswordChangeModel():
return $default(_that.passwordChanged);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'password_changed')  bool passwordChanged)?  $default,) {final _that = this;
switch (_that) {
case _ClinicPasswordChangeModel() when $default != null:
return $default(_that.passwordChanged);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ClinicPasswordChangeModel implements ClinicPasswordChangeModel {
  const _ClinicPasswordChangeModel({@JsonKey(name: 'password_changed') this.passwordChanged = false});
  factory _ClinicPasswordChangeModel.fromJson(Map<String, dynamic> json) => _$ClinicPasswordChangeModelFromJson(json);

@override@JsonKey(name: 'password_changed') final  bool passwordChanged;

/// Create a copy of ClinicPasswordChangeModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ClinicPasswordChangeModelCopyWith<_ClinicPasswordChangeModel> get copyWith => __$ClinicPasswordChangeModelCopyWithImpl<_ClinicPasswordChangeModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ClinicPasswordChangeModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ClinicPasswordChangeModel&&(identical(other.passwordChanged, passwordChanged) || other.passwordChanged == passwordChanged));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,passwordChanged);

@override
String toString() {
  return 'ClinicPasswordChangeModel(passwordChanged: $passwordChanged)';
}


}

/// @nodoc
abstract mixin class _$ClinicPasswordChangeModelCopyWith<$Res> implements $ClinicPasswordChangeModelCopyWith<$Res> {
  factory _$ClinicPasswordChangeModelCopyWith(_ClinicPasswordChangeModel value, $Res Function(_ClinicPasswordChangeModel) _then) = __$ClinicPasswordChangeModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'password_changed') bool passwordChanged
});




}
/// @nodoc
class __$ClinicPasswordChangeModelCopyWithImpl<$Res>
    implements _$ClinicPasswordChangeModelCopyWith<$Res> {
  __$ClinicPasswordChangeModelCopyWithImpl(this._self, this._then);

  final _ClinicPasswordChangeModel _self;
  final $Res Function(_ClinicPasswordChangeModel) _then;

/// Create a copy of ClinicPasswordChangeModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? passwordChanged = null,}) {
  return _then(_ClinicPasswordChangeModel(
passwordChanged: null == passwordChanged ? _self.passwordChanged : passwordChanged // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
