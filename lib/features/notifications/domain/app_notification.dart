import 'package:equatable/equatable.dart';

import 'notification_kind.dart';

/// A single notification row. Display strings are already localized by the
/// catalog; [unread] is the seed value — the live read/unread flag lives in the
/// cubit so the list can be rebuilt from l10n on locale change.
class AppNotification extends Equatable {
  const AppNotification({
    required this.id,
    required this.kind,
    required this.title,
    required this.body,
    required this.time,
    required this.group,
    required this.unread,
  });

  final int id;
  final NotificationKind kind;
  final String title;
  final String body;
  final String time;
  final String group;
  final bool unread;

  @override
  List<Object?> get props => [id, kind, title, body, time, group, unread];
}
