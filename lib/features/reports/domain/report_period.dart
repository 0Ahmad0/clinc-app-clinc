/// The time window a report covers.
enum ReportPeriod { week, month }

extension ReportPeriodBackend on ReportPeriod {
  String get backendValue => switch (this) {
    ReportPeriod.week => 'week',
    ReportPeriod.month => 'month',
  };
}
