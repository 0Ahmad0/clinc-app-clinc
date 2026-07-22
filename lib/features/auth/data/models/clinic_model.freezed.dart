// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'clinic_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ClinicModel {

@JsonKey(name: 'clinic_id') String? get clinicId; String? get name; String? get location;@JsonKey(name: 'doctors_count') int? get doctorsCount;@JsonKey(name: 'appointments_count') int? get appointmentsCount; num? get revenue; num? get rating; String? get status; String? get email; String? get phone; String? get type; String? get logo; String? get cover; String? get description; Object? get lat; Object? get lng;@JsonKey(name: 'is_active') bool? get isActive;@JsonKey(name: 'created_at') String? get createdAt;
/// Create a copy of ClinicModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ClinicModelCopyWith<ClinicModel> get copyWith => _$ClinicModelCopyWithImpl<ClinicModel>(this as ClinicModel, _$identity);

  /// Serializes this ClinicModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ClinicModel&&(identical(other.clinicId, clinicId) || other.clinicId == clinicId)&&(identical(other.name, name) || other.name == name)&&(identical(other.location, location) || other.location == location)&&(identical(other.doctorsCount, doctorsCount) || other.doctorsCount == doctorsCount)&&(identical(other.appointmentsCount, appointmentsCount) || other.appointmentsCount == appointmentsCount)&&(identical(other.revenue, revenue) || other.revenue == revenue)&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.status, status) || other.status == status)&&(identical(other.email, email) || other.email == email)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.type, type) || other.type == type)&&(identical(other.logo, logo) || other.logo == logo)&&(identical(other.cover, cover) || other.cover == cover)&&(identical(other.description, description) || other.description == description)&&const DeepCollectionEquality().equals(other.lat, lat)&&const DeepCollectionEquality().equals(other.lng, lng)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,clinicId,name,location,doctorsCount,appointmentsCount,revenue,rating,status,email,phone,type,logo,cover,description,const DeepCollectionEquality().hash(lat),const DeepCollectionEquality().hash(lng),isActive,createdAt);

@override
String toString() {
  return 'ClinicModel(clinicId: $clinicId, name: $name, location: $location, doctorsCount: $doctorsCount, appointmentsCount: $appointmentsCount, revenue: $revenue, rating: $rating, status: $status, email: $email, phone: $phone, type: $type, logo: $logo, cover: $cover, description: $description, lat: $lat, lng: $lng, isActive: $isActive, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $ClinicModelCopyWith<$Res>  {
  factory $ClinicModelCopyWith(ClinicModel value, $Res Function(ClinicModel) _then) = _$ClinicModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'clinic_id') String? clinicId, String? name, String? location,@JsonKey(name: 'doctors_count') int? doctorsCount,@JsonKey(name: 'appointments_count') int? appointmentsCount, num? revenue, num? rating, String? status, String? email, String? phone, String? type, String? logo, String? cover, String? description, Object? lat, Object? lng,@JsonKey(name: 'is_active') bool? isActive,@JsonKey(name: 'created_at') String? createdAt
});




}
/// @nodoc
class _$ClinicModelCopyWithImpl<$Res>
    implements $ClinicModelCopyWith<$Res> {
  _$ClinicModelCopyWithImpl(this._self, this._then);

  final ClinicModel _self;
  final $Res Function(ClinicModel) _then;

/// Create a copy of ClinicModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? clinicId = freezed,Object? name = freezed,Object? location = freezed,Object? doctorsCount = freezed,Object? appointmentsCount = freezed,Object? revenue = freezed,Object? rating = freezed,Object? status = freezed,Object? email = freezed,Object? phone = freezed,Object? type = freezed,Object? logo = freezed,Object? cover = freezed,Object? description = freezed,Object? lat = freezed,Object? lng = freezed,Object? isActive = freezed,Object? createdAt = freezed,}) {
  return _then(_self.copyWith(
clinicId: freezed == clinicId ? _self.clinicId : clinicId // ignore: cast_nullable_to_non_nullable
as String?,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,location: freezed == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String?,doctorsCount: freezed == doctorsCount ? _self.doctorsCount : doctorsCount // ignore: cast_nullable_to_non_nullable
as int?,appointmentsCount: freezed == appointmentsCount ? _self.appointmentsCount : appointmentsCount // ignore: cast_nullable_to_non_nullable
as int?,revenue: freezed == revenue ? _self.revenue : revenue // ignore: cast_nullable_to_non_nullable
as num?,rating: freezed == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as num?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,phone: freezed == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String?,type: freezed == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String?,logo: freezed == logo ? _self.logo : logo // ignore: cast_nullable_to_non_nullable
as String?,cover: freezed == cover ? _self.cover : cover // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,lat: freezed == lat ? _self.lat : lat ,lng: freezed == lng ? _self.lng : lng ,isActive: freezed == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ClinicModel].
extension ClinicModelPatterns on ClinicModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ClinicModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ClinicModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ClinicModel value)  $default,){
final _that = this;
switch (_that) {
case _ClinicModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ClinicModel value)?  $default,){
final _that = this;
switch (_that) {
case _ClinicModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'clinic_id')  String? clinicId,  String? name,  String? location, @JsonKey(name: 'doctors_count')  int? doctorsCount, @JsonKey(name: 'appointments_count')  int? appointmentsCount,  num? revenue,  num? rating,  String? status,  String? email,  String? phone,  String? type,  String? logo,  String? cover,  String? description,  Object? lat,  Object? lng, @JsonKey(name: 'is_active')  bool? isActive, @JsonKey(name: 'created_at')  String? createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ClinicModel() when $default != null:
return $default(_that.clinicId,_that.name,_that.location,_that.doctorsCount,_that.appointmentsCount,_that.revenue,_that.rating,_that.status,_that.email,_that.phone,_that.type,_that.logo,_that.cover,_that.description,_that.lat,_that.lng,_that.isActive,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'clinic_id')  String? clinicId,  String? name,  String? location, @JsonKey(name: 'doctors_count')  int? doctorsCount, @JsonKey(name: 'appointments_count')  int? appointmentsCount,  num? revenue,  num? rating,  String? status,  String? email,  String? phone,  String? type,  String? logo,  String? cover,  String? description,  Object? lat,  Object? lng, @JsonKey(name: 'is_active')  bool? isActive, @JsonKey(name: 'created_at')  String? createdAt)  $default,) {final _that = this;
switch (_that) {
case _ClinicModel():
return $default(_that.clinicId,_that.name,_that.location,_that.doctorsCount,_that.appointmentsCount,_that.revenue,_that.rating,_that.status,_that.email,_that.phone,_that.type,_that.logo,_that.cover,_that.description,_that.lat,_that.lng,_that.isActive,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'clinic_id')  String? clinicId,  String? name,  String? location, @JsonKey(name: 'doctors_count')  int? doctorsCount, @JsonKey(name: 'appointments_count')  int? appointmentsCount,  num? revenue,  num? rating,  String? status,  String? email,  String? phone,  String? type,  String? logo,  String? cover,  String? description,  Object? lat,  Object? lng, @JsonKey(name: 'is_active')  bool? isActive, @JsonKey(name: 'created_at')  String? createdAt)?  $default,) {final _that = this;
switch (_that) {
case _ClinicModel() when $default != null:
return $default(_that.clinicId,_that.name,_that.location,_that.doctorsCount,_that.appointmentsCount,_that.revenue,_that.rating,_that.status,_that.email,_that.phone,_that.type,_that.logo,_that.cover,_that.description,_that.lat,_that.lng,_that.isActive,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ClinicModel implements ClinicModel {
  const _ClinicModel({@JsonKey(name: 'clinic_id') this.clinicId, this.name, this.location, @JsonKey(name: 'doctors_count') this.doctorsCount, @JsonKey(name: 'appointments_count') this.appointmentsCount, this.revenue, this.rating, this.status, this.email, this.phone, this.type, this.logo, this.cover, this.description, this.lat, this.lng, @JsonKey(name: 'is_active') this.isActive, @JsonKey(name: 'created_at') this.createdAt});
  factory _ClinicModel.fromJson(Map<String, dynamic> json) => _$ClinicModelFromJson(json);

@override@JsonKey(name: 'clinic_id') final  String? clinicId;
@override final  String? name;
@override final  String? location;
@override@JsonKey(name: 'doctors_count') final  int? doctorsCount;
@override@JsonKey(name: 'appointments_count') final  int? appointmentsCount;
@override final  num? revenue;
@override final  num? rating;
@override final  String? status;
@override final  String? email;
@override final  String? phone;
@override final  String? type;
@override final  String? logo;
@override final  String? cover;
@override final  String? description;
@override final  Object? lat;
@override final  Object? lng;
@override@JsonKey(name: 'is_active') final  bool? isActive;
@override@JsonKey(name: 'created_at') final  String? createdAt;

/// Create a copy of ClinicModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ClinicModelCopyWith<_ClinicModel> get copyWith => __$ClinicModelCopyWithImpl<_ClinicModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ClinicModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ClinicModel&&(identical(other.clinicId, clinicId) || other.clinicId == clinicId)&&(identical(other.name, name) || other.name == name)&&(identical(other.location, location) || other.location == location)&&(identical(other.doctorsCount, doctorsCount) || other.doctorsCount == doctorsCount)&&(identical(other.appointmentsCount, appointmentsCount) || other.appointmentsCount == appointmentsCount)&&(identical(other.revenue, revenue) || other.revenue == revenue)&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.status, status) || other.status == status)&&(identical(other.email, email) || other.email == email)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.type, type) || other.type == type)&&(identical(other.logo, logo) || other.logo == logo)&&(identical(other.cover, cover) || other.cover == cover)&&(identical(other.description, description) || other.description == description)&&const DeepCollectionEquality().equals(other.lat, lat)&&const DeepCollectionEquality().equals(other.lng, lng)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,clinicId,name,location,doctorsCount,appointmentsCount,revenue,rating,status,email,phone,type,logo,cover,description,const DeepCollectionEquality().hash(lat),const DeepCollectionEquality().hash(lng),isActive,createdAt);

@override
String toString() {
  return 'ClinicModel(clinicId: $clinicId, name: $name, location: $location, doctorsCount: $doctorsCount, appointmentsCount: $appointmentsCount, revenue: $revenue, rating: $rating, status: $status, email: $email, phone: $phone, type: $type, logo: $logo, cover: $cover, description: $description, lat: $lat, lng: $lng, isActive: $isActive, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$ClinicModelCopyWith<$Res> implements $ClinicModelCopyWith<$Res> {
  factory _$ClinicModelCopyWith(_ClinicModel value, $Res Function(_ClinicModel) _then) = __$ClinicModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'clinic_id') String? clinicId, String? name, String? location,@JsonKey(name: 'doctors_count') int? doctorsCount,@JsonKey(name: 'appointments_count') int? appointmentsCount, num? revenue, num? rating, String? status, String? email, String? phone, String? type, String? logo, String? cover, String? description, Object? lat, Object? lng,@JsonKey(name: 'is_active') bool? isActive,@JsonKey(name: 'created_at') String? createdAt
});




}
/// @nodoc
class __$ClinicModelCopyWithImpl<$Res>
    implements _$ClinicModelCopyWith<$Res> {
  __$ClinicModelCopyWithImpl(this._self, this._then);

  final _ClinicModel _self;
  final $Res Function(_ClinicModel) _then;

/// Create a copy of ClinicModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? clinicId = freezed,Object? name = freezed,Object? location = freezed,Object? doctorsCount = freezed,Object? appointmentsCount = freezed,Object? revenue = freezed,Object? rating = freezed,Object? status = freezed,Object? email = freezed,Object? phone = freezed,Object? type = freezed,Object? logo = freezed,Object? cover = freezed,Object? description = freezed,Object? lat = freezed,Object? lng = freezed,Object? isActive = freezed,Object? createdAt = freezed,}) {
  return _then(_ClinicModel(
clinicId: freezed == clinicId ? _self.clinicId : clinicId // ignore: cast_nullable_to_non_nullable
as String?,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,location: freezed == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String?,doctorsCount: freezed == doctorsCount ? _self.doctorsCount : doctorsCount // ignore: cast_nullable_to_non_nullable
as int?,appointmentsCount: freezed == appointmentsCount ? _self.appointmentsCount : appointmentsCount // ignore: cast_nullable_to_non_nullable
as int?,revenue: freezed == revenue ? _self.revenue : revenue // ignore: cast_nullable_to_non_nullable
as num?,rating: freezed == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as num?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,phone: freezed == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String?,type: freezed == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String?,logo: freezed == logo ? _self.logo : logo // ignore: cast_nullable_to_non_nullable
as String?,cover: freezed == cover ? _self.cover : cover // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,lat: freezed == lat ? _self.lat : lat ,lng: freezed == lng ? _self.lng : lng ,isActive: freezed == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
