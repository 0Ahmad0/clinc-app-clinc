import '../../../app/core/utils/app_url.dart';
import '../../../app/data/base_model.dart';
import '../../../app/data/report_model.dart';
import '../../../app/domain/services/api_service.dart';
import 'reports_data_source.dart';

class ReportsRemoteDataSource implements ReportsDataSource {
  ReportsRemoteDataSource(this._apiServices);

  final ApiServices _apiServices;

  @override
  Future<BaseModel<BaseModels<ReportModel>>> getReports({
    required int page,
    ReportType? type,
  }) async {
    final response = await _apiServices.get(
      AppUrl.clinicReports,
      queryParams: {'page': page, if (type != null) 'type': type.name},
      hasToken: true,
    );
    return BaseModel.fromJson(
      response,
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
    final response = await _apiServices.post(
      AppUrl.clinicReports,
      body: {'type': type.name, 'range': range.name, 'format': format.name},
      hasToken: true,
    );
    return BaseModel.fromJson(
      response,
      (json) => ReportModel.fromJson(Map<String, dynamic>.from(json as Map)),
    );
  }
}
