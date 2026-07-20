import 'package:flutter/widgets.dart';

import '../../../config/theme/app_colors.dart';
import '../../../l10n/app_localizations.dart';
import '../domain/appointment_kind.dart';

/// Accent color for the service chip and the finish label per [AppointmentKind]
/// (lab appointments finish by uploading a result file).
extension AppointmentKindStyle on AppointmentKind {
  Color accent(AppColorsTheme colors) => switch (this) {
    AppointmentKind.lab => colors.purple,
    AppointmentKind.clinic => colors.primary600,
    AppointmentKind.ray => colors.teal,
  };

  bool get requiresResult => this == AppointmentKind.lab;

  String finishLabel(AppLocalizations l10n) =>
      requiresResult ? l10n.apptFinishLab : l10n.apptFinish;
}
