import 'package:flutter/widgets.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../../../config/theme/app_colors.dart';
import '../../../l10n/app_localizations.dart';
import '../domain/report_outcome.dart';
import '../domain/report_period.dart';
import '../domain/report_type.dart';

extension ReportPeriodL10n on ReportPeriod {
  String label(AppLocalizations l10n) => switch (this) {
    ReportPeriod.week => l10n.reportsPeriodWeek,
    ReportPeriod.month => l10n.reportsPeriodMonth,
  };

  IconData get icon => switch (this) {
    ReportPeriod.week => Iconsax.chart_21,
    ReportPeriod.month => Iconsax.calendar_1,
  };

  String chartTitle(AppLocalizations l10n) => switch (this) {
    ReportPeriod.week => l10n.reportsChartTitleWeek,
    ReportPeriod.month => l10n.reportsChartTitleMonth,
  };

  String chartSub(AppLocalizations l10n) => switch (this) {
    ReportPeriod.week => l10n.reportsChartSubWeek,
    ReportPeriod.month => l10n.reportsChartSubMonth,
  };
}

extension ReportTypeL10n on ReportType {
  String label(AppLocalizations l10n) => switch (this) {
    ReportType.appointments => l10n.reportsTypeAppointments,
    ReportType.clinic => _localized(l10n, ar: 'العيادة', en: 'Clinic'),
    ReportType.revenue => l10n.reportsTypeRevenue,
    ReportType.doctors => _localized(l10n, ar: 'الأطباء', en: 'Doctors'),
  };

  IconData get icon => switch (this) {
    ReportType.appointments => Iconsax.calendar,
    ReportType.clinic => Iconsax.hospital,
    ReportType.revenue => Iconsax.trend_up,
    ReportType.doctors => Iconsax.profile_2user,
  };
}

String _localized(
  AppLocalizations l10n, {
  required String ar,
  required String en,
}) => l10n.localeName.startsWith('ar') ? ar : en;

/// Label, glyph and colors for each outcome. `barColor` tints bars/dots/tints;
/// `textColor` is the readable foreground for numbers and icons.
extension ReportOutcomeL10n on ReportOutcome {
  /// Long form used on stat cards and per-report counts (e.g. "قيد المراجعة").
  String label(AppLocalizations l10n) => switch (this) {
    ReportOutcome.done => l10n.reportsOutcomeDone,
    ReportOutcome.pending => l10n.reportsOutcomePendingLong,
    ReportOutcome.cancelled => l10n.reportsOutcomeCancelled,
  };

  /// Short form used on the chart legend and header pill (e.g. "قيد").
  String shortLabel(AppLocalizations l10n) => switch (this) {
    ReportOutcome.done => l10n.reportsOutcomeDone,
    ReportOutcome.pending => l10n.reportsOutcomePending,
    ReportOutcome.cancelled => l10n.reportsOutcomeCancelled,
  };

  IconData get icon => switch (this) {
    ReportOutcome.done => Iconsax.tick_circle,
    ReportOutcome.pending => Iconsax.clock,
    ReportOutcome.cancelled => Iconsax.close_circle,
  };

  Color barColor(AppColorsTheme colors) => switch (this) {
    ReportOutcome.done => colors.success,
    ReportOutcome.pending => colors.warning,
    ReportOutcome.cancelled => colors.danger,
  };

  Color textColor(AppColorsTheme colors) => switch (this) {
    ReportOutcome.done => colors.successFg,
    ReportOutcome.pending => colors.warningFg,
    ReportOutcome.cancelled => colors.dangerFg,
  };
}
