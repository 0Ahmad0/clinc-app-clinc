import '../../../core/data/base_model.dart';
import '../../../core/data/remote/api_response.dart';
import '../../../core/domain/error_handler/network_exceptions.dart';
import '../data/clinic_reports_remote_data_source.dart';
import '../data/models/clinic_report_model.dart';
import 'report_period.dart';
import 'report_type.dart';

class ClinicReportsRepository {
  ClinicReportsRepository(this._remoteDataSource);

  final ClinicReportsRemoteDataSource _remoteDataSource;

  Future<ApiResponse<BaseModel<ClinicReportSummaryModel>>> summary({
    required ReportPeriod period,
    required ReportType type,
  }) => _execute(() => _remoteDataSource.summary(period: period, type: type));

  Future<ApiResponse<BaseModel<ClinicGeneratedReportModel>>> export({
    required ReportPeriod period,
    required ReportType type,
    required String format,
  }) => _execute(
    () => _remoteDataSource.export(period: period, type: type, format: format),
  );

  Future<ApiResponse<BaseModel<BaseModels<ClinicGeneratedReportModel>>>>
  generated({
    required int page,
    required int perPage,
    ReportPeriod? period,
    ReportType? type,
  }) => _execute(
    () => _remoteDataSource.generated(
      page: page,
      perPage: perPage,
      period: period,
      type: type,
    ),
  );

  Future<ApiResponse<BaseModel<T>>> _execute<T>(
    Future<BaseModel<T>> Function() action,
  ) async {
    try {
      return ApiResponse.success(await action());
    } catch (error) {
      return ApiResponse.failure(NetworkExceptions.getException(error));
    }
  }
}
