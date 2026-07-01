import '../../../app/data/base_model.dart';
import '../../../app/data/remote/api_response.dart';
import '../../../app/domain/error_handler/network_exceptions.dart';
import '../data/doctors_data_source.dart';
import '../models/doctor_details_model.dart';
import '../models/doctors_list_model.dart';

class DoctorsRepository {
  DoctorsRepository(this._dataSource);

  final DoctorsDataSource _dataSource;

  Future<ApiResponse<DoctorsListResponse>> getDoctors({
    String? search,
    int? specializationId,
  }) async {
    try {
      return ApiResponse.success(
        await _dataSource.getDoctors(
          search: search,
          specializationId: specializationId,
        ),
      );
    } catch (error) {
      return ApiResponse.failure(NetworkExceptions.getException(error));
    }
  }

  Future<ApiResponse<BaseModel<DoctorDetailsModel>>> getDoctor(
    String id,
  ) async {
    try {
      return ApiResponse.success(await _dataSource.getDoctor(id));
    } catch (error) {
      return ApiResponse.failure(NetworkExceptions.getException(error));
    }
  }
}
