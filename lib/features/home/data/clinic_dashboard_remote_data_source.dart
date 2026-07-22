import '../../../core/data/base_model.dart';
import '../../../core/domain/services/api_service.dart';
import '../../../core/utils/app_url.dart';
import 'models/clinic_dashboard_model.dart';

class ClinicDashboardRemoteDataSource {
  ClinicDashboardRemoteDataSource(this._apiServices);

  final ApiServices _apiServices;

  Future<BaseModel<ClinicDashboardModel>> getDashboard({String? date}) async {
    final response = await _apiServices.get(
      AppUrl.clinicDashboard,
      queryParams: {if (date != null) 'date': date},
    );

    return BaseModel.fromJson(
      Map<String, dynamic>.from(response as Map),
      (json) =>
          ClinicDashboardModel.fromJson(Map<String, dynamic>.from(json as Map)),
    );
  }
}
