import '../../../core/data/base_model.dart';
import '../../../core/data/remote/api_response.dart';
import '../../../core/domain/error_handler/network_exceptions.dart';
import '../data/clinic_dashboard_remote_data_source.dart';
import '../data/models/clinic_dashboard_model.dart';

class ClinicDashboardRepository {
  ClinicDashboardRepository(this._remoteDataSource);

  final ClinicDashboardRemoteDataSource _remoteDataSource;

  Future<ApiResponse<BaseModel<ClinicDashboardModel>>> getDashboard({
    String? date,
  }) async {
    try {
      final response = await _remoteDataSource.getDashboard(date: date);
      return ApiResponse.success(response);
    } catch (error) {
      return ApiResponse.failure(NetworkExceptions.getException(error));
    }
  }
}
