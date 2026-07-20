import 'package:equatable/equatable.dart';

import 'report_outcome.dart';

/// A done/pending/cancelled tally — the shared shape behind a chart bar, a
/// report row and the period totals.
class ReportBreakdown extends Equatable {
  const ReportBreakdown({
    required this.done,
    required this.pending,
    required this.cancelled,
  });

  final int done;
  final int pending;
  final int cancelled;

  int get total => done + pending + cancelled;

  int count(ReportOutcome outcome) => switch (outcome) {
    ReportOutcome.done => done,
    ReportOutcome.pending => pending,
    ReportOutcome.cancelled => cancelled,
  };

  ReportBreakdown operator +(ReportBreakdown other) => ReportBreakdown(
    done: done + other.done,
    pending: pending + other.pending,
    cancelled: cancelled + other.cancelled,
  );

  static const zero = ReportBreakdown(done: 0, pending: 0, cancelled: 0);

  @override
  List<Object> get props => [done, pending, cancelled];
}
