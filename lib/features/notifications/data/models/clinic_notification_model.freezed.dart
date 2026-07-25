// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'clinic_notification_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ClinicNotificationModel {

 int? get id; String? get title; String? get body; String? get message; String? get type; Map<String, dynamic>? get data;@JsonKey(name: 'is_read') bool get isRead;@JsonKey(name: 'read_at') String? get readAt;@JsonKey(name: 'sent_at') String? get sentAt;@JsonKey(name: 'created_at') String? get createdAt;@JsonKey(name: 'notifiable_type') String? get notifiableType;@JsonKey(name: 'notifiable_id') int? get notifiableId;
/// Create a copy of ClinicNotificationModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ClinicNotificationModelCopyWith<ClinicNotificationModel> get copyWith => _$ClinicNotificationModelCopyWithImpl<ClinicNotificationModel>(this as ClinicNotificationModel, _$identity);

  /// Serializes this ClinicNotificationModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ClinicNotificationModel&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.body, body) || other.body == body)&&(identical(other.message, message) || other.message == message)&&(identical(other.type, type) || other.type == type)&&const DeepCollectionEquality().equals(other.data, data)&&(identical(other.isRead, isRead) || other.isRead == isRead)&&(identical(other.readAt, readAt) || other.readAt == readAt)&&(identical(other.sentAt, sentAt) || other.sentAt == sentAt)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.notifiableType, notifiableType) || other.notifiableType == notifiableType)&&(identical(other.notifiableId, notifiableId) || other.notifiableId == notifiableId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,body,message,type,const DeepCollectionEquality().hash(data),isRead,readAt,sentAt,createdAt,notifiableType,notifiableId);

@override
String toString() {
  return 'ClinicNotificationModel(id: $id, title: $title, body: $body, message: $message, type: $type, data: $data, isRead: $isRead, readAt: $readAt, sentAt: $sentAt, createdAt: $createdAt, notifiableType: $notifiableType, notifiableId: $notifiableId)';
}


}

/// @nodoc
abstract mixin class $ClinicNotificationModelCopyWith<$Res>  {
  factory $ClinicNotificationModelCopyWith(ClinicNotificationModel value, $Res Function(ClinicNotificationModel) _then) = _$ClinicNotificationModelCopyWithImpl;
@useResult
$Res call({
 int? id, String? title, String? body, String? message, String? type, Map<String, dynamic>? data,@JsonKey(name: 'is_read') bool isRead,@JsonKey(name: 'read_at') String? readAt,@JsonKey(name: 'sent_at') String? sentAt,@JsonKey(name: 'created_at') String? createdAt,@JsonKey(name: 'notifiable_type') String? notifiableType,@JsonKey(name: 'notifiable_id') int? notifiableId
});




}
/// @nodoc
class _$ClinicNotificationModelCopyWithImpl<$Res>
    implements $ClinicNotificationModelCopyWith<$Res> {
  _$ClinicNotificationModelCopyWithImpl(this._self, this._then);

  final ClinicNotificationModel _self;
  final $Res Function(ClinicNotificationModel) _then;

/// Create a copy of ClinicNotificationModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? title = freezed,Object? body = freezed,Object? message = freezed,Object? type = freezed,Object? data = freezed,Object? isRead = null,Object? readAt = freezed,Object? sentAt = freezed,Object? createdAt = freezed,Object? notifiableType = freezed,Object? notifiableId = freezed,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,body: freezed == body ? _self.body : body // ignore: cast_nullable_to_non_nullable
as String?,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,type: freezed == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String?,data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,isRead: null == isRead ? _self.isRead : isRead // ignore: cast_nullable_to_non_nullable
as bool,readAt: freezed == readAt ? _self.readAt : readAt // ignore: cast_nullable_to_non_nullable
as String?,sentAt: freezed == sentAt ? _self.sentAt : sentAt // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String?,notifiableType: freezed == notifiableType ? _self.notifiableType : notifiableType // ignore: cast_nullable_to_non_nullable
as String?,notifiableId: freezed == notifiableId ? _self.notifiableId : notifiableId // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [ClinicNotificationModel].
extension ClinicNotificationModelPatterns on ClinicNotificationModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ClinicNotificationModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ClinicNotificationModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ClinicNotificationModel value)  $default,){
final _that = this;
switch (_that) {
case _ClinicNotificationModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ClinicNotificationModel value)?  $default,){
final _that = this;
switch (_that) {
case _ClinicNotificationModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int? id,  String? title,  String? body,  String? message,  String? type,  Map<String, dynamic>? data, @JsonKey(name: 'is_read')  bool isRead, @JsonKey(name: 'read_at')  String? readAt, @JsonKey(name: 'sent_at')  String? sentAt, @JsonKey(name: 'created_at')  String? createdAt, @JsonKey(name: 'notifiable_type')  String? notifiableType, @JsonKey(name: 'notifiable_id')  int? notifiableId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ClinicNotificationModel() when $default != null:
return $default(_that.id,_that.title,_that.body,_that.message,_that.type,_that.data,_that.isRead,_that.readAt,_that.sentAt,_that.createdAt,_that.notifiableType,_that.notifiableId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int? id,  String? title,  String? body,  String? message,  String? type,  Map<String, dynamic>? data, @JsonKey(name: 'is_read')  bool isRead, @JsonKey(name: 'read_at')  String? readAt, @JsonKey(name: 'sent_at')  String? sentAt, @JsonKey(name: 'created_at')  String? createdAt, @JsonKey(name: 'notifiable_type')  String? notifiableType, @JsonKey(name: 'notifiable_id')  int? notifiableId)  $default,) {final _that = this;
switch (_that) {
case _ClinicNotificationModel():
return $default(_that.id,_that.title,_that.body,_that.message,_that.type,_that.data,_that.isRead,_that.readAt,_that.sentAt,_that.createdAt,_that.notifiableType,_that.notifiableId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int? id,  String? title,  String? body,  String? message,  String? type,  Map<String, dynamic>? data, @JsonKey(name: 'is_read')  bool isRead, @JsonKey(name: 'read_at')  String? readAt, @JsonKey(name: 'sent_at')  String? sentAt, @JsonKey(name: 'created_at')  String? createdAt, @JsonKey(name: 'notifiable_type')  String? notifiableType, @JsonKey(name: 'notifiable_id')  int? notifiableId)?  $default,) {final _that = this;
switch (_that) {
case _ClinicNotificationModel() when $default != null:
return $default(_that.id,_that.title,_that.body,_that.message,_that.type,_that.data,_that.isRead,_that.readAt,_that.sentAt,_that.createdAt,_that.notifiableType,_that.notifiableId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ClinicNotificationModel implements ClinicNotificationModel {
  const _ClinicNotificationModel({this.id, this.title, this.body, this.message, this.type, final  Map<String, dynamic>? data, @JsonKey(name: 'is_read') this.isRead = false, @JsonKey(name: 'read_at') this.readAt, @JsonKey(name: 'sent_at') this.sentAt, @JsonKey(name: 'created_at') this.createdAt, @JsonKey(name: 'notifiable_type') this.notifiableType, @JsonKey(name: 'notifiable_id') this.notifiableId}): _data = data;
  factory _ClinicNotificationModel.fromJson(Map<String, dynamic> json) => _$ClinicNotificationModelFromJson(json);

@override final  int? id;
@override final  String? title;
@override final  String? body;
@override final  String? message;
@override final  String? type;
 final  Map<String, dynamic>? _data;
@override Map<String, dynamic>? get data {
  final value = _data;
  if (value == null) return null;
  if (_data is EqualUnmodifiableMapView) return _data;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

@override@JsonKey(name: 'is_read') final  bool isRead;
@override@JsonKey(name: 'read_at') final  String? readAt;
@override@JsonKey(name: 'sent_at') final  String? sentAt;
@override@JsonKey(name: 'created_at') final  String? createdAt;
@override@JsonKey(name: 'notifiable_type') final  String? notifiableType;
@override@JsonKey(name: 'notifiable_id') final  int? notifiableId;

/// Create a copy of ClinicNotificationModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ClinicNotificationModelCopyWith<_ClinicNotificationModel> get copyWith => __$ClinicNotificationModelCopyWithImpl<_ClinicNotificationModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ClinicNotificationModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ClinicNotificationModel&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.body, body) || other.body == body)&&(identical(other.message, message) || other.message == message)&&(identical(other.type, type) || other.type == type)&&const DeepCollectionEquality().equals(other._data, _data)&&(identical(other.isRead, isRead) || other.isRead == isRead)&&(identical(other.readAt, readAt) || other.readAt == readAt)&&(identical(other.sentAt, sentAt) || other.sentAt == sentAt)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.notifiableType, notifiableType) || other.notifiableType == notifiableType)&&(identical(other.notifiableId, notifiableId) || other.notifiableId == notifiableId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,body,message,type,const DeepCollectionEquality().hash(_data),isRead,readAt,sentAt,createdAt,notifiableType,notifiableId);

@override
String toString() {
  return 'ClinicNotificationModel(id: $id, title: $title, body: $body, message: $message, type: $type, data: $data, isRead: $isRead, readAt: $readAt, sentAt: $sentAt, createdAt: $createdAt, notifiableType: $notifiableType, notifiableId: $notifiableId)';
}


}

/// @nodoc
abstract mixin class _$ClinicNotificationModelCopyWith<$Res> implements $ClinicNotificationModelCopyWith<$Res> {
  factory _$ClinicNotificationModelCopyWith(_ClinicNotificationModel value, $Res Function(_ClinicNotificationModel) _then) = __$ClinicNotificationModelCopyWithImpl;
@override @useResult
$Res call({
 int? id, String? title, String? body, String? message, String? type, Map<String, dynamic>? data,@JsonKey(name: 'is_read') bool isRead,@JsonKey(name: 'read_at') String? readAt,@JsonKey(name: 'sent_at') String? sentAt,@JsonKey(name: 'created_at') String? createdAt,@JsonKey(name: 'notifiable_type') String? notifiableType,@JsonKey(name: 'notifiable_id') int? notifiableId
});




}
/// @nodoc
class __$ClinicNotificationModelCopyWithImpl<$Res>
    implements _$ClinicNotificationModelCopyWith<$Res> {
  __$ClinicNotificationModelCopyWithImpl(this._self, this._then);

  final _ClinicNotificationModel _self;
  final $Res Function(_ClinicNotificationModel) _then;

/// Create a copy of ClinicNotificationModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? title = freezed,Object? body = freezed,Object? message = freezed,Object? type = freezed,Object? data = freezed,Object? isRead = null,Object? readAt = freezed,Object? sentAt = freezed,Object? createdAt = freezed,Object? notifiableType = freezed,Object? notifiableId = freezed,}) {
  return _then(_ClinicNotificationModel(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,body: freezed == body ? _self.body : body // ignore: cast_nullable_to_non_nullable
as String?,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,type: freezed == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String?,data: freezed == data ? _self._data : data // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,isRead: null == isRead ? _self.isRead : isRead // ignore: cast_nullable_to_non_nullable
as bool,readAt: freezed == readAt ? _self.readAt : readAt // ignore: cast_nullable_to_non_nullable
as String?,sentAt: freezed == sentAt ? _self.sentAt : sentAt // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String?,notifiableType: freezed == notifiableType ? _self.notifiableType : notifiableType // ignore: cast_nullable_to_non_nullable
as String?,notifiableId: freezed == notifiableId ? _self.notifiableId : notifiableId // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}


/// @nodoc
mixin _$ClinicMarkAllNotificationsModel {

@JsonKey(name: 'marked_read_count') int get markedReadCount;@JsonKey(name: 'unread_count') int get unreadCount;
/// Create a copy of ClinicMarkAllNotificationsModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ClinicMarkAllNotificationsModelCopyWith<ClinicMarkAllNotificationsModel> get copyWith => _$ClinicMarkAllNotificationsModelCopyWithImpl<ClinicMarkAllNotificationsModel>(this as ClinicMarkAllNotificationsModel, _$identity);

  /// Serializes this ClinicMarkAllNotificationsModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ClinicMarkAllNotificationsModel&&(identical(other.markedReadCount, markedReadCount) || other.markedReadCount == markedReadCount)&&(identical(other.unreadCount, unreadCount) || other.unreadCount == unreadCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,markedReadCount,unreadCount);

@override
String toString() {
  return 'ClinicMarkAllNotificationsModel(markedReadCount: $markedReadCount, unreadCount: $unreadCount)';
}


}

/// @nodoc
abstract mixin class $ClinicMarkAllNotificationsModelCopyWith<$Res>  {
  factory $ClinicMarkAllNotificationsModelCopyWith(ClinicMarkAllNotificationsModel value, $Res Function(ClinicMarkAllNotificationsModel) _then) = _$ClinicMarkAllNotificationsModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'marked_read_count') int markedReadCount,@JsonKey(name: 'unread_count') int unreadCount
});




}
/// @nodoc
class _$ClinicMarkAllNotificationsModelCopyWithImpl<$Res>
    implements $ClinicMarkAllNotificationsModelCopyWith<$Res> {
  _$ClinicMarkAllNotificationsModelCopyWithImpl(this._self, this._then);

  final ClinicMarkAllNotificationsModel _self;
  final $Res Function(ClinicMarkAllNotificationsModel) _then;

/// Create a copy of ClinicMarkAllNotificationsModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? markedReadCount = null,Object? unreadCount = null,}) {
  return _then(_self.copyWith(
markedReadCount: null == markedReadCount ? _self.markedReadCount : markedReadCount // ignore: cast_nullable_to_non_nullable
as int,unreadCount: null == unreadCount ? _self.unreadCount : unreadCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [ClinicMarkAllNotificationsModel].
extension ClinicMarkAllNotificationsModelPatterns on ClinicMarkAllNotificationsModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ClinicMarkAllNotificationsModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ClinicMarkAllNotificationsModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ClinicMarkAllNotificationsModel value)  $default,){
final _that = this;
switch (_that) {
case _ClinicMarkAllNotificationsModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ClinicMarkAllNotificationsModel value)?  $default,){
final _that = this;
switch (_that) {
case _ClinicMarkAllNotificationsModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'marked_read_count')  int markedReadCount, @JsonKey(name: 'unread_count')  int unreadCount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ClinicMarkAllNotificationsModel() when $default != null:
return $default(_that.markedReadCount,_that.unreadCount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'marked_read_count')  int markedReadCount, @JsonKey(name: 'unread_count')  int unreadCount)  $default,) {final _that = this;
switch (_that) {
case _ClinicMarkAllNotificationsModel():
return $default(_that.markedReadCount,_that.unreadCount);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'marked_read_count')  int markedReadCount, @JsonKey(name: 'unread_count')  int unreadCount)?  $default,) {final _that = this;
switch (_that) {
case _ClinicMarkAllNotificationsModel() when $default != null:
return $default(_that.markedReadCount,_that.unreadCount);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ClinicMarkAllNotificationsModel implements ClinicMarkAllNotificationsModel {
  const _ClinicMarkAllNotificationsModel({@JsonKey(name: 'marked_read_count') this.markedReadCount = 0, @JsonKey(name: 'unread_count') this.unreadCount = 0});
  factory _ClinicMarkAllNotificationsModel.fromJson(Map<String, dynamic> json) => _$ClinicMarkAllNotificationsModelFromJson(json);

@override@JsonKey(name: 'marked_read_count') final  int markedReadCount;
@override@JsonKey(name: 'unread_count') final  int unreadCount;

/// Create a copy of ClinicMarkAllNotificationsModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ClinicMarkAllNotificationsModelCopyWith<_ClinicMarkAllNotificationsModel> get copyWith => __$ClinicMarkAllNotificationsModelCopyWithImpl<_ClinicMarkAllNotificationsModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ClinicMarkAllNotificationsModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ClinicMarkAllNotificationsModel&&(identical(other.markedReadCount, markedReadCount) || other.markedReadCount == markedReadCount)&&(identical(other.unreadCount, unreadCount) || other.unreadCount == unreadCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,markedReadCount,unreadCount);

@override
String toString() {
  return 'ClinicMarkAllNotificationsModel(markedReadCount: $markedReadCount, unreadCount: $unreadCount)';
}


}

/// @nodoc
abstract mixin class _$ClinicMarkAllNotificationsModelCopyWith<$Res> implements $ClinicMarkAllNotificationsModelCopyWith<$Res> {
  factory _$ClinicMarkAllNotificationsModelCopyWith(_ClinicMarkAllNotificationsModel value, $Res Function(_ClinicMarkAllNotificationsModel) _then) = __$ClinicMarkAllNotificationsModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'marked_read_count') int markedReadCount,@JsonKey(name: 'unread_count') int unreadCount
});




}
/// @nodoc
class __$ClinicMarkAllNotificationsModelCopyWithImpl<$Res>
    implements _$ClinicMarkAllNotificationsModelCopyWith<$Res> {
  __$ClinicMarkAllNotificationsModelCopyWithImpl(this._self, this._then);

  final _ClinicMarkAllNotificationsModel _self;
  final $Res Function(_ClinicMarkAllNotificationsModel) _then;

/// Create a copy of ClinicMarkAllNotificationsModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? markedReadCount = null,Object? unreadCount = null,}) {
  return _then(_ClinicMarkAllNotificationsModel(
markedReadCount: null == markedReadCount ? _self.markedReadCount : markedReadCount // ignore: cast_nullable_to_non_nullable
as int,unreadCount: null == unreadCount ? _self.unreadCount : unreadCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$ClinicUnreadCountModel {

@JsonKey(name: 'unread_count') int get unreadCount;
/// Create a copy of ClinicUnreadCountModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ClinicUnreadCountModelCopyWith<ClinicUnreadCountModel> get copyWith => _$ClinicUnreadCountModelCopyWithImpl<ClinicUnreadCountModel>(this as ClinicUnreadCountModel, _$identity);

  /// Serializes this ClinicUnreadCountModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ClinicUnreadCountModel&&(identical(other.unreadCount, unreadCount) || other.unreadCount == unreadCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,unreadCount);

@override
String toString() {
  return 'ClinicUnreadCountModel(unreadCount: $unreadCount)';
}


}

/// @nodoc
abstract mixin class $ClinicUnreadCountModelCopyWith<$Res>  {
  factory $ClinicUnreadCountModelCopyWith(ClinicUnreadCountModel value, $Res Function(ClinicUnreadCountModel) _then) = _$ClinicUnreadCountModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'unread_count') int unreadCount
});




}
/// @nodoc
class _$ClinicUnreadCountModelCopyWithImpl<$Res>
    implements $ClinicUnreadCountModelCopyWith<$Res> {
  _$ClinicUnreadCountModelCopyWithImpl(this._self, this._then);

  final ClinicUnreadCountModel _self;
  final $Res Function(ClinicUnreadCountModel) _then;

/// Create a copy of ClinicUnreadCountModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? unreadCount = null,}) {
  return _then(_self.copyWith(
unreadCount: null == unreadCount ? _self.unreadCount : unreadCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [ClinicUnreadCountModel].
extension ClinicUnreadCountModelPatterns on ClinicUnreadCountModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ClinicUnreadCountModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ClinicUnreadCountModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ClinicUnreadCountModel value)  $default,){
final _that = this;
switch (_that) {
case _ClinicUnreadCountModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ClinicUnreadCountModel value)?  $default,){
final _that = this;
switch (_that) {
case _ClinicUnreadCountModel() when $default != null:
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
case _ClinicUnreadCountModel() when $default != null:
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
case _ClinicUnreadCountModel():
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
case _ClinicUnreadCountModel() when $default != null:
return $default(_that.unreadCount);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ClinicUnreadCountModel implements ClinicUnreadCountModel {
  const _ClinicUnreadCountModel({@JsonKey(name: 'unread_count') this.unreadCount = 0});
  factory _ClinicUnreadCountModel.fromJson(Map<String, dynamic> json) => _$ClinicUnreadCountModelFromJson(json);

@override@JsonKey(name: 'unread_count') final  int unreadCount;

/// Create a copy of ClinicUnreadCountModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ClinicUnreadCountModelCopyWith<_ClinicUnreadCountModel> get copyWith => __$ClinicUnreadCountModelCopyWithImpl<_ClinicUnreadCountModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ClinicUnreadCountModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ClinicUnreadCountModel&&(identical(other.unreadCount, unreadCount) || other.unreadCount == unreadCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,unreadCount);

@override
String toString() {
  return 'ClinicUnreadCountModel(unreadCount: $unreadCount)';
}


}

/// @nodoc
abstract mixin class _$ClinicUnreadCountModelCopyWith<$Res> implements $ClinicUnreadCountModelCopyWith<$Res> {
  factory _$ClinicUnreadCountModelCopyWith(_ClinicUnreadCountModel value, $Res Function(_ClinicUnreadCountModel) _then) = __$ClinicUnreadCountModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'unread_count') int unreadCount
});




}
/// @nodoc
class __$ClinicUnreadCountModelCopyWithImpl<$Res>
    implements _$ClinicUnreadCountModelCopyWith<$Res> {
  __$ClinicUnreadCountModelCopyWithImpl(this._self, this._then);

  final _ClinicUnreadCountModel _self;
  final $Res Function(_ClinicUnreadCountModel) _then;

/// Create a copy of ClinicUnreadCountModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? unreadCount = null,}) {
  return _then(_ClinicUnreadCountModel(
unreadCount: null == unreadCount ? _self.unreadCount : unreadCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$ClinicNotificationDeletionModel {

 bool get deleted;
/// Create a copy of ClinicNotificationDeletionModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ClinicNotificationDeletionModelCopyWith<ClinicNotificationDeletionModel> get copyWith => _$ClinicNotificationDeletionModelCopyWithImpl<ClinicNotificationDeletionModel>(this as ClinicNotificationDeletionModel, _$identity);

  /// Serializes this ClinicNotificationDeletionModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ClinicNotificationDeletionModel&&(identical(other.deleted, deleted) || other.deleted == deleted));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,deleted);

@override
String toString() {
  return 'ClinicNotificationDeletionModel(deleted: $deleted)';
}


}

/// @nodoc
abstract mixin class $ClinicNotificationDeletionModelCopyWith<$Res>  {
  factory $ClinicNotificationDeletionModelCopyWith(ClinicNotificationDeletionModel value, $Res Function(ClinicNotificationDeletionModel) _then) = _$ClinicNotificationDeletionModelCopyWithImpl;
@useResult
$Res call({
 bool deleted
});




}
/// @nodoc
class _$ClinicNotificationDeletionModelCopyWithImpl<$Res>
    implements $ClinicNotificationDeletionModelCopyWith<$Res> {
  _$ClinicNotificationDeletionModelCopyWithImpl(this._self, this._then);

  final ClinicNotificationDeletionModel _self;
  final $Res Function(ClinicNotificationDeletionModel) _then;

/// Create a copy of ClinicNotificationDeletionModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? deleted = null,}) {
  return _then(_self.copyWith(
deleted: null == deleted ? _self.deleted : deleted // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [ClinicNotificationDeletionModel].
extension ClinicNotificationDeletionModelPatterns on ClinicNotificationDeletionModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ClinicNotificationDeletionModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ClinicNotificationDeletionModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ClinicNotificationDeletionModel value)  $default,){
final _that = this;
switch (_that) {
case _ClinicNotificationDeletionModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ClinicNotificationDeletionModel value)?  $default,){
final _that = this;
switch (_that) {
case _ClinicNotificationDeletionModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool deleted)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ClinicNotificationDeletionModel() when $default != null:
return $default(_that.deleted);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool deleted)  $default,) {final _that = this;
switch (_that) {
case _ClinicNotificationDeletionModel():
return $default(_that.deleted);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool deleted)?  $default,) {final _that = this;
switch (_that) {
case _ClinicNotificationDeletionModel() when $default != null:
return $default(_that.deleted);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ClinicNotificationDeletionModel implements ClinicNotificationDeletionModel {
  const _ClinicNotificationDeletionModel({this.deleted = false});
  factory _ClinicNotificationDeletionModel.fromJson(Map<String, dynamic> json) => _$ClinicNotificationDeletionModelFromJson(json);

@override@JsonKey() final  bool deleted;

/// Create a copy of ClinicNotificationDeletionModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ClinicNotificationDeletionModelCopyWith<_ClinicNotificationDeletionModel> get copyWith => __$ClinicNotificationDeletionModelCopyWithImpl<_ClinicNotificationDeletionModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ClinicNotificationDeletionModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ClinicNotificationDeletionModel&&(identical(other.deleted, deleted) || other.deleted == deleted));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,deleted);

@override
String toString() {
  return 'ClinicNotificationDeletionModel(deleted: $deleted)';
}


}

/// @nodoc
abstract mixin class _$ClinicNotificationDeletionModelCopyWith<$Res> implements $ClinicNotificationDeletionModelCopyWith<$Res> {
  factory _$ClinicNotificationDeletionModelCopyWith(_ClinicNotificationDeletionModel value, $Res Function(_ClinicNotificationDeletionModel) _then) = __$ClinicNotificationDeletionModelCopyWithImpl;
@override @useResult
$Res call({
 bool deleted
});




}
/// @nodoc
class __$ClinicNotificationDeletionModelCopyWithImpl<$Res>
    implements _$ClinicNotificationDeletionModelCopyWith<$Res> {
  __$ClinicNotificationDeletionModelCopyWithImpl(this._self, this._then);

  final _ClinicNotificationDeletionModel _self;
  final $Res Function(_ClinicNotificationDeletionModel) _then;

/// Create a copy of ClinicNotificationDeletionModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? deleted = null,}) {
  return _then(_ClinicNotificationDeletionModel(
deleted: null == deleted ? _self.deleted : deleted // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$ClinicNotificationsClearModel {

@JsonKey(name: 'deleted_count') int get deletedCount;@JsonKey(name: 'unread_count') int get unreadCount;
/// Create a copy of ClinicNotificationsClearModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ClinicNotificationsClearModelCopyWith<ClinicNotificationsClearModel> get copyWith => _$ClinicNotificationsClearModelCopyWithImpl<ClinicNotificationsClearModel>(this as ClinicNotificationsClearModel, _$identity);

  /// Serializes this ClinicNotificationsClearModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ClinicNotificationsClearModel&&(identical(other.deletedCount, deletedCount) || other.deletedCount == deletedCount)&&(identical(other.unreadCount, unreadCount) || other.unreadCount == unreadCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,deletedCount,unreadCount);

@override
String toString() {
  return 'ClinicNotificationsClearModel(deletedCount: $deletedCount, unreadCount: $unreadCount)';
}


}

/// @nodoc
abstract mixin class $ClinicNotificationsClearModelCopyWith<$Res>  {
  factory $ClinicNotificationsClearModelCopyWith(ClinicNotificationsClearModel value, $Res Function(ClinicNotificationsClearModel) _then) = _$ClinicNotificationsClearModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'deleted_count') int deletedCount,@JsonKey(name: 'unread_count') int unreadCount
});




}
/// @nodoc
class _$ClinicNotificationsClearModelCopyWithImpl<$Res>
    implements $ClinicNotificationsClearModelCopyWith<$Res> {
  _$ClinicNotificationsClearModelCopyWithImpl(this._self, this._then);

  final ClinicNotificationsClearModel _self;
  final $Res Function(ClinicNotificationsClearModel) _then;

/// Create a copy of ClinicNotificationsClearModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? deletedCount = null,Object? unreadCount = null,}) {
  return _then(_self.copyWith(
deletedCount: null == deletedCount ? _self.deletedCount : deletedCount // ignore: cast_nullable_to_non_nullable
as int,unreadCount: null == unreadCount ? _self.unreadCount : unreadCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [ClinicNotificationsClearModel].
extension ClinicNotificationsClearModelPatterns on ClinicNotificationsClearModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ClinicNotificationsClearModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ClinicNotificationsClearModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ClinicNotificationsClearModel value)  $default,){
final _that = this;
switch (_that) {
case _ClinicNotificationsClearModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ClinicNotificationsClearModel value)?  $default,){
final _that = this;
switch (_that) {
case _ClinicNotificationsClearModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'deleted_count')  int deletedCount, @JsonKey(name: 'unread_count')  int unreadCount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ClinicNotificationsClearModel() when $default != null:
return $default(_that.deletedCount,_that.unreadCount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'deleted_count')  int deletedCount, @JsonKey(name: 'unread_count')  int unreadCount)  $default,) {final _that = this;
switch (_that) {
case _ClinicNotificationsClearModel():
return $default(_that.deletedCount,_that.unreadCount);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'deleted_count')  int deletedCount, @JsonKey(name: 'unread_count')  int unreadCount)?  $default,) {final _that = this;
switch (_that) {
case _ClinicNotificationsClearModel() when $default != null:
return $default(_that.deletedCount,_that.unreadCount);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ClinicNotificationsClearModel implements ClinicNotificationsClearModel {
  const _ClinicNotificationsClearModel({@JsonKey(name: 'deleted_count') this.deletedCount = 0, @JsonKey(name: 'unread_count') this.unreadCount = 0});
  factory _ClinicNotificationsClearModel.fromJson(Map<String, dynamic> json) => _$ClinicNotificationsClearModelFromJson(json);

@override@JsonKey(name: 'deleted_count') final  int deletedCount;
@override@JsonKey(name: 'unread_count') final  int unreadCount;

/// Create a copy of ClinicNotificationsClearModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ClinicNotificationsClearModelCopyWith<_ClinicNotificationsClearModel> get copyWith => __$ClinicNotificationsClearModelCopyWithImpl<_ClinicNotificationsClearModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ClinicNotificationsClearModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ClinicNotificationsClearModel&&(identical(other.deletedCount, deletedCount) || other.deletedCount == deletedCount)&&(identical(other.unreadCount, unreadCount) || other.unreadCount == unreadCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,deletedCount,unreadCount);

@override
String toString() {
  return 'ClinicNotificationsClearModel(deletedCount: $deletedCount, unreadCount: $unreadCount)';
}


}

/// @nodoc
abstract mixin class _$ClinicNotificationsClearModelCopyWith<$Res> implements $ClinicNotificationsClearModelCopyWith<$Res> {
  factory _$ClinicNotificationsClearModelCopyWith(_ClinicNotificationsClearModel value, $Res Function(_ClinicNotificationsClearModel) _then) = __$ClinicNotificationsClearModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'deleted_count') int deletedCount,@JsonKey(name: 'unread_count') int unreadCount
});




}
/// @nodoc
class __$ClinicNotificationsClearModelCopyWithImpl<$Res>
    implements _$ClinicNotificationsClearModelCopyWith<$Res> {
  __$ClinicNotificationsClearModelCopyWithImpl(this._self, this._then);

  final _ClinicNotificationsClearModel _self;
  final $Res Function(_ClinicNotificationsClearModel) _then;

/// Create a copy of ClinicNotificationsClearModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? deletedCount = null,Object? unreadCount = null,}) {
  return _then(_ClinicNotificationsClearModel(
deletedCount: null == deletedCount ? _self.deletedCount : deletedCount // ignore: cast_nullable_to_non_nullable
as int,unreadCount: null == unreadCount ? _self.unreadCount : unreadCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$ClinicDeviceTokenModel {

 int? get id; String? get platform;@JsonKey(name: 'device_id') String? get deviceId;@JsonKey(name: 'app_version') String? get appVersion; String? get locale;@JsonKey(name: 'is_active') bool get isActive;@JsonKey(name: 'last_seen_at') String? get lastSeenAt;
/// Create a copy of ClinicDeviceTokenModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ClinicDeviceTokenModelCopyWith<ClinicDeviceTokenModel> get copyWith => _$ClinicDeviceTokenModelCopyWithImpl<ClinicDeviceTokenModel>(this as ClinicDeviceTokenModel, _$identity);

  /// Serializes this ClinicDeviceTokenModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ClinicDeviceTokenModel&&(identical(other.id, id) || other.id == id)&&(identical(other.platform, platform) || other.platform == platform)&&(identical(other.deviceId, deviceId) || other.deviceId == deviceId)&&(identical(other.appVersion, appVersion) || other.appVersion == appVersion)&&(identical(other.locale, locale) || other.locale == locale)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.lastSeenAt, lastSeenAt) || other.lastSeenAt == lastSeenAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,platform,deviceId,appVersion,locale,isActive,lastSeenAt);

@override
String toString() {
  return 'ClinicDeviceTokenModel(id: $id, platform: $platform, deviceId: $deviceId, appVersion: $appVersion, locale: $locale, isActive: $isActive, lastSeenAt: $lastSeenAt)';
}


}

/// @nodoc
abstract mixin class $ClinicDeviceTokenModelCopyWith<$Res>  {
  factory $ClinicDeviceTokenModelCopyWith(ClinicDeviceTokenModel value, $Res Function(ClinicDeviceTokenModel) _then) = _$ClinicDeviceTokenModelCopyWithImpl;
@useResult
$Res call({
 int? id, String? platform,@JsonKey(name: 'device_id') String? deviceId,@JsonKey(name: 'app_version') String? appVersion, String? locale,@JsonKey(name: 'is_active') bool isActive,@JsonKey(name: 'last_seen_at') String? lastSeenAt
});




}
/// @nodoc
class _$ClinicDeviceTokenModelCopyWithImpl<$Res>
    implements $ClinicDeviceTokenModelCopyWith<$Res> {
  _$ClinicDeviceTokenModelCopyWithImpl(this._self, this._then);

  final ClinicDeviceTokenModel _self;
  final $Res Function(ClinicDeviceTokenModel) _then;

/// Create a copy of ClinicDeviceTokenModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? platform = freezed,Object? deviceId = freezed,Object? appVersion = freezed,Object? locale = freezed,Object? isActive = null,Object? lastSeenAt = freezed,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,platform: freezed == platform ? _self.platform : platform // ignore: cast_nullable_to_non_nullable
as String?,deviceId: freezed == deviceId ? _self.deviceId : deviceId // ignore: cast_nullable_to_non_nullable
as String?,appVersion: freezed == appVersion ? _self.appVersion : appVersion // ignore: cast_nullable_to_non_nullable
as String?,locale: freezed == locale ? _self.locale : locale // ignore: cast_nullable_to_non_nullable
as String?,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,lastSeenAt: freezed == lastSeenAt ? _self.lastSeenAt : lastSeenAt // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ClinicDeviceTokenModel].
extension ClinicDeviceTokenModelPatterns on ClinicDeviceTokenModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ClinicDeviceTokenModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ClinicDeviceTokenModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ClinicDeviceTokenModel value)  $default,){
final _that = this;
switch (_that) {
case _ClinicDeviceTokenModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ClinicDeviceTokenModel value)?  $default,){
final _that = this;
switch (_that) {
case _ClinicDeviceTokenModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int? id,  String? platform, @JsonKey(name: 'device_id')  String? deviceId, @JsonKey(name: 'app_version')  String? appVersion,  String? locale, @JsonKey(name: 'is_active')  bool isActive, @JsonKey(name: 'last_seen_at')  String? lastSeenAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ClinicDeviceTokenModel() when $default != null:
return $default(_that.id,_that.platform,_that.deviceId,_that.appVersion,_that.locale,_that.isActive,_that.lastSeenAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int? id,  String? platform, @JsonKey(name: 'device_id')  String? deviceId, @JsonKey(name: 'app_version')  String? appVersion,  String? locale, @JsonKey(name: 'is_active')  bool isActive, @JsonKey(name: 'last_seen_at')  String? lastSeenAt)  $default,) {final _that = this;
switch (_that) {
case _ClinicDeviceTokenModel():
return $default(_that.id,_that.platform,_that.deviceId,_that.appVersion,_that.locale,_that.isActive,_that.lastSeenAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int? id,  String? platform, @JsonKey(name: 'device_id')  String? deviceId, @JsonKey(name: 'app_version')  String? appVersion,  String? locale, @JsonKey(name: 'is_active')  bool isActive, @JsonKey(name: 'last_seen_at')  String? lastSeenAt)?  $default,) {final _that = this;
switch (_that) {
case _ClinicDeviceTokenModel() when $default != null:
return $default(_that.id,_that.platform,_that.deviceId,_that.appVersion,_that.locale,_that.isActive,_that.lastSeenAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ClinicDeviceTokenModel implements ClinicDeviceTokenModel {
  const _ClinicDeviceTokenModel({this.id, this.platform, @JsonKey(name: 'device_id') this.deviceId, @JsonKey(name: 'app_version') this.appVersion, this.locale, @JsonKey(name: 'is_active') this.isActive = false, @JsonKey(name: 'last_seen_at') this.lastSeenAt});
  factory _ClinicDeviceTokenModel.fromJson(Map<String, dynamic> json) => _$ClinicDeviceTokenModelFromJson(json);

@override final  int? id;
@override final  String? platform;
@override@JsonKey(name: 'device_id') final  String? deviceId;
@override@JsonKey(name: 'app_version') final  String? appVersion;
@override final  String? locale;
@override@JsonKey(name: 'is_active') final  bool isActive;
@override@JsonKey(name: 'last_seen_at') final  String? lastSeenAt;

/// Create a copy of ClinicDeviceTokenModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ClinicDeviceTokenModelCopyWith<_ClinicDeviceTokenModel> get copyWith => __$ClinicDeviceTokenModelCopyWithImpl<_ClinicDeviceTokenModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ClinicDeviceTokenModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ClinicDeviceTokenModel&&(identical(other.id, id) || other.id == id)&&(identical(other.platform, platform) || other.platform == platform)&&(identical(other.deviceId, deviceId) || other.deviceId == deviceId)&&(identical(other.appVersion, appVersion) || other.appVersion == appVersion)&&(identical(other.locale, locale) || other.locale == locale)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.lastSeenAt, lastSeenAt) || other.lastSeenAt == lastSeenAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,platform,deviceId,appVersion,locale,isActive,lastSeenAt);

@override
String toString() {
  return 'ClinicDeviceTokenModel(id: $id, platform: $platform, deviceId: $deviceId, appVersion: $appVersion, locale: $locale, isActive: $isActive, lastSeenAt: $lastSeenAt)';
}


}

/// @nodoc
abstract mixin class _$ClinicDeviceTokenModelCopyWith<$Res> implements $ClinicDeviceTokenModelCopyWith<$Res> {
  factory _$ClinicDeviceTokenModelCopyWith(_ClinicDeviceTokenModel value, $Res Function(_ClinicDeviceTokenModel) _then) = __$ClinicDeviceTokenModelCopyWithImpl;
@override @useResult
$Res call({
 int? id, String? platform,@JsonKey(name: 'device_id') String? deviceId,@JsonKey(name: 'app_version') String? appVersion, String? locale,@JsonKey(name: 'is_active') bool isActive,@JsonKey(name: 'last_seen_at') String? lastSeenAt
});




}
/// @nodoc
class __$ClinicDeviceTokenModelCopyWithImpl<$Res>
    implements _$ClinicDeviceTokenModelCopyWith<$Res> {
  __$ClinicDeviceTokenModelCopyWithImpl(this._self, this._then);

  final _ClinicDeviceTokenModel _self;
  final $Res Function(_ClinicDeviceTokenModel) _then;

/// Create a copy of ClinicDeviceTokenModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? platform = freezed,Object? deviceId = freezed,Object? appVersion = freezed,Object? locale = freezed,Object? isActive = null,Object? lastSeenAt = freezed,}) {
  return _then(_ClinicDeviceTokenModel(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,platform: freezed == platform ? _self.platform : platform // ignore: cast_nullable_to_non_nullable
as String?,deviceId: freezed == deviceId ? _self.deviceId : deviceId // ignore: cast_nullable_to_non_nullable
as String?,appVersion: freezed == appVersion ? _self.appVersion : appVersion // ignore: cast_nullable_to_non_nullable
as String?,locale: freezed == locale ? _self.locale : locale // ignore: cast_nullable_to_non_nullable
as String?,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,lastSeenAt: freezed == lastSeenAt ? _self.lastSeenAt : lastSeenAt // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
