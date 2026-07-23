// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'clinic_appointment_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ClinicAppointmentModel {

@JsonKey(name: 'appointment_id') String? get appointmentId; String? get type; String? get status;@JsonKey(name: 'patient_name') String? get patientName;@JsonKey(name: 'patient_phone') String? get patientPhone;@JsonKey(name: 'patient_image') String? get patientImage;@JsonKey(name: 'doctor_id') String? get doctorId;@JsonKey(name: 'doctor_name') String? get doctorName;@JsonKey(name: 'specialization_id') String? get specializationId;@JsonKey(name: 'specialization_name') String? get specializationName;@JsonKey(name: 'service_name') String? get serviceName; String? get date; String? get time; num get price; String? get notes; String? get problem;@JsonKey(name: 'result_file') String? get resultFile;@JsonKey(name: 'rejection_reason') String? get rejectionReason;
/// Create a copy of ClinicAppointmentModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ClinicAppointmentModelCopyWith<ClinicAppointmentModel> get copyWith => _$ClinicAppointmentModelCopyWithImpl<ClinicAppointmentModel>(this as ClinicAppointmentModel, _$identity);

  /// Serializes this ClinicAppointmentModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ClinicAppointmentModel&&(identical(other.appointmentId, appointmentId) || other.appointmentId == appointmentId)&&(identical(other.type, type) || other.type == type)&&(identical(other.status, status) || other.status == status)&&(identical(other.patientName, patientName) || other.patientName == patientName)&&(identical(other.patientPhone, patientPhone) || other.patientPhone == patientPhone)&&(identical(other.patientImage, patientImage) || other.patientImage == patientImage)&&(identical(other.doctorId, doctorId) || other.doctorId == doctorId)&&(identical(other.doctorName, doctorName) || other.doctorName == doctorName)&&(identical(other.specializationId, specializationId) || other.specializationId == specializationId)&&(identical(other.specializationName, specializationName) || other.specializationName == specializationName)&&(identical(other.serviceName, serviceName) || other.serviceName == serviceName)&&(identical(other.date, date) || other.date == date)&&(identical(other.time, time) || other.time == time)&&(identical(other.price, price) || other.price == price)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.problem, problem) || other.problem == problem)&&(identical(other.resultFile, resultFile) || other.resultFile == resultFile)&&(identical(other.rejectionReason, rejectionReason) || other.rejectionReason == rejectionReason));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,appointmentId,type,status,patientName,patientPhone,patientImage,doctorId,doctorName,specializationId,specializationName,serviceName,date,time,price,notes,problem,resultFile,rejectionReason);

@override
String toString() {
  return 'ClinicAppointmentModel(appointmentId: $appointmentId, type: $type, status: $status, patientName: $patientName, patientPhone: $patientPhone, patientImage: $patientImage, doctorId: $doctorId, doctorName: $doctorName, specializationId: $specializationId, specializationName: $specializationName, serviceName: $serviceName, date: $date, time: $time, price: $price, notes: $notes, problem: $problem, resultFile: $resultFile, rejectionReason: $rejectionReason)';
}


}

/// @nodoc
abstract mixin class $ClinicAppointmentModelCopyWith<$Res>  {
  factory $ClinicAppointmentModelCopyWith(ClinicAppointmentModel value, $Res Function(ClinicAppointmentModel) _then) = _$ClinicAppointmentModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'appointment_id') String? appointmentId, String? type, String? status,@JsonKey(name: 'patient_name') String? patientName,@JsonKey(name: 'patient_phone') String? patientPhone,@JsonKey(name: 'patient_image') String? patientImage,@JsonKey(name: 'doctor_id') String? doctorId,@JsonKey(name: 'doctor_name') String? doctorName,@JsonKey(name: 'specialization_id') String? specializationId,@JsonKey(name: 'specialization_name') String? specializationName,@JsonKey(name: 'service_name') String? serviceName, String? date, String? time, num price, String? notes, String? problem,@JsonKey(name: 'result_file') String? resultFile,@JsonKey(name: 'rejection_reason') String? rejectionReason
});




}
/// @nodoc
class _$ClinicAppointmentModelCopyWithImpl<$Res>
    implements $ClinicAppointmentModelCopyWith<$Res> {
  _$ClinicAppointmentModelCopyWithImpl(this._self, this._then);

  final ClinicAppointmentModel _self;
  final $Res Function(ClinicAppointmentModel) _then;

/// Create a copy of ClinicAppointmentModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? appointmentId = freezed,Object? type = freezed,Object? status = freezed,Object? patientName = freezed,Object? patientPhone = freezed,Object? patientImage = freezed,Object? doctorId = freezed,Object? doctorName = freezed,Object? specializationId = freezed,Object? specializationName = freezed,Object? serviceName = freezed,Object? date = freezed,Object? time = freezed,Object? price = null,Object? notes = freezed,Object? problem = freezed,Object? resultFile = freezed,Object? rejectionReason = freezed,}) {
  return _then(_self.copyWith(
appointmentId: freezed == appointmentId ? _self.appointmentId : appointmentId // ignore: cast_nullable_to_non_nullable
as String?,type: freezed == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,patientName: freezed == patientName ? _self.patientName : patientName // ignore: cast_nullable_to_non_nullable
as String?,patientPhone: freezed == patientPhone ? _self.patientPhone : patientPhone // ignore: cast_nullable_to_non_nullable
as String?,patientImage: freezed == patientImage ? _self.patientImage : patientImage // ignore: cast_nullable_to_non_nullable
as String?,doctorId: freezed == doctorId ? _self.doctorId : doctorId // ignore: cast_nullable_to_non_nullable
as String?,doctorName: freezed == doctorName ? _self.doctorName : doctorName // ignore: cast_nullable_to_non_nullable
as String?,specializationId: freezed == specializationId ? _self.specializationId : specializationId // ignore: cast_nullable_to_non_nullable
as String?,specializationName: freezed == specializationName ? _self.specializationName : specializationName // ignore: cast_nullable_to_non_nullable
as String?,serviceName: freezed == serviceName ? _self.serviceName : serviceName // ignore: cast_nullable_to_non_nullable
as String?,date: freezed == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String?,time: freezed == time ? _self.time : time // ignore: cast_nullable_to_non_nullable
as String?,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as num,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,problem: freezed == problem ? _self.problem : problem // ignore: cast_nullable_to_non_nullable
as String?,resultFile: freezed == resultFile ? _self.resultFile : resultFile // ignore: cast_nullable_to_non_nullable
as String?,rejectionReason: freezed == rejectionReason ? _self.rejectionReason : rejectionReason // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ClinicAppointmentModel].
extension ClinicAppointmentModelPatterns on ClinicAppointmentModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ClinicAppointmentModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ClinicAppointmentModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ClinicAppointmentModel value)  $default,){
final _that = this;
switch (_that) {
case _ClinicAppointmentModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ClinicAppointmentModel value)?  $default,){
final _that = this;
switch (_that) {
case _ClinicAppointmentModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'appointment_id')  String? appointmentId,  String? type,  String? status, @JsonKey(name: 'patient_name')  String? patientName, @JsonKey(name: 'patient_phone')  String? patientPhone, @JsonKey(name: 'patient_image')  String? patientImage, @JsonKey(name: 'doctor_id')  String? doctorId, @JsonKey(name: 'doctor_name')  String? doctorName, @JsonKey(name: 'specialization_id')  String? specializationId, @JsonKey(name: 'specialization_name')  String? specializationName, @JsonKey(name: 'service_name')  String? serviceName,  String? date,  String? time,  num price,  String? notes,  String? problem, @JsonKey(name: 'result_file')  String? resultFile, @JsonKey(name: 'rejection_reason')  String? rejectionReason)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ClinicAppointmentModel() when $default != null:
return $default(_that.appointmentId,_that.type,_that.status,_that.patientName,_that.patientPhone,_that.patientImage,_that.doctorId,_that.doctorName,_that.specializationId,_that.specializationName,_that.serviceName,_that.date,_that.time,_that.price,_that.notes,_that.problem,_that.resultFile,_that.rejectionReason);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'appointment_id')  String? appointmentId,  String? type,  String? status, @JsonKey(name: 'patient_name')  String? patientName, @JsonKey(name: 'patient_phone')  String? patientPhone, @JsonKey(name: 'patient_image')  String? patientImage, @JsonKey(name: 'doctor_id')  String? doctorId, @JsonKey(name: 'doctor_name')  String? doctorName, @JsonKey(name: 'specialization_id')  String? specializationId, @JsonKey(name: 'specialization_name')  String? specializationName, @JsonKey(name: 'service_name')  String? serviceName,  String? date,  String? time,  num price,  String? notes,  String? problem, @JsonKey(name: 'result_file')  String? resultFile, @JsonKey(name: 'rejection_reason')  String? rejectionReason)  $default,) {final _that = this;
switch (_that) {
case _ClinicAppointmentModel():
return $default(_that.appointmentId,_that.type,_that.status,_that.patientName,_that.patientPhone,_that.patientImage,_that.doctorId,_that.doctorName,_that.specializationId,_that.specializationName,_that.serviceName,_that.date,_that.time,_that.price,_that.notes,_that.problem,_that.resultFile,_that.rejectionReason);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'appointment_id')  String? appointmentId,  String? type,  String? status, @JsonKey(name: 'patient_name')  String? patientName, @JsonKey(name: 'patient_phone')  String? patientPhone, @JsonKey(name: 'patient_image')  String? patientImage, @JsonKey(name: 'doctor_id')  String? doctorId, @JsonKey(name: 'doctor_name')  String? doctorName, @JsonKey(name: 'specialization_id')  String? specializationId, @JsonKey(name: 'specialization_name')  String? specializationName, @JsonKey(name: 'service_name')  String? serviceName,  String? date,  String? time,  num price,  String? notes,  String? problem, @JsonKey(name: 'result_file')  String? resultFile, @JsonKey(name: 'rejection_reason')  String? rejectionReason)?  $default,) {final _that = this;
switch (_that) {
case _ClinicAppointmentModel() when $default != null:
return $default(_that.appointmentId,_that.type,_that.status,_that.patientName,_that.patientPhone,_that.patientImage,_that.doctorId,_that.doctorName,_that.specializationId,_that.specializationName,_that.serviceName,_that.date,_that.time,_that.price,_that.notes,_that.problem,_that.resultFile,_that.rejectionReason);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ClinicAppointmentModel implements ClinicAppointmentModel {
  const _ClinicAppointmentModel({@JsonKey(name: 'appointment_id') this.appointmentId, this.type, this.status, @JsonKey(name: 'patient_name') this.patientName, @JsonKey(name: 'patient_phone') this.patientPhone, @JsonKey(name: 'patient_image') this.patientImage, @JsonKey(name: 'doctor_id') this.doctorId, @JsonKey(name: 'doctor_name') this.doctorName, @JsonKey(name: 'specialization_id') this.specializationId, @JsonKey(name: 'specialization_name') this.specializationName, @JsonKey(name: 'service_name') this.serviceName, this.date, this.time, this.price = 0, this.notes, this.problem, @JsonKey(name: 'result_file') this.resultFile, @JsonKey(name: 'rejection_reason') this.rejectionReason});
  factory _ClinicAppointmentModel.fromJson(Map<String, dynamic> json) => _$ClinicAppointmentModelFromJson(json);

@override@JsonKey(name: 'appointment_id') final  String? appointmentId;
@override final  String? type;
@override final  String? status;
@override@JsonKey(name: 'patient_name') final  String? patientName;
@override@JsonKey(name: 'patient_phone') final  String? patientPhone;
@override@JsonKey(name: 'patient_image') final  String? patientImage;
@override@JsonKey(name: 'doctor_id') final  String? doctorId;
@override@JsonKey(name: 'doctor_name') final  String? doctorName;
@override@JsonKey(name: 'specialization_id') final  String? specializationId;
@override@JsonKey(name: 'specialization_name') final  String? specializationName;
@override@JsonKey(name: 'service_name') final  String? serviceName;
@override final  String? date;
@override final  String? time;
@override@JsonKey() final  num price;
@override final  String? notes;
@override final  String? problem;
@override@JsonKey(name: 'result_file') final  String? resultFile;
@override@JsonKey(name: 'rejection_reason') final  String? rejectionReason;

/// Create a copy of ClinicAppointmentModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ClinicAppointmentModelCopyWith<_ClinicAppointmentModel> get copyWith => __$ClinicAppointmentModelCopyWithImpl<_ClinicAppointmentModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ClinicAppointmentModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ClinicAppointmentModel&&(identical(other.appointmentId, appointmentId) || other.appointmentId == appointmentId)&&(identical(other.type, type) || other.type == type)&&(identical(other.status, status) || other.status == status)&&(identical(other.patientName, patientName) || other.patientName == patientName)&&(identical(other.patientPhone, patientPhone) || other.patientPhone == patientPhone)&&(identical(other.patientImage, patientImage) || other.patientImage == patientImage)&&(identical(other.doctorId, doctorId) || other.doctorId == doctorId)&&(identical(other.doctorName, doctorName) || other.doctorName == doctorName)&&(identical(other.specializationId, specializationId) || other.specializationId == specializationId)&&(identical(other.specializationName, specializationName) || other.specializationName == specializationName)&&(identical(other.serviceName, serviceName) || other.serviceName == serviceName)&&(identical(other.date, date) || other.date == date)&&(identical(other.time, time) || other.time == time)&&(identical(other.price, price) || other.price == price)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.problem, problem) || other.problem == problem)&&(identical(other.resultFile, resultFile) || other.resultFile == resultFile)&&(identical(other.rejectionReason, rejectionReason) || other.rejectionReason == rejectionReason));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,appointmentId,type,status,patientName,patientPhone,patientImage,doctorId,doctorName,specializationId,specializationName,serviceName,date,time,price,notes,problem,resultFile,rejectionReason);

@override
String toString() {
  return 'ClinicAppointmentModel(appointmentId: $appointmentId, type: $type, status: $status, patientName: $patientName, patientPhone: $patientPhone, patientImage: $patientImage, doctorId: $doctorId, doctorName: $doctorName, specializationId: $specializationId, specializationName: $specializationName, serviceName: $serviceName, date: $date, time: $time, price: $price, notes: $notes, problem: $problem, resultFile: $resultFile, rejectionReason: $rejectionReason)';
}


}

/// @nodoc
abstract mixin class _$ClinicAppointmentModelCopyWith<$Res> implements $ClinicAppointmentModelCopyWith<$Res> {
  factory _$ClinicAppointmentModelCopyWith(_ClinicAppointmentModel value, $Res Function(_ClinicAppointmentModel) _then) = __$ClinicAppointmentModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'appointment_id') String? appointmentId, String? type, String? status,@JsonKey(name: 'patient_name') String? patientName,@JsonKey(name: 'patient_phone') String? patientPhone,@JsonKey(name: 'patient_image') String? patientImage,@JsonKey(name: 'doctor_id') String? doctorId,@JsonKey(name: 'doctor_name') String? doctorName,@JsonKey(name: 'specialization_id') String? specializationId,@JsonKey(name: 'specialization_name') String? specializationName,@JsonKey(name: 'service_name') String? serviceName, String? date, String? time, num price, String? notes, String? problem,@JsonKey(name: 'result_file') String? resultFile,@JsonKey(name: 'rejection_reason') String? rejectionReason
});




}
/// @nodoc
class __$ClinicAppointmentModelCopyWithImpl<$Res>
    implements _$ClinicAppointmentModelCopyWith<$Res> {
  __$ClinicAppointmentModelCopyWithImpl(this._self, this._then);

  final _ClinicAppointmentModel _self;
  final $Res Function(_ClinicAppointmentModel) _then;

/// Create a copy of ClinicAppointmentModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? appointmentId = freezed,Object? type = freezed,Object? status = freezed,Object? patientName = freezed,Object? patientPhone = freezed,Object? patientImage = freezed,Object? doctorId = freezed,Object? doctorName = freezed,Object? specializationId = freezed,Object? specializationName = freezed,Object? serviceName = freezed,Object? date = freezed,Object? time = freezed,Object? price = null,Object? notes = freezed,Object? problem = freezed,Object? resultFile = freezed,Object? rejectionReason = freezed,}) {
  return _then(_ClinicAppointmentModel(
appointmentId: freezed == appointmentId ? _self.appointmentId : appointmentId // ignore: cast_nullable_to_non_nullable
as String?,type: freezed == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,patientName: freezed == patientName ? _self.patientName : patientName // ignore: cast_nullable_to_non_nullable
as String?,patientPhone: freezed == patientPhone ? _self.patientPhone : patientPhone // ignore: cast_nullable_to_non_nullable
as String?,patientImage: freezed == patientImage ? _self.patientImage : patientImage // ignore: cast_nullable_to_non_nullable
as String?,doctorId: freezed == doctorId ? _self.doctorId : doctorId // ignore: cast_nullable_to_non_nullable
as String?,doctorName: freezed == doctorName ? _self.doctorName : doctorName // ignore: cast_nullable_to_non_nullable
as String?,specializationId: freezed == specializationId ? _self.specializationId : specializationId // ignore: cast_nullable_to_non_nullable
as String?,specializationName: freezed == specializationName ? _self.specializationName : specializationName // ignore: cast_nullable_to_non_nullable
as String?,serviceName: freezed == serviceName ? _self.serviceName : serviceName // ignore: cast_nullable_to_non_nullable
as String?,date: freezed == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String?,time: freezed == time ? _self.time : time // ignore: cast_nullable_to_non_nullable
as String?,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as num,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,problem: freezed == problem ? _self.problem : problem // ignore: cast_nullable_to_non_nullable
as String?,resultFile: freezed == resultFile ? _self.resultFile : resultFile // ignore: cast_nullable_to_non_nullable
as String?,rejectionReason: freezed == rejectionReason ? _self.rejectionReason : rejectionReason // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
