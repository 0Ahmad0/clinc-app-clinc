import '../../../app/data/base_model.dart';
import '../../../app/data/remote/api_response.dart';
import '../../../app/domain/error_handler/network_exceptions.dart';
import '../data/add_doctor_data_source.dart';
import '../models/add_doctor_model.dart';

class AddDoctorRepository {
  AddDoctorRepository(this._dataSource);

  final AddDoctorDataSource _dataSource;

  Future<ApiResponse<BaseModel<AddedDoctorModel>>> addDoctor(
    AddDoctorRequest request,
  ) async {
    try {
      return ApiResponse.success(await _dataSource.addDoctor(request));
    } catch (error) {
      return ApiResponse.failure(NetworkExceptions.getException(error));
    }
  }

  Future<ApiResponse<BaseModel<AddedDoctorModel>>> updateDoctor(
    String id,
    AddDoctorRequest request,
  ) async {
    try {
      return ApiResponse.success(await _dataSource.updateDoctor(id, request));
    } catch (error) {
      return ApiResponse.failure(NetworkExceptions.getException(error));
    }
  }
}
