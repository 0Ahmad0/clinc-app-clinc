import '../../../../app/data/remote/api_response.dart';
import '../../../../app/domain/error_handler/network_exceptions.dart';
import '../../data/data_sources/clinic_login_data_source.dart';
import '../../data/login_model.dart';

class ClinicLoginRepository {
  ClinicLoginRepository(this._dataSource);

  final ClinicLoginDataSource _dataSource;

  Future<ApiResponse<ClinicLoginResponse>> login({
    required String identifier,
    required String password,
  }) async {
    try {
      final response = await _dataSource.login(
        ClinicLoginRequest(identifier: identifier, password: password),
      );
      return ApiResponse.success(response);
    } catch (error) {
      return ApiResponse.failure(NetworkExceptions.getException(error));
    }
  }
}
