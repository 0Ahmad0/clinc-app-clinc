import '../../../app/data/base_model.dart';
import '../../../app/data/remote/api_response.dart';
import '../../../app/data/report_model.dart';
import '../../../app/domain/error_handler/network_exceptions.dart';
import '../data/reports_data_source.dart';

class ReportsRepository {
  ReportsRepository(this._dataSource);

  final ReportsDataSource _dataSource;

  Future<ApiResponse<BaseModel<BaseModels<ReportModel>>>> getReports({
    required int page,
    ReportType? type,
  }) {
    return _execute(() => _dataSource.getReports(page: page, type: type));
  }

  Future<ApiResponse<BaseModel<ReportModel>>> generateReport({
    required ReportType type,
    required ReportRange range,
    required ReportFormat format,
  }) {
    return _execute(
      () =>
          _dataSource.generateReport(type: type, range: range, format: format),
    );
  }

  Future<ApiResponse<T>> _execute<T>(Future<T> Function() action) async {
    try {
      return ApiResponse.success(await action());
    } catch (error) {
      return ApiResponse.failure(NetworkExceptions.getException(error));
    }
  }
}
