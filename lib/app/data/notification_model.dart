import 'package:flutter/material.dart';

enum NotificationType { appointment, labResult, payment, message }

enum NotificationStatus { unread, read }

class NotificationModel {
  final String id;
  final String title;
  final String body;
  final NotificationType type;
  final NotificationStatus status;
  final DateTime createdAt;
  final String? relatedId;

  const NotificationModel({
    required this.id,
    required this.title,
    required this.body,
    required this.type,
    required this.status,
    required this.createdAt,
    this.relatedId,
  });

  bool get isToday {
    final now = DateTime.now();
    return createdAt.year == now.year &&
        createdAt.month == now.month &&
        createdAt.day == now.day;
  }

  bool get isYesterday {
    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    return createdAt.year == yesterday.year &&
        createdAt.month == yesterday.month &&
        createdAt.day == yesterday.day;
  }

  String get formattedDate {
    if (isToday) return 'اليوم';
    if (isYesterday) return 'البارحة';
    return '${createdAt.day}/${createdAt.month}/${createdAt.year}';
  }

  String get formattedTime =>
      '${createdAt.hour}:${createdAt.minute.toString().padLeft(2, '0')}';

  NotificationModel copyWith({
    String? id,
    String? title,
    String? body,
    NotificationType? type,
    NotificationStatus? status,
    DateTime? createdAt,
    String? relatedId,
  }) =>
      NotificationModel(
        id: id ?? this.id,
        title: title ?? this.title,
        body: body ?? this.body,
        type: type ?? this.type,
        status: status ?? this.status,
        createdAt: createdAt ?? this.createdAt,
        relatedId: relatedId ?? this.relatedId,
      );
}

// ── UI extensions (type → icon / color) ──────────────────────────────────────

extension NotificationTypeX on NotificationType {
  IconData get icon => switch (this) {
    NotificationType.appointment => Icons.event_note_rounded,
    NotificationType.labResult   => Icons.science_rounded,
    NotificationType.payment     => Icons.payments_rounded,
    NotificationType.message     => Icons.message_rounded,
  };

  Color get color => switch (this) {
    NotificationType.appointment => const Color(0xFF009688),
    NotificationType.labResult   => const Color(0xFF8B5CF6),
    NotificationType.payment     => const Color(0xFF10B981),
    NotificationType.message     => const Color(0xFF3B82F6),
  };
}
