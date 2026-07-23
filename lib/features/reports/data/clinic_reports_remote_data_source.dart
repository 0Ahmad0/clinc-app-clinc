import '../../../core/data/base_model.dart';
import '../../../core/domain/services/api_service.dart';
import '../../../core/utils/app_url.dart';
import '../domain/report_period.dart';
import '../domain/report_type.dart';
import 'models/clinic_report_model.dart';

class ClinicReportsRemoteDataSource {
  ClinicReportsRemoteDataSource(this._apiServices);

  final ApiServices _apiServices;

  Future<BaseModel<ClinicReportSummaryModel>> summary({
    required ReportPeriod period,
    required ReportType type,
  }) async {
    final response = await _apiServices.get(
      AppUrl.clinicReportsSummary,
      queryParams: {'period': period.backendValue, 'type': type.backendValue},
    );

    return BaseModel.fromJson(
      Map<String, dynamic>.from(response as Map),
      (json) => ClinicReportSummaryModel.fromJson(
        Map<String, dynamic>.from(json as Map),
      ),
    );
  }

  Future<BaseModel<ClinicGeneratedReportModel>> export({
    required ReportPeriod period,
    required ReportType type,
    required String format,
  }) async {
    final response = await _apiServices.post(
      AppUrl.clinicReportsExport,
      body: {
        'period': period.backendValue,
        'type': type.backendValue,
        'format': format,
      },
    );

    return BaseModel.fromJson(
      Map<String, dynamic>.from(response as Map),
      (json) => ClinicGeneratedReportModel.fromJson(
        Map<String, dynamic>.from(json as Map),
      ),
    );
  }

  Future<BaseModel<BaseModels<ClinicGeneratedReportModel>>> generated({
    required int page,
    required int perPage,
    ReportPeriod? period,
    ReportType? type,
  }) async {
    final response = await _apiServices.get(
      AppUrl.clinicReportsGenerated,
      queryParams: {
        'page': page,
        'per_page': perPage,
        if (period != null) 'period': period.backendValue,
        if (type != null) 'type': type.backendValue,
      },
    );

    return BaseModel.fromJson(
      _normalizePaginatedResponse(Map<String, dynamic>.from(response as Map)),
      (json) => BaseModels.fromJson(
        json,
        (itemJson) => ClinicGeneratedReportModel.fromJson(
          Map<String, dynamic>.from(itemJson as Map),
        ),
      ),
    );
  }

  Map<String, dynamic> _normalizePaginatedResponse(Map<String, dynamic> json) {
    final data = json['data'];
    if (data is Map && data['meta'] is Map) {
      final meta = Map<String, dynamic>.from(data['meta'] as Map);
      final currentPage = int.tryParse('${meta['currentPage']}') ?? 1;
      final perPage = int.tryParse('${meta['perPage']}') ?? 0;
      data['meta'] = {
        'current_page': currentPage,
        'per_page': perPage,
        'total': meta['total'],
        'to': currentPage * perPage,
      };
    }
    return json;
  }
}
