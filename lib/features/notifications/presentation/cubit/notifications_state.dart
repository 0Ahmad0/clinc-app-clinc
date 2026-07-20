import 'package:equatable/equatable.dart';

import '../../domain/app_notification.dart';
import '../../domain/notification_tab.dart';

class NotificationsState extends Equatable {
  const NotificationsState({
    this.tab = NotificationTab.all,
    this.readIds = const {},
    this.removedIds = const {},
  });

  final NotificationTab tab;
  final Set<int> readIds;
  final Set<int> removedIds;

  bool isRemoved(int id) => removedIds.contains(id);

  /// Live unread flag: seeded unread and not yet opened or marked read.
  bool isUnread(AppNotification notification) =>
      notification.unread && !readIds.contains(notification.id);

  NotificationsState copyWith({
    NotificationTab? tab,
    Set<int>? readIds,
    Set<int>? removedIds,
  }) => NotificationsState(
    tab: tab ?? this.tab,
    readIds: readIds ?? this.readIds,
    removedIds: removedIds ?? this.removedIds,
  );

  @override
  List<Object?> get props => [tab, readIds, removedIds];
}
