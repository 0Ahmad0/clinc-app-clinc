// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'services_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ServicesState {

 ServiceKind get kind; ClinicLabSectionModel? get detail; List<ClinicLabSectionModel> get labSections; Set<int> get selectedLabSectionIds; NetworkExceptions? get failure; bool get isLoading; bool get isLabSectionsLoading; bool get isSpecializationFiltersLoading; bool get isMutating; String get labSearch; String get specializationSearch; Map<int, String> get labTestPriceDrafts; Map<int, int> get labSectionEnabledCounts; Set<int> get busyLabTestIds; Set<int> get busySpecializationIds; int get version; PaginationState<ClinicAvailableLabTestModel> get availableLabTests; PaginationState<ClinicEnabledLabTestModel> get enabledLabTests; PaginationState<ClinicAvailableSpecializationModel> get availableSpecializations; PaginationState<ClinicEnabledSpecializationModel> get enabledSpecializations;
/// Create a copy of ServicesState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ServicesStateCopyWith<ServicesState> get copyWith => _$ServicesStateCopyWithImpl<ServicesState>(this as ServicesState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ServicesState&&(identical(other.kind, kind) || other.kind == kind)&&(identical(other.detail, detail) || other.detail == detail)&&const DeepCollectionEquality().equals(other.labSections, labSections)&&const DeepCollectionEquality().equals(other.selectedLabSectionIds, selectedLabSectionIds)&&(identical(other.failure, failure) || other.failure == failure)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isLabSectionsLoading, isLabSectionsLoading) || other.isLabSectionsLoading == isLabSectionsLoading)&&(identical(other.isSpecializationFiltersLoading, isSpecializationFiltersLoading) || other.isSpecializationFiltersLoading == isSpecializationFiltersLoading)&&(identical(other.isMutating, isMutating) || other.isMutating == isMutating)&&(identical(other.labSearch, labSearch) || other.labSearch == labSearch)&&(identical(other.specializationSearch, specializationSearch) || other.specializationSearch == specializationSearch)&&const DeepCollectionEquality().equals(other.labTestPriceDrafts, labTestPriceDrafts)&&const DeepCollectionEquality().equals(other.labSectionEnabledCounts, labSectionEnabledCounts)&&const DeepCollectionEquality().equals(other.busyLabTestIds, busyLabTestIds)&&const DeepCollectionEquality().equals(other.busySpecializationIds, busySpecializationIds)&&(identical(other.version, version) || other.version == version)&&(identical(other.availableLabTests, availableLabTests) || other.availableLabTests == availableLabTests)&&(identical(other.enabledLabTests, enabledLabTests) || other.enabledLabTests == enabledLabTests)&&(identical(other.availableSpecializations, availableSpecializations) || other.availableSpecializations == availableSpecializations)&&(identical(other.enabledSpecializations, enabledSpecializations) || other.enabledSpecializations == enabledSpecializations));
}


@override
int get hashCode => Object.hashAll([runtimeType,kind,detail,const DeepCollectionEquality().hash(labSections),const DeepCollectionEquality().hash(selectedLabSectionIds),failure,isLoading,isLabSectionsLoading,isSpecializationFiltersLoading,isMutating,labSearch,specializationSearch,const DeepCollectionEquality().hash(labTestPriceDrafts),const DeepCollectionEquality().hash(labSectionEnabledCounts),const DeepCollectionEquality().hash(busyLabTestIds),const DeepCollectionEquality().hash(busySpecializationIds),version,availableLabTests,enabledLabTests,availableSpecializations,enabledSpecializations]);

@override
String toString() {
  return 'ServicesState(kind: $kind, detail: $detail, labSections: $labSections, selectedLabSectionIds: $selectedLabSectionIds, failure: $failure, isLoading: $isLoading, isLabSectionsLoading: $isLabSectionsLoading, isSpecializationFiltersLoading: $isSpecializationFiltersLoading, isMutating: $isMutating, labSearch: $labSearch, specializationSearch: $specializationSearch, labTestPriceDrafts: $labTestPriceDrafts, labSectionEnabledCounts: $labSectionEnabledCounts, busyLabTestIds: $busyLabTestIds, busySpecializationIds: $busySpecializationIds, version: $version, availableLabTests: $availableLabTests, enabledLabTests: $enabledLabTests, availableSpecializations: $availableSpecializations, enabledSpecializations: $enabledSpecializations)';
}


}

/// @nodoc
abstract mixin class $ServicesStateCopyWith<$Res>  {
  factory $ServicesStateCopyWith(ServicesState value, $Res Function(ServicesState) _then) = _$ServicesStateCopyWithImpl;
@useResult
$Res call({
 ServiceKind kind, ClinicLabSectionModel? detail, List<ClinicLabSectionModel> labSections, Set<int> selectedLabSectionIds, NetworkExceptions? failure, bool isLoading, bool isLabSectionsLoading, bool isSpecializationFiltersLoading, bool isMutating, String labSearch, String specializationSearch, Map<int, String> labTestPriceDrafts, Map<int, int> labSectionEnabledCounts, Set<int> busyLabTestIds, Set<int> busySpecializationIds, int version, PaginationState<ClinicAvailableLabTestModel> availableLabTests, PaginationState<ClinicEnabledLabTestModel> enabledLabTests, PaginationState<ClinicAvailableSpecializationModel> availableSpecializations, PaginationState<ClinicEnabledSpecializationModel> enabledSpecializations
});


$ClinicLabSectionModelCopyWith<$Res>? get detail;$NetworkExceptionsCopyWith<$Res>? get failure;

}
/// @nodoc
class _$ServicesStateCopyWithImpl<$Res>
    implements $ServicesStateCopyWith<$Res> {
  _$ServicesStateCopyWithImpl(this._self, this._then);

  final ServicesState _self;
  final $Res Function(ServicesState) _then;

/// Create a copy of ServicesState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? kind = null,Object? detail = freezed,Object? labSections = null,Object? selectedLabSectionIds = null,Object? failure = freezed,Object? isLoading = null,Object? isLabSectionsLoading = null,Object? isSpecializationFiltersLoading = null,Object? isMutating = null,Object? labSearch = null,Object? specializationSearch = null,Object? labTestPriceDrafts = null,Object? labSectionEnabledCounts = null,Object? busyLabTestIds = null,Object? busySpecializationIds = null,Object? version = null,Object? availableLabTests = null,Object? enabledLabTests = null,Object? availableSpecializations = null,Object? enabledSpecializations = null,}) {
  return _then(_self.copyWith(
kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as ServiceKind,detail: freezed == detail ? _self.detail : detail // ignore: cast_nullable_to_non_nullable
as ClinicLabSectionModel?,labSections: null == labSections ? _self.labSections : labSections // ignore: cast_nullable_to_non_nullable
as List<ClinicLabSectionModel>,selectedLabSectionIds: null == selectedLabSectionIds ? _self.selectedLabSectionIds : selectedLabSectionIds // ignore: cast_nullable_to_non_nullable
as Set<int>,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as NetworkExceptions?,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isLabSectionsLoading: null == isLabSectionsLoading ? _self.isLabSectionsLoading : isLabSectionsLoading // ignore: cast_nullable_to_non_nullable
as bool,isSpecializationFiltersLoading: null == isSpecializationFiltersLoading ? _self.isSpecializationFiltersLoading : isSpecializationFiltersLoading // ignore: cast_nullable_to_non_nullable
as bool,isMutating: null == isMutating ? _self.isMutating : isMutating // ignore: cast_nullable_to_non_nullable
as bool,labSearch: null == labSearch ? _self.labSearch : labSearch // ignore: cast_nullable_to_non_nullable
as String,specializationSearch: null == specializationSearch ? _self.specializationSearch : specializationSearch // ignore: cast_nullable_to_non_nullable
as String,labTestPriceDrafts: null == labTestPriceDrafts ? _self.labTestPriceDrafts : labTestPriceDrafts // ignore: cast_nullable_to_non_nullable
as Map<int, String>,labSectionEnabledCounts: null == labSectionEnabledCounts ? _self.labSectionEnabledCounts : labSectionEnabledCounts // ignore: cast_nullable_to_non_nullable
as Map<int, int>,busyLabTestIds: null == busyLabTestIds ? _self.busyLabTestIds : busyLabTestIds // ignore: cast_nullable_to_non_nullable
as Set<int>,busySpecializationIds: null == busySpecializationIds ? _self.busySpecializationIds : busySpecializationIds // ignore: cast_nullable_to_non_nullable
as Set<int>,version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as int,availableLabTests: null == availableLabTests ? _self.availableLabTests : availableLabTests // ignore: cast_nullable_to_non_nullable
as PaginationState<ClinicAvailableLabTestModel>,enabledLabTests: null == enabledLabTests ? _self.enabledLabTests : enabledLabTests // ignore: cast_nullable_to_non_nullable
as PaginationState<ClinicEnabledLabTestModel>,availableSpecializations: null == availableSpecializations ? _self.availableSpecializations : availableSpecializations // ignore: cast_nullable_to_non_nullable
as PaginationState<ClinicAvailableSpecializationModel>,enabledSpecializations: null == enabledSpecializations ? _self.enabledSpecializations : enabledSpecializations // ignore: cast_nullable_to_non_nullable
as PaginationState<ClinicEnabledSpecializationModel>,
  ));
}
/// Create a copy of ServicesState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ClinicLabSectionModelCopyWith<$Res>? get detail {
    if (_self.detail == null) {
    return null;
  }

  return $ClinicLabSectionModelCopyWith<$Res>(_self.detail!, (value) {
    return _then(_self.copyWith(detail: value));
  });
}/// Create a copy of ServicesState
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


/// Adds pattern-matching-related methods to [ServicesState].
extension ServicesStatePatterns on ServicesState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ServicesState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ServicesState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ServicesState value)  $default,){
final _that = this;
switch (_that) {
case _ServicesState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ServicesState value)?  $default,){
final _that = this;
switch (_that) {
case _ServicesState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( ServiceKind kind,  ClinicLabSectionModel? detail,  List<ClinicLabSectionModel> labSections,  Set<int> selectedLabSectionIds,  NetworkExceptions? failure,  bool isLoading,  bool isLabSectionsLoading,  bool isSpecializationFiltersLoading,  bool isMutating,  String labSearch,  String specializationSearch,  Map<int, String> labTestPriceDrafts,  Map<int, int> labSectionEnabledCounts,  Set<int> busyLabTestIds,  Set<int> busySpecializationIds,  int version,  PaginationState<ClinicAvailableLabTestModel> availableLabTests,  PaginationState<ClinicEnabledLabTestModel> enabledLabTests,  PaginationState<ClinicAvailableSpecializationModel> availableSpecializations,  PaginationState<ClinicEnabledSpecializationModel> enabledSpecializations)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ServicesState() when $default != null:
return $default(_that.kind,_that.detail,_that.labSections,_that.selectedLabSectionIds,_that.failure,_that.isLoading,_that.isLabSectionsLoading,_that.isSpecializationFiltersLoading,_that.isMutating,_that.labSearch,_that.specializationSearch,_that.labTestPriceDrafts,_that.labSectionEnabledCounts,_that.busyLabTestIds,_that.busySpecializationIds,_that.version,_that.availableLabTests,_that.enabledLabTests,_that.availableSpecializations,_that.enabledSpecializations);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( ServiceKind kind,  ClinicLabSectionModel? detail,  List<ClinicLabSectionModel> labSections,  Set<int> selectedLabSectionIds,  NetworkExceptions? failure,  bool isLoading,  bool isLabSectionsLoading,  bool isSpecializationFiltersLoading,  bool isMutating,  String labSearch,  String specializationSearch,  Map<int, String> labTestPriceDrafts,  Map<int, int> labSectionEnabledCounts,  Set<int> busyLabTestIds,  Set<int> busySpecializationIds,  int version,  PaginationState<ClinicAvailableLabTestModel> availableLabTests,  PaginationState<ClinicEnabledLabTestModel> enabledLabTests,  PaginationState<ClinicAvailableSpecializationModel> availableSpecializations,  PaginationState<ClinicEnabledSpecializationModel> enabledSpecializations)  $default,) {final _that = this;
switch (_that) {
case _ServicesState():
return $default(_that.kind,_that.detail,_that.labSections,_that.selectedLabSectionIds,_that.failure,_that.isLoading,_that.isLabSectionsLoading,_that.isSpecializationFiltersLoading,_that.isMutating,_that.labSearch,_that.specializationSearch,_that.labTestPriceDrafts,_that.labSectionEnabledCounts,_that.busyLabTestIds,_that.busySpecializationIds,_that.version,_that.availableLabTests,_that.enabledLabTests,_that.availableSpecializations,_that.enabledSpecializations);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( ServiceKind kind,  ClinicLabSectionModel? detail,  List<ClinicLabSectionModel> labSections,  Set<int> selectedLabSectionIds,  NetworkExceptions? failure,  bool isLoading,  bool isLabSectionsLoading,  bool isSpecializationFiltersLoading,  bool isMutating,  String labSearch,  String specializationSearch,  Map<int, String> labTestPriceDrafts,  Map<int, int> labSectionEnabledCounts,  Set<int> busyLabTestIds,  Set<int> busySpecializationIds,  int version,  PaginationState<ClinicAvailableLabTestModel> availableLabTests,  PaginationState<ClinicEnabledLabTestModel> enabledLabTests,  PaginationState<ClinicAvailableSpecializationModel> availableSpecializations,  PaginationState<ClinicEnabledSpecializationModel> enabledSpecializations)?  $default,) {final _that = this;
switch (_that) {
case _ServicesState() when $default != null:
return $default(_that.kind,_that.detail,_that.labSections,_that.selectedLabSectionIds,_that.failure,_that.isLoading,_that.isLabSectionsLoading,_that.isSpecializationFiltersLoading,_that.isMutating,_that.labSearch,_that.specializationSearch,_that.labTestPriceDrafts,_that.labSectionEnabledCounts,_that.busyLabTestIds,_that.busySpecializationIds,_that.version,_that.availableLabTests,_that.enabledLabTests,_that.availableSpecializations,_that.enabledSpecializations);case _:
  return null;

}
}

}

/// @nodoc


class _ServicesState extends ServicesState {
  const _ServicesState({required this.kind, this.detail, final  List<ClinicLabSectionModel> labSections = const [], final  Set<int> selectedLabSectionIds = const {}, this.failure, this.isLoading = false, this.isLabSectionsLoading = false, this.isSpecializationFiltersLoading = false, this.isMutating = false, this.labSearch = '', this.specializationSearch = '', final  Map<int, String> labTestPriceDrafts = const {}, final  Map<int, int> labSectionEnabledCounts = const {}, final  Set<int> busyLabTestIds = const {}, final  Set<int> busySpecializationIds = const {}, this.version = 0, required this.availableLabTests, required this.enabledLabTests, required this.availableSpecializations, required this.enabledSpecializations}): _labSections = labSections,_selectedLabSectionIds = selectedLabSectionIds,_labTestPriceDrafts = labTestPriceDrafts,_labSectionEnabledCounts = labSectionEnabledCounts,_busyLabTestIds = busyLabTestIds,_busySpecializationIds = busySpecializationIds,super._();
  

@override final  ServiceKind kind;
@override final  ClinicLabSectionModel? detail;
 final  List<ClinicLabSectionModel> _labSections;
@override@JsonKey() List<ClinicLabSectionModel> get labSections {
  if (_labSections is EqualUnmodifiableListView) return _labSections;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_labSections);
}

 final  Set<int> _selectedLabSectionIds;
@override@JsonKey() Set<int> get selectedLabSectionIds {
  if (_selectedLabSectionIds is EqualUnmodifiableSetView) return _selectedLabSectionIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableSetView(_selectedLabSectionIds);
}

@override final  NetworkExceptions? failure;
@override@JsonKey() final  bool isLoading;
@override@JsonKey() final  bool isLabSectionsLoading;
@override@JsonKey() final  bool isSpecializationFiltersLoading;
@override@JsonKey() final  bool isMutating;
@override@JsonKey() final  String labSearch;
@override@JsonKey() final  String specializationSearch;
 final  Map<int, String> _labTestPriceDrafts;
@override@JsonKey() Map<int, String> get labTestPriceDrafts {
  if (_labTestPriceDrafts is EqualUnmodifiableMapView) return _labTestPriceDrafts;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_labTestPriceDrafts);
}

 final  Map<int, int> _labSectionEnabledCounts;
@override@JsonKey() Map<int, int> get labSectionEnabledCounts {
  if (_labSectionEnabledCounts is EqualUnmodifiableMapView) return _labSectionEnabledCounts;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_labSectionEnabledCounts);
}

 final  Set<int> _busyLabTestIds;
@override@JsonKey() Set<int> get busyLabTestIds {
  if (_busyLabTestIds is EqualUnmodifiableSetView) return _busyLabTestIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableSetView(_busyLabTestIds);
}

 final  Set<int> _busySpecializationIds;
@override@JsonKey() Set<int> get busySpecializationIds {
  if (_busySpecializationIds is EqualUnmodifiableSetView) return _busySpecializationIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableSetView(_busySpecializationIds);
}

@override@JsonKey() final  int version;
@override final  PaginationState<ClinicAvailableLabTestModel> availableLabTests;
@override final  PaginationState<ClinicEnabledLabTestModel> enabledLabTests;
@override final  PaginationState<ClinicAvailableSpecializationModel> availableSpecializations;
@override final  PaginationState<ClinicEnabledSpecializationModel> enabledSpecializations;

/// Create a copy of ServicesState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ServicesStateCopyWith<_ServicesState> get copyWith => __$ServicesStateCopyWithImpl<_ServicesState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ServicesState&&(identical(other.kind, kind) || other.kind == kind)&&(identical(other.detail, detail) || other.detail == detail)&&const DeepCollectionEquality().equals(other._labSections, _labSections)&&const DeepCollectionEquality().equals(other._selectedLabSectionIds, _selectedLabSectionIds)&&(identical(other.failure, failure) || other.failure == failure)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isLabSectionsLoading, isLabSectionsLoading) || other.isLabSectionsLoading == isLabSectionsLoading)&&(identical(other.isSpecializationFiltersLoading, isSpecializationFiltersLoading) || other.isSpecializationFiltersLoading == isSpecializationFiltersLoading)&&(identical(other.isMutating, isMutating) || other.isMutating == isMutating)&&(identical(other.labSearch, labSearch) || other.labSearch == labSearch)&&(identical(other.specializationSearch, specializationSearch) || other.specializationSearch == specializationSearch)&&const DeepCollectionEquality().equals(other._labTestPriceDrafts, _labTestPriceDrafts)&&const DeepCollectionEquality().equals(other._labSectionEnabledCounts, _labSectionEnabledCounts)&&const DeepCollectionEquality().equals(other._busyLabTestIds, _busyLabTestIds)&&const DeepCollectionEquality().equals(other._busySpecializationIds, _busySpecializationIds)&&(identical(other.version, version) || other.version == version)&&(identical(other.availableLabTests, availableLabTests) || other.availableLabTests == availableLabTests)&&(identical(other.enabledLabTests, enabledLabTests) || other.enabledLabTests == enabledLabTests)&&(identical(other.availableSpecializations, availableSpecializations) || other.availableSpecializations == availableSpecializations)&&(identical(other.enabledSpecializations, enabledSpecializations) || other.enabledSpecializations == enabledSpecializations));
}


@override
int get hashCode => Object.hashAll([runtimeType,kind,detail,const DeepCollectionEquality().hash(_labSections),const DeepCollectionEquality().hash(_selectedLabSectionIds),failure,isLoading,isLabSectionsLoading,isSpecializationFiltersLoading,isMutating,labSearch,specializationSearch,const DeepCollectionEquality().hash(_labTestPriceDrafts),const DeepCollectionEquality().hash(_labSectionEnabledCounts),const DeepCollectionEquality().hash(_busyLabTestIds),const DeepCollectionEquality().hash(_busySpecializationIds),version,availableLabTests,enabledLabTests,availableSpecializations,enabledSpecializations]);

@override
String toString() {
  return 'ServicesState(kind: $kind, detail: $detail, labSections: $labSections, selectedLabSectionIds: $selectedLabSectionIds, failure: $failure, isLoading: $isLoading, isLabSectionsLoading: $isLabSectionsLoading, isSpecializationFiltersLoading: $isSpecializationFiltersLoading, isMutating: $isMutating, labSearch: $labSearch, specializationSearch: $specializationSearch, labTestPriceDrafts: $labTestPriceDrafts, labSectionEnabledCounts: $labSectionEnabledCounts, busyLabTestIds: $busyLabTestIds, busySpecializationIds: $busySpecializationIds, version: $version, availableLabTests: $availableLabTests, enabledLabTests: $enabledLabTests, availableSpecializations: $availableSpecializations, enabledSpecializations: $enabledSpecializations)';
}


}

/// @nodoc
abstract mixin class _$ServicesStateCopyWith<$Res> implements $ServicesStateCopyWith<$Res> {
  factory _$ServicesStateCopyWith(_ServicesState value, $Res Function(_ServicesState) _then) = __$ServicesStateCopyWithImpl;
@override @useResult
$Res call({
 ServiceKind kind, ClinicLabSectionModel? detail, List<ClinicLabSectionModel> labSections, Set<int> selectedLabSectionIds, NetworkExceptions? failure, bool isLoading, bool isLabSectionsLoading, bool isSpecializationFiltersLoading, bool isMutating, String labSearch, String specializationSearch, Map<int, String> labTestPriceDrafts, Map<int, int> labSectionEnabledCounts, Set<int> busyLabTestIds, Set<int> busySpecializationIds, int version, PaginationState<ClinicAvailableLabTestModel> availableLabTests, PaginationState<ClinicEnabledLabTestModel> enabledLabTests, PaginationState<ClinicAvailableSpecializationModel> availableSpecializations, PaginationState<ClinicEnabledSpecializationModel> enabledSpecializations
});


@override $ClinicLabSectionModelCopyWith<$Res>? get detail;@override $NetworkExceptionsCopyWith<$Res>? get failure;

}
/// @nodoc
class __$ServicesStateCopyWithImpl<$Res>
    implements _$ServicesStateCopyWith<$Res> {
  __$ServicesStateCopyWithImpl(this._self, this._then);

  final _ServicesState _self;
  final $Res Function(_ServicesState) _then;

/// Create a copy of ServicesState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? kind = null,Object? detail = freezed,Object? labSections = null,Object? selectedLabSectionIds = null,Object? failure = freezed,Object? isLoading = null,Object? isLabSectionsLoading = null,Object? isSpecializationFiltersLoading = null,Object? isMutating = null,Object? labSearch = null,Object? specializationSearch = null,Object? labTestPriceDrafts = null,Object? labSectionEnabledCounts = null,Object? busyLabTestIds = null,Object? busySpecializationIds = null,Object? version = null,Object? availableLabTests = null,Object? enabledLabTests = null,Object? availableSpecializations = null,Object? enabledSpecializations = null,}) {
  return _then(_ServicesState(
kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as ServiceKind,detail: freezed == detail ? _self.detail : detail // ignore: cast_nullable_to_non_nullable
as ClinicLabSectionModel?,labSections: null == labSections ? _self._labSections : labSections // ignore: cast_nullable_to_non_nullable
as List<ClinicLabSectionModel>,selectedLabSectionIds: null == selectedLabSectionIds ? _self._selectedLabSectionIds : selectedLabSectionIds // ignore: cast_nullable_to_non_nullable
as Set<int>,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as NetworkExceptions?,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isLabSectionsLoading: null == isLabSectionsLoading ? _self.isLabSectionsLoading : isLabSectionsLoading // ignore: cast_nullable_to_non_nullable
as bool,isSpecializationFiltersLoading: null == isSpecializationFiltersLoading ? _self.isSpecializationFiltersLoading : isSpecializationFiltersLoading // ignore: cast_nullable_to_non_nullable
as bool,isMutating: null == isMutating ? _self.isMutating : isMutating // ignore: cast_nullable_to_non_nullable
as bool,labSearch: null == labSearch ? _self.labSearch : labSearch // ignore: cast_nullable_to_non_nullable
as String,specializationSearch: null == specializationSearch ? _self.specializationSearch : specializationSearch // ignore: cast_nullable_to_non_nullable
as String,labTestPriceDrafts: null == labTestPriceDrafts ? _self._labTestPriceDrafts : labTestPriceDrafts // ignore: cast_nullable_to_non_nullable
as Map<int, String>,labSectionEnabledCounts: null == labSectionEnabledCounts ? _self._labSectionEnabledCounts : labSectionEnabledCounts // ignore: cast_nullable_to_non_nullable
as Map<int, int>,busyLabTestIds: null == busyLabTestIds ? _self._busyLabTestIds : busyLabTestIds // ignore: cast_nullable_to_non_nullable
as Set<int>,busySpecializationIds: null == busySpecializationIds ? _self._busySpecializationIds : busySpecializationIds // ignore: cast_nullable_to_non_nullable
as Set<int>,version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as int,availableLabTests: null == availableLabTests ? _self.availableLabTests : availableLabTests // ignore: cast_nullable_to_non_nullable
as PaginationState<ClinicAvailableLabTestModel>,enabledLabTests: null == enabledLabTests ? _self.enabledLabTests : enabledLabTests // ignore: cast_nullable_to_non_nullable
as PaginationState<ClinicEnabledLabTestModel>,availableSpecializations: null == availableSpecializations ? _self.availableSpecializations : availableSpecializations // ignore: cast_nullable_to_non_nullable
as PaginationState<ClinicAvailableSpecializationModel>,enabledSpecializations: null == enabledSpecializations ? _self.enabledSpecializations : enabledSpecializations // ignore: cast_nullable_to_non_nullable
as PaginationState<ClinicEnabledSpecializationModel>,
  ));
}

/// Create a copy of ServicesState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ClinicLabSectionModelCopyWith<$Res>? get detail {
    if (_self.detail == null) {
    return null;
  }

  return $ClinicLabSectionModelCopyWith<$Res>(_self.detail!, (value) {
    return _then(_self.copyWith(detail: value));
  });
}/// Create a copy of ServicesState
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
