import '../../../l10n/app_localizations.dart';
import '../domain/report_breakdown.dart';
import '../domain/report_period.dart';

/// A labelled chart bar: its axis label and its done/pending/cancelled tally.
typedef ReportBar = (String label, ReportBreakdown breakdown);

/// A saved report row: its issue date (LTR) and its tally.
typedef ReportEntry = (String date, ReportBreakdown breakdown);

/// Chart data for the selected period. Numbers are illustrative until a live
/// analytics endpoint exists; only the labels are localized.
List<ReportBar> reportChart(AppLocalizations l10n, ReportPeriod period) =>
    switch (period) {
      ReportPeriod.week => [
        (l10n.reportsDaySat, const ReportBreakdown(done: 6, pending: 3, cancelled: 2)),
        (l10n.reportsDaySun, const ReportBreakdown(done: 4, pending: 3, cancelled: 1)),
        (l10n.reportsDayMon, const ReportBreakdown(done: 6, pending: 2, cancelled: 0)),
        (l10n.reportsDayTue, const ReportBreakdown(done: 5, pending: 4, cancelled: 2)),
        (l10n.reportsDayWed, const ReportBreakdown(done: 8, pending: 1, cancelled: 2)),
        (l10n.reportsDayThu, const ReportBreakdown(done: 3, pending: 5, cancelled: 2)),
        (l10n.reportsDayFri, const ReportBreakdown(done: 0, pending: 0, cancelled: 0)),
      ],
      ReportPeriod.month => [
        (l10n.reportsWeek1, const ReportBreakdown(done: 18, pending: 6, cancelled: 3)),
        (l10n.reportsWeek2, const ReportBreakdown(done: 22, pending: 8, cancelled: 4)),
        (l10n.reportsWeek3, const ReportBreakdown(done: 16, pending: 5, cancelled: 2)),
        (l10n.reportsWeek4, const ReportBreakdown(done: 25, pending: 7, cancelled: 5)),
      ],
    };

/// The saved reports shown in the list.
List<ReportEntry> reportEntries(AppLocalizations l10n) => [
  (l10n.report1Date, const ReportBreakdown(done: 20, pending: 8, cancelled: 4)),
  (l10n.report2Date, const ReportBreakdown(done: 18, pending: 6, cancelled: 4)),
  (l10n.report3Date, const ReportBreakdown(done: 16, pending: 5, cancelled: 4)),
];
