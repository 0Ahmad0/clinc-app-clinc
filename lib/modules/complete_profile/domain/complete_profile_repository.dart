import '../../../app/data/remote/api_response.dart';
import '../../../app/domain/error_handler/network_exceptions.dart';
import '../data/complete_profile_data_source.dart';
import '../models/complete_profile_model.dart';

class CompleteProfileRepository {
  CompleteProfileRepository(this._dataSource);

  final CompleteProfileDataSource _dataSource;

  Future<ApiResponse<List<InsuranceModel>>> getInsurances() async {
    try {
      return ApiResponse.success(await _dataSource.getInsurances());
    } catch (error) {
      return ApiResponse.failure(NetworkExceptions.getException(error));
    }
  }

  Future<ApiResponse<CompleteProfileResponse>> completeProfile(
    CompleteClinicProfileRequest request,
  ) async {
    try {
      return ApiResponse.success(await _dataSource.completeProfile(request));
    } catch (error) {
      return ApiResponse.failure(NetworkExceptions.getException(error));
    }
  }
}
