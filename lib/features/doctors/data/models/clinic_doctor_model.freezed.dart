// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'clinic_doctor_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ClinicDoctorModel {

@JsonKey(name: 'doctor_id') String? get doctorId;@JsonKey(name: 'name_ar') String? get nameAr;@JsonKey(name: 'name_en') String? get nameEn; String? get name;@JsonKey(name: 'specialization_id') String? get specializationId;@JsonKey(name: 'specialization_name') String? get specializationName;@JsonKey(name: 'specialization_icon') String? get specializationIcon;@JsonKey(name: 'specialization_color') String? get specializationColor; String? get gender; String? get phone; String? get email;@JsonKey(name: 'license_number') String? get licenseNumber;@JsonKey(name: 'experience_years') int get experienceYears;@JsonKey(name: 'consultation_fee') num get consultationFee; String? get bio;@JsonKey(name: 'image_url') String? get imageUrl;@JsonKey(name: 'qualification_files') List<String> get qualificationFiles;@JsonKey(name: 'is_active') bool get isActive; num get rating;@JsonKey(name: 'patients_count') int get patientsCount; List<ClinicDoctorScheduleModel> get schedules;
/// Create a copy of ClinicDoctorModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ClinicDoctorModelCopyWith<ClinicDoctorModel> get copyWith => _$ClinicDoctorModelCopyWithImpl<ClinicDoctorModel>(this as ClinicDoctorModel, _$identity);

  /// Serializes this ClinicDoctorModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ClinicDoctorModel&&(identical(other.doctorId, doctorId) || other.doctorId == doctorId)&&(identical(other.nameAr, nameAr) || other.nameAr == nameAr)&&(identical(other.nameEn, nameEn) || other.nameEn == nameEn)&&(identical(other.name, name) || other.name == name)&&(identical(other.specializationId, specializationId) || other.specializationId == specializationId)&&(identical(other.specializationName, specializationName) || other.specializationName == specializationName)&&(identical(other.specializationIcon, specializationIcon) || other.specializationIcon == specializationIcon)&&(identical(other.specializationColor, specializationColor) || other.specializationColor == specializationColor)&&(identical(other.gender, gender) || other.gender == gender)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.email, email) || other.email == email)&&(identical(other.licenseNumber, licenseNumber) || other.licenseNumber == licenseNumber)&&(identical(other.experienceYears, experienceYears) || other.experienceYears == experienceYears)&&(identical(other.consultationFee, consultationFee) || other.consultationFee == consultationFee)&&(identical(other.bio, bio) || other.bio == bio)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&const DeepCollectionEquality().equals(other.qualificationFiles, qualificationFiles)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.patientsCount, patientsCount) || other.patientsCount == patientsCount)&&const DeepCollectionEquality().equals(other.schedules, schedules));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,doctorId,nameAr,nameEn,name,specializationId,specializationName,specializationIcon,specializationColor,gender,phone,email,licenseNumber,experienceYears,consultationFee,bio,imageUrl,const DeepCollectionEquality().hash(qualificationFiles),isActive,rating,patientsCount,const DeepCollectionEquality().hash(schedules)]);

@override
String toString() {
  return 'ClinicDoctorModel(doctorId: $doctorId, nameAr: $nameAr, nameEn: $nameEn, name: $name, specializationId: $specializationId, specializationName: $specializationName, specializationIcon: $specializationIcon, specializationColor: $specializationColor, gender: $gender, phone: $phone, email: $email, licenseNumber: $licenseNumber, experienceYears: $experienceYears, consultationFee: $consultationFee, bio: $bio, imageUrl: $imageUrl, qualificationFiles: $qualificationFiles, isActive: $isActive, rating: $rating, patientsCount: $patientsCount, schedules: $schedules)';
}


}

/// @nodoc
abstract mixin class $ClinicDoctorModelCopyWith<$Res>  {
  factory $ClinicDoctorModelCopyWith(ClinicDoctorModel value, $Res Function(ClinicDoctorModel) _then) = _$ClinicDoctorModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'doctor_id') String? doctorId,@JsonKey(name: 'name_ar') String? nameAr,@JsonKey(name: 'name_en') String? nameEn, String? name,@JsonKey(name: 'specialization_id') String? specializationId,@JsonKey(name: 'specialization_name') String? specializationName,@JsonKey(name: 'specialization_icon') String? specializationIcon,@JsonKey(name: 'specialization_color') String? specializationColor, String? gender, String? phone, String? email,@JsonKey(name: 'license_number') String? licenseNumber,@JsonKey(name: 'experience_years') int experienceYears,@JsonKey(name: 'consultation_fee') num consultationFee, String? bio,@JsonKey(name: 'image_url') String? imageUrl,@JsonKey(name: 'qualification_files') List<String> qualificationFiles,@JsonKey(name: 'is_active') bool isActive, num rating,@JsonKey(name: 'patients_count') int patientsCount, List<ClinicDoctorScheduleModel> schedules
});




}
/// @nodoc
class _$ClinicDoctorModelCopyWithImpl<$Res>
    implements $ClinicDoctorModelCopyWith<$Res> {
  _$ClinicDoctorModelCopyWithImpl(this._self, this._then);

  final ClinicDoctorModel _self;
  final $Res Function(ClinicDoctorModel) _then;

/// Create a copy of ClinicDoctorModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? doctorId = freezed,Object? nameAr = freezed,Object? nameEn = freezed,Object? name = freezed,Object? specializationId = freezed,Object? specializationName = freezed,Object? specializationIcon = freezed,Object? specializationColor = freezed,Object? gender = freezed,Object? phone = freezed,Object? email = freezed,Object? licenseNumber = freezed,Object? experienceYears = null,Object? consultationFee = null,Object? bio = freezed,Object? imageUrl = freezed,Object? qualificationFiles = null,Object? isActive = null,Object? rating = null,Object? patientsCount = null,Object? schedules = null,}) {
  return _then(_self.copyWith(
doctorId: freezed == doctorId ? _self.doctorId : doctorId // ignore: cast_nullable_to_non_nullable
as String?,nameAr: freezed == nameAr ? _self.nameAr : nameAr // ignore: cast_nullable_to_non_nullable
as String?,nameEn: freezed == nameEn ? _self.nameEn : nameEn // ignore: cast_nullable_to_non_nullable
as String?,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,specializationId: freezed == specializationId ? _self.specializationId : specializationId // ignore: cast_nullable_to_non_nullable
as String?,specializationName: freezed == specializationName ? _self.specializationName : specializationName // ignore: cast_nullable_to_non_nullable
as String?,specializationIcon: freezed == specializationIcon ? _self.specializationIcon : specializationIcon // ignore: cast_nullable_to_non_nullable
as String?,specializationColor: freezed == specializationColor ? _self.specializationColor : specializationColor // ignore: cast_nullable_to_non_nullable
as String?,gender: freezed == gender ? _self.gender : gender // ignore: cast_nullable_to_non_nullable
as String?,phone: freezed == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String?,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,licenseNumber: freezed == licenseNumber ? _self.licenseNumber : licenseNumber // ignore: cast_nullable_to_non_nullable
as String?,experienceYears: null == experienceYears ? _self.experienceYears : experienceYears // ignore: cast_nullable_to_non_nullable
as int,consultationFee: null == consultationFee ? _self.consultationFee : consultationFee // ignore: cast_nullable_to_non_nullable
as num,bio: freezed == bio ? _self.bio : bio // ignore: cast_nullable_to_non_nullable
as String?,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,qualificationFiles: null == qualificationFiles ? _self.qualificationFiles : qualificationFiles // ignore: cast_nullable_to_non_nullable
as List<String>,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,rating: null == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as num,patientsCount: null == patientsCount ? _self.patientsCount : patientsCount // ignore: cast_nullable_to_non_nullable
as int,schedules: null == schedules ? _self.schedules : schedules // ignore: cast_nullable_to_non_nullable
as List<ClinicDoctorScheduleModel>,
  ));
}

}


/// Adds pattern-matching-related methods to [ClinicDoctorModel].
extension ClinicDoctorModelPatterns on ClinicDoctorModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ClinicDoctorModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ClinicDoctorModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ClinicDoctorModel value)  $default,){
final _that = this;
switch (_that) {
case _ClinicDoctorModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ClinicDoctorModel value)?  $default,){
final _that = this;
switch (_that) {
case _ClinicDoctorModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'doctor_id')  String? doctorId, @JsonKey(name: 'name_ar')  String? nameAr, @JsonKey(name: 'name_en')  String? nameEn,  String? name, @JsonKey(name: 'specialization_id')  String? specializationId, @JsonKey(name: 'specialization_name')  String? specializationName, @JsonKey(name: 'specialization_icon')  String? specializationIcon, @JsonKey(name: 'specialization_color')  String? specializationColor,  String? gender,  String? phone,  String? email, @JsonKey(name: 'license_number')  String? licenseNumber, @JsonKey(name: 'experience_years')  int experienceYears, @JsonKey(name: 'consultation_fee')  num consultationFee,  String? bio, @JsonKey(name: 'image_url')  String? imageUrl, @JsonKey(name: 'qualification_files')  List<String> qualificationFiles, @JsonKey(name: 'is_active')  bool isActive,  num rating, @JsonKey(name: 'patients_count')  int patientsCount,  List<ClinicDoctorScheduleModel> schedules)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ClinicDoctorModel() when $default != null:
return $default(_that.doctorId,_that.nameAr,_that.nameEn,_that.name,_that.specializationId,_that.specializationName,_that.specializationIcon,_that.specializationColor,_that.gender,_that.phone,_that.email,_that.licenseNumber,_that.experienceYears,_that.consultationFee,_that.bio,_that.imageUrl,_that.qualificationFiles,_that.isActive,_that.rating,_that.patientsCount,_that.schedules);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'doctor_id')  String? doctorId, @JsonKey(name: 'name_ar')  String? nameAr, @JsonKey(name: 'name_en')  String? nameEn,  String? name, @JsonKey(name: 'specialization_id')  String? specializationId, @JsonKey(name: 'specialization_name')  String? specializationName, @JsonKey(name: 'specialization_icon')  String? specializationIcon, @JsonKey(name: 'specialization_color')  String? specializationColor,  String? gender,  String? phone,  String? email, @JsonKey(name: 'license_number')  String? licenseNumber, @JsonKey(name: 'experience_years')  int experienceYears, @JsonKey(name: 'consultation_fee')  num consultationFee,  String? bio, @JsonKey(name: 'image_url')  String? imageUrl, @JsonKey(name: 'qualification_files')  List<String> qualificationFiles, @JsonKey(name: 'is_active')  bool isActive,  num rating, @JsonKey(name: 'patients_count')  int patientsCount,  List<ClinicDoctorScheduleModel> schedules)  $default,) {final _that = this;
switch (_that) {
case _ClinicDoctorModel():
return $default(_that.doctorId,_that.nameAr,_that.nameEn,_that.name,_that.specializationId,_that.specializationName,_that.specializationIcon,_that.specializationColor,_that.gender,_that.phone,_that.email,_that.licenseNumber,_that.experienceYears,_that.consultationFee,_that.bio,_that.imageUrl,_that.qualificationFiles,_that.isActive,_that.rating,_that.patientsCount,_that.schedules);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'doctor_id')  String? doctorId, @JsonKey(name: 'name_ar')  String? nameAr, @JsonKey(name: 'name_en')  String? nameEn,  String? name, @JsonKey(name: 'specialization_id')  String? specializationId, @JsonKey(name: 'specialization_name')  String? specializationName, @JsonKey(name: 'specialization_icon')  String? specializationIcon, @JsonKey(name: 'specialization_color')  String? specializationColor,  String? gender,  String? phone,  String? email, @JsonKey(name: 'license_number')  String? licenseNumber, @JsonKey(name: 'experience_years')  int experienceYears, @JsonKey(name: 'consultation_fee')  num consultationFee,  String? bio, @JsonKey(name: 'image_url')  String? imageUrl, @JsonKey(name: 'qualification_files')  List<String> qualificationFiles, @JsonKey(name: 'is_active')  bool isActive,  num rating, @JsonKey(name: 'patients_count')  int patientsCount,  List<ClinicDoctorScheduleModel> schedules)?  $default,) {final _that = this;
switch (_that) {
case _ClinicDoctorModel() when $default != null:
return $default(_that.doctorId,_that.nameAr,_that.nameEn,_that.name,_that.specializationId,_that.specializationName,_that.specializationIcon,_that.specializationColor,_that.gender,_that.phone,_that.email,_that.licenseNumber,_that.experienceYears,_that.consultationFee,_that.bio,_that.imageUrl,_that.qualificationFiles,_that.isActive,_that.rating,_that.patientsCount,_that.schedules);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ClinicDoctorModel implements ClinicDoctorModel {
  const _ClinicDoctorModel({@JsonKey(name: 'doctor_id') this.doctorId, @JsonKey(name: 'name_ar') this.nameAr, @JsonKey(name: 'name_en') this.nameEn, this.name, @JsonKey(name: 'specialization_id') this.specializationId, @JsonKey(name: 'specialization_name') this.specializationName, @JsonKey(name: 'specialization_icon') this.specializationIcon, @JsonKey(name: 'specialization_color') this.specializationColor, this.gender, this.phone, this.email, @JsonKey(name: 'license_number') this.licenseNumber, @JsonKey(name: 'experience_years') this.experienceYears = 0, @JsonKey(name: 'consultation_fee') this.consultationFee = 0, this.bio, @JsonKey(name: 'image_url') this.imageUrl, @JsonKey(name: 'qualification_files') final  List<String> qualificationFiles = const <String>[], @JsonKey(name: 'is_active') this.isActive = false, this.rating = 0, @JsonKey(name: 'patients_count') this.patientsCount = 0, final  List<ClinicDoctorScheduleModel> schedules = const <ClinicDoctorScheduleModel>[]}): _qualificationFiles = qualificationFiles,_schedules = schedules;
  factory _ClinicDoctorModel.fromJson(Map<String, dynamic> json) => _$ClinicDoctorModelFromJson(json);

@override@JsonKey(name: 'doctor_id') final  String? doctorId;
@override@JsonKey(name: 'name_ar') final  String? nameAr;
@override@JsonKey(name: 'name_en') final  String? nameEn;
@override final  String? name;
@override@JsonKey(name: 'specialization_id') final  String? specializationId;
@override@JsonKey(name: 'specialization_name') final  String? specializationName;
@override@JsonKey(name: 'specialization_icon') final  String? specializationIcon;
@override@JsonKey(name: 'specialization_color') final  String? specializationColor;
@override final  String? gender;
@override final  String? phone;
@override final  String? email;
@override@JsonKey(name: 'license_number') final  String? licenseNumber;
@override@JsonKey(name: 'experience_years') final  int experienceYears;
@override@JsonKey(name: 'consultation_fee') final  num consultationFee;
@override final  String? bio;
@override@JsonKey(name: 'image_url') final  String? imageUrl;
 final  List<String> _qualificationFiles;
@override@JsonKey(name: 'qualification_files') List<String> get qualificationFiles {
  if (_qualificationFiles is EqualUnmodifiableListView) return _qualificationFiles;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_qualificationFiles);
}

@override@JsonKey(name: 'is_active') final  bool isActive;
@override@JsonKey() final  num rating;
@override@JsonKey(name: 'patients_count') final  int patientsCount;
 final  List<ClinicDoctorScheduleModel> _schedules;
@override@JsonKey() List<ClinicDoctorScheduleModel> get schedules {
  if (_schedules is EqualUnmodifiableListView) return _schedules;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_schedules);
}


/// Create a copy of ClinicDoctorModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ClinicDoctorModelCopyWith<_ClinicDoctorModel> get copyWith => __$ClinicDoctorModelCopyWithImpl<_ClinicDoctorModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ClinicDoctorModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ClinicDoctorModel&&(identical(other.doctorId, doctorId) || other.doctorId == doctorId)&&(identical(other.nameAr, nameAr) || other.nameAr == nameAr)&&(identical(other.nameEn, nameEn) || other.nameEn == nameEn)&&(identical(other.name, name) || other.name == name)&&(identical(other.specializationId, specializationId) || other.specializationId == specializationId)&&(identical(other.specializationName, specializationName) || other.specializationName == specializationName)&&(identical(other.specializationIcon, specializationIcon) || other.specializationIcon == specializationIcon)&&(identical(other.specializationColor, specializationColor) || other.specializationColor == specializationColor)&&(identical(other.gender, gender) || other.gender == gender)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.email, email) || other.email == email)&&(identical(other.licenseNumber, licenseNumber) || other.licenseNumber == licenseNumber)&&(identical(other.experienceYears, experienceYears) || other.experienceYears == experienceYears)&&(identical(other.consultationFee, consultationFee) || other.consultationFee == consultationFee)&&(identical(other.bio, bio) || other.bio == bio)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&const DeepCollectionEquality().equals(other._qualificationFiles, _qualificationFiles)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.patientsCount, patientsCount) || other.patientsCount == patientsCount)&&const DeepCollectionEquality().equals(other._schedules, _schedules));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,doctorId,nameAr,nameEn,name,specializationId,specializationName,specializationIcon,specializationColor,gender,phone,email,licenseNumber,experienceYears,consultationFee,bio,imageUrl,const DeepCollectionEquality().hash(_qualificationFiles),isActive,rating,patientsCount,const DeepCollectionEquality().hash(_schedules)]);

@override
String toString() {
  return 'ClinicDoctorModel(doctorId: $doctorId, nameAr: $nameAr, nameEn: $nameEn, name: $name, specializationId: $specializationId, specializationName: $specializationName, specializationIcon: $specializationIcon, specializationColor: $specializationColor, gender: $gender, phone: $phone, email: $email, licenseNumber: $licenseNumber, experienceYears: $experienceYears, consultationFee: $consultationFee, bio: $bio, imageUrl: $imageUrl, qualificationFiles: $qualificationFiles, isActive: $isActive, rating: $rating, patientsCount: $patientsCount, schedules: $schedules)';
}


}

/// @nodoc
abstract mixin class _$ClinicDoctorModelCopyWith<$Res> implements $ClinicDoctorModelCopyWith<$Res> {
  factory _$ClinicDoctorModelCopyWith(_ClinicDoctorModel value, $Res Function(_ClinicDoctorModel) _then) = __$ClinicDoctorModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'doctor_id') String? doctorId,@JsonKey(name: 'name_ar') String? nameAr,@JsonKey(name: 'name_en') String? nameEn, String? name,@JsonKey(name: 'specialization_id') String? specializationId,@JsonKey(name: 'specialization_name') String? specializationName,@JsonKey(name: 'specialization_icon') String? specializationIcon,@JsonKey(name: 'specialization_color') String? specializationColor, String? gender, String? phone, String? email,@JsonKey(name: 'license_number') String? licenseNumber,@JsonKey(name: 'experience_years') int experienceYears,@JsonKey(name: 'consultation_fee') num consultationFee, String? bio,@JsonKey(name: 'image_url') String? imageUrl,@JsonKey(name: 'qualification_files') List<String> qualificationFiles,@JsonKey(name: 'is_active') bool isActive, num rating,@JsonKey(name: 'patients_count') int patientsCount, List<ClinicDoctorScheduleModel> schedules
});




}
/// @nodoc
class __$ClinicDoctorModelCopyWithImpl<$Res>
    implements _$ClinicDoctorModelCopyWith<$Res> {
  __$ClinicDoctorModelCopyWithImpl(this._self, this._then);

  final _ClinicDoctorModel _self;
  final $Res Function(_ClinicDoctorModel) _then;

/// Create a copy of ClinicDoctorModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? doctorId = freezed,Object? nameAr = freezed,Object? nameEn = freezed,Object? name = freezed,Object? specializationId = freezed,Object? specializationName = freezed,Object? specializationIcon = freezed,Object? specializationColor = freezed,Object? gender = freezed,Object? phone = freezed,Object? email = freezed,Object? licenseNumber = freezed,Object? experienceYears = null,Object? consultationFee = null,Object? bio = freezed,Object? imageUrl = freezed,Object? qualificationFiles = null,Object? isActive = null,Object? rating = null,Object? patientsCount = null,Object? schedules = null,}) {
  return _then(_ClinicDoctorModel(
doctorId: freezed == doctorId ? _self.doctorId : doctorId // ignore: cast_nullable_to_non_nullable
as String?,nameAr: freezed == nameAr ? _self.nameAr : nameAr // ignore: cast_nullable_to_non_nullable
as String?,nameEn: freezed == nameEn ? _self.nameEn : nameEn // ignore: cast_nullable_to_non_nullable
as String?,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,specializationId: freezed == specializationId ? _self.specializationId : specializationId // ignore: cast_nullable_to_non_nullable
as String?,specializationName: freezed == specializationName ? _self.specializationName : specializationName // ignore: cast_nullable_to_non_nullable
as String?,specializationIcon: freezed == specializationIcon ? _self.specializationIcon : specializationIcon // ignore: cast_nullable_to_non_nullable
as String?,specializationColor: freezed == specializationColor ? _self.specializationColor : specializationColor // ignore: cast_nullable_to_non_nullable
as String?,gender: freezed == gender ? _self.gender : gender // ignore: cast_nullable_to_non_nullable
as String?,phone: freezed == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String?,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,licenseNumber: freezed == licenseNumber ? _self.licenseNumber : licenseNumber // ignore: cast_nullable_to_non_nullable
as String?,experienceYears: null == experienceYears ? _self.experienceYears : experienceYears // ignore: cast_nullable_to_non_nullable
as int,consultationFee: null == consultationFee ? _self.consultationFee : consultationFee // ignore: cast_nullable_to_non_nullable
as num,bio: freezed == bio ? _self.bio : bio // ignore: cast_nullable_to_non_nullable
as String?,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,qualificationFiles: null == qualificationFiles ? _self._qualificationFiles : qualificationFiles // ignore: cast_nullable_to_non_nullable
as List<String>,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,rating: null == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as num,patientsCount: null == patientsCount ? _self.patientsCount : patientsCount // ignore: cast_nullable_to_non_nullable
as int,schedules: null == schedules ? _self._schedules : schedules // ignore: cast_nullable_to_non_nullable
as List<ClinicDoctorScheduleModel>,
  ));
}


}


/// @nodoc
mixin _$ClinicDoctorScheduleModel {

 String? get day; String? get from; String? get to;@JsonKey(name: 'is_active') bool get isActive;
/// Create a copy of ClinicDoctorScheduleModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ClinicDoctorScheduleModelCopyWith<ClinicDoctorScheduleModel> get copyWith => _$ClinicDoctorScheduleModelCopyWithImpl<ClinicDoctorScheduleModel>(this as ClinicDoctorScheduleModel, _$identity);

  /// Serializes this ClinicDoctorScheduleModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ClinicDoctorScheduleModel&&(identical(other.day, day) || other.day == day)&&(identical(other.from, from) || other.from == from)&&(identical(other.to, to) || other.to == to)&&(identical(other.isActive, isActive) || other.isActive == isActive));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,day,from,to,isActive);

@override
String toString() {
  return 'ClinicDoctorScheduleModel(day: $day, from: $from, to: $to, isActive: $isActive)';
}


}

/// @nodoc
abstract mixin class $ClinicDoctorScheduleModelCopyWith<$Res>  {
  factory $ClinicDoctorScheduleModelCopyWith(ClinicDoctorScheduleModel value, $Res Function(ClinicDoctorScheduleModel) _then) = _$ClinicDoctorScheduleModelCopyWithImpl;
@useResult
$Res call({
 String? day, String? from, String? to,@JsonKey(name: 'is_active') bool isActive
});




}
/// @nodoc
class _$ClinicDoctorScheduleModelCopyWithImpl<$Res>
    implements $ClinicDoctorScheduleModelCopyWith<$Res> {
  _$ClinicDoctorScheduleModelCopyWithImpl(this._self, this._then);

  final ClinicDoctorScheduleModel _self;
  final $Res Function(ClinicDoctorScheduleModel) _then;

/// Create a copy of ClinicDoctorScheduleModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? day = freezed,Object? from = freezed,Object? to = freezed,Object? isActive = null,}) {
  return _then(_self.copyWith(
day: freezed == day ? _self.day : day // ignore: cast_nullable_to_non_nullable
as String?,from: freezed == from ? _self.from : from // ignore: cast_nullable_to_non_nullable
as String?,to: freezed == to ? _self.to : to // ignore: cast_nullable_to_non_nullable
as String?,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [ClinicDoctorScheduleModel].
extension ClinicDoctorScheduleModelPatterns on ClinicDoctorScheduleModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ClinicDoctorScheduleModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ClinicDoctorScheduleModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ClinicDoctorScheduleModel value)  $default,){
final _that = this;
switch (_that) {
case _ClinicDoctorScheduleModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ClinicDoctorScheduleModel value)?  $default,){
final _that = this;
switch (_that) {
case _ClinicDoctorScheduleModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? day,  String? from,  String? to, @JsonKey(name: 'is_active')  bool isActive)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ClinicDoctorScheduleModel() when $default != null:
return $default(_that.day,_that.from,_that.to,_that.isActive);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? day,  String? from,  String? to, @JsonKey(name: 'is_active')  bool isActive)  $default,) {final _that = this;
switch (_that) {
case _ClinicDoctorScheduleModel():
return $default(_that.day,_that.from,_that.to,_that.isActive);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? day,  String? from,  String? to, @JsonKey(name: 'is_active')  bool isActive)?  $default,) {final _that = this;
switch (_that) {
case _ClinicDoctorScheduleModel() when $default != null:
return $default(_that.day,_that.from,_that.to,_that.isActive);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ClinicDoctorScheduleModel implements ClinicDoctorScheduleModel {
  const _ClinicDoctorScheduleModel({this.day, this.from, this.to, @JsonKey(name: 'is_active') this.isActive = false});
  factory _ClinicDoctorScheduleModel.fromJson(Map<String, dynamic> json) => _$ClinicDoctorScheduleModelFromJson(json);

@override final  String? day;
@override final  String? from;
@override final  String? to;
@override@JsonKey(name: 'is_active') final  bool isActive;

/// Create a copy of ClinicDoctorScheduleModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ClinicDoctorScheduleModelCopyWith<_ClinicDoctorScheduleModel> get copyWith => __$ClinicDoctorScheduleModelCopyWithImpl<_ClinicDoctorScheduleModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ClinicDoctorScheduleModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ClinicDoctorScheduleModel&&(identical(other.day, day) || other.day == day)&&(identical(other.from, from) || other.from == from)&&(identical(other.to, to) || other.to == to)&&(identical(other.isActive, isActive) || other.isActive == isActive));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,day,from,to,isActive);

@override
String toString() {
  return 'ClinicDoctorScheduleModel(day: $day, from: $from, to: $to, isActive: $isActive)';
}


}

/// @nodoc
abstract mixin class _$ClinicDoctorScheduleModelCopyWith<$Res> implements $ClinicDoctorScheduleModelCopyWith<$Res> {
  factory _$ClinicDoctorScheduleModelCopyWith(_ClinicDoctorScheduleModel value, $Res Function(_ClinicDoctorScheduleModel) _then) = __$ClinicDoctorScheduleModelCopyWithImpl;
@override @useResult
$Res call({
 String? day, String? from, String? to,@JsonKey(name: 'is_active') bool isActive
});




}
/// @nodoc
class __$ClinicDoctorScheduleModelCopyWithImpl<$Res>
    implements _$ClinicDoctorScheduleModelCopyWith<$Res> {
  __$ClinicDoctorScheduleModelCopyWithImpl(this._self, this._then);

  final _ClinicDoctorScheduleModel _self;
  final $Res Function(_ClinicDoctorScheduleModel) _then;

/// Create a copy of ClinicDoctorScheduleModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? day = freezed,Object? from = freezed,Object? to = freezed,Object? isActive = null,}) {
  return _then(_ClinicDoctorScheduleModel(
day: freezed == day ? _self.day : day // ignore: cast_nullable_to_non_nullable
as String?,from: freezed == from ? _self.from : from // ignore: cast_nullable_to_non_nullable
as String?,to: freezed == to ? _self.to : to // ignore: cast_nullable_to_non_nullable
as String?,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
