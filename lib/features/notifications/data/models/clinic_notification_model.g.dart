// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'clinic_notification_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ClinicNotificationModel _$ClinicNotificationModelFromJson(
  Map<String, dynamic> json,
) => _ClinicNotificationModel(
  id: (json['id'] as num?)?.toInt(),
  title: json['title'] as String?,
  body: json['body'] as String?,
  message: json['message'] as String?,
  type: json['type'] as String?,
  data: json['data'] as Map<String, dynamic>?,
  isRead: json['is_read'] as bool? ?? false,
  readAt: json['read_at'] as String?,
  sentAt: json['sent_at'] as String?,
  createdAt: json['created_at'] as String?,
  notifiableType: json['notifiable_type'] as String?,
  notifiableId: (json['notifiable_id'] as num?)?.toInt(),
);

Map<String, dynamic> _$ClinicNotificationModelToJson(
  _ClinicNotificationModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'body': instance.body,
  'message': instance.message,
  'type': instance.type,
  'data': instance.data,
  'is_read': instance.isRead,
  'read_at': instance.readAt,
  'sent_at': instance.sentAt,
  'created_at': instance.createdAt,
  'notifiable_type': instance.notifiableType,
  'notifiable_id': instance.notifiableId,
};

_ClinicMarkAllNotificationsModel _$ClinicMarkAllNotificationsModelFromJson(
  Map<String, dynamic> json,
) => _ClinicMarkAllNotificationsModel(
  markedReadCount: (json['marked_read_count'] as num?)?.toInt() ?? 0,
  unreadCount: (json['unread_count'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$ClinicMarkAllNotificationsModelToJson(
  _ClinicMarkAllNotificationsModel instance,
) => <String, dynamic>{
  'marked_read_count': instance.markedReadCount,
  'unread_count': instance.unreadCount,
};

_ClinicUnreadCountModel _$ClinicUnreadCountModelFromJson(
  Map<String, dynamic> json,
) => _ClinicUnreadCountModel(
  unreadCount: (json['unread_count'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$ClinicUnreadCountModelToJson(
  _ClinicUnreadCountModel instance,
) => <String, dynamic>{'unread_count': instance.unreadCount};

_ClinicNotificationDeletionModel _$ClinicNotificationDeletionModelFromJson(
  Map<String, dynamic> json,
) => _ClinicNotificationDeletionModel(
  deleted: json['deleted'] as bool? ?? false,
);

Map<String, dynamic> _$ClinicNotificationDeletionModelToJson(
  _ClinicNotificationDeletionModel instance,
) => <String, dynamic>{'deleted': instance.deleted};

_ClinicNotificationsClearModel _$ClinicNotificationsClearModelFromJson(
  Map<String, dynamic> json,
) => _ClinicNotificationsClearModel(
  deletedCount: (json['deleted_count'] as num?)?.toInt() ?? 0,
  unreadCount: (json['unread_count'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$ClinicNotificationsClearModelToJson(
  _ClinicNotificationsClearModel instance,
) => <String, dynamic>{
  'deleted_count': instance.deletedCount,
  'unread_count': instance.unreadCount,
};

_ClinicDeviceTokenModel _$ClinicDeviceTokenModelFromJson(
  Map<String, dynamic> json,
) => _ClinicDeviceTokenModel(
  id: (json['id'] as num?)?.toInt(),
  platform: json['platform'] as String?,
  deviceId: json['device_id'] as String?,
  appVersion: json['app_version'] as String?,
  locale: json['locale'] as String?,
  isActive: json['is_active'] as bool? ?? false,
  lastSeenAt: json['last_seen_at'] as String?,
);

Map<String, dynamic> _$ClinicDeviceTokenModelToJson(
  _ClinicDeviceTokenModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'platform': instance.platform,
  'device_id': instance.deviceId,
  'app_version': instance.appVersion,
  'locale': instance.locale,
  'is_active': instance.isActive,
  'last_seen_at': instance.lastSeenAt,
};
