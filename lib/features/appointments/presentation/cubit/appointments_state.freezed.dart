// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'appointments_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AppointmentsState {

 PaginationState<ClinicAppointmentModel> get pagination; AppointmentTab get tab; String? get selectedId; ClinicAppointmentModel? get selected; NetworkExceptions? get failure;
/// Create a copy of AppointmentsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AppointmentsStateCopyWith<AppointmentsState> get copyWith => _$AppointmentsStateCopyWithImpl<AppointmentsState>(this as AppointmentsState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AppointmentsState&&(identical(other.pagination, pagination) || other.pagination == pagination)&&(identical(other.tab, tab) || other.tab == tab)&&(identical(other.selectedId, selectedId) || other.selectedId == selectedId)&&(identical(other.selected, selected) || other.selected == selected)&&(identical(other.failure, failure) || other.failure == failure));
}


@override
int get hashCode => Object.hash(runtimeType,pagination,tab,selectedId,selected,failure);

@override
String toString() {
  return 'AppointmentsState(pagination: $pagination, tab: $tab, selectedId: $selectedId, selected: $selected, failure: $failure)';
}


}

/// @nodoc
abstract mixin class $AppointmentsStateCopyWith<$Res>  {
  factory $AppointmentsStateCopyWith(AppointmentsState value, $Res Function(AppointmentsState) _then) = _$AppointmentsStateCopyWithImpl;
@useResult
$Res call({
 PaginationState<ClinicAppointmentModel> pagination, AppointmentTab tab, String? selectedId, ClinicAppointmentModel? selected, NetworkExceptions? failure
});


$ClinicAppointmentModelCopyWith<$Res>? get selected;$NetworkExceptionsCopyWith<$Res>? get failure;

}
/// @nodoc
class _$AppointmentsStateCopyWithImpl<$Res>
    implements $AppointmentsStateCopyWith<$Res> {
  _$AppointmentsStateCopyWithImpl(this._self, this._then);

  final AppointmentsState _self;
  final $Res Function(AppointmentsState) _then;

/// Create a copy of AppointmentsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? pagination = null,Object? tab = null,Object? selectedId = freezed,Object? selected = freezed,Object? failure = freezed,}) {
  return _then(_self.copyWith(
pagination: null == pagination ? _self.pagination : pagination // ignore: cast_nullable_to_non_nullable
as PaginationState<ClinicAppointmentModel>,tab: null == tab ? _self.tab : tab // ignore: cast_nullable_to_non_nullable
as AppointmentTab,selectedId: freezed == selectedId ? _self.selectedId : selectedId // ignore: cast_nullable_to_non_nullable
as String?,selected: freezed == selected ? _self.selected : selected // ignore: cast_nullable_to_non_nullable
as ClinicAppointmentModel?,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as NetworkExceptions?,
  ));
}
/// Create a copy of AppointmentsState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ClinicAppointmentModelCopyWith<$Res>? get selected {
    if (_self.selected == null) {
    return null;
  }

  return $ClinicAppointmentModelCopyWith<$Res>(_self.selected!, (value) {
    return _then(_self.copyWith(selected: value));
  });
}/// Create a copy of AppointmentsState
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


/// Adds pattern-matching-related methods to [AppointmentsState].
extension AppointmentsStatePatterns on AppointmentsState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AppointmentsState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AppointmentsState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AppointmentsState value)  $default,){
final _that = this;
switch (_that) {
case _AppointmentsState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AppointmentsState value)?  $default,){
final _that = this;
switch (_that) {
case _AppointmentsState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( PaginationState<ClinicAppointmentModel> pagination,  AppointmentTab tab,  String? selectedId,  ClinicAppointmentModel? selected,  NetworkExceptions? failure)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AppointmentsState() when $default != null:
return $default(_that.pagination,_that.tab,_that.selectedId,_that.selected,_that.failure);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( PaginationState<ClinicAppointmentModel> pagination,  AppointmentTab tab,  String? selectedId,  ClinicAppointmentModel? selected,  NetworkExceptions? failure)  $default,) {final _that = this;
switch (_that) {
case _AppointmentsState():
return $default(_that.pagination,_that.tab,_that.selectedId,_that.selected,_that.failure);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( PaginationState<ClinicAppointmentModel> pagination,  AppointmentTab tab,  String? selectedId,  ClinicAppointmentModel? selected,  NetworkExceptions? failure)?  $default,) {final _that = this;
switch (_that) {
case _AppointmentsState() when $default != null:
return $default(_that.pagination,_that.tab,_that.selectedId,_that.selected,_that.failure);case _:
  return null;

}
}

}

/// @nodoc


class _AppointmentsState implements AppointmentsState {
  const _AppointmentsState({required this.pagination, this.tab = AppointmentTab.all, this.selectedId, this.selected, this.failure});
  

@override final  PaginationState<ClinicAppointmentModel> pagination;
@override@JsonKey() final  AppointmentTab tab;
@override final  String? selectedId;
@override final  ClinicAppointmentModel? selected;
@override final  NetworkExceptions? failure;

/// Create a copy of AppointmentsState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AppointmentsStateCopyWith<_AppointmentsState> get copyWith => __$AppointmentsStateCopyWithImpl<_AppointmentsState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AppointmentsState&&(identical(other.pagination, pagination) || other.pagination == pagination)&&(identical(other.tab, tab) || other.tab == tab)&&(identical(other.selectedId, selectedId) || other.selectedId == selectedId)&&(identical(other.selected, selected) || other.selected == selected)&&(identical(other.failure, failure) || other.failure == failure));
}


@override
int get hashCode => Object.hash(runtimeType,pagination,tab,selectedId,selected,failure);

@override
String toString() {
  return 'AppointmentsState(pagination: $pagination, tab: $tab, selectedId: $selectedId, selected: $selected, failure: $failure)';
}


}

/// @nodoc
abstract mixin class _$AppointmentsStateCopyWith<$Res> implements $AppointmentsStateCopyWith<$Res> {
  factory _$AppointmentsStateCopyWith(_AppointmentsState value, $Res Function(_AppointmentsState) _then) = __$AppointmentsStateCopyWithImpl;
@override @useResult
$Res call({
 PaginationState<ClinicAppointmentModel> pagination, AppointmentTab tab, String? selectedId, ClinicAppointmentModel? selected, NetworkExceptions? failure
});


@override $ClinicAppointmentModelCopyWith<$Res>? get selected;@override $NetworkExceptionsCopyWith<$Res>? get failure;

}
/// @nodoc
class __$AppointmentsStateCopyWithImpl<$Res>
    implements _$AppointmentsStateCopyWith<$Res> {
  __$AppointmentsStateCopyWithImpl(this._self, this._then);

  final _AppointmentsState _self;
  final $Res Function(_AppointmentsState) _then;

/// Create a copy of AppointmentsState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? pagination = null,Object? tab = null,Object? selectedId = freezed,Object? selected = freezed,Object? failure = freezed,}) {
  return _then(_AppointmentsState(
pagination: null == pagination ? _self.pagination : pagination // ignore: cast_nullable_to_non_nullable
as PaginationState<ClinicAppointmentModel>,tab: null == tab ? _self.tab : tab // ignore: cast_nullable_to_non_nullable
as AppointmentTab,selectedId: freezed == selectedId ? _self.selectedId : selectedId // ignore: cast_nullable_to_non_nullable
as String?,selected: freezed == selected ? _self.selected : selected // ignore: cast_nullable_to_non_nullable
as ClinicAppointmentModel?,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as NetworkExceptions?,
  ));
}

/// Create a copy of AppointmentsState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ClinicAppointmentModelCopyWith<$Res>? get selected {
    if (_self.selected == null) {
    return null;
  }

  return $ClinicAppointmentModelCopyWith<$Res>(_self.selected!, (value) {
    return _then(_self.copyWith(selected: value));
  });
}/// Create a copy of AppointmentsState
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
