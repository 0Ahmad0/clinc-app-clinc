enum NotificationType {
  appointment,
  labResult,
  payment,
  message,
}

enum NotificationStatus {
  unread,
  read,
}

class NotificationModel {
  final String id;
  final String title;
  final String body;
  final NotificationType type;
  final NotificationStatus status;
  final DateTime createdAt;
  final String? relatedId; // ID للموعد أو الفاتورة المرتبطة

  NotificationModel({
    required this.id,
    required this.title,
    required this.body,
    required this.type,
    required this.status,
    required this.createdAt,
    this.relatedId,
  });

  // للتحقق إذا كان الإشعار اليوم
  bool get isToday {
    final now = DateTime.now();
    return createdAt.year == now.year &&
        createdAt.month == now.month &&
        createdAt.day == now.day;
  }

  // للتحقق إذا كان الإشعار البارحة
  bool get isYesterday {
    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    return createdAt.year == yesterday.year &&
        createdAt.month == yesterday.month &&
        createdAt.day == yesterday.day;
  }

  // للحصول على التاريخ المنسق
  String get formattedDate {
    if (isToday) return 'اليوم';
    if (isYesterday) return 'البارحة';
    return '${createdAt.day}/${createdAt.month}/${createdAt.year}';
  }

  // للحصول على الوقت المنسق
  String get formattedTime {
    return '${createdAt.hour}:${createdAt.minute.toString().padLeft(2, '0')}';
  }
}