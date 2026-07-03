import '../../../app/data/base_model.dart';
import '../../../app/data/report_model.dart';
import 'reports_data_source.dart';

class ReportsMockDataSource implements ReportsDataSource {
  static const _pageSize = 2;
  static const _delay = Duration(milliseconds: 450);
  static int _nextId = 4;
  static final List<Map<String, dynamic>> _reports = [
    _report(
      id: 'R-003',
      type: 'doctors',
      range: 'year',
      format: 'excel',
      daysAgo: 1,
      total: 3,
      completed: 3,
    ),
    _report(
      id: 'R-002',
      type: 'revenue',
      range: 'month',
      format: 'pdf',
      daysAgo: 2,
      total: 12,
      completed: 10,
      pending: 2,
    ),
    _report(
      id: 'R-001',
      type: 'appointments',
      range: 'week',
      format: 'pdf',
      daysAgo: 4,
      total: 32,
      completed: 20,
      pending: 8,
      cancelled: 4,
    ),
  ];

  @override
  Future<BaseModel<BaseModels<ReportModel>>> getReports({
    required int page,
    ReportType? type,
  }) async {
    await Future<void>.delayed(_delay);
    final filtered = _reports
        .where((report) => type == null || report['type'] == type.name)
        .toList();
    final start = (page - 1) * _pageSize;
    final items = start >= filtered.length
        ? <Map<String, dynamic>>[]
        : filtered.sublist(
            start,
            (start + _pageSize).clamp(0, filtered.length),
          );

    return BaseModel.fromJson(
      {
        'status': 'success',
        'message': 'Reports retrieved successfully',
        'data': items,
        'meta': {
          'current_page': page,
          'from': items.isEmpty ? null : start + 1,
          'to': items.isEmpty ? null : start + items.length,
          'per_page': _pageSize,
          'total': filtered.length,
        },
      },
      (json) => BaseModels.fromJson(
        json,
        (item) => ReportModel.fromJson(Map<String, dynamic>.from(item as Map)),
      ),
    );
  }

  @override
  Future<BaseModel<ReportModel>> generateReport({
    required ReportType type,
    required ReportRange range,
    required ReportFormat format,
  }) async {
    await Future<void>.delayed(_delay);
    final report = _report(
      id: 'R-${_nextId.toString().padLeft(3, '0')}',
      type: type.name,
      range: range.name,
      format: format.name,
      total: 24,
      completed: 18,
      pending: 4,
      cancelled: 2,
    );
    _nextId++;
    _reports.insert(0, report);
    return BaseModel.fromJson({
      'status': 'success',
      'message': 'Report generated successfully',
      'data': report,
      'meta': <String, dynamic>{},
    }, (json) => ReportModel.fromJson(Map<String, dynamic>.from(json as Map)));
  }

  @override
  Future<BaseModel<Map<String, dynamic>>> downloadReport(
    ReportModel report,
  ) async {
    await Future<void>.delayed(_delay);
    return BaseModel.fromJson({
      'status': 'success',
      'message': 'Report downloaded successfully',
      'data': {
        'report_id': report.id,
        'file_url': report.fileUrl,
        'local_path': 'mock://downloads/${report.id}.${report.format.name}',
      },
      'meta': <String, dynamic>{},
    }, (json) => Map<String, dynamic>.from(json as Map));
  }

  @override
  Future<BaseModel<Map<String, dynamic>>> shareReport(
    ReportModel report,
  ) async {
    await Future<void>.delayed(_delay);
    return BaseModel.fromJson({
      'status': 'success',
      'message': 'Report share link prepared successfully',
      'data': {
        'report_id': report.id,
        'share_url': 'mock://share/reports/${report.id}',
      },
      'meta': <String, dynamic>{},
    }, (json) => Map<String, dynamic>.from(json as Map));
  }

  static Map<String, dynamic> _report({
    required String id,
    required String type,
    required String range,
    required String format,
    int daysAgo = 0,
    required int total,
    required int completed,
    int pending = 0,
    int cancelled = 0,
  }) {
    return {
      'report_id': id,
      'type': type,
      'range': range,
      'format': format,
      'generated_at': DateTime.now()
          .subtract(Duration(days: daysAgo))
          .toIso8601String(),
      'summary': {
        'total': total,
        'completed': completed,
        'pending': pending,
        'cancelled': cancelled,
      },
      'file_url': 'mock://reports/$id.$format',
    };
  }
}
