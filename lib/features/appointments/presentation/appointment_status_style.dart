import 'package:flutter/widgets.dart';

import '../../../config/theme/app_colors.dart';
import '../../../l10n/app_localizations.dart';
import '../domain/appointment_status.dart';
import '../domain/appointment_tab.dart';

/// Localized label and accent color per [AppointmentStatus]. The status color
/// tints the avatar, the status chip and the card's leading border.
extension AppointmentStatusStyle on AppointmentStatus {
  String label(AppLocalizations l10n) => switch (this) {
    AppointmentStatus.pending => l10n.apptStatusPending,
    AppointmentStatus.confirmed => l10n.apptStatusConfirmed,
    AppointmentStatus.done => l10n.apptStatusDone,
    AppointmentStatus.rejected => l10n.apptStatusRejected,
  };

  Color accent(AppColorsTheme colors) => switch (this) {
    AppointmentStatus.pending => colors.warningFg,
    AppointmentStatus.confirmed => colors.primary600,
    AppointmentStatus.done => colors.successFg,
    AppointmentStatus.rejected => colors.dangerFg,
  };
}

/// Localized label per filter tab.
extension AppointmentTabLabel on AppointmentTab {
  String label(AppLocalizations l10n) => switch (this) {
    AppointmentTab.all => l10n.apptTabAll,
    AppointmentTab.pending => l10n.apptTabPending,
    AppointmentTab.confirmed => l10n.apptTabConfirmed,
    AppointmentTab.done => l10n.apptTabDone,
    AppointmentTab.rejected => l10n.apptTabRejected,
  };
}
