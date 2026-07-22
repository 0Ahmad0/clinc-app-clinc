// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'clinic_dashboard_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ClinicDashboardModel {

 ClinicDashboardClinicModel? get clinic; ClinicDashboardStatsModel? get stats; List<ClinicDashboardAppointmentModel> get appointments; ClinicDashboardNotificationsModel? get notifications;
/// Create a copy of ClinicDashboardModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ClinicDashboardModelCopyWith<ClinicDashboardModel> get copyWith => _$ClinicDashboardModelCopyWithImpl<ClinicDashboardModel>(this as ClinicDashboardModel, _$identity);

  /// Serializes this ClinicDashboardModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ClinicDashboardModel&&(identical(other.clinic, clinic) || other.clinic == clinic)&&(identical(other.stats, stats) || other.stats == stats)&&const DeepCollectionEquality().equals(other.appointments, appointments)&&(identical(other.notifications, notifications) || other.notifications == notifications));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,clinic,stats,const DeepCollectionEquality().hash(appointments),notifications);

@override
String toString() {
  return 'ClinicDashboardModel(clinic: $clinic, stats: $stats, appointments: $appointments, notifications: $notifications)';
}


}

/// @nodoc
abstract mixin class $ClinicDashboardModelCopyWith<$Res>  {
  factory $ClinicDashboardModelCopyWith(ClinicDashboardModel value, $Res Function(ClinicDashboardModel) _then) = _$ClinicDashboardModelCopyWithImpl;
@useResult
$Res call({
 ClinicDashboardClinicModel? clinic, ClinicDashboardStatsModel? stats, List<ClinicDashboardAppointmentModel> appointments, ClinicDashboardNotificationsModel? notifications
});


$ClinicDashboardClinicModelCopyWith<$Res>? get clinic;$ClinicDashboardStatsModelCopyWith<$Res>? get stats;$ClinicDashboardNotificationsModelCopyWith<$Res>? get notifications;

}
/// @nodoc
class _$ClinicDashboardModelCopyWithImpl<$Res>
    implements $ClinicDashboardModelCopyWith<$Res> {
  _$ClinicDashboardModelCopyWithImpl(this._self, this._then);

  final ClinicDashboardModel _self;
  final $Res Function(ClinicDashboardModel) _then;

/// Create a copy of ClinicDashboardModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? clinic = freezed,Object? stats = freezed,Object? appointments = null,Object? notifications = freezed,}) {
  return _then(_self.copyWith(
clinic: freezed == clinic ? _self.clinic : clinic // ignore: cast_nullable_to_non_nullable
as ClinicDashboardClinicModel?,stats: freezed == stats ? _self.stats : stats // ignore: cast_nullable_to_non_nullable
as ClinicDashboardStatsModel?,appointments: null == appointments ? _self.appointments : appointments // ignore: cast_nullable_to_non_nullable
as List<ClinicDashboardAppointmentModel>,notifications: freezed == notifications ? _self.notifications : notifications // ignore: cast_nullable_to_non_nullable
as ClinicDashboardNotificationsModel?,
  ));
}
/// Create a copy of ClinicDashboardModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ClinicDashboardClinicModelCopyWith<$Res>? get clinic {
    if (_self.clinic == null) {
    return null;
  }

  return $ClinicDashboardClinicModelCopyWith<$Res>(_self.clinic!, (value) {
    return _then(_self.copyWith(clinic: value));
  });
}/// Create a copy of ClinicDashboardModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ClinicDashboardStatsModelCopyWith<$Res>? get stats {
    if (_self.stats == null) {
    return null;
  }

  return $ClinicDashboardStatsModelCopyWith<$Res>(_self.stats!, (value) {
    return _then(_self.copyWith(stats: value));
  });
}/// Create a copy of ClinicDashboardModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ClinicDashboardNotificationsModelCopyWith<$Res>? get notifications {
    if (_self.notifications == null) {
    return null;
  }

  return $ClinicDashboardNotificationsModelCopyWith<$Res>(_self.notifications!, (value) {
    return _then(_self.copyWith(notifications: value));
  });
}
}


/// Adds pattern-matching-related methods to [ClinicDashboardModel].
extension ClinicDashboardModelPatterns on ClinicDashboardModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ClinicDashboardModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ClinicDashboardModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ClinicDashboardModel value)  $default,){
final _that = this;
switch (_that) {
case _ClinicDashboardModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ClinicDashboardModel value)?  $default,){
final _that = this;
switch (_that) {
case _ClinicDashboardModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( ClinicDashboardClinicModel? clinic,  ClinicDashboardStatsModel? stats,  List<ClinicDashboardAppointmentModel> appointments,  ClinicDashboardNotificationsModel? notifications)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ClinicDashboardModel() when $default != null:
return $default(_that.clinic,_that.stats,_that.appointments,_that.notifications);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( ClinicDashboardClinicModel? clinic,  ClinicDashboardStatsModel? stats,  List<ClinicDashboardAppointmentModel> appointments,  ClinicDashboardNotificationsModel? notifications)  $default,) {final _that = this;
switch (_that) {
case _ClinicDashboardModel():
return $default(_that.clinic,_that.stats,_that.appointments,_that.notifications);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( ClinicDashboardClinicModel? clinic,  ClinicDashboardStatsModel? stats,  List<ClinicDashboardAppointmentModel> appointments,  ClinicDashboardNotificationsModel? notifications)?  $default,) {final _that = this;
switch (_that) {
case _ClinicDashboardModel() when $default != null:
return $default(_that.clinic,_that.stats,_that.appointments,_that.notifications);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ClinicDashboardModel implements ClinicDashboardModel {
  const _ClinicDashboardModel({this.clinic, this.stats, final  List<ClinicDashboardAppointmentModel> appointments = const <ClinicDashboardAppointmentModel>[], this.notifications}): _appointments = appointments;
  factory _ClinicDashboardModel.fromJson(Map<String, dynamic> json) => _$ClinicDashboardModelFromJson(json);

@override final  ClinicDashboardClinicModel? clinic;
@override final  ClinicDashboardStatsModel? stats;
 final  List<ClinicDashboardAppointmentModel> _appointments;
@override@JsonKey() List<ClinicDashboardAppointmentModel> get appointments {
  if (_appointments is EqualUnmodifiableListView) return _appointments;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_appointments);
}

@override final  ClinicDashboardNotificationsModel? notifications;

/// Create a copy of ClinicDashboardModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ClinicDashboardModelCopyWith<_ClinicDashboardModel> get copyWith => __$ClinicDashboardModelCopyWithImpl<_ClinicDashboardModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ClinicDashboardModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ClinicDashboardModel&&(identical(other.clinic, clinic) || other.clinic == clinic)&&(identical(other.stats, stats) || other.stats == stats)&&const DeepCollectionEquality().equals(other._appointments, _appointments)&&(identical(other.notifications, notifications) || other.notifications == notifications));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,clinic,stats,const DeepCollectionEquality().hash(_appointments),notifications);

@override
String toString() {
  return 'ClinicDashboardModel(clinic: $clinic, stats: $stats, appointments: $appointments, notifications: $notifications)';
}


}

/// @nodoc
abstract mixin class _$ClinicDashboardModelCopyWith<$Res> implements $ClinicDashboardModelCopyWith<$Res> {
  factory _$ClinicDashboardModelCopyWith(_ClinicDashboardModel value, $Res Function(_ClinicDashboardModel) _then) = __$ClinicDashboardModelCopyWithImpl;
@override @useResult
$Res call({
 ClinicDashboardClinicModel? clinic, ClinicDashboardStatsModel? stats, List<ClinicDashboardAppointmentModel> appointments, ClinicDashboardNotificationsModel? notifications
});


@override $ClinicDashboardClinicModelCopyWith<$Res>? get clinic;@override $ClinicDashboardStatsModelCopyWith<$Res>? get stats;@override $ClinicDashboardNotificationsModelCopyWith<$Res>? get notifications;

}
/// @nodoc
class __$ClinicDashboardModelCopyWithImpl<$Res>
    implements _$ClinicDashboardModelCopyWith<$Res> {
  __$ClinicDashboardModelCopyWithImpl(this._self, this._then);

  final _ClinicDashboardModel _self;
  final $Res Function(_ClinicDashboardModel) _then;

/// Create a copy of ClinicDashboardModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? clinic = freezed,Object? stats = freezed,Object? appointments = null,Object? notifications = freezed,}) {
  return _then(_ClinicDashboardModel(
clinic: freezed == clinic ? _self.clinic : clinic // ignore: cast_nullable_to_non_nullable
as ClinicDashboardClinicModel?,stats: freezed == stats ? _self.stats : stats // ignore: cast_nullable_to_non_nullable
as ClinicDashboardStatsModel?,appointments: null == appointments ? _self._appointments : appointments // ignore: cast_nullable_to_non_nullable
as List<ClinicDashboardAppointmentModel>,notifications: freezed == notifications ? _self.notifications : notifications // ignore: cast_nullable_to_non_nullable
as ClinicDashboardNotificationsModel?,
  ));
}

/// Create a copy of ClinicDashboardModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ClinicDashboardClinicModelCopyWith<$Res>? get clinic {
    if (_self.clinic == null) {
    return null;
  }

  return $ClinicDashboardClinicModelCopyWith<$Res>(_self.clinic!, (value) {
    return _then(_self.copyWith(clinic: value));
  });
}/// Create a copy of ClinicDashboardModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ClinicDashboardStatsModelCopyWith<$Res>? get stats {
    if (_self.stats == null) {
    return null;
  }

  return $ClinicDashboardStatsModelCopyWith<$Res>(_self.stats!, (value) {
    return _then(_self.copyWith(stats: value));
  });
}/// Create a copy of ClinicDashboardModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ClinicDashboardNotificationsModelCopyWith<$Res>? get notifications {
    if (_self.notifications == null) {
    return null;
  }

  return $ClinicDashboardNotificationsModelCopyWith<$Res>(_self.notifications!, (value) {
    return _then(_self.copyWith(notifications: value));
  });
}
}


/// @nodoc
mixin _$ClinicDashboardClinicModel {

@JsonKey(name: 'clinic_id') String? get clinicId; String? get name; String? get logo; String? get cover; String? get status;@JsonKey(name: 'is_active') bool? get isActive;@JsonKey(name: 'is_open') bool? get isOpen;@JsonKey(name: 'working_hours_text') String? get workingHoursText;
/// Create a copy of ClinicDashboardClinicModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ClinicDashboardClinicModelCopyWith<ClinicDashboardClinicModel> get copyWith => _$ClinicDashboardClinicModelCopyWithImpl<ClinicDashboardClinicModel>(this as ClinicDashboardClinicModel, _$identity);

  /// Serializes this ClinicDashboardClinicModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ClinicDashboardClinicModel&&(identical(other.clinicId, clinicId) || other.clinicId == clinicId)&&(identical(other.name, name) || other.name == name)&&(identical(other.logo, logo) || other.logo == logo)&&(identical(other.cover, cover) || other.cover == cover)&&(identical(other.status, status) || other.status == status)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.isOpen, isOpen) || other.isOpen == isOpen)&&(identical(other.workingHoursText, workingHoursText) || other.workingHoursText == workingHoursText));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,clinicId,name,logo,cover,status,isActive,isOpen,workingHoursText);

@override
String toString() {
  return 'ClinicDashboardClinicModel(clinicId: $clinicId, name: $name, logo: $logo, cover: $cover, status: $status, isActive: $isActive, isOpen: $isOpen, workingHoursText: $workingHoursText)';
}


}

/// @nodoc
abstract mixin class $ClinicDashboardClinicModelCopyWith<$Res>  {
  factory $ClinicDashboardClinicModelCopyWith(ClinicDashboardClinicModel value, $Res Function(ClinicDashboardClinicModel) _then) = _$ClinicDashboardClinicModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'clinic_id') String? clinicId, String? name, String? logo, String? cover, String? status,@JsonKey(name: 'is_active') bool? isActive,@JsonKey(name: 'is_open') bool? isOpen,@JsonKey(name: 'working_hours_text') String? workingHoursText
});




}
/// @nodoc
class _$ClinicDashboardClinicModelCopyWithImpl<$Res>
    implements $ClinicDashboardClinicModelCopyWith<$Res> {
  _$ClinicDashboardClinicModelCopyWithImpl(this._self, this._then);

  final ClinicDashboardClinicModel _self;
  final $Res Function(ClinicDashboardClinicModel) _then;

/// Create a copy of ClinicDashboardClinicModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? clinicId = freezed,Object? name = freezed,Object? logo = freezed,Object? cover = freezed,Object? status = freezed,Object? isActive = freezed,Object? isOpen = freezed,Object? workingHoursText = freezed,}) {
  return _then(_self.copyWith(
clinicId: freezed == clinicId ? _self.clinicId : clinicId // ignore: cast_nullable_to_non_nullable
as String?,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,logo: freezed == logo ? _self.logo : logo // ignore: cast_nullable_to_non_nullable
as String?,cover: freezed == cover ? _self.cover : cover // ignore: cast_nullable_to_non_nullable
as String?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,isActive: freezed == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool?,isOpen: freezed == isOpen ? _self.isOpen : isOpen // ignore: cast_nullable_to_non_nullable
as bool?,workingHoursText: freezed == workingHoursText ? _self.workingHoursText : workingHoursText // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ClinicDashboardClinicModel].
extension ClinicDashboardClinicModelPatterns on ClinicDashboardClinicModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ClinicDashboardClinicModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ClinicDashboardClinicModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ClinicDashboardClinicModel value)  $default,){
final _that = this;
switch (_that) {
case _ClinicDashboardClinicModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ClinicDashboardClinicModel value)?  $default,){
final _that = this;
switch (_that) {
case _ClinicDashboardClinicModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'clinic_id')  String? clinicId,  String? name,  String? logo,  String? cover,  String? status, @JsonKey(name: 'is_active')  bool? isActive, @JsonKey(name: 'is_open')  bool? isOpen, @JsonKey(name: 'working_hours_text')  String? workingHoursText)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ClinicDashboardClinicModel() when $default != null:
return $default(_that.clinicId,_that.name,_that.logo,_that.cover,_that.status,_that.isActive,_that.isOpen,_that.workingHoursText);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'clinic_id')  String? clinicId,  String? name,  String? logo,  String? cover,  String? status, @JsonKey(name: 'is_active')  bool? isActive, @JsonKey(name: 'is_open')  bool? isOpen, @JsonKey(name: 'working_hours_text')  String? workingHoursText)  $default,) {final _that = this;
switch (_that) {
case _ClinicDashboardClinicModel():
return $default(_that.clinicId,_that.name,_that.logo,_that.cover,_that.status,_that.isActive,_that.isOpen,_that.workingHoursText);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'clinic_id')  String? clinicId,  String? name,  String? logo,  String? cover,  String? status, @JsonKey(name: 'is_active')  bool? isActive, @JsonKey(name: 'is_open')  bool? isOpen, @JsonKey(name: 'working_hours_text')  String? workingHoursText)?  $default,) {final _that = this;
switch (_that) {
case _ClinicDashboardClinicModel() when $default != null:
return $default(_that.clinicId,_that.name,_that.logo,_that.cover,_that.status,_that.isActive,_that.isOpen,_that.workingHoursText);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ClinicDashboardClinicModel implements ClinicDashboardClinicModel {
  const _ClinicDashboardClinicModel({@JsonKey(name: 'clinic_id') this.clinicId, this.name, this.logo, this.cover, this.status, @JsonKey(name: 'is_active') this.isActive, @JsonKey(name: 'is_open') this.isOpen, @JsonKey(name: 'working_hours_text') this.workingHoursText});
  factory _ClinicDashboardClinicModel.fromJson(Map<String, dynamic> json) => _$ClinicDashboardClinicModelFromJson(json);

@override@JsonKey(name: 'clinic_id') final  String? clinicId;
@override final  String? name;
@override final  String? logo;
@override final  String? cover;
@override final  String? status;
@override@JsonKey(name: 'is_active') final  bool? isActive;
@override@JsonKey(name: 'is_open') final  bool? isOpen;
@override@JsonKey(name: 'working_hours_text') final  String? workingHoursText;

/// Create a copy of ClinicDashboardClinicModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ClinicDashboardClinicModelCopyWith<_ClinicDashboardClinicModel> get copyWith => __$ClinicDashboardClinicModelCopyWithImpl<_ClinicDashboardClinicModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ClinicDashboardClinicModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ClinicDashboardClinicModel&&(identical(other.clinicId, clinicId) || other.clinicId == clinicId)&&(identical(other.name, name) || other.name == name)&&(identical(other.logo, logo) || other.logo == logo)&&(identical(other.cover, cover) || other.cover == cover)&&(identical(other.status, status) || other.status == status)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.isOpen, isOpen) || other.isOpen == isOpen)&&(identical(other.workingHoursText, workingHoursText) || other.workingHoursText == workingHoursText));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,clinicId,name,logo,cover,status,isActive,isOpen,workingHoursText);

@override
String toString() {
  return 'ClinicDashboardClinicModel(clinicId: $clinicId, name: $name, logo: $logo, cover: $cover, status: $status, isActive: $isActive, isOpen: $isOpen, workingHoursText: $workingHoursText)';
}


}

/// @nodoc
abstract mixin class _$ClinicDashboardClinicModelCopyWith<$Res> implements $ClinicDashboardClinicModelCopyWith<$Res> {
  factory _$ClinicDashboardClinicModelCopyWith(_ClinicDashboardClinicModel value, $Res Function(_ClinicDashboardClinicModel) _then) = __$ClinicDashboardClinicModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'clinic_id') String? clinicId, String? name, String? logo, String? cover, String? status,@JsonKey(name: 'is_active') bool? isActive,@JsonKey(name: 'is_open') bool? isOpen,@JsonKey(name: 'working_hours_text') String? workingHoursText
});




}
/// @nodoc
class __$ClinicDashboardClinicModelCopyWithImpl<$Res>
    implements _$ClinicDashboardClinicModelCopyWith<$Res> {
  __$ClinicDashboardClinicModelCopyWithImpl(this._self, this._then);

  final _ClinicDashboardClinicModel _self;
  final $Res Function(_ClinicDashboardClinicModel) _then;

/// Create a copy of ClinicDashboardClinicModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? clinicId = freezed,Object? name = freezed,Object? logo = freezed,Object? cover = freezed,Object? status = freezed,Object? isActive = freezed,Object? isOpen = freezed,Object? workingHoursText = freezed,}) {
  return _then(_ClinicDashboardClinicModel(
clinicId: freezed == clinicId ? _self.clinicId : clinicId // ignore: cast_nullable_to_non_nullable
as String?,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,logo: freezed == logo ? _self.logo : logo // ignore: cast_nullable_to_non_nullable
as String?,cover: freezed == cover ? _self.cover : cover // ignore: cast_nullable_to_non_nullable
as String?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,isActive: freezed == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool?,isOpen: freezed == isOpen ? _self.isOpen : isOpen // ignore: cast_nullable_to_non_nullable
as bool?,workingHoursText: freezed == workingHoursText ? _self.workingHoursText : workingHoursText // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$ClinicDashboardStatsModel {

@JsonKey(name: 'patients_count') int get patientsCount;@JsonKey(name: 'doctors_count') int get doctorsCount;@JsonKey(name: 'daily_income') num get dailyIncome;@JsonKey(name: 'today_appointments_count') int get todayAppointmentsCount;@JsonKey(name: 'pending_appointments_count') int get pendingAppointmentsCount;@JsonKey(name: 'completed_appointments_count') int get completedAppointmentsCount;@JsonKey(name: 'rejected_appointments_count') int get rejectedAppointmentsCount;
/// Create a copy of ClinicDashboardStatsModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ClinicDashboardStatsModelCopyWith<ClinicDashboardStatsModel> get copyWith => _$ClinicDashboardStatsModelCopyWithImpl<ClinicDashboardStatsModel>(this as ClinicDashboardStatsModel, _$identity);

  /// Serializes this ClinicDashboardStatsModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ClinicDashboardStatsModel&&(identical(other.patientsCount, patientsCount) || other.patientsCount == patientsCount)&&(identical(other.doctorsCount, doctorsCount) || other.doctorsCount == doctorsCount)&&(identical(other.dailyIncome, dailyIncome) || other.dailyIncome == dailyIncome)&&(identical(other.todayAppointmentsCount, todayAppointmentsCount) || other.todayAppointmentsCount == todayAppointmentsCount)&&(identical(other.pendingAppointmentsCount, pendingAppointmentsCount) || other.pendingAppointmentsCount == pendingAppointmentsCount)&&(identical(other.completedAppointmentsCount, completedAppointmentsCount) || other.completedAppointmentsCount == completedAppointmentsCount)&&(identical(other.rejectedAppointmentsCount, rejectedAppointmentsCount) || other.rejectedAppointmentsCount == rejectedAppointmentsCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,patientsCount,doctorsCount,dailyIncome,todayAppointmentsCount,pendingAppointmentsCount,completedAppointmentsCount,rejectedAppointmentsCount);

@override
String toString() {
  return 'ClinicDashboardStatsModel(patientsCount: $patientsCount, doctorsCount: $doctorsCount, dailyIncome: $dailyIncome, todayAppointmentsCount: $todayAppointmentsCount, pendingAppointmentsCount: $pendingAppointmentsCount, completedAppointmentsCount: $completedAppointmentsCount, rejectedAppointmentsCount: $rejectedAppointmentsCount)';
}


}

/// @nodoc
abstract mixin class $ClinicDashboardStatsModelCopyWith<$Res>  {
  factory $ClinicDashboardStatsModelCopyWith(ClinicDashboardStatsModel value, $Res Function(ClinicDashboardStatsModel) _then) = _$ClinicDashboardStatsModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'patients_count') int patientsCount,@JsonKey(name: 'doctors_count') int doctorsCount,@JsonKey(name: 'daily_income') num dailyIncome,@JsonKey(name: 'today_appointments_count') int todayAppointmentsCount,@JsonKey(name: 'pending_appointments_count') int pendingAppointmentsCount,@JsonKey(name: 'completed_appointments_count') int completedAppointmentsCount,@JsonKey(name: 'rejected_appointments_count') int rejectedAppointmentsCount
});




}
/// @nodoc
class _$ClinicDashboardStatsModelCopyWithImpl<$Res>
    implements $ClinicDashboardStatsModelCopyWith<$Res> {
  _$ClinicDashboardStatsModelCopyWithImpl(this._self, this._then);

  final ClinicDashboardStatsModel _self;
  final $Res Function(ClinicDashboardStatsModel) _then;

/// Create a copy of ClinicDashboardStatsModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? patientsCount = null,Object? doctorsCount = null,Object? dailyIncome = null,Object? todayAppointmentsCount = null,Object? pendingAppointmentsCount = null,Object? completedAppointmentsCount = null,Object? rejectedAppointmentsCount = null,}) {
  return _then(_self.copyWith(
patientsCount: null == patientsCount ? _self.patientsCount : patientsCount // ignore: cast_nullable_to_non_nullable
as int,doctorsCount: null == doctorsCount ? _self.doctorsCount : doctorsCount // ignore: cast_nullable_to_non_nullable
as int,dailyIncome: null == dailyIncome ? _self.dailyIncome : dailyIncome // ignore: cast_nullable_to_non_nullable
as num,todayAppointmentsCount: null == todayAppointmentsCount ? _self.todayAppointmentsCount : todayAppointmentsCount // ignore: cast_nullable_to_non_nullable
as int,pendingAppointmentsCount: null == pendingAppointmentsCount ? _self.pendingAppointmentsCount : pendingAppointmentsCount // ignore: cast_nullable_to_non_nullable
as int,completedAppointmentsCount: null == completedAppointmentsCount ? _self.completedAppointmentsCount : completedAppointmentsCount // ignore: cast_nullable_to_non_nullable
as int,rejectedAppointmentsCount: null == rejectedAppointmentsCount ? _self.rejectedAppointmentsCount : rejectedAppointmentsCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [ClinicDashboardStatsModel].
extension ClinicDashboardStatsModelPatterns on ClinicDashboardStatsModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ClinicDashboardStatsModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ClinicDashboardStatsModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ClinicDashboardStatsModel value)  $default,){
final _that = this;
switch (_that) {
case _ClinicDashboardStatsModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ClinicDashboardStatsModel value)?  $default,){
final _that = this;
switch (_that) {
case _ClinicDashboardStatsModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'patients_count')  int patientsCount, @JsonKey(name: 'doctors_count')  int doctorsCount, @JsonKey(name: 'daily_income')  num dailyIncome, @JsonKey(name: 'today_appointments_count')  int todayAppointmentsCount, @JsonKey(name: 'pending_appointments_count')  int pendingAppointmentsCount, @JsonKey(name: 'completed_appointments_count')  int completedAppointmentsCount, @JsonKey(name: 'rejected_appointments_count')  int rejectedAppointmentsCount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ClinicDashboardStatsModel() when $default != null:
return $default(_that.patientsCount,_that.doctorsCount,_that.dailyIncome,_that.todayAppointmentsCount,_that.pendingAppointmentsCount,_that.completedAppointmentsCount,_that.rejectedAppointmentsCount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'patients_count')  int patientsCount, @JsonKey(name: 'doctors_count')  int doctorsCount, @JsonKey(name: 'daily_income')  num dailyIncome, @JsonKey(name: 'today_appointments_count')  int todayAppointmentsCount, @JsonKey(name: 'pending_appointments_count')  int pendingAppointmentsCount, @JsonKey(name: 'completed_appointments_count')  int completedAppointmentsCount, @JsonKey(name: 'rejected_appointments_count')  int rejectedAppointmentsCount)  $default,) {final _that = this;
switch (_that) {
case _ClinicDashboardStatsModel():
return $default(_that.patientsCount,_that.doctorsCount,_that.dailyIncome,_that.todayAppointmentsCount,_that.pendingAppointmentsCount,_that.completedAppointmentsCount,_that.rejectedAppointmentsCount);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'patients_count')  int patientsCount, @JsonKey(name: 'doctors_count')  int doctorsCount, @JsonKey(name: 'daily_income')  num dailyIncome, @JsonKey(name: 'today_appointments_count')  int todayAppointmentsCount, @JsonKey(name: 'pending_appointments_count')  int pendingAppointmentsCount, @JsonKey(name: 'completed_appointments_count')  int completedAppointmentsCount, @JsonKey(name: 'rejected_appointments_count')  int rejectedAppointmentsCount)?  $default,) {final _that = this;
switch (_that) {
case _ClinicDashboardStatsModel() when $default != null:
return $default(_that.patientsCount,_that.doctorsCount,_that.dailyIncome,_that.todayAppointmentsCount,_that.pendingAppointmentsCount,_that.completedAppointmentsCount,_that.rejectedAppointmentsCount);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ClinicDashboardStatsModel implements ClinicDashboardStatsModel {
  const _ClinicDashboardStatsModel({@JsonKey(name: 'patients_count') this.patientsCount = 0, @JsonKey(name: 'doctors_count') this.doctorsCount = 0, @JsonKey(name: 'daily_income') this.dailyIncome = 0, @JsonKey(name: 'today_appointments_count') this.todayAppointmentsCount = 0, @JsonKey(name: 'pending_appointments_count') this.pendingAppointmentsCount = 0, @JsonKey(name: 'completed_appointments_count') this.completedAppointmentsCount = 0, @JsonKey(name: 'rejected_appointments_count') this.rejectedAppointmentsCount = 0});
  factory _ClinicDashboardStatsModel.fromJson(Map<String, dynamic> json) => _$ClinicDashboardStatsModelFromJson(json);

@override@JsonKey(name: 'patients_count') final  int patientsCount;
@override@JsonKey(name: 'doctors_count') final  int doctorsCount;
@override@JsonKey(name: 'daily_income') final  num dailyIncome;
@override@JsonKey(name: 'today_appointments_count') final  int todayAppointmentsCount;
@override@JsonKey(name: 'pending_appointments_count') final  int pendingAppointmentsCount;
@override@JsonKey(name: 'completed_appointments_count') final  int completedAppointmentsCount;
@override@JsonKey(name: 'rejected_appointments_count') final  int rejectedAppointmentsCount;

/// Create a copy of ClinicDashboardStatsModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ClinicDashboardStatsModelCopyWith<_ClinicDashboardStatsModel> get copyWith => __$ClinicDashboardStatsModelCopyWithImpl<_ClinicDashboardStatsModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ClinicDashboardStatsModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ClinicDashboardStatsModel&&(identical(other.patientsCount, patientsCount) || other.patientsCount == patientsCount)&&(identical(other.doctorsCount, doctorsCount) || other.doctorsCount == doctorsCount)&&(identical(other.dailyIncome, dailyIncome) || other.dailyIncome == dailyIncome)&&(identical(other.todayAppointmentsCount, todayAppointmentsCount) || other.todayAppointmentsCount == todayAppointmentsCount)&&(identical(other.pendingAppointmentsCount, pendingAppointmentsCount) || other.pendingAppointmentsCount == pendingAppointmentsCount)&&(identical(other.completedAppointmentsCount, completedAppointmentsCount) || other.completedAppointmentsCount == completedAppointmentsCount)&&(identical(other.rejectedAppointmentsCount, rejectedAppointmentsCount) || other.rejectedAppointmentsCount == rejectedAppointmentsCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,patientsCount,doctorsCount,dailyIncome,todayAppointmentsCount,pendingAppointmentsCount,completedAppointmentsCount,rejectedAppointmentsCount);

@override
String toString() {
  return 'ClinicDashboardStatsModel(patientsCount: $patientsCount, doctorsCount: $doctorsCount, dailyIncome: $dailyIncome, todayAppointmentsCount: $todayAppointmentsCount, pendingAppointmentsCount: $pendingAppointmentsCount, completedAppointmentsCount: $completedAppointmentsCount, rejectedAppointmentsCount: $rejectedAppointmentsCount)';
}


}

/// @nodoc
abstract mixin class _$ClinicDashboardStatsModelCopyWith<$Res> implements $ClinicDashboardStatsModelCopyWith<$Res> {
  factory _$ClinicDashboardStatsModelCopyWith(_ClinicDashboardStatsModel value, $Res Function(_ClinicDashboardStatsModel) _then) = __$ClinicDashboardStatsModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'patients_count') int patientsCount,@JsonKey(name: 'doctors_count') int doctorsCount,@JsonKey(name: 'daily_income') num dailyIncome,@JsonKey(name: 'today_appointments_count') int todayAppointmentsCount,@JsonKey(name: 'pending_appointments_count') int pendingAppointmentsCount,@JsonKey(name: 'completed_appointments_count') int completedAppointmentsCount,@JsonKey(name: 'rejected_appointments_count') int rejectedAppointmentsCount
});




}
/// @nodoc
class __$ClinicDashboardStatsModelCopyWithImpl<$Res>
    implements _$ClinicDashboardStatsModelCopyWith<$Res> {
  __$ClinicDashboardStatsModelCopyWithImpl(this._self, this._then);

  final _ClinicDashboardStatsModel _self;
  final $Res Function(_ClinicDashboardStatsModel) _then;

/// Create a copy of ClinicDashboardStatsModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? patientsCount = null,Object? doctorsCount = null,Object? dailyIncome = null,Object? todayAppointmentsCount = null,Object? pendingAppointmentsCount = null,Object? completedAppointmentsCount = null,Object? rejectedAppointmentsCount = null,}) {
  return _then(_ClinicDashboardStatsModel(
patientsCount: null == patientsCount ? _self.patientsCount : patientsCount // ignore: cast_nullable_to_non_nullable
as int,doctorsCount: null == doctorsCount ? _self.doctorsCount : doctorsCount // ignore: cast_nullable_to_non_nullable
as int,dailyIncome: null == dailyIncome ? _self.dailyIncome : dailyIncome // ignore: cast_nullable_to_non_nullable
as num,todayAppointmentsCount: null == todayAppointmentsCount ? _self.todayAppointmentsCount : todayAppointmentsCount // ignore: cast_nullable_to_non_nullable
as int,pendingAppointmentsCount: null == pendingAppointmentsCount ? _self.pendingAppointmentsCount : pendingAppointmentsCount // ignore: cast_nullable_to_non_nullable
as int,completedAppointmentsCount: null == completedAppointmentsCount ? _self.completedAppointmentsCount : completedAppointmentsCount // ignore: cast_nullable_to_non_nullable
as int,rejectedAppointmentsCount: null == rejectedAppointmentsCount ? _self.rejectedAppointmentsCount : rejectedAppointmentsCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$ClinicDashboardAppointmentModel {

@JsonKey(name: 'appointment_id') String? get appointmentId;@JsonKey(name: 'patient_name') String? get patientName;@JsonKey(name: 'service_name') String? get serviceName; String? get type; String? get time; String? get date; String? get status;@JsonKey(name: 'doctor_name') String? get doctorName;@JsonKey(name: 'specialization_name') String? get specializationName; String? get icon;
/// Create a copy of ClinicDashboardAppointmentModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ClinicDashboardAppointmentModelCopyWith<ClinicDashboardAppointmentModel> get copyWith => _$ClinicDashboardAppointmentModelCopyWithImpl<ClinicDashboardAppointmentModel>(this as ClinicDashboardAppointmentModel, _$identity);

  /// Serializes this ClinicDashboardAppointmentModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ClinicDashboardAppointmentModel&&(identical(other.appointmentId, appointmentId) || other.appointmentId == appointmentId)&&(identical(other.patientName, patientName) || other.patientName == patientName)&&(identical(other.serviceName, serviceName) || other.serviceName == serviceName)&&(identical(other.type, type) || other.type == type)&&(identical(other.time, time) || other.time == time)&&(identical(other.date, date) || other.date == date)&&(identical(other.status, status) || other.status == status)&&(identical(other.doctorName, doctorName) || other.doctorName == doctorName)&&(identical(other.specializationName, specializationName) || other.specializationName == specializationName)&&(identical(other.icon, icon) || other.icon == icon));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,appointmentId,patientName,serviceName,type,time,date,status,doctorName,specializationName,icon);

@override
String toString() {
  return 'ClinicDashboardAppointmentModel(appointmentId: $appointmentId, patientName: $patientName, serviceName: $serviceName, type: $type, time: $time, date: $date, status: $status, doctorName: $doctorName, specializationName: $specializationName, icon: $icon)';
}


}

/// @nodoc
abstract mixin class $ClinicDashboardAppointmentModelCopyWith<$Res>  {
  factory $ClinicDashboardAppointmentModelCopyWith(ClinicDashboardAppointmentModel value, $Res Function(ClinicDashboardAppointmentModel) _then) = _$ClinicDashboardAppointmentModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'appointment_id') String? appointmentId,@JsonKey(name: 'patient_name') String? patientName,@JsonKey(name: 'service_name') String? serviceName, String? type, String? time, String? date, String? status,@JsonKey(name: 'doctor_name') String? doctorName,@JsonKey(name: 'specialization_name') String? specializationName, String? icon
});




}
/// @nodoc
class _$ClinicDashboardAppointmentModelCopyWithImpl<$Res>
    implements $ClinicDashboardAppointmentModelCopyWith<$Res> {
  _$ClinicDashboardAppointmentModelCopyWithImpl(this._self, this._then);

  final ClinicDashboardAppointmentModel _self;
  final $Res Function(ClinicDashboardAppointmentModel) _then;

/// Create a copy of ClinicDashboardAppointmentModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? appointmentId = freezed,Object? patientName = freezed,Object? serviceName = freezed,Object? type = freezed,Object? time = freezed,Object? date = freezed,Object? status = freezed,Object? doctorName = freezed,Object? specializationName = freezed,Object? icon = freezed,}) {
  return _then(_self.copyWith(
appointmentId: freezed == appointmentId ? _self.appointmentId : appointmentId // ignore: cast_nullable_to_non_nullable
as String?,patientName: freezed == patientName ? _self.patientName : patientName // ignore: cast_nullable_to_non_nullable
as String?,serviceName: freezed == serviceName ? _self.serviceName : serviceName // ignore: cast_nullable_to_non_nullable
as String?,type: freezed == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String?,time: freezed == time ? _self.time : time // ignore: cast_nullable_to_non_nullable
as String?,date: freezed == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,doctorName: freezed == doctorName ? _self.doctorName : doctorName // ignore: cast_nullable_to_non_nullable
as String?,specializationName: freezed == specializationName ? _self.specializationName : specializationName // ignore: cast_nullable_to_non_nullable
as String?,icon: freezed == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ClinicDashboardAppointmentModel].
extension ClinicDashboardAppointmentModelPatterns on ClinicDashboardAppointmentModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ClinicDashboardAppointmentModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ClinicDashboardAppointmentModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ClinicDashboardAppointmentModel value)  $default,){
final _that = this;
switch (_that) {
case _ClinicDashboardAppointmentModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ClinicDashboardAppointmentModel value)?  $default,){
final _that = this;
switch (_that) {
case _ClinicDashboardAppointmentModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'appointment_id')  String? appointmentId, @JsonKey(name: 'patient_name')  String? patientName, @JsonKey(name: 'service_name')  String? serviceName,  String? type,  String? time,  String? date,  String? status, @JsonKey(name: 'doctor_name')  String? doctorName, @JsonKey(name: 'specialization_name')  String? specializationName,  String? icon)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ClinicDashboardAppointmentModel() when $default != null:
return $default(_that.appointmentId,_that.patientName,_that.serviceName,_that.type,_that.time,_that.date,_that.status,_that.doctorName,_that.specializationName,_that.icon);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'appointment_id')  String? appointmentId, @JsonKey(name: 'patient_name')  String? patientName, @JsonKey(name: 'service_name')  String? serviceName,  String? type,  String? time,  String? date,  String? status, @JsonKey(name: 'doctor_name')  String? doctorName, @JsonKey(name: 'specialization_name')  String? specializationName,  String? icon)  $default,) {final _that = this;
switch (_that) {
case _ClinicDashboardAppointmentModel():
return $default(_that.appointmentId,_that.patientName,_that.serviceName,_that.type,_that.time,_that.date,_that.status,_that.doctorName,_that.specializationName,_that.icon);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'appointment_id')  String? appointmentId, @JsonKey(name: 'patient_name')  String? patientName, @JsonKey(name: 'service_name')  String? serviceName,  String? type,  String? time,  String? date,  String? status, @JsonKey(name: 'doctor_name')  String? doctorName, @JsonKey(name: 'specialization_name')  String? specializationName,  String? icon)?  $default,) {final _that = this;
switch (_that) {
case _ClinicDashboardAppointmentModel() when $default != null:
return $default(_that.appointmentId,_that.patientName,_that.serviceName,_that.type,_that.time,_that.date,_that.status,_that.doctorName,_that.specializationName,_that.icon);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ClinicDashboardAppointmentModel implements ClinicDashboardAppointmentModel {
  const _ClinicDashboardAppointmentModel({@JsonKey(name: 'appointment_id') this.appointmentId, @JsonKey(name: 'patient_name') this.patientName, @JsonKey(name: 'service_name') this.serviceName, this.type, this.time, this.date, this.status, @JsonKey(name: 'doctor_name') this.doctorName, @JsonKey(name: 'specialization_name') this.specializationName, this.icon});
  factory _ClinicDashboardAppointmentModel.fromJson(Map<String, dynamic> json) => _$ClinicDashboardAppointmentModelFromJson(json);

@override@JsonKey(name: 'appointment_id') final  String? appointmentId;
@override@JsonKey(name: 'patient_name') final  String? patientName;
@override@JsonKey(name: 'service_name') final  String? serviceName;
@override final  String? type;
@override final  String? time;
@override final  String? date;
@override final  String? status;
@override@JsonKey(name: 'doctor_name') final  String? doctorName;
@override@JsonKey(name: 'specialization_name') final  String? specializationName;
@override final  String? icon;

/// Create a copy of ClinicDashboardAppointmentModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ClinicDashboardAppointmentModelCopyWith<_ClinicDashboardAppointmentModel> get copyWith => __$ClinicDashboardAppointmentModelCopyWithImpl<_ClinicDashboardAppointmentModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ClinicDashboardAppointmentModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ClinicDashboardAppointmentModel&&(identical(other.appointmentId, appointmentId) || other.appointmentId == appointmentId)&&(identical(other.patientName, patientName) || other.patientName == patientName)&&(identical(other.serviceName, serviceName) || other.serviceName == serviceName)&&(identical(other.type, type) || other.type == type)&&(identical(other.time, time) || other.time == time)&&(identical(other.date, date) || other.date == date)&&(identical(other.status, status) || other.status == status)&&(identical(other.doctorName, doctorName) || other.doctorName == doctorName)&&(identical(other.specializationName, specializationName) || other.specializationName == specializationName)&&(identical(other.icon, icon) || other.icon == icon));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,appointmentId,patientName,serviceName,type,time,date,status,doctorName,specializationName,icon);

@override
String toString() {
  return 'ClinicDashboardAppointmentModel(appointmentId: $appointmentId, patientName: $patientName, serviceName: $serviceName, type: $type, time: $time, date: $date, status: $status, doctorName: $doctorName, specializationName: $specializationName, icon: $icon)';
}


}

/// @nodoc
abstract mixin class _$ClinicDashboardAppointmentModelCopyWith<$Res> implements $ClinicDashboardAppointmentModelCopyWith<$Res> {
  factory _$ClinicDashboardAppointmentModelCopyWith(_ClinicDashboardAppointmentModel value, $Res Function(_ClinicDashboardAppointmentModel) _then) = __$ClinicDashboardAppointmentModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'appointment_id') String? appointmentId,@JsonKey(name: 'patient_name') String? patientName,@JsonKey(name: 'service_name') String? serviceName, String? type, String? time, String? date, String? status,@JsonKey(name: 'doctor_name') String? doctorName,@JsonKey(name: 'specialization_name') String? specializationName, String? icon
});




}
/// @nodoc
class __$ClinicDashboardAppointmentModelCopyWithImpl<$Res>
    implements _$ClinicDashboardAppointmentModelCopyWith<$Res> {
  __$ClinicDashboardAppointmentModelCopyWithImpl(this._self, this._then);

  final _ClinicDashboardAppointmentModel _self;
  final $Res Function(_ClinicDashboardAppointmentModel) _then;

/// Create a copy of ClinicDashboardAppointmentModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? appointmentId = freezed,Object? patientName = freezed,Object? serviceName = freezed,Object? type = freezed,Object? time = freezed,Object? date = freezed,Object? status = freezed,Object? doctorName = freezed,Object? specializationName = freezed,Object? icon = freezed,}) {
  return _then(_ClinicDashboardAppointmentModel(
appointmentId: freezed == appointmentId ? _self.appointmentId : appointmentId // ignore: cast_nullable_to_non_nullable
as String?,patientName: freezed == patientName ? _self.patientName : patientName // ignore: cast_nullable_to_non_nullable
as String?,serviceName: freezed == serviceName ? _self.serviceName : serviceName // ignore: cast_nullable_to_non_nullable
as String?,type: freezed == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String?,time: freezed == time ? _self.time : time // ignore: cast_nullable_to_non_nullable
as String?,date: freezed == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,doctorName: freezed == doctorName ? _self.doctorName : doctorName // ignore: cast_nullable_to_non_nullable
as String?,specializationName: freezed == specializationName ? _self.specializationName : specializationName // ignore: cast_nullable_to_non_nullable
as String?,icon: freezed == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$ClinicDashboardNotificationsModel {

@JsonKey(name: 'unread_count') int get unreadCount;
/// Create a copy of ClinicDashboardNotificationsModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ClinicDashboardNotificationsModelCopyWith<ClinicDashboardNotificationsModel> get copyWith => _$ClinicDashboardNotificationsModelCopyWithImpl<ClinicDashboardNotificationsModel>(this as ClinicDashboardNotificationsModel, _$identity);

  /// Serializes this ClinicDashboardNotificationsModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ClinicDashboardNotificationsModel&&(identical(other.unreadCount, unreadCount) || other.unreadCount == unreadCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,unreadCount);

@override
String toString() {
  return 'ClinicDashboardNotificationsModel(unreadCount: $unreadCount)';
}


}

/// @nodoc
abstract mixin class $ClinicDashboardNotificationsModelCopyWith<$Res>  {
  factory $ClinicDashboardNotificationsModelCopyWith(ClinicDashboardNotificationsModel value, $Res Function(ClinicDashboardNotificationsModel) _then) = _$ClinicDashboardNotificationsModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'unread_count') int unreadCount
});




}
/// @nodoc
class _$ClinicDashboardNotificationsModelCopyWithImpl<$Res>
    implements $ClinicDashboardNotificationsModelCopyWith<$Res> {
  _$ClinicDashboardNotificationsModelCopyWithImpl(this._self, this._then);

  final ClinicDashboardNotificationsModel _self;
  final $Res Function(ClinicDashboardNotificationsModel) _then;

/// Create a copy of ClinicDashboardNotificationsModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? unreadCount = null,}) {
  return _then(_self.copyWith(
unreadCount: null == unreadCount ? _self.unreadCount : unreadCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [ClinicDashboardNotificationsModel].
extension ClinicDashboardNotificationsModelPatterns on ClinicDashboardNotificationsModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ClinicDashboardNotificationsModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ClinicDashboardNotificationsModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ClinicDashboardNotificationsModel value)  $default,){
final _that = this;
switch (_that) {
case _ClinicDashboardNotificationsModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ClinicDashboardNotificationsModel value)?  $default,){
final _that = this;
switch (_that) {
case _ClinicDashboardNotificationsModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'unread_count')  int unreadCount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ClinicDashboardNotificationsModel() when $default != null:
return $default(_that.unreadCount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'unread_count')  int unreadCount)  $default,) {final _that = this;
switch (_that) {
case _ClinicDashboardNotificationsModel():
return $default(_that.unreadCount);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'unread_count')  int unreadCount)?  $default,) {final _that = this;
switch (_that) {
case _ClinicDashboardNotificationsModel() when $default != null:
return $default(_that.unreadCount);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ClinicDashboardNotificationsModel implements ClinicDashboardNotificationsModel {
  const _ClinicDashboardNotificationsModel({@JsonKey(name: 'unread_count') this.unreadCount = 0});
  factory _ClinicDashboardNotificationsModel.fromJson(Map<String, dynamic> json) => _$ClinicDashboardNotificationsModelFromJson(json);

@override@JsonKey(name: 'unread_count') final  int unreadCount;

/// Create a copy of ClinicDashboardNotificationsModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ClinicDashboardNotificationsModelCopyWith<_ClinicDashboardNotificationsModel> get copyWith => __$ClinicDashboardNotificationsModelCopyWithImpl<_ClinicDashboardNotificationsModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ClinicDashboardNotificationsModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ClinicDashboardNotificationsModel&&(identical(other.unreadCount, unreadCount) || other.unreadCount == unreadCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,unreadCount);

@override
String toString() {
  return 'ClinicDashboardNotificationsModel(unreadCount: $unreadCount)';
}


}

/// @nodoc
abstract mixin class _$ClinicDashboardNotificationsModelCopyWith<$Res> implements $ClinicDashboardNotificationsModelCopyWith<$Res> {
  factory _$ClinicDashboardNotificationsModelCopyWith(_ClinicDashboardNotificationsModel value, $Res Function(_ClinicDashboardNotificationsModel) _then) = __$ClinicDashboardNotificationsModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'unread_count') int unreadCount
});




}
/// @nodoc
class __$ClinicDashboardNotificationsModelCopyWithImpl<$Res>
    implements _$ClinicDashboardNotificationsModelCopyWith<$Res> {
  __$ClinicDashboardNotificationsModelCopyWithImpl(this._self, this._then);

  final _ClinicDashboardNotificationsModel _self;
  final $Res Function(_ClinicDashboardNotificationsModel) _then;

/// Create a copy of ClinicDashboardNotificationsModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? unreadCount = null,}) {
  return _then(_ClinicDashboardNotificationsModel(
unreadCount: null == unreadCount ? _self.unreadCount : unreadCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
