// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'doctors_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$DoctorsState {

 PaginationState<ClinicDoctorModel> get pagination; List<ClinicSpecializationModel> get specializations; String? get selectedSpecializationId; String get query; NetworkExceptions? get failure;
/// Create a copy of DoctorsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DoctorsStateCopyWith<DoctorsState> get copyWith => _$DoctorsStateCopyWithImpl<DoctorsState>(this as DoctorsState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DoctorsState&&(identical(other.pagination, pagination) || other.pagination == pagination)&&const DeepCollectionEquality().equals(other.specializations, specializations)&&(identical(other.selectedSpecializationId, selectedSpecializationId) || other.selectedSpecializationId == selectedSpecializationId)&&(identical(other.query, query) || other.query == query)&&(identical(other.failure, failure) || other.failure == failure));
}


@override
int get hashCode => Object.hash(runtimeType,pagination,const DeepCollectionEquality().hash(specializations),selectedSpecializationId,query,failure);

@override
String toString() {
  return 'DoctorsState(pagination: $pagination, specializations: $specializations, selectedSpecializationId: $selectedSpecializationId, query: $query, failure: $failure)';
}


}

/// @nodoc
abstract mixin class $DoctorsStateCopyWith<$Res>  {
  factory $DoctorsStateCopyWith(DoctorsState value, $Res Function(DoctorsState) _then) = _$DoctorsStateCopyWithImpl;
@useResult
$Res call({
 PaginationState<ClinicDoctorModel> pagination, List<ClinicSpecializationModel> specializations, String? selectedSpecializationId, String query, NetworkExceptions? failure
});


$NetworkExceptionsCopyWith<$Res>? get failure;

}
/// @nodoc
class _$DoctorsStateCopyWithImpl<$Res>
    implements $DoctorsStateCopyWith<$Res> {
  _$DoctorsStateCopyWithImpl(this._self, this._then);

  final DoctorsState _self;
  final $Res Function(DoctorsState) _then;

/// Create a copy of DoctorsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? pagination = null,Object? specializations = null,Object? selectedSpecializationId = freezed,Object? query = null,Object? failure = freezed,}) {
  return _then(_self.copyWith(
pagination: null == pagination ? _self.pagination : pagination // ignore: cast_nullable_to_non_nullable
as PaginationState<ClinicDoctorModel>,specializations: null == specializations ? _self.specializations : specializations // ignore: cast_nullable_to_non_nullable
as List<ClinicSpecializationModel>,selectedSpecializationId: freezed == selectedSpecializationId ? _self.selectedSpecializationId : selectedSpecializationId // ignore: cast_nullable_to_non_nullable
as String?,query: null == query ? _self.query : query // ignore: cast_nullable_to_non_nullable
as String,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as NetworkExceptions?,
  ));
}
/// Create a copy of DoctorsState
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


/// Adds pattern-matching-related methods to [DoctorsState].
extension DoctorsStatePatterns on DoctorsState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DoctorsState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DoctorsState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DoctorsState value)  $default,){
final _that = this;
switch (_that) {
case _DoctorsState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DoctorsState value)?  $default,){
final _that = this;
switch (_that) {
case _DoctorsState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( PaginationState<ClinicDoctorModel> pagination,  List<ClinicSpecializationModel> specializations,  String? selectedSpecializationId,  String query,  NetworkExceptions? failure)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DoctorsState() when $default != null:
return $default(_that.pagination,_that.specializations,_that.selectedSpecializationId,_that.query,_that.failure);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( PaginationState<ClinicDoctorModel> pagination,  List<ClinicSpecializationModel> specializations,  String? selectedSpecializationId,  String query,  NetworkExceptions? failure)  $default,) {final _that = this;
switch (_that) {
case _DoctorsState():
return $default(_that.pagination,_that.specializations,_that.selectedSpecializationId,_that.query,_that.failure);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( PaginationState<ClinicDoctorModel> pagination,  List<ClinicSpecializationModel> specializations,  String? selectedSpecializationId,  String query,  NetworkExceptions? failure)?  $default,) {final _that = this;
switch (_that) {
case _DoctorsState() when $default != null:
return $default(_that.pagination,_that.specializations,_that.selectedSpecializationId,_that.query,_that.failure);case _:
  return null;

}
}

}

/// @nodoc


class _DoctorsState implements DoctorsState {
  const _DoctorsState({required this.pagination, final  List<ClinicSpecializationModel> specializations = const <ClinicSpecializationModel>[], this.selectedSpecializationId, this.query = '', this.failure}): _specializations = specializations;
  

@override final  PaginationState<ClinicDoctorModel> pagination;
 final  List<ClinicSpecializationModel> _specializations;
@override@JsonKey() List<ClinicSpecializationModel> get specializations {
  if (_specializations is EqualUnmodifiableListView) return _specializations;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_specializations);
}

@override final  String? selectedSpecializationId;
@override@JsonKey() final  String query;
@override final  NetworkExceptions? failure;

/// Create a copy of DoctorsState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DoctorsStateCopyWith<_DoctorsState> get copyWith => __$DoctorsStateCopyWithImpl<_DoctorsState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DoctorsState&&(identical(other.pagination, pagination) || other.pagination == pagination)&&const DeepCollectionEquality().equals(other._specializations, _specializations)&&(identical(other.selectedSpecializationId, selectedSpecializationId) || other.selectedSpecializationId == selectedSpecializationId)&&(identical(other.query, query) || other.query == query)&&(identical(other.failure, failure) || other.failure == failure));
}


@override
int get hashCode => Object.hash(runtimeType,pagination,const DeepCollectionEquality().hash(_specializations),selectedSpecializationId,query,failure);

@override
String toString() {
  return 'DoctorsState(pagination: $pagination, specializations: $specializations, selectedSpecializationId: $selectedSpecializationId, query: $query, failure: $failure)';
}


}

/// @nodoc
abstract mixin class _$DoctorsStateCopyWith<$Res> implements $DoctorsStateCopyWith<$Res> {
  factory _$DoctorsStateCopyWith(_DoctorsState value, $Res Function(_DoctorsState) _then) = __$DoctorsStateCopyWithImpl;
@override @useResult
$Res call({
 PaginationState<ClinicDoctorModel> pagination, List<ClinicSpecializationModel> specializations, String? selectedSpecializationId, String query, NetworkExceptions? failure
});


@override $NetworkExceptionsCopyWith<$Res>? get failure;

}
/// @nodoc
class __$DoctorsStateCopyWithImpl<$Res>
    implements _$DoctorsStateCopyWith<$Res> {
  __$DoctorsStateCopyWithImpl(this._self, this._then);

  final _DoctorsState _self;
  final $Res Function(_DoctorsState) _then;

/// Create a copy of DoctorsState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? pagination = null,Object? specializations = null,Object? selectedSpecializationId = freezed,Object? query = null,Object? failure = freezed,}) {
  return _then(_DoctorsState(
pagination: null == pagination ? _self.pagination : pagination // ignore: cast_nullable_to_non_nullable
as PaginationState<ClinicDoctorModel>,specializations: null == specializations ? _self._specializations : specializations // ignore: cast_nullable_to_non_nullable
as List<ClinicSpecializationModel>,selectedSpecializationId: freezed == selectedSpecializationId ? _self.selectedSpecializationId : selectedSpecializationId // ignore: cast_nullable_to_non_nullable
as String?,query: null == query ? _self.query : query // ignore: cast_nullable_to_non_nullable
as String,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as NetworkExceptions?,
  ));
}

/// Create a copy of DoctorsState
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
