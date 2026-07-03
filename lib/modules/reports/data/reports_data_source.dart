import '../../../app/data/base_model.dart';
import '../../../app/data/report_model.dart';

abstract class ReportsDataSource {
  Future<BaseModel<BaseModels<ReportModel>>> getReports({
    required int page,
    ReportType? type,
  });

  Future<BaseModel<ReportModel>> generateReport({
    required ReportType type,
    required ReportRange range,
    required ReportFormat format,
  });

  Future<BaseModel<Map<String, dynamic>>> downloadReport(ReportModel report);

  Future<BaseModel<Map<String, dynamic>>> shareReport(ReportModel report);
}
