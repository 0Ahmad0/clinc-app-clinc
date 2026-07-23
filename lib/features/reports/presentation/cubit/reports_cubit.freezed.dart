// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'reports_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ReportsState {

 ReportPeriod get period; ReportType get type; ClinicReportSummaryModel? get summary; ClinicGeneratedReportModel? get exportedReport; NetworkExceptions? get failure; bool get isSummaryLoading; bool get isExportingPdf; bool get isExportingXlsx; PaginationState<ClinicGeneratedReportModel> get pagination;
/// Create a copy of ReportsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReportsStateCopyWith<ReportsState> get copyWith => _$ReportsStateCopyWithImpl<ReportsState>(this as ReportsState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReportsState&&(identical(other.period, period) || other.period == period)&&(identical(other.type, type) || other.type == type)&&(identical(other.summary, summary) || other.summary == summary)&&(identical(other.exportedReport, exportedReport) || other.exportedReport == exportedReport)&&(identical(other.failure, failure) || other.failure == failure)&&(identical(other.isSummaryLoading, isSummaryLoading) || other.isSummaryLoading == isSummaryLoading)&&(identical(other.isExportingPdf, isExportingPdf) || other.isExportingPdf == isExportingPdf)&&(identical(other.isExportingXlsx, isExportingXlsx) || other.isExportingXlsx == isExportingXlsx)&&(identical(other.pagination, pagination) || other.pagination == pagination));
}


@override
int get hashCode => Object.hash(runtimeType,period,type,summary,exportedReport,failure,isSummaryLoading,isExportingPdf,isExportingXlsx,pagination);

@override
String toString() {
  return 'ReportsState(period: $period, type: $type, summary: $summary, exportedReport: $exportedReport, failure: $failure, isSummaryLoading: $isSummaryLoading, isExportingPdf: $isExportingPdf, isExportingXlsx: $isExportingXlsx, pagination: $pagination)';
}


}

/// @nodoc
abstract mixin class $ReportsStateCopyWith<$Res>  {
  factory $ReportsStateCopyWith(ReportsState value, $Res Function(ReportsState) _then) = _$ReportsStateCopyWithImpl;
@useResult
$Res call({
 ReportPeriod period, ReportType type, ClinicReportSummaryModel? summary, ClinicGeneratedReportModel? exportedReport, NetworkExceptions? failure, bool isSummaryLoading, bool isExportingPdf, bool isExportingXlsx, PaginationState<ClinicGeneratedReportModel> pagination
});


$ClinicReportSummaryModelCopyWith<$Res>? get summary;$ClinicGeneratedReportModelCopyWith<$Res>? get exportedReport;$NetworkExceptionsCopyWith<$Res>? get failure;

}
/// @nodoc
class _$ReportsStateCopyWithImpl<$Res>
    implements $ReportsStateCopyWith<$Res> {
  _$ReportsStateCopyWithImpl(this._self, this._then);

  final ReportsState _self;
  final $Res Function(ReportsState) _then;

/// Create a copy of ReportsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? period = null,Object? type = null,Object? summary = freezed,Object? exportedReport = freezed,Object? failure = freezed,Object? isSummaryLoading = null,Object? isExportingPdf = null,Object? isExportingXlsx = null,Object? pagination = null,}) {
  return _then(_self.copyWith(
period: null == period ? _self.period : period // ignore: cast_nullable_to_non_nullable
as ReportPeriod,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as ReportType,summary: freezed == summary ? _self.summary : summary // ignore: cast_nullable_to_non_nullable
as ClinicReportSummaryModel?,exportedReport: freezed == exportedReport ? _self.exportedReport : exportedReport // ignore: cast_nullable_to_non_nullable
as ClinicGeneratedReportModel?,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as NetworkExceptions?,isSummaryLoading: null == isSummaryLoading ? _self.isSummaryLoading : isSummaryLoading // ignore: cast_nullable_to_non_nullable
as bool,isExportingPdf: null == isExportingPdf ? _self.isExportingPdf : isExportingPdf // ignore: cast_nullable_to_non_nullable
as bool,isExportingXlsx: null == isExportingXlsx ? _self.isExportingXlsx : isExportingXlsx // ignore: cast_nullable_to_non_nullable
as bool,pagination: null == pagination ? _self.pagination : pagination // ignore: cast_nullable_to_non_nullable
as PaginationState<ClinicGeneratedReportModel>,
  ));
}
/// Create a copy of ReportsState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ClinicReportSummaryModelCopyWith<$Res>? get summary {
    if (_self.summary == null) {
    return null;
  }

  return $ClinicReportSummaryModelCopyWith<$Res>(_self.summary!, (value) {
    return _then(_self.copyWith(summary: value));
  });
}/// Create a copy of ReportsState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ClinicGeneratedReportModelCopyWith<$Res>? get exportedReport {
    if (_self.exportedReport == null) {
    return null;
  }

  return $ClinicGeneratedReportModelCopyWith<$Res>(_self.exportedReport!, (value) {
    return _then(_self.copyWith(exportedReport: value));
  });
}/// Create a copy of ReportsState
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


/// Adds pattern-matching-related methods to [ReportsState].
extension ReportsStatePatterns on ReportsState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ReportsState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ReportsState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ReportsState value)  $default,){
final _that = this;
switch (_that) {
case _ReportsState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ReportsState value)?  $default,){
final _that = this;
switch (_that) {
case _ReportsState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( ReportPeriod period,  ReportType type,  ClinicReportSummaryModel? summary,  ClinicGeneratedReportModel? exportedReport,  NetworkExceptions? failure,  bool isSummaryLoading,  bool isExportingPdf,  bool isExportingXlsx,  PaginationState<ClinicGeneratedReportModel> pagination)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ReportsState() when $default != null:
return $default(_that.period,_that.type,_that.summary,_that.exportedReport,_that.failure,_that.isSummaryLoading,_that.isExportingPdf,_that.isExportingXlsx,_that.pagination);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( ReportPeriod period,  ReportType type,  ClinicReportSummaryModel? summary,  ClinicGeneratedReportModel? exportedReport,  NetworkExceptions? failure,  bool isSummaryLoading,  bool isExportingPdf,  bool isExportingXlsx,  PaginationState<ClinicGeneratedReportModel> pagination)  $default,) {final _that = this;
switch (_that) {
case _ReportsState():
return $default(_that.period,_that.type,_that.summary,_that.exportedReport,_that.failure,_that.isSummaryLoading,_that.isExportingPdf,_that.isExportingXlsx,_that.pagination);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( ReportPeriod period,  ReportType type,  ClinicReportSummaryModel? summary,  ClinicGeneratedReportModel? exportedReport,  NetworkExceptions? failure,  bool isSummaryLoading,  bool isExportingPdf,  bool isExportingXlsx,  PaginationState<ClinicGeneratedReportModel> pagination)?  $default,) {final _that = this;
switch (_that) {
case _ReportsState() when $default != null:
return $default(_that.period,_that.type,_that.summary,_that.exportedReport,_that.failure,_that.isSummaryLoading,_that.isExportingPdf,_that.isExportingXlsx,_that.pagination);case _:
  return null;

}
}

}

/// @nodoc


class _ReportsState implements ReportsState {
  const _ReportsState({this.period = ReportPeriod.week, required this.type, this.summary, this.exportedReport, this.failure, this.isSummaryLoading = false, this.isExportingPdf = false, this.isExportingXlsx = false, required this.pagination});
  

@override@JsonKey() final  ReportPeriod period;
@override final  ReportType type;
@override final  ClinicReportSummaryModel? summary;
@override final  ClinicGeneratedReportModel? exportedReport;
@override final  NetworkExceptions? failure;
@override@JsonKey() final  bool isSummaryLoading;
@override@JsonKey() final  bool isExportingPdf;
@override@JsonKey() final  bool isExportingXlsx;
@override final  PaginationState<ClinicGeneratedReportModel> pagination;

/// Create a copy of ReportsState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReportsStateCopyWith<_ReportsState> get copyWith => __$ReportsStateCopyWithImpl<_ReportsState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ReportsState&&(identical(other.period, period) || other.period == period)&&(identical(other.type, type) || other.type == type)&&(identical(other.summary, summary) || other.summary == summary)&&(identical(other.exportedReport, exportedReport) || other.exportedReport == exportedReport)&&(identical(other.failure, failure) || other.failure == failure)&&(identical(other.isSummaryLoading, isSummaryLoading) || other.isSummaryLoading == isSummaryLoading)&&(identical(other.isExportingPdf, isExportingPdf) || other.isExportingPdf == isExportingPdf)&&(identical(other.isExportingXlsx, isExportingXlsx) || other.isExportingXlsx == isExportingXlsx)&&(identical(other.pagination, pagination) || other.pagination == pagination));
}


@override
int get hashCode => Object.hash(runtimeType,period,type,summary,exportedReport,failure,isSummaryLoading,isExportingPdf,isExportingXlsx,pagination);

@override
String toString() {
  return 'ReportsState(period: $period, type: $type, summary: $summary, exportedReport: $exportedReport, failure: $failure, isSummaryLoading: $isSummaryLoading, isExportingPdf: $isExportingPdf, isExportingXlsx: $isExportingXlsx, pagination: $pagination)';
}


}

/// @nodoc
abstract mixin class _$ReportsStateCopyWith<$Res> implements $ReportsStateCopyWith<$Res> {
  factory _$ReportsStateCopyWith(_ReportsState value, $Res Function(_ReportsState) _then) = __$ReportsStateCopyWithImpl;
@override @useResult
$Res call({
 ReportPeriod period, ReportType type, ClinicReportSummaryModel? summary, ClinicGeneratedReportModel? exportedReport, NetworkExceptions? failure, bool isSummaryLoading, bool isExportingPdf, bool isExportingXlsx, PaginationState<ClinicGeneratedReportModel> pagination
});


@override $ClinicReportSummaryModelCopyWith<$Res>? get summary;@override $ClinicGeneratedReportModelCopyWith<$Res>? get exportedReport;@override $NetworkExceptionsCopyWith<$Res>? get failure;

}
/// @nodoc
class __$ReportsStateCopyWithImpl<$Res>
    implements _$ReportsStateCopyWith<$Res> {
  __$ReportsStateCopyWithImpl(this._self, this._then);

  final _ReportsState _self;
  final $Res Function(_ReportsState) _then;

/// Create a copy of ReportsState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? period = null,Object? type = null,Object? summary = freezed,Object? exportedReport = freezed,Object? failure = freezed,Object? isSummaryLoading = null,Object? isExportingPdf = null,Object? isExportingXlsx = null,Object? pagination = null,}) {
  return _then(_ReportsState(
period: null == period ? _self.period : period // ignore: cast_nullable_to_non_nullable
as ReportPeriod,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as ReportType,summary: freezed == summary ? _self.summary : summary // ignore: cast_nullable_to_non_nullable
as ClinicReportSummaryModel?,exportedReport: freezed == exportedReport ? _self.exportedReport : exportedReport // ignore: cast_nullable_to_non_nullable
as ClinicGeneratedReportModel?,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as NetworkExceptions?,isSummaryLoading: null == isSummaryLoading ? _self.isSummaryLoading : isSummaryLoading // ignore: cast_nullable_to_non_nullable
as bool,isExportingPdf: null == isExportingPdf ? _self.isExportingPdf : isExportingPdf // ignore: cast_nullable_to_non_nullable
as bool,isExportingXlsx: null == isExportingXlsx ? _self.isExportingXlsx : isExportingXlsx // ignore: cast_nullable_to_non_nullable
as bool,pagination: null == pagination ? _self.pagination : pagination // ignore: cast_nullable_to_non_nullable
as PaginationState<ClinicGeneratedReportModel>,
  ));
}

/// Create a copy of ReportsState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ClinicReportSummaryModelCopyWith<$Res>? get summary {
    if (_self.summary == null) {
    return null;
  }

  return $ClinicReportSummaryModelCopyWith<$Res>(_self.summary!, (value) {
    return _then(_self.copyWith(summary: value));
  });
}/// Create a copy of ReportsState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ClinicGeneratedReportModelCopyWith<$Res>? get exportedReport {
    if (_self.exportedReport == null) {
    return null;
  }

  return $ClinicGeneratedReportModelCopyWith<$Res>(_self.exportedReport!, (value) {
    return _then(_self.copyWith(exportedReport: value));
  });
}/// Create a copy of ReportsState
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
