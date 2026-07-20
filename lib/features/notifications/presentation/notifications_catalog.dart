import '../../../l10n/app_localizations.dart';
import '../domain/app_notification.dart';
import '../domain/notification_kind.dart';

/// Sample notifications shown on the screen. Mirrors the doctors catalog: all
/// display copy comes from l10n so both locales render correctly.
List<AppNotification> localizedNotifications(AppLocalizations l10n) => [
  AppNotification(
    id: 1,
    kind: NotificationKind.appointment,
    title: l10n.notif1Title,
    body: l10n.notif1Body,
    time: '9:52',
    group: l10n.notifToday,
    unread: true,
  ),
  AppNotification(
    id: 2,
    kind: NotificationKind.lab,
    title: l10n.notif2Title,
    body: l10n.notif2Body,
    time: '8:22',
    group: l10n.notifToday,
    unread: true,
  ),
  AppNotification(
    id: 3,
    kind: NotificationKind.payment,
    title: l10n.notif3Title,
    body: l10n.notif3Body,
    time: '10:22',
    group: l10n.notifYesterday,
    unread: false,
  ),
  AppNotification(
    id: 4,
    kind: NotificationKind.message,
    title: l10n.notif4Title,
    body: l10n.notif4Body,
    time: '10:22',
    group: l10n.notifSampleDate,
    unread: true,
  ),
  AppNotification(
    id: 5,
    kind: NotificationKind.appointment,
    title: l10n.notif5Title,
    body: l10n.notif5Body,
    time: '9:05',
    group: l10n.notifSampleDate,
    unread: false,
  ),
];
