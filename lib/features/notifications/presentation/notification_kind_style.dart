import 'package:flutter/widgets.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../../../config/theme/app_colors.dart';
import '../domain/notification_kind.dart';

/// Icon and accent color per [NotificationKind] — kept in one place so the card
/// and its badge stay in sync.
extension NotificationKindStyle on NotificationKind {
  IconData get icon => switch (this) {
    NotificationKind.appointment => Iconsax.calendar_1,
    NotificationKind.lab => Iconsax.health,
    NotificationKind.payment => Iconsax.card,
    NotificationKind.message => Iconsax.message,
  };

  Color accent(AppColorsTheme colors) => switch (this) {
    NotificationKind.appointment => colors.primary600,
    NotificationKind.lab => colors.purple,
    NotificationKind.payment => colors.successFg,
    NotificationKind.message => colors.info,
  };
}
