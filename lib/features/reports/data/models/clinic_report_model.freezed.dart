// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'clinic_report_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ClinicReportSummaryModel {

 String? get period; String? get type; ClinicReportTotalsModel? get totals; List<ClinicReportChartModel> get chart;
/// Create a copy of ClinicReportSummaryModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ClinicReportSummaryModelCopyWith<ClinicReportSummaryModel> get copyWith => _$ClinicReportSummaryModelCopyWithImpl<ClinicReportSummaryModel>(this as ClinicReportSummaryModel, _$identity);

  /// Serializes this ClinicReportSummaryModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ClinicReportSummaryModel&&(identical(other.period, period) || other.period == period)&&(identical(other.type, type) || other.type == type)&&(identical(other.totals, totals) || other.totals == totals)&&const DeepCollectionEquality().equals(other.chart, chart));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,period,type,totals,const DeepCollectionEquality().hash(chart));

@override
String toString() {
  return 'ClinicReportSummaryModel(period: $period, type: $type, totals: $totals, chart: $chart)';
}


}

/// @nodoc
abstract mixin class $ClinicReportSummaryModelCopyWith<$Res>  {
  factory $ClinicReportSummaryModelCopyWith(ClinicReportSummaryModel value, $Res Function(ClinicReportSummaryModel) _then) = _$ClinicReportSummaryModelCopyWithImpl;
@useResult
$Res call({
 String? period, String? type, ClinicReportTotalsModel? totals, List<ClinicReportChartModel> chart
});


$ClinicReportTotalsModelCopyWith<$Res>? get totals;

}
/// @nodoc
class _$ClinicReportSummaryModelCopyWithImpl<$Res>
    implements $ClinicReportSummaryModelCopyWith<$Res> {
  _$ClinicReportSummaryModelCopyWithImpl(this._self, this._then);

  final ClinicReportSummaryModel _self;
  final $Res Function(ClinicReportSummaryModel) _then;

/// Create a copy of ClinicReportSummaryModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? period = freezed,Object? type = freezed,Object? totals = freezed,Object? chart = null,}) {
  return _then(_self.copyWith(
period: freezed == period ? _self.period : period // ignore: cast_nullable_to_non_nullable
as String?,type: freezed == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String?,totals: freezed == totals ? _self.totals : totals // ignore: cast_nullable_to_non_nullable
as ClinicReportTotalsModel?,chart: null == chart ? _self.chart : chart // ignore: cast_nullable_to_non_nullable
as List<ClinicReportChartModel>,
  ));
}
/// Create a copy of ClinicReportSummaryModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ClinicReportTotalsModelCopyWith<$Res>? get totals {
    if (_self.totals == null) {
    return null;
  }

  return $ClinicReportTotalsModelCopyWith<$Res>(_self.totals!, (value) {
    return _then(_self.copyWith(totals: value));
  });
}
}


/// Adds pattern-matching-related methods to [ClinicReportSummaryModel].
extension ClinicReportSummaryModelPatterns on ClinicReportSummaryModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ClinicReportSummaryModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ClinicReportSummaryModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ClinicReportSummaryModel value)  $default,){
final _that = this;
switch (_that) {
case _ClinicReportSummaryModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ClinicReportSummaryModel value)?  $default,){
final _that = this;
switch (_that) {
case _ClinicReportSummaryModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? period,  String? type,  ClinicReportTotalsModel? totals,  List<ClinicReportChartModel> chart)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ClinicReportSummaryModel() when $default != null:
return $default(_that.period,_that.type,_that.totals,_that.chart);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? period,  String? type,  ClinicReportTotalsModel? totals,  List<ClinicReportChartModel> chart)  $default,) {final _that = this;
switch (_that) {
case _ClinicReportSummaryModel():
return $default(_that.period,_that.type,_that.totals,_that.chart);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? period,  String? type,  ClinicReportTotalsModel? totals,  List<ClinicReportChartModel> chart)?  $default,) {final _that = this;
switch (_that) {
case _ClinicReportSummaryModel() when $default != null:
return $default(_that.period,_that.type,_that.totals,_that.chart);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ClinicReportSummaryModel implements ClinicReportSummaryModel {
  const _ClinicReportSummaryModel({this.period, this.type, this.totals, final  List<ClinicReportChartModel> chart = const []}): _chart = chart;
  factory _ClinicReportSummaryModel.fromJson(Map<String, dynamic> json) => _$ClinicReportSummaryModelFromJson(json);

@override final  String? period;
@override final  String? type;
@override final  ClinicReportTotalsModel? totals;
 final  List<ClinicReportChartModel> _chart;
@override@JsonKey() List<ClinicReportChartModel> get chart {
  if (_chart is EqualUnmodifiableListView) return _chart;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_chart);
}


/// Create a copy of ClinicReportSummaryModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ClinicReportSummaryModelCopyWith<_ClinicReportSummaryModel> get copyWith => __$ClinicReportSummaryModelCopyWithImpl<_ClinicReportSummaryModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ClinicReportSummaryModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ClinicReportSummaryModel&&(identical(other.period, period) || other.period == period)&&(identical(other.type, type) || other.type == type)&&(identical(other.totals, totals) || other.totals == totals)&&const DeepCollectionEquality().equals(other._chart, _chart));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,period,type,totals,const DeepCollectionEquality().hash(_chart));

@override
String toString() {
  return 'ClinicReportSummaryModel(period: $period, type: $type, totals: $totals, chart: $chart)';
}


}

/// @nodoc
abstract mixin class _$ClinicReportSummaryModelCopyWith<$Res> implements $ClinicReportSummaryModelCopyWith<$Res> {
  factory _$ClinicReportSummaryModelCopyWith(_ClinicReportSummaryModel value, $Res Function(_ClinicReportSummaryModel) _then) = __$ClinicReportSummaryModelCopyWithImpl;
@override @useResult
$Res call({
 String? period, String? type, ClinicReportTotalsModel? totals, List<ClinicReportChartModel> chart
});


@override $ClinicReportTotalsModelCopyWith<$Res>? get totals;

}
/// @nodoc
class __$ClinicReportSummaryModelCopyWithImpl<$Res>
    implements _$ClinicReportSummaryModelCopyWith<$Res> {
  __$ClinicReportSummaryModelCopyWithImpl(this._self, this._then);

  final _ClinicReportSummaryModel _self;
  final $Res Function(_ClinicReportSummaryModel) _then;

/// Create a copy of ClinicReportSummaryModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? period = freezed,Object? type = freezed,Object? totals = freezed,Object? chart = null,}) {
  return _then(_ClinicReportSummaryModel(
period: freezed == period ? _self.period : period // ignore: cast_nullable_to_non_nullable
as String?,type: freezed == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String?,totals: freezed == totals ? _self.totals : totals // ignore: cast_nullable_to_non_nullable
as ClinicReportTotalsModel?,chart: null == chart ? _self._chart : chart // ignore: cast_nullable_to_non_nullable
as List<ClinicReportChartModel>,
  ));
}

/// Create a copy of ClinicReportSummaryModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ClinicReportTotalsModelCopyWith<$Res>? get totals {
    if (_self.totals == null) {
    return null;
  }

  return $ClinicReportTotalsModelCopyWith<$Res>(_self.totals!, (value) {
    return _then(_self.copyWith(totals: value));
  });
}
}


/// @nodoc
mixin _$ClinicReportTotalsModel {

 int get completed; int get pending; int get rejected; num get revenue; int get doctors; int get appointments;
/// Create a copy of ClinicReportTotalsModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ClinicReportTotalsModelCopyWith<ClinicReportTotalsModel> get copyWith => _$ClinicReportTotalsModelCopyWithImpl<ClinicReportTotalsModel>(this as ClinicReportTotalsModel, _$identity);

  /// Serializes this ClinicReportTotalsModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ClinicReportTotalsModel&&(identical(other.completed, completed) || other.completed == completed)&&(identical(other.pending, pending) || other.pending == pending)&&(identical(other.rejected, rejected) || other.rejected == rejected)&&(identical(other.revenue, revenue) || other.revenue == revenue)&&(identical(other.doctors, doctors) || other.doctors == doctors)&&(identical(other.appointments, appointments) || other.appointments == appointments));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,completed,pending,rejected,revenue,doctors,appointments);

@override
String toString() {
  return 'ClinicReportTotalsModel(completed: $completed, pending: $pending, rejected: $rejected, revenue: $revenue, doctors: $doctors, appointments: $appointments)';
}


}

/// @nodoc
abstract mixin class $ClinicReportTotalsModelCopyWith<$Res>  {
  factory $ClinicReportTotalsModelCopyWith(ClinicReportTotalsModel value, $Res Function(ClinicReportTotalsModel) _then) = _$ClinicReportTotalsModelCopyWithImpl;
@useResult
$Res call({
 int completed, int pending, int rejected, num revenue, int doctors, int appointments
});




}
/// @nodoc
class _$ClinicReportTotalsModelCopyWithImpl<$Res>
    implements $ClinicReportTotalsModelCopyWith<$Res> {
  _$ClinicReportTotalsModelCopyWithImpl(this._self, this._then);

  final ClinicReportTotalsModel _self;
  final $Res Function(ClinicReportTotalsModel) _then;

/// Create a copy of ClinicReportTotalsModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? completed = null,Object? pending = null,Object? rejected = null,Object? revenue = null,Object? doctors = null,Object? appointments = null,}) {
  return _then(_self.copyWith(
completed: null == completed ? _self.completed : completed // ignore: cast_nullable_to_non_nullable
as int,pending: null == pending ? _self.pending : pending // ignore: cast_nullable_to_non_nullable
as int,rejected: null == rejected ? _self.rejected : rejected // ignore: cast_nullable_to_non_nullable
as int,revenue: null == revenue ? _self.revenue : revenue // ignore: cast_nullable_to_non_nullable
as num,doctors: null == doctors ? _self.doctors : doctors // ignore: cast_nullable_to_non_nullable
as int,appointments: null == appointments ? _self.appointments : appointments // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [ClinicReportTotalsModel].
extension ClinicReportTotalsModelPatterns on ClinicReportTotalsModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ClinicReportTotalsModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ClinicReportTotalsModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ClinicReportTotalsModel value)  $default,){
final _that = this;
switch (_that) {
case _ClinicReportTotalsModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ClinicReportTotalsModel value)?  $default,){
final _that = this;
switch (_that) {
case _ClinicReportTotalsModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int completed,  int pending,  int rejected,  num revenue,  int doctors,  int appointments)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ClinicReportTotalsModel() when $default != null:
return $default(_that.completed,_that.pending,_that.rejected,_that.revenue,_that.doctors,_that.appointments);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int completed,  int pending,  int rejected,  num revenue,  int doctors,  int appointments)  $default,) {final _that = this;
switch (_that) {
case _ClinicReportTotalsModel():
return $default(_that.completed,_that.pending,_that.rejected,_that.revenue,_that.doctors,_that.appointments);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int completed,  int pending,  int rejected,  num revenue,  int doctors,  int appointments)?  $default,) {final _that = this;
switch (_that) {
case _ClinicReportTotalsModel() when $default != null:
return $default(_that.completed,_that.pending,_that.rejected,_that.revenue,_that.doctors,_that.appointments);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ClinicReportTotalsModel implements ClinicReportTotalsModel {
  const _ClinicReportTotalsModel({this.completed = 0, this.pending = 0, this.rejected = 0, this.revenue = 0, this.doctors = 0, this.appointments = 0});
  factory _ClinicReportTotalsModel.fromJson(Map<String, dynamic> json) => _$ClinicReportTotalsModelFromJson(json);

@override@JsonKey() final  int completed;
@override@JsonKey() final  int pending;
@override@JsonKey() final  int rejected;
@override@JsonKey() final  num revenue;
@override@JsonKey() final  int doctors;
@override@JsonKey() final  int appointments;

/// Create a copy of ClinicReportTotalsModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ClinicReportTotalsModelCopyWith<_ClinicReportTotalsModel> get copyWith => __$ClinicReportTotalsModelCopyWithImpl<_ClinicReportTotalsModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ClinicReportTotalsModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ClinicReportTotalsModel&&(identical(other.completed, completed) || other.completed == completed)&&(identical(other.pending, pending) || other.pending == pending)&&(identical(other.rejected, rejected) || other.rejected == rejected)&&(identical(other.revenue, revenue) || other.revenue == revenue)&&(identical(other.doctors, doctors) || other.doctors == doctors)&&(identical(other.appointments, appointments) || other.appointments == appointments));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,completed,pending,rejected,revenue,doctors,appointments);

@override
String toString() {
  return 'ClinicReportTotalsModel(completed: $completed, pending: $pending, rejected: $rejected, revenue: $revenue, doctors: $doctors, appointments: $appointments)';
}


}

/// @nodoc
abstract mixin class _$ClinicReportTotalsModelCopyWith<$Res> implements $ClinicReportTotalsModelCopyWith<$Res> {
  factory _$ClinicReportTotalsModelCopyWith(_ClinicReportTotalsModel value, $Res Function(_ClinicReportTotalsModel) _then) = __$ClinicReportTotalsModelCopyWithImpl;
@override @useResult
$Res call({
 int completed, int pending, int rejected, num revenue, int doctors, int appointments
});




}
/// @nodoc
class __$ClinicReportTotalsModelCopyWithImpl<$Res>
    implements _$ClinicReportTotalsModelCopyWith<$Res> {
  __$ClinicReportTotalsModelCopyWithImpl(this._self, this._then);

  final _ClinicReportTotalsModel _self;
  final $Res Function(_ClinicReportTotalsModel) _then;

/// Create a copy of ClinicReportTotalsModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? completed = null,Object? pending = null,Object? rejected = null,Object? revenue = null,Object? doctors = null,Object? appointments = null,}) {
  return _then(_ClinicReportTotalsModel(
completed: null == completed ? _self.completed : completed // ignore: cast_nullable_to_non_nullable
as int,pending: null == pending ? _self.pending : pending // ignore: cast_nullable_to_non_nullable
as int,rejected: null == rejected ? _self.rejected : rejected // ignore: cast_nullable_to_non_nullable
as int,revenue: null == revenue ? _self.revenue : revenue // ignore: cast_nullable_to_non_nullable
as num,doctors: null == doctors ? _self.doctors : doctors // ignore: cast_nullable_to_non_nullable
as int,appointments: null == appointments ? _self.appointments : appointments // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$ClinicReportChartModel {

 String? get label; int get completed; int get pending; int get rejected; num get revenue;
/// Create a copy of ClinicReportChartModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ClinicReportChartModelCopyWith<ClinicReportChartModel> get copyWith => _$ClinicReportChartModelCopyWithImpl<ClinicReportChartModel>(this as ClinicReportChartModel, _$identity);

  /// Serializes this ClinicReportChartModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ClinicReportChartModel&&(identical(other.label, label) || other.label == label)&&(identical(other.completed, completed) || other.completed == completed)&&(identical(other.pending, pending) || other.pending == pending)&&(identical(other.rejected, rejected) || other.rejected == rejected)&&(identical(other.revenue, revenue) || other.revenue == revenue));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,label,completed,pending,rejected,revenue);

@override
String toString() {
  return 'ClinicReportChartModel(label: $label, completed: $completed, pending: $pending, rejected: $rejected, revenue: $revenue)';
}


}

/// @nodoc
abstract mixin class $ClinicReportChartModelCopyWith<$Res>  {
  factory $ClinicReportChartModelCopyWith(ClinicReportChartModel value, $Res Function(ClinicReportChartModel) _then) = _$ClinicReportChartModelCopyWithImpl;
@useResult
$Res call({
 String? label, int completed, int pending, int rejected, num revenue
});




}
/// @nodoc
class _$ClinicReportChartModelCopyWithImpl<$Res>
    implements $ClinicReportChartModelCopyWith<$Res> {
  _$ClinicReportChartModelCopyWithImpl(this._self, this._then);

  final ClinicReportChartModel _self;
  final $Res Function(ClinicReportChartModel) _then;

/// Create a copy of ClinicReportChartModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? label = freezed,Object? completed = null,Object? pending = null,Object? rejected = null,Object? revenue = null,}) {
  return _then(_self.copyWith(
label: freezed == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String?,completed: null == completed ? _self.completed : completed // ignore: cast_nullable_to_non_nullable
as int,pending: null == pending ? _self.pending : pending // ignore: cast_nullable_to_non_nullable
as int,rejected: null == rejected ? _self.rejected : rejected // ignore: cast_nullable_to_non_nullable
as int,revenue: null == revenue ? _self.revenue : revenue // ignore: cast_nullable_to_non_nullable
as num,
  ));
}

}


/// Adds pattern-matching-related methods to [ClinicReportChartModel].
extension ClinicReportChartModelPatterns on ClinicReportChartModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ClinicReportChartModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ClinicReportChartModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ClinicReportChartModel value)  $default,){
final _that = this;
switch (_that) {
case _ClinicReportChartModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ClinicReportChartModel value)?  $default,){
final _that = this;
switch (_that) {
case _ClinicReportChartModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? label,  int completed,  int pending,  int rejected,  num revenue)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ClinicReportChartModel() when $default != null:
return $default(_that.label,_that.completed,_that.pending,_that.rejected,_that.revenue);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? label,  int completed,  int pending,  int rejected,  num revenue)  $default,) {final _that = this;
switch (_that) {
case _ClinicReportChartModel():
return $default(_that.label,_that.completed,_that.pending,_that.rejected,_that.revenue);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? label,  int completed,  int pending,  int rejected,  num revenue)?  $default,) {final _that = this;
switch (_that) {
case _ClinicReportChartModel() when $default != null:
return $default(_that.label,_that.completed,_that.pending,_that.rejected,_that.revenue);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ClinicReportChartModel implements ClinicReportChartModel {
  const _ClinicReportChartModel({this.label, this.completed = 0, this.pending = 0, this.rejected = 0, this.revenue = 0});
  factory _ClinicReportChartModel.fromJson(Map<String, dynamic> json) => _$ClinicReportChartModelFromJson(json);

@override final  String? label;
@override@JsonKey() final  int completed;
@override@JsonKey() final  int pending;
@override@JsonKey() final  int rejected;
@override@JsonKey() final  num revenue;

/// Create a copy of ClinicReportChartModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ClinicReportChartModelCopyWith<_ClinicReportChartModel> get copyWith => __$ClinicReportChartModelCopyWithImpl<_ClinicReportChartModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ClinicReportChartModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ClinicReportChartModel&&(identical(other.label, label) || other.label == label)&&(identical(other.completed, completed) || other.completed == completed)&&(identical(other.pending, pending) || other.pending == pending)&&(identical(other.rejected, rejected) || other.rejected == rejected)&&(identical(other.revenue, revenue) || other.revenue == revenue));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,label,completed,pending,rejected,revenue);

@override
String toString() {
  return 'ClinicReportChartModel(label: $label, completed: $completed, pending: $pending, rejected: $rejected, revenue: $revenue)';
}


}

/// @nodoc
abstract mixin class _$ClinicReportChartModelCopyWith<$Res> implements $ClinicReportChartModelCopyWith<$Res> {
  factory _$ClinicReportChartModelCopyWith(_ClinicReportChartModel value, $Res Function(_ClinicReportChartModel) _then) = __$ClinicReportChartModelCopyWithImpl;
@override @useResult
$Res call({
 String? label, int completed, int pending, int rejected, num revenue
});




}
/// @nodoc
class __$ClinicReportChartModelCopyWithImpl<$Res>
    implements _$ClinicReportChartModelCopyWith<$Res> {
  __$ClinicReportChartModelCopyWithImpl(this._self, this._then);

  final _ClinicReportChartModel _self;
  final $Res Function(_ClinicReportChartModel) _then;

/// Create a copy of ClinicReportChartModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? label = freezed,Object? completed = null,Object? pending = null,Object? rejected = null,Object? revenue = null,}) {
  return _then(_ClinicReportChartModel(
label: freezed == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String?,completed: null == completed ? _self.completed : completed // ignore: cast_nullable_to_non_nullable
as int,pending: null == pending ? _self.pending : pending // ignore: cast_nullable_to_non_nullable
as int,rejected: null == rejected ? _self.rejected : rejected // ignore: cast_nullable_to_non_nullable
as int,revenue: null == revenue ? _self.revenue : revenue // ignore: cast_nullable_to_non_nullable
as num,
  ));
}


}


/// @nodoc
mixin _$ClinicGeneratedReportModel {

@JsonKey(name: 'report_id') int? get reportId; String? get type; String? get period; String? get format; String? get status;@JsonKey(name: 'file_url') String? get fileUrl;@JsonKey(name: 'generated_at') String? get generatedAt;
/// Create a copy of ClinicGeneratedReportModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ClinicGeneratedReportModelCopyWith<ClinicGeneratedReportModel> get copyWith => _$ClinicGeneratedReportModelCopyWithImpl<ClinicGeneratedReportModel>(this as ClinicGeneratedReportModel, _$identity);

  /// Serializes this ClinicGeneratedReportModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ClinicGeneratedReportModel&&(identical(other.reportId, reportId) || other.reportId == reportId)&&(identical(other.type, type) || other.type == type)&&(identical(other.period, period) || other.period == period)&&(identical(other.format, format) || other.format == format)&&(identical(other.status, status) || other.status == status)&&(identical(other.fileUrl, fileUrl) || other.fileUrl == fileUrl)&&(identical(other.generatedAt, generatedAt) || other.generatedAt == generatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,reportId,type,period,format,status,fileUrl,generatedAt);

@override
String toString() {
  return 'ClinicGeneratedReportModel(reportId: $reportId, type: $type, period: $period, format: $format, status: $status, fileUrl: $fileUrl, generatedAt: $generatedAt)';
}


}

/// @nodoc
abstract mixin class $ClinicGeneratedReportModelCopyWith<$Res>  {
  factory $ClinicGeneratedReportModelCopyWith(ClinicGeneratedReportModel value, $Res Function(ClinicGeneratedReportModel) _then) = _$ClinicGeneratedReportModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'report_id') int? reportId, String? type, String? period, String? format, String? status,@JsonKey(name: 'file_url') String? fileUrl,@JsonKey(name: 'generated_at') String? generatedAt
});




}
/// @nodoc
class _$ClinicGeneratedReportModelCopyWithImpl<$Res>
    implements $ClinicGeneratedReportModelCopyWith<$Res> {
  _$ClinicGeneratedReportModelCopyWithImpl(this._self, this._then);

  final ClinicGeneratedReportModel _self;
  final $Res Function(ClinicGeneratedReportModel) _then;

/// Create a copy of ClinicGeneratedReportModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? reportId = freezed,Object? type = freezed,Object? period = freezed,Object? format = freezed,Object? status = freezed,Object? fileUrl = freezed,Object? generatedAt = freezed,}) {
  return _then(_self.copyWith(
reportId: freezed == reportId ? _self.reportId : reportId // ignore: cast_nullable_to_non_nullable
as int?,type: freezed == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String?,period: freezed == period ? _self.period : period // ignore: cast_nullable_to_non_nullable
as String?,format: freezed == format ? _self.format : format // ignore: cast_nullable_to_non_nullable
as String?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,fileUrl: freezed == fileUrl ? _self.fileUrl : fileUrl // ignore: cast_nullable_to_non_nullable
as String?,generatedAt: freezed == generatedAt ? _self.generatedAt : generatedAt // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ClinicGeneratedReportModel].
extension ClinicGeneratedReportModelPatterns on ClinicGeneratedReportModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ClinicGeneratedReportModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ClinicGeneratedReportModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ClinicGeneratedReportModel value)  $default,){
final _that = this;
switch (_that) {
case _ClinicGeneratedReportModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ClinicGeneratedReportModel value)?  $default,){
final _that = this;
switch (_that) {
case _ClinicGeneratedReportModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'report_id')  int? reportId,  String? type,  String? period,  String? format,  String? status, @JsonKey(name: 'file_url')  String? fileUrl, @JsonKey(name: 'generated_at')  String? generatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ClinicGeneratedReportModel() when $default != null:
return $default(_that.reportId,_that.type,_that.period,_that.format,_that.status,_that.fileUrl,_that.generatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'report_id')  int? reportId,  String? type,  String? period,  String? format,  String? status, @JsonKey(name: 'file_url')  String? fileUrl, @JsonKey(name: 'generated_at')  String? generatedAt)  $default,) {final _that = this;
switch (_that) {
case _ClinicGeneratedReportModel():
return $default(_that.reportId,_that.type,_that.period,_that.format,_that.status,_that.fileUrl,_that.generatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'report_id')  int? reportId,  String? type,  String? period,  String? format,  String? status, @JsonKey(name: 'file_url')  String? fileUrl, @JsonKey(name: 'generated_at')  String? generatedAt)?  $default,) {final _that = this;
switch (_that) {
case _ClinicGeneratedReportModel() when $default != null:
return $default(_that.reportId,_that.type,_that.period,_that.format,_that.status,_that.fileUrl,_that.generatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ClinicGeneratedReportModel implements ClinicGeneratedReportModel {
  const _ClinicGeneratedReportModel({@JsonKey(name: 'report_id') this.reportId, this.type, this.period, this.format, this.status, @JsonKey(name: 'file_url') this.fileUrl, @JsonKey(name: 'generated_at') this.generatedAt});
  factory _ClinicGeneratedReportModel.fromJson(Map<String, dynamic> json) => _$ClinicGeneratedReportModelFromJson(json);

@override@JsonKey(name: 'report_id') final  int? reportId;
@override final  String? type;
@override final  String? period;
@override final  String? format;
@override final  String? status;
@override@JsonKey(name: 'file_url') final  String? fileUrl;
@override@JsonKey(name: 'generated_at') final  String? generatedAt;

/// Create a copy of ClinicGeneratedReportModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ClinicGeneratedReportModelCopyWith<_ClinicGeneratedReportModel> get copyWith => __$ClinicGeneratedReportModelCopyWithImpl<_ClinicGeneratedReportModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ClinicGeneratedReportModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ClinicGeneratedReportModel&&(identical(other.reportId, reportId) || other.reportId == reportId)&&(identical(other.type, type) || other.type == type)&&(identical(other.period, period) || other.period == period)&&(identical(other.format, format) || other.format == format)&&(identical(other.status, status) || other.status == status)&&(identical(other.fileUrl, fileUrl) || other.fileUrl == fileUrl)&&(identical(other.generatedAt, generatedAt) || other.generatedAt == generatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,reportId,type,period,format,status,fileUrl,generatedAt);

@override
String toString() {
  return 'ClinicGeneratedReportModel(reportId: $reportId, type: $type, period: $period, format: $format, status: $status, fileUrl: $fileUrl, generatedAt: $generatedAt)';
}


}

/// @nodoc
abstract mixin class _$ClinicGeneratedReportModelCopyWith<$Res> implements $ClinicGeneratedReportModelCopyWith<$Res> {
  factory _$ClinicGeneratedReportModelCopyWith(_ClinicGeneratedReportModel value, $Res Function(_ClinicGeneratedReportModel) _then) = __$ClinicGeneratedReportModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'report_id') int? reportId, String? type, String? period, String? format, String? status,@JsonKey(name: 'file_url') String? fileUrl,@JsonKey(name: 'generated_at') String? generatedAt
});




}
/// @nodoc
class __$ClinicGeneratedReportModelCopyWithImpl<$Res>
    implements _$ClinicGeneratedReportModelCopyWith<$Res> {
  __$ClinicGeneratedReportModelCopyWithImpl(this._self, this._then);

  final _ClinicGeneratedReportModel _self;
  final $Res Function(_ClinicGeneratedReportModel) _then;

/// Create a copy of ClinicGeneratedReportModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? reportId = freezed,Object? type = freezed,Object? period = freezed,Object? format = freezed,Object? status = freezed,Object? fileUrl = freezed,Object? generatedAt = freezed,}) {
  return _then(_ClinicGeneratedReportModel(
reportId: freezed == reportId ? _self.reportId : reportId // ignore: cast_nullable_to_non_nullable
as int?,type: freezed == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String?,period: freezed == period ? _self.period : period // ignore: cast_nullable_to_non_nullable
as String?,format: freezed == format ? _self.format : format // ignore: cast_nullable_to_non_nullable
as String?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,fileUrl: freezed == fileUrl ? _self.fileUrl : fileUrl // ignore: cast_nullable_to_non_nullable
as String?,generatedAt: freezed == generatedAt ? _self.generatedAt : generatedAt // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
