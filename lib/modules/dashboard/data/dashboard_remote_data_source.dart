import '../../../app/core/utils/app_url.dart';
import '../../../app/domain/services/api_service.dart';
import '../models/dashboard_model.dart';
import 'dashboard_data_source.dart';

class DashboardRemoteDataSource implements DashboardDataSource {
  DashboardRemoteDataSource(this._apiServices);

  final ApiServices _apiServices;

  @override
  Future<DashboardResponse> getDashboard() async {
    final response = await _apiServices.get(
      AppUrl.clinicDashboard,
      hasToken: true,
    );
    return DashboardResponse.fromJson(response);
  }
}
