enum ReportType { appointments, revenue, labResults, doctors }
enum ReportRange { today, week, month, custom }

extension ReportTypeX on ReportType {
  String key() {
    switch (this) {
      case ReportType.appointments:
        return 'reports.types.appointments';
      case ReportType.revenue:
        return 'reports.types.revenue';
      case ReportType.labResults:
        return 'reports.types.lab_results';
      case ReportType.doctors:
        return 'reports.types.doctors';
    }
  }
}

extension ReportRangeX on ReportRange {
  String key() {
    switch (this) {
      case ReportRange.today:
        return 'reports.filters.today';
      case ReportRange.week:
        return 'reports.filters.week';
      case ReportRange.month:
        return 'reports.filters.month';
      case ReportRange.custom:
        return 'reports.filters.custom';
    }
  }
}

class ReportModel {
  final String id;
  final ReportType type;
  final DateTime generatedAt;

  final int total;
  final int completed;
  final int pending;
  final int cancelled;

  final String? pdfPathOrUrl;

  final double? totalRevenue;

  const ReportModel({
    required this.id,
    required this.type,
    required this.generatedAt,
    required this.total,
    required this.completed,
    required this.pending,
    required this.cancelled,
    this.pdfPathOrUrl,
    this.totalRevenue,
  });

  bool get hasPdf => (pdfPathOrUrl ?? '').isNotEmpty;

  double get completionRate =>
      total == 0 ? 0 : (completed / total * 100);
}
