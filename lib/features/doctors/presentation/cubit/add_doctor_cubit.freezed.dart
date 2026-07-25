// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'add_doctor_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AddDoctorState {

 ClinicDoctorModel? get initialDoctor; ClinicDoctorModel? get savedDoctor; List<ClinicSpecializationModel> get specializations; String? get selectedSpecializationId; String get gender; String? get imagePath; List<DoctorPickedQualification> get qualificationFiles; bool get specialtyOpen; Set<Weekday> get activeDays; Map<Weekday, WorkingHours> get hours; bool get isLoadingSpecializations; bool get isSaving; bool get saved; NetworkExceptions? get failure;
/// Create a copy of AddDoctorState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AddDoctorStateCopyWith<AddDoctorState> get copyWith => _$AddDoctorStateCopyWithImpl<AddDoctorState>(this as AddDoctorState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AddDoctorState&&(identical(other.initialDoctor, initialDoctor) || other.initialDoctor == initialDoctor)&&(identical(other.savedDoctor, savedDoctor) || other.savedDoctor == savedDoctor)&&const DeepCollectionEquality().equals(other.specializations, specializations)&&(identical(other.selectedSpecializationId, selectedSpecializationId) || other.selectedSpecializationId == selectedSpecializationId)&&(identical(other.gender, gender) || other.gender == gender)&&(identical(other.imagePath, imagePath) || other.imagePath == imagePath)&&const DeepCollectionEquality().equals(other.qualificationFiles, qualificationFiles)&&(identical(other.specialtyOpen, specialtyOpen) || other.specialtyOpen == specialtyOpen)&&const DeepCollectionEquality().equals(other.activeDays, activeDays)&&const DeepCollectionEquality().equals(other.hours, hours)&&(identical(other.isLoadingSpecializations, isLoadingSpecializations) || other.isLoadingSpecializations == isLoadingSpecializations)&&(identical(other.isSaving, isSaving) || other.isSaving == isSaving)&&(identical(other.saved, saved) || other.saved == saved)&&(identical(other.failure, failure) || other.failure == failure));
}


@override
int get hashCode => Object.hash(runtimeType,initialDoctor,savedDoctor,const DeepCollectionEquality().hash(specializations),selectedSpecializationId,gender,imagePath,const DeepCollectionEquality().hash(qualificationFiles),specialtyOpen,const DeepCollectionEquality().hash(activeDays),const DeepCollectionEquality().hash(hours),isLoadingSpecializations,isSaving,saved,failure);

@override
String toString() {
  return 'AddDoctorState(initialDoctor: $initialDoctor, savedDoctor: $savedDoctor, specializations: $specializations, selectedSpecializationId: $selectedSpecializationId, gender: $gender, imagePath: $imagePath, qualificationFiles: $qualificationFiles, specialtyOpen: $specialtyOpen, activeDays: $activeDays, hours: $hours, isLoadingSpecializations: $isLoadingSpecializations, isSaving: $isSaving, saved: $saved, failure: $failure)';
}


}

/// @nodoc
abstract mixin class $AddDoctorStateCopyWith<$Res>  {
  factory $AddDoctorStateCopyWith(AddDoctorState value, $Res Function(AddDoctorState) _then) = _$AddDoctorStateCopyWithImpl;
@useResult
$Res call({
 ClinicDoctorModel? initialDoctor, ClinicDoctorModel? savedDoctor, List<ClinicSpecializationModel> specializations, String? selectedSpecializationId, String gender, String? imagePath, List<DoctorPickedQualification> qualificationFiles, bool specialtyOpen, Set<Weekday> activeDays, Map<Weekday, WorkingHours> hours, bool isLoadingSpecializations, bool isSaving, bool saved, NetworkExceptions? failure
});


$ClinicDoctorModelCopyWith<$Res>? get initialDoctor;$ClinicDoctorModelCopyWith<$Res>? get savedDoctor;$NetworkExceptionsCopyWith<$Res>? get failure;

}
/// @nodoc
class _$AddDoctorStateCopyWithImpl<$Res>
    implements $AddDoctorStateCopyWith<$Res> {
  _$AddDoctorStateCopyWithImpl(this._self, this._then);

  final AddDoctorState _self;
  final $Res Function(AddDoctorState) _then;

/// Create a copy of AddDoctorState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? initialDoctor = freezed,Object? savedDoctor = freezed,Object? specializations = null,Object? selectedSpecializationId = freezed,Object? gender = null,Object? imagePath = freezed,Object? qualificationFiles = null,Object? specialtyOpen = null,Object? activeDays = null,Object? hours = null,Object? isLoadingSpecializations = null,Object? isSaving = null,Object? saved = null,Object? failure = freezed,}) {
  return _then(_self.copyWith(
initialDoctor: freezed == initialDoctor ? _self.initialDoctor : initialDoctor // ignore: cast_nullable_to_non_nullable
as ClinicDoctorModel?,savedDoctor: freezed == savedDoctor ? _self.savedDoctor : savedDoctor // ignore: cast_nullable_to_non_nullable
as ClinicDoctorModel?,specializations: null == specializations ? _self.specializations : specializations // ignore: cast_nullable_to_non_nullable
as List<ClinicSpecializationModel>,selectedSpecializationId: freezed == selectedSpecializationId ? _self.selectedSpecializationId : selectedSpecializationId // ignore: cast_nullable_to_non_nullable
as String?,gender: null == gender ? _self.gender : gender // ignore: cast_nullable_to_non_nullable
as String,imagePath: freezed == imagePath ? _self.imagePath : imagePath // ignore: cast_nullable_to_non_nullable
as String?,qualificationFiles: null == qualificationFiles ? _self.qualificationFiles : qualificationFiles // ignore: cast_nullable_to_non_nullable
as List<DoctorPickedQualification>,specialtyOpen: null == specialtyOpen ? _self.specialtyOpen : specialtyOpen // ignore: cast_nullable_to_non_nullable
as bool,activeDays: null == activeDays ? _self.activeDays : activeDays // ignore: cast_nullable_to_non_nullable
as Set<Weekday>,hours: null == hours ? _self.hours : hours // ignore: cast_nullable_to_non_nullable
as Map<Weekday, WorkingHours>,isLoadingSpecializations: null == isLoadingSpecializations ? _self.isLoadingSpecializations : isLoadingSpecializations // ignore: cast_nullable_to_non_nullable
as bool,isSaving: null == isSaving ? _self.isSaving : isSaving // ignore: cast_nullable_to_non_nullable
as bool,saved: null == saved ? _self.saved : saved // ignore: cast_nullable_to_non_nullable
as bool,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as NetworkExceptions?,
  ));
}
/// Create a copy of AddDoctorState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ClinicDoctorModelCopyWith<$Res>? get initialDoctor {
    if (_self.initialDoctor == null) {
    return null;
  }

  return $ClinicDoctorModelCopyWith<$Res>(_self.initialDoctor!, (value) {
    return _then(_self.copyWith(initialDoctor: value));
  });
}/// Create a copy of AddDoctorState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ClinicDoctorModelCopyWith<$Res>? get savedDoctor {
    if (_self.savedDoctor == null) {
    return null;
  }

  return $ClinicDoctorModelCopyWith<$Res>(_self.savedDoctor!, (value) {
    return _then(_self.copyWith(savedDoctor: value));
  });
}/// Create a copy of AddDoctorState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$NetworkExceptionsCopyWith<$Res>? get failure {
    if (_self.failure == null) {
    return null;
  }

  return $NetworkExceptionsCopyWith<$Res>(_self.failure!, (value) {
    return _then(_self.copyWith(failure: value));
  });
}
}


/// Adds pattern-matching-related methods to [AddDoctorState].
extension AddDoctorStatePatterns on AddDoctorState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AddDoctorState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AddDoctorState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AddDoctorState value)  $default,){
final _that = this;
switch (_that) {
case _AddDoctorState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AddDoctorState value)?  $default,){
final _that = this;
switch (_that) {
case _AddDoctorState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( ClinicDoctorModel? initialDoctor,  ClinicDoctorModel? savedDoctor,  List<ClinicSpecializationModel> specializations,  String? selectedSpecializationId,  String gender,  String? imagePath,  List<DoctorPickedQualification> qualificationFiles,  bool specialtyOpen,  Set<Weekday> activeDays,  Map<Weekday, WorkingHours> hours,  bool isLoadingSpecializations,  bool isSaving,  bool saved,  NetworkExceptions? failure)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AddDoctorState() when $default != null:
return $default(_that.initialDoctor,_that.savedDoctor,_that.specializations,_that.selectedSpecializationId,_that.gender,_that.imagePath,_that.qualificationFiles,_that.specialtyOpen,_that.activeDays,_that.hours,_that.isLoadingSpecializations,_that.isSaving,_that.saved,_that.failure);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( ClinicDoctorModel? initialDoctor,  ClinicDoctorModel? savedDoctor,  List<ClinicSpecializationModel> specializations,  String? selectedSpecializationId,  String gender,  String? imagePath,  List<DoctorPickedQualification> qualificationFiles,  bool specialtyOpen,  Set<Weekday> activeDays,  Map<Weekday, WorkingHours> hours,  bool isLoadingSpecializations,  bool isSaving,  bool saved,  NetworkExceptions? failure)  $default,) {final _that = this;
switch (_that) {
case _AddDoctorState():
return $default(_that.initialDoctor,_that.savedDoctor,_that.specializations,_that.selectedSpecializationId,_that.gender,_that.imagePath,_that.qualificationFiles,_that.specialtyOpen,_that.activeDays,_that.hours,_that.isLoadingSpecializations,_that.isSaving,_that.saved,_that.failure);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( ClinicDoctorModel? initialDoctor,  ClinicDoctorModel? savedDoctor,  List<ClinicSpecializationModel> specializations,  String? selectedSpecializationId,  String gender,  String? imagePath,  List<DoctorPickedQualification> qualificationFiles,  bool specialtyOpen,  Set<Weekday> activeDays,  Map<Weekday, WorkingHours> hours,  bool isLoadingSpecializations,  bool isSaving,  bool saved,  NetworkExceptions? failure)?  $default,) {final _that = this;
switch (_that) {
case _AddDoctorState() when $default != null:
return $default(_that.initialDoctor,_that.savedDoctor,_that.specializations,_that.selectedSpecializationId,_that.gender,_that.imagePath,_that.qualificationFiles,_that.specialtyOpen,_that.activeDays,_that.hours,_that.isLoadingSpecializations,_that.isSaving,_that.saved,_that.failure);case _:
  return null;

}
}

}

/// @nodoc


class _AddDoctorState implements AddDoctorState {
  const _AddDoctorState({this.initialDoctor, this.savedDoctor, final  List<ClinicSpecializationModel> specializations = const <ClinicSpecializationModel>[], this.selectedSpecializationId, this.gender = 'male', this.imagePath, final  List<DoctorPickedQualification> qualificationFiles = const <DoctorPickedQualification>[], this.specialtyOpen = false, final  Set<Weekday> activeDays = _defaultDays, final  Map<Weekday, WorkingHours> hours = _defaultHours, this.isLoadingSpecializations = false, this.isSaving = false, this.saved = false, this.failure}): _specializations = specializations,_qualificationFiles = qualificationFiles,_activeDays = activeDays,_hours = hours;
  

@override final  ClinicDoctorModel? initialDoctor;
@override final  ClinicDoctorModel? savedDoctor;
 final  List<ClinicSpecializationModel> _specializations;
@override@JsonKey() List<ClinicSpecializationModel> get specializations {
  if (_specializations is EqualUnmodifiableListView) return _specializations;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_specializations);
}

@override final  String? selectedSpecializationId;
@override@JsonKey() final  String gender;
@override final  String? imagePath;
 final  List<DoctorPickedQualification> _qualificationFiles;
@override@JsonKey() List<DoctorPickedQualification> get qualificationFiles {
  if (_qualificationFiles is EqualUnmodifiableListView) return _qualificationFiles;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_qualificationFiles);
}

@override@JsonKey() final  bool specialtyOpen;
 final  Set<Weekday> _activeDays;
@override@JsonKey() Set<Weekday> get activeDays {
  if (_activeDays is EqualUnmodifiableSetView) return _activeDays;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableSetView(_activeDays);
}

 final  Map<Weekday, WorkingHours> _hours;
@override@JsonKey() Map<Weekday, WorkingHours> get hours {
  if (_hours is EqualUnmodifiableMapView) return _hours;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_hours);
}

@override@JsonKey() final  bool isLoadingSpecializations;
@override@JsonKey() final  bool isSaving;
@override@JsonKey() final  bool saved;
@override final  NetworkExceptions? failure;

/// Create a copy of AddDoctorState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AddDoctorStateCopyWith<_AddDoctorState> get copyWith => __$AddDoctorStateCopyWithImpl<_AddDoctorState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AddDoctorState&&(identical(other.initialDoctor, initialDoctor) || other.initialDoctor == initialDoctor)&&(identical(other.savedDoctor, savedDoctor) || other.savedDoctor == savedDoctor)&&const DeepCollectionEquality().equals(other._specializations, _specializations)&&(identical(other.selectedSpecializationId, selectedSpecializationId) || other.selectedSpecializationId == selectedSpecializationId)&&(identical(other.gender, gender) || other.gender == gender)&&(identical(other.imagePath, imagePath) || other.imagePath == imagePath)&&const DeepCollectionEquality().equals(other._qualificationFiles, _qualificationFiles)&&(identical(other.specialtyOpen, specialtyOpen) || other.specialtyOpen == specialtyOpen)&&const DeepCollectionEquality().equals(other._activeDays, _activeDays)&&const DeepCollectionEquality().equals(other._hours, _hours)&&(identical(other.isLoadingSpecializations, isLoadingSpecializations) || other.isLoadingSpecializations == isLoadingSpecializations)&&(identical(other.isSaving, isSaving) || other.isSaving == isSaving)&&(identical(other.saved, saved) || other.saved == saved)&&(identical(other.failure, failure) || other.failure == failure));
}


@override
int get hashCode => Object.hash(runtimeType,initialDoctor,savedDoctor,const DeepCollectionEquality().hash(_specializations),selectedSpecializationId,gender,imagePath,const DeepCollectionEquality().hash(_qualificationFiles),specialtyOpen,const DeepCollectionEquality().hash(_activeDays),const DeepCollectionEquality().hash(_hours),isLoadingSpecializations,isSaving,saved,failure);

@override
String toString() {
  return 'AddDoctorState(initialDoctor: $initialDoctor, savedDoctor: $savedDoctor, specializations: $specializations, selectedSpecializationId: $selectedSpecializationId, gender: $gender, imagePath: $imagePath, qualificationFiles: $qualificationFiles, specialtyOpen: $specialtyOpen, activeDays: $activeDays, hours: $hours, isLoadingSpecializations: $isLoadingSpecializations, isSaving: $isSaving, saved: $saved, failure: $failure)';
}


}

/// @nodoc
abstract mixin class _$AddDoctorStateCopyWith<$Res> implements $AddDoctorStateCopyWith<$Res> {
  factory _$AddDoctorStateCopyWith(_AddDoctorState value, $Res Function(_AddDoctorState) _then) = __$AddDoctorStateCopyWithImpl;
@override @useResult
$Res call({
 ClinicDoctorModel? initialDoctor, ClinicDoctorModel? savedDoctor, List<ClinicSpecializationModel> specializations, String? selectedSpecializationId, String gender, String? imagePath, List<DoctorPickedQualification> qualificationFiles, bool specialtyOpen, Set<Weekday> activeDays, Map<Weekday, WorkingHours> hours, bool isLoadingSpecializations, bool isSaving, bool saved, NetworkExceptions? failure
});


@override $ClinicDoctorModelCopyWith<$Res>? get initialDoctor;@override $ClinicDoctorModelCopyWith<$Res>? get savedDoctor;@override $NetworkExceptionsCopyWith<$Res>? get failure;

}
/// @nodoc
class __$AddDoctorStateCopyWithImpl<$Res>
    implements _$AddDoctorStateCopyWith<$Res> {
  __$AddDoctorStateCopyWithImpl(this._self, this._then);

  final _AddDoctorState _self;
  final $Res Function(_AddDoctorState) _then;

/// Create a copy of AddDoctorState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? initialDoctor = freezed,Object? savedDoctor = freezed,Object? specializations = null,Object? selectedSpecializationId = freezed,Object? gender = null,Object? imagePath = freezed,Object? qualificationFiles = null,Object? specialtyOpen = null,Object? activeDays = null,Object? hours = null,Object? isLoadingSpecializations = null,Object? isSaving = null,Object? saved = null,Object? failure = freezed,}) {
  return _then(_AddDoctorState(
initialDoctor: freezed == initialDoctor ? _self.initialDoctor : initialDoctor // ignore: cast_nullable_to_non_nullable
as ClinicDoctorModel?,savedDoctor: freezed == savedDoctor ? _self.savedDoctor : savedDoctor // ignore: cast_nullable_to_non_nullable
as ClinicDoctorModel?,specializations: null == specializations ? _self._specializations : specializations // ignore: cast_nullable_to_non_nullable
as List<ClinicSpecializationModel>,selectedSpecializationId: freezed == selectedSpecializationId ? _self.selectedSpecializationId : selectedSpecializationId // ignore: cast_nullable_to_non_nullable
as String?,gender: null == gender ? _self.gender : gender // ignore: cast_nullable_to_non_nullable
as String,imagePath: freezed == imagePath ? _self.imagePath : imagePath // ignore: cast_nullable_to_non_nullable
as String?,qualificationFiles: null == qualificationFiles ? _self._qualificationFiles : qualificationFiles // ignore: cast_nullable_to_non_nullable
as List<DoctorPickedQualification>,specialtyOpen: null == specialtyOpen ? _self.specialtyOpen : specialtyOpen // ignore: cast_nullable_to_non_nullable
as bool,activeDays: null == activeDays ? _self._activeDays : activeDays // ignore: cast_nullable_to_non_nullable
as Set<Weekday>,hours: null == hours ? _self._hours : hours // ignore: cast_nullable_to_non_nullable
as Map<Weekday, WorkingHours>,isLoadingSpecializations: null == isLoadingSpecializations ? _self.isLoadingSpecializations : isLoadingSpecializations // ignore: cast_nullable_to_non_nullable
as bool,isSaving: null == isSaving ? _self.isSaving : isSaving // ignore: cast_nullable_to_non_nullable
as bool,saved: null == saved ? _self.saved : saved // ignore: cast_nullable_to_non_nullable
as bool,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as NetworkExceptions?,
  ));
}

/// Create a copy of AddDoctorState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ClinicDoctorModelCopyWith<$Res>? get initialDoctor {
    if (_self.initialDoctor == null) {
    return null;
  }

  return $ClinicDoctorModelCopyWith<$Res>(_self.initialDoctor!, (value) {
    return _then(_self.copyWith(initialDoctor: value));
  });
}/// Create a copy of AddDoctorState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ClinicDoctorModelCopyWith<$Res>? get savedDoctor {
    if (_self.savedDoctor == null) {
    return null;
  }

  return $ClinicDoctorModelCopyWith<$Res>(_self.savedDoctor!, (value) {
    return _then(_self.copyWith(savedDoctor: value));
  });
}/// Create a copy of AddDoctorState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$NetworkExceptionsCopyWith<$Res>? get failure {
    if (_self.failure == null) {
    return null;
  }

  return $NetworkExceptionsCopyWith<$Res>(_self.failure!, (value) {
    return _then(_self.copyWith(failure: value));
  });
}
}

// dart format on
