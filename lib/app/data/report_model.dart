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

  // Summary numbers (flexible)
  final int total;
  final int completed;
  final int pending;
  final int cancelled;

  // PDF (اختياري)
  final String? pdfPathOrUrl;

  const ReportModel({
    required this.id,
    required this.type,
    required this.generatedAt,
    required this.total,
    required this.completed,
    required this.pending,
    required this.cancelled,
    this.pdfPathOrUrl,
  });

  bool get hasPdf => (pdfPathOrUrl ?? '').isNotEmpty;
}