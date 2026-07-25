import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/notification_kind.dart';

part 'clinic_notification_model.freezed.dart';
part 'clinic_notification_model.g.dart';

@freezed
abstract class ClinicNotificationModel with _$ClinicNotificationModel {
  const factory ClinicNotificationModel({
    int? id,
    String? title,
    String? body,
    String? message,
    String? type,
    Map<String, dynamic>? data,
    @JsonKey(name: 'is_read') @Default(false) bool isRead,
    @JsonKey(name: 'read_at') String? readAt,
    @JsonKey(name: 'sent_at') String? sentAt,
    @JsonKey(name: 'created_at') String? createdAt,
    @JsonKey(name: 'notifiable_type') String? notifiableType,
    @JsonKey(name: 'notifiable_id') int? notifiableId,
  }) = _ClinicNotificationModel;

  factory ClinicNotificationModel.fromJson(Map<String, dynamic> json) =>
      _$ClinicNotificationModelFromJson(json);
}

@freezed
abstract class ClinicMarkAllNotificationsModel
    with _$ClinicMarkAllNotificationsModel {
  const factory ClinicMarkAllNotificationsModel({
    @JsonKey(name: 'marked_read_count') @Default(0) int markedReadCount,
    @JsonKey(name: 'unread_count') @Default(0) int unreadCount,
  }) = _ClinicMarkAllNotificationsModel;

  factory ClinicMarkAllNotificationsModel.fromJson(Map<String, dynamic> json) =>
      _$ClinicMarkAllNotificationsModelFromJson(json);
}

@freezed
abstract class ClinicUnreadCountModel with _$ClinicUnreadCountModel {
  const factory ClinicUnreadCountModel({
    @JsonKey(name: 'unread_count') @Default(0) int unreadCount,
  }) = _ClinicUnreadCountModel;

  factory ClinicUnreadCountModel.fromJson(Map<String, dynamic> json) =>
      _$ClinicUnreadCountModelFromJson(json);
}

@freezed
abstract class ClinicNotificationDeletionModel
    with _$ClinicNotificationDeletionModel {
  const factory ClinicNotificationDeletionModel({
    @Default(false) bool deleted,
  }) = _ClinicNotificationDeletionModel;

  factory ClinicNotificationDeletionModel.fromJson(Map<String, dynamic> json) =>
      _$ClinicNotificationDeletionModelFromJson(json);
}

@freezed
abstract class ClinicNotificationsClearModel
    with _$ClinicNotificationsClearModel {
  const factory ClinicNotificationsClearModel({
    @JsonKey(name: 'deleted_count') @Default(0) int deletedCount,
    @JsonKey(name: 'unread_count') @Default(0) int unreadCount,
  }) = _ClinicNotificationsClearModel;

  factory ClinicNotificationsClearModel.fromJson(Map<String, dynamic> json) =>
      _$ClinicNotificationsClearModelFromJson(json);
}

@freezed
abstract class ClinicDeviceTokenModel with _$ClinicDeviceTokenModel {
  const factory ClinicDeviceTokenModel({
    int? id,
    String? platform,
    @JsonKey(name: 'device_id') String? deviceId,
    @JsonKey(name: 'app_version') String? appVersion,
    String? locale,
    @JsonKey(name: 'is_active') @Default(false) bool isActive,
    @JsonKey(name: 'last_seen_at') String? lastSeenAt,
  }) = _ClinicDeviceTokenModel;

  factory ClinicDeviceTokenModel.fromJson(Map<String, dynamic> json) =>
      _$ClinicDeviceTokenModelFromJson(json);
}

extension ClinicNotificationModelX on ClinicNotificationModel {
  bool get unread => !isRead;

  String get displayTitle => title ?? '';

  String get displayBody => body ?? message ?? '';

  String get displayTime => (sentAt ?? createdAt ?? '').split('T').first;

  String get group => displayTime.isEmpty ? '-' : displayTime;

  NotificationKind get kind {
    final value = (type ?? '').toLowerCase();
    if (value.contains('lab')) return NotificationKind.lab;
    if (value.contains('payment')) return NotificationKind.payment;
    if (value.contains('appointment')) return NotificationKind.appointment;
    return NotificationKind.message;
  }
}
