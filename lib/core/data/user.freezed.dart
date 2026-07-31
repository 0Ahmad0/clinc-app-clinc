// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$UserModel {

 int? get id;@JsonKey(name: 'first_name') String? get firstName;@JsonKey(name: 'last_name') String? get lastName;@JsonKey(name: 'email') String? get email;@JsonKey(name: 'gender') String? get gender;@JsonKey(name: 'is_verified') bool? get isVerified;@JsonKey(name: 'email_verified_at') DateTime? get emailVerifiedAt;@JsonKey(name: 'birth_day') DateTime? get birthDay;@JsonKey(name: 'phone') String? get phone;@JsonKey(name: 'account_status') String? get accountStatus;@JsonKey(name: 'deleted_at') DateTime? get deletedAt;@JsonKey(name: 'last_seen') DateTime? get lastSeen;@JsonKey(name: 'personal_photo') String? get personalPhoto;@JsonKey(name: 'is_online') bool? get isOnline;@JsonKey(name: 'profile_image') String? get profileImage;@JsonKey(name: 'google_id') String? get googleId;@JsonKey(name: 'otp') int? get otp;
/// Create a copy of UserModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserModelCopyWith<UserModel> get copyWith => _$UserModelCopyWithImpl<UserModel>(this as UserModel, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserModel&&(identical(other.id, id) || other.id == id)&&(identical(other.firstName, firstName) || other.firstName == firstName)&&(identical(other.lastName, lastName) || other.lastName == lastName)&&(identical(other.email, email) || other.email == email)&&(identical(other.gender, gender) || other.gender == gender)&&(identical(other.isVerified, isVerified) || other.isVerified == isVerified)&&(identical(other.emailVerifiedAt, emailVerifiedAt) || other.emailVerifiedAt == emailVerifiedAt)&&(identical(other.birthDay, birthDay) || other.birthDay == birthDay)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.accountStatus, accountStatus) || other.accountStatus == accountStatus)&&(identical(other.deletedAt, deletedAt) || other.deletedAt == deletedAt)&&(identical(other.lastSeen, lastSeen) || other.lastSeen == lastSeen)&&(identical(other.personalPhoto, personalPhoto) || other.personalPhoto == personalPhoto)&&(identical(other.isOnline, isOnline) || other.isOnline == isOnline)&&(identical(other.profileImage, profileImage) || other.profileImage == profileImage)&&(identical(other.googleId, googleId) || other.googleId == googleId)&&(identical(other.otp, otp) || other.otp == otp));
}


@override
int get hashCode => Object.hash(runtimeType,id,firstName,lastName,email,gender,isVerified,emailVerifiedAt,birthDay,phone,accountStatus,deletedAt,lastSeen,personalPhoto,isOnline,profileImage,googleId,otp);

@override
String toString() {
  return 'UserModel(id: $id, firstName: $firstName, lastName: $lastName, email: $email, gender: $gender, isVerified: $isVerified, emailVerifiedAt: $emailVerifiedAt, birthDay: $birthDay, phone: $phone, accountStatus: $accountStatus, deletedAt: $deletedAt, lastSeen: $lastSeen, personalPhoto: $personalPhoto, isOnline: $isOnline, profileImage: $profileImage, googleId: $googleId, otp: $otp)';
}


}

/// @nodoc
abstract mixin class $UserModelCopyWith<$Res>  {
  factory $UserModelCopyWith(UserModel value, $Res Function(UserModel) _then) = _$UserModelCopyWithImpl;
@useResult
$Res call({
 int? id,@JsonKey(name: 'first_name') String? firstName,@JsonKey(name: 'last_name') String? lastName,@JsonKey(name: 'email') String? email,@JsonKey(name: 'gender') String? gender,@JsonKey(name: 'is_verified') bool? isVerified,@JsonKey(name: 'email_verified_at') DateTime? emailVerifiedAt,@JsonKey(name: 'birth_day') DateTime? birthDay,@JsonKey(name: 'phone') String? phone,@JsonKey(name: 'account_status') String? accountStatus,@JsonKey(name: 'deleted_at') DateTime? deletedAt,@JsonKey(name: 'last_seen') DateTime? lastSeen,@JsonKey(name: 'personal_photo') String? personalPhoto,@JsonKey(name: 'is_online') bool? isOnline,@JsonKey(name: 'profile_image') String? profileImage,@JsonKey(name: 'google_id') String? googleId,@JsonKey(name: 'otp') int? otp
});




}
/// @nodoc
class _$UserModelCopyWithImpl<$Res>
    implements $UserModelCopyWith<$Res> {
  _$UserModelCopyWithImpl(this._self, this._then);

  final UserModel _self;
  final $Res Function(UserModel) _then;

/// Create a copy of UserModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? firstName = freezed,Object? lastName = freezed,Object? email = freezed,Object? gender = freezed,Object? isVerified = freezed,Object? emailVerifiedAt = freezed,Object? birthDay = freezed,Object? phone = freezed,Object? accountStatus = freezed,Object? deletedAt = freezed,Object? lastSeen = freezed,Object? personalPhoto = freezed,Object? isOnline = freezed,Object? profileImage = freezed,Object? googleId = freezed,Object? otp = freezed,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,firstName: freezed == firstName ? _self.firstName : firstName // ignore: cast_nullable_to_non_nullable
as String?,lastName: freezed == lastName ? _self.lastName : lastName // ignore: cast_nullable_to_non_nullable
as String?,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,gender: freezed == gender ? _self.gender : gender // ignore: cast_nullable_to_non_nullable
as String?,isVerified: freezed == isVerified ? _self.isVerified : isVerified // ignore: cast_nullable_to_non_nullable
as bool?,emailVerifiedAt: freezed == emailVerifiedAt ? _self.emailVerifiedAt : emailVerifiedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,birthDay: freezed == birthDay ? _self.birthDay : birthDay // ignore: cast_nullable_to_non_nullable
as DateTime?,phone: freezed == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String?,accountStatus: freezed == accountStatus ? _self.accountStatus : accountStatus // ignore: cast_nullable_to_non_nullable
as String?,deletedAt: freezed == deletedAt ? _self.deletedAt : deletedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,lastSeen: freezed == lastSeen ? _self.lastSeen : lastSeen // ignore: cast_nullable_to_non_nullable
as DateTime?,personalPhoto: freezed == personalPhoto ? _self.personalPhoto : personalPhoto // ignore: cast_nullable_to_non_nullable
as String?,isOnline: freezed == isOnline ? _self.isOnline : isOnline // ignore: cast_nullable_to_non_nullable
as bool?,profileImage: freezed == profileImage ? _self.profileImage : profileImage // ignore: cast_nullable_to_non_nullable
as String?,googleId: freezed == googleId ? _self.googleId : googleId // ignore: cast_nullable_to_non_nullable
as String?,otp: freezed == otp ? _self.otp : otp // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [UserModel].
extension UserModelPatterns on UserModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UserModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UserModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UserModel value)  $default,){
final _that = this;
switch (_that) {
case _UserModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UserModel value)?  $default,){
final _that = this;
switch (_that) {
case _UserModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int? id, @JsonKey(name: 'first_name')  String? firstName, @JsonKey(name: 'last_name')  String? lastName, @JsonKey(name: 'email')  String? email, @JsonKey(name: 'gender')  String? gender, @JsonKey(name: 'is_verified')  bool? isVerified, @JsonKey(name: 'email_verified_at')  DateTime? emailVerifiedAt, @JsonKey(name: 'birth_day')  DateTime? birthDay, @JsonKey(name: 'phone')  String? phone, @JsonKey(name: 'account_status')  String? accountStatus, @JsonKey(name: 'deleted_at')  DateTime? deletedAt, @JsonKey(name: 'last_seen')  DateTime? lastSeen, @JsonKey(name: 'personal_photo')  String? personalPhoto, @JsonKey(name: 'is_online')  bool? isOnline, @JsonKey(name: 'profile_image')  String? profileImage, @JsonKey(name: 'google_id')  String? googleId, @JsonKey(name: 'otp')  int? otp)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UserModel() when $default != null:
return $default(_that.id,_that.firstName,_that.lastName,_that.email,_that.gender,_that.isVerified,_that.emailVerifiedAt,_that.birthDay,_that.phone,_that.accountStatus,_that.deletedAt,_that.lastSeen,_that.personalPhoto,_that.isOnline,_that.profileImage,_that.googleId,_that.otp);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int? id, @JsonKey(name: 'first_name')  String? firstName, @JsonKey(name: 'last_name')  String? lastName, @JsonKey(name: 'email')  String? email, @JsonKey(name: 'gender')  String? gender, @JsonKey(name: 'is_verified')  bool? isVerified, @JsonKey(name: 'email_verified_at')  DateTime? emailVerifiedAt, @JsonKey(name: 'birth_day')  DateTime? birthDay, @JsonKey(name: 'phone')  String? phone, @JsonKey(name: 'account_status')  String? accountStatus, @JsonKey(name: 'deleted_at')  DateTime? deletedAt, @JsonKey(name: 'last_seen')  DateTime? lastSeen, @JsonKey(name: 'personal_photo')  String? personalPhoto, @JsonKey(name: 'is_online')  bool? isOnline, @JsonKey(name: 'profile_image')  String? profileImage, @JsonKey(name: 'google_id')  String? googleId, @JsonKey(name: 'otp')  int? otp)  $default,) {final _that = this;
switch (_that) {
case _UserModel():
return $default(_that.id,_that.firstName,_that.lastName,_that.email,_that.gender,_that.isVerified,_that.emailVerifiedAt,_that.birthDay,_that.phone,_that.accountStatus,_that.deletedAt,_that.lastSeen,_that.personalPhoto,_that.isOnline,_that.profileImage,_that.googleId,_that.otp);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int? id, @JsonKey(name: 'first_name')  String? firstName, @JsonKey(name: 'last_name')  String? lastName, @JsonKey(name: 'email')  String? email, @JsonKey(name: 'gender')  String? gender, @JsonKey(name: 'is_verified')  bool? isVerified, @JsonKey(name: 'email_verified_at')  DateTime? emailVerifiedAt, @JsonKey(name: 'birth_day')  DateTime? birthDay, @JsonKey(name: 'phone')  String? phone, @JsonKey(name: 'account_status')  String? accountStatus, @JsonKey(name: 'deleted_at')  DateTime? deletedAt, @JsonKey(name: 'last_seen')  DateTime? lastSeen, @JsonKey(name: 'personal_photo')  String? personalPhoto, @JsonKey(name: 'is_online')  bool? isOnline, @JsonKey(name: 'profile_image')  String? profileImage, @JsonKey(name: 'google_id')  String? googleId, @JsonKey(name: 'otp')  int? otp)?  $default,) {final _that = this;
switch (_that) {
case _UserModel() when $default != null:
return $default(_that.id,_that.firstName,_that.lastName,_that.email,_that.gender,_that.isVerified,_that.emailVerifiedAt,_that.birthDay,_that.phone,_that.accountStatus,_that.deletedAt,_that.lastSeen,_that.personalPhoto,_that.isOnline,_that.profileImage,_that.googleId,_that.otp);case _:
  return null;

}
}

}

/// @nodoc


class _UserModel extends UserModel {
  const _UserModel({this.id, @JsonKey(name: 'first_name') this.firstName, @JsonKey(name: 'last_name') this.lastName, @JsonKey(name: 'email') this.email, @JsonKey(name: 'gender') this.gender, @JsonKey(name: 'is_verified') this.isVerified, @JsonKey(name: 'email_verified_at') this.emailVerifiedAt, @JsonKey(name: 'birth_day') this.birthDay, @JsonKey(name: 'phone') this.phone, @JsonKey(name: 'account_status') this.accountStatus, @JsonKey(name: 'deleted_at') this.deletedAt, @JsonKey(name: 'last_seen') this.lastSeen, @JsonKey(name: 'personal_photo') this.personalPhoto, @JsonKey(name: 'is_online') this.isOnline, @JsonKey(name: 'profile_image') this.profileImage, @JsonKey(name: 'google_id') this.googleId, @JsonKey(name: 'otp') this.otp}): super._();
  

@override final  int? id;
@override@JsonKey(name: 'first_name') final  String? firstName;
@override@JsonKey(name: 'last_name') final  String? lastName;
@override@JsonKey(name: 'email') final  String? email;
@override@JsonKey(name: 'gender') final  String? gender;
@override@JsonKey(name: 'is_verified') final  bool? isVerified;
@override@JsonKey(name: 'email_verified_at') final  DateTime? emailVerifiedAt;
@override@JsonKey(name: 'birth_day') final  DateTime? birthDay;
@override@JsonKey(name: 'phone') final  String? phone;
@override@JsonKey(name: 'account_status') final  String? accountStatus;
@override@JsonKey(name: 'deleted_at') final  DateTime? deletedAt;
@override@JsonKey(name: 'last_seen') final  DateTime? lastSeen;
@override@JsonKey(name: 'personal_photo') final  String? personalPhoto;
@override@JsonKey(name: 'is_online') final  bool? isOnline;
@override@JsonKey(name: 'profile_image') final  String? profileImage;
@override@JsonKey(name: 'google_id') final  String? googleId;
@override@JsonKey(name: 'otp') final  int? otp;

/// Create a copy of UserModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserModelCopyWith<_UserModel> get copyWith => __$UserModelCopyWithImpl<_UserModel>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserModel&&(identical(other.id, id) || other.id == id)&&(identical(other.firstName, firstName) || other.firstName == firstName)&&(identical(other.lastName, lastName) || other.lastName == lastName)&&(identical(other.email, email) || other.email == email)&&(identical(other.gender, gender) || other.gender == gender)&&(identical(other.isVerified, isVerified) || other.isVerified == isVerified)&&(identical(other.emailVerifiedAt, emailVerifiedAt) || other.emailVerifiedAt == emailVerifiedAt)&&(identical(other.birthDay, birthDay) || other.birthDay == birthDay)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.accountStatus, accountStatus) || other.accountStatus == accountStatus)&&(identical(other.deletedAt, deletedAt) || other.deletedAt == deletedAt)&&(identical(other.lastSeen, lastSeen) || other.lastSeen == lastSeen)&&(identical(other.personalPhoto, personalPhoto) || other.personalPhoto == personalPhoto)&&(identical(other.isOnline, isOnline) || other.isOnline == isOnline)&&(identical(other.profileImage, profileImage) || other.profileImage == profileImage)&&(identical(other.googleId, googleId) || other.googleId == googleId)&&(identical(other.otp, otp) || other.otp == otp));
}


@override
int get hashCode => Object.hash(runtimeType,id,firstName,lastName,email,gender,isVerified,emailVerifiedAt,birthDay,phone,accountStatus,deletedAt,lastSeen,personalPhoto,isOnline,profileImage,googleId,otp);

@override
String toString() {
  return 'UserModel(id: $id, firstName: $firstName, lastName: $lastName, email: $email, gender: $gender, isVerified: $isVerified, emailVerifiedAt: $emailVerifiedAt, birthDay: $birthDay, phone: $phone, accountStatus: $accountStatus, deletedAt: $deletedAt, lastSeen: $lastSeen, personalPhoto: $personalPhoto, isOnline: $isOnline, profileImage: $profileImage, googleId: $googleId, otp: $otp)';
}


}

/// @nodoc
abstract mixin class _$UserModelCopyWith<$Res> implements $UserModelCopyWith<$Res> {
  factory _$UserModelCopyWith(_UserModel value, $Res Function(_UserModel) _then) = __$UserModelCopyWithImpl;
@override @useResult
$Res call({
 int? id,@JsonKey(name: 'first_name') String? firstName,@JsonKey(name: 'last_name') String? lastName,@JsonKey(name: 'email') String? email,@JsonKey(name: 'gender') String? gender,@JsonKey(name: 'is_verified') bool? isVerified,@JsonKey(name: 'email_verified_at') DateTime? emailVerifiedAt,@JsonKey(name: 'birth_day') DateTime? birthDay,@JsonKey(name: 'phone') String? phone,@JsonKey(name: 'account_status') String? accountStatus,@JsonKey(name: 'deleted_at') DateTime? deletedAt,@JsonKey(name: 'last_seen') DateTime? lastSeen,@JsonKey(name: 'personal_photo') String? personalPhoto,@JsonKey(name: 'is_online') bool? isOnline,@JsonKey(name: 'profile_image') String? profileImage,@JsonKey(name: 'google_id') String? googleId,@JsonKey(name: 'otp') int? otp
});




}
/// @nodoc
class __$UserModelCopyWithImpl<$Res>
    implements _$UserModelCopyWith<$Res> {
  __$UserModelCopyWithImpl(this._self, this._then);

  final _UserModel _self;
  final $Res Function(_UserModel) _then;

/// Create a copy of UserModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? firstName = freezed,Object? lastName = freezed,Object? email = freezed,Object? gender = freezed,Object? isVerified = freezed,Object? emailVerifiedAt = freezed,Object? birthDay = freezed,Object? phone = freezed,Object? accountStatus = freezed,Object? deletedAt = freezed,Object? lastSeen = freezed,Object? personalPhoto = freezed,Object? isOnline = freezed,Object? profileImage = freezed,Object? googleId = freezed,Object? otp = freezed,}) {
  return _then(_UserModel(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,firstName: freezed == firstName ? _self.firstName : firstName // ignore: cast_nullable_to_non_nullable
as String?,lastName: freezed == lastName ? _self.lastName : lastName // ignore: cast_nullable_to_non_nullable
as String?,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,gender: freezed == gender ? _self.gender : gender // ignore: cast_nullable_to_non_nullable
as String?,isVerified: freezed == isVerified ? _self.isVerified : isVerified // ignore: cast_nullable_to_non_nullable
as bool?,emailVerifiedAt: freezed == emailVerifiedAt ? _self.emailVerifiedAt : emailVerifiedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,birthDay: freezed == birthDay ? _self.birthDay : birthDay // ignore: cast_nullable_to_non_nullable
as DateTime?,phone: freezed == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String?,accountStatus: freezed == accountStatus ? _self.accountStatus : accountStatus // ignore: cast_nullable_to_non_nullable
as String?,deletedAt: freezed == deletedAt ? _self.deletedAt : deletedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,lastSeen: freezed == lastSeen ? _self.lastSeen : lastSeen // ignore: cast_nullable_to_non_nullable
as DateTime?,personalPhoto: freezed == personalPhoto ? _self.personalPhoto : personalPhoto // ignore: cast_nullable_to_non_nullable
as String?,isOnline: freezed == isOnline ? _self.isOnline : isOnline // ignore: cast_nullable_to_non_nullable
as bool?,profileImage: freezed == profileImage ? _self.profileImage : profileImage // ignore: cast_nullable_to_non_nullable
as String?,googleId: freezed == googleId ? _self.googleId : googleId // ignore: cast_nullable_to_non_nullable
as String?,otp: freezed == otp ? _self.otp : otp // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

// dart format on
