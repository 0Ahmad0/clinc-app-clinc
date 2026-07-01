import '../../../app/data/remote/api_response.dart';
import '../../../app/domain/error_handler/network_exceptions.dart';
import '../data/dashboard_data_source.dart';
import '../models/dashboard_model.dart';

class DashboardRepository {
  DashboardRepository(this._dataSource);

  final DashboardDataSource _dataSource;

  Future<ApiResponse<DashboardResponse>> getDashboard() async {
    try {
      return ApiResponse.success(await _dataSource.getDashboard());
    } catch (error) {
      return ApiResponse.failure(NetworkExceptions.getException(error));
    }
  }
}
