enum ReportType { appointments, clinic, revenue, doctors, labResults }

enum ReportRange { week, month, year, custom }

enum ReportFormat { pdf, excel }

extension ReportTypeX on ReportType {
  String key() => this == ReportType.labResults
      ? 'reports.types.lab_results'
      : 'reports.types.$name';
}

extension ReportRangeX on ReportRange {
  String key() => 'reports.filters.$name';
}

extension ReportFormatX on ReportFormat {
  String key() => 'reports.formats.$name';
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
    this.range = ReportRange.month,
    this.format = ReportFormat.pdf,
    required this.generatedAt,
    required this.total,
    required this.completed,
    required this.pending,
    required this.cancelled,
    this.pdfPathOrUrl,
    this.totalRevenue,
    required this.fileUrl,
  });

  double get completionRate => total == 0 ? 0 : (completed / total * 100);

  final ReportRange range;
  final ReportFormat format;

  final String fileUrl;

  bool get hasPdf => format == ReportFormat.pdf && fileUrl.isNotEmpty;
  // String? get pdfPathOrUrl => hasPdf ? fileUrl : null;

  factory ReportModel.fromJson(Map<String, dynamic> json) {
    return ReportModel(
      id: json['report_id'].toString(),
      type: ReportType.values.firstWhere((value) => value.name == json['type']),
      range: ReportRange.values.firstWhere(
        (value) => value.name == json['range'],
      ),
      format: ReportFormat.values.firstWhere(
        (value) => value.name == json['format'],
      ),
      generatedAt: DateTime.parse(json['generated_at'] as String),
      total: json['summary']?['total'] as int? ?? 0,
      completed: json['summary']?['completed'] as int? ?? 0,
      pending: json['summary']?['pending'] as int? ?? 0,
      cancelled: json['summary']?['cancelled'] as int? ?? 0,
      fileUrl: json['file_url'] as String? ?? '',
    );
  }
}
