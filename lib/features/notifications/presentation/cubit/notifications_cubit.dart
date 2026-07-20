import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/app_notification.dart';
import '../../domain/notification_tab.dart';
import 'notifications_state.dart';

class NotificationsCubit extends Cubit<NotificationsState> {
  NotificationsCubit() : super(const NotificationsState());

  void selectTab(NotificationTab tab) => emit(state.copyWith(tab: tab));

  void open(int id) => emit(state.copyWith(readIds: {...state.readIds, id}));

  void markAllRead(Iterable<int> ids) =>
      emit(state.copyWith(readIds: {...state.readIds, ...ids}));

  void clearAll(Iterable<int> ids) =>
      emit(state.copyWith(removedIds: {...state.removedIds, ...ids}));

  /// Notifications the user has not cleared, in catalog order.
  List<AppNotification> active(List<AppNotification> all) =>
      all.where((n) => !state.isRemoved(n.id)).toList(growable: false);

  int unreadCount(List<AppNotification> all) =>
      active(all).where(state.isUnread).length;

  /// Notifications matching the selected tab.
  List<AppNotification> visible(List<AppNotification> all) => active(all)
      .where(
        (n) => switch (state.tab) {
          NotificationTab.all => true,
          NotificationTab.unread => state.isUnread(n),
          NotificationTab.read => !state.isUnread(n),
        },
      )
      .toList(growable: false);

  /// Visible notifications bucketed by their date label, in catalog order.
  List<({String label, List<AppNotification> items})> grouped(
    List<AppNotification> all,
  ) {
    final items = visible(all);
    final labels = <String>[];
    for (final n in items) {
      if (!labels.contains(n.group)) labels.add(n.group);
    }
    return [
      for (final label in labels)
        (
          label: label,
          items: items
              .where((n) => n.group == label)
              .toList(growable: false),
        ),
    ];
  }
}
