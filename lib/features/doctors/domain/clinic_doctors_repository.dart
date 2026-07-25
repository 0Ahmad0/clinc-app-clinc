import '../../../core/data/base_model.dart';
import '../../../core/data/remote/api_response.dart';
import '../../../core/domain/error_handler/network_exceptions.dart';
import '../data/clinic_doctors_remote_data_source.dart';
import '../data/models/clinic_doctor_model.dart';
import '../data/models/clinic_specialization_model.dart';

class ClinicDoctorsRepository {
  ClinicDoctorsRepository(this._remoteDataSource);

  final ClinicDoctorsRemoteDataSource _remoteDataSource;

  Future<ApiResponse<BaseModel<BaseModels<ClinicDoctorModel>>>> getDoctors({
    required int page,
    required int perPage,
    String? search,
    String? specializationId,
    bool? isActive,
  }) => _execute(
    () => _remoteDataSource.getDoctors(
      page: page,
      perPage: perPage,
      search: search,
      specializationId: specializationId,
      isActive: isActive,
    ),
  );

  Future<ApiResponse<BaseModel<ClinicDoctorModel>>> getDoctor(String id) =>
      _execute(() => _remoteDataSource.getDoctor(id));

  Future<ApiResponse<BaseModel<ClinicDoctorModel>>> createDoctor(
    Map<String, dynamic> body, {
    String? imagePath,
    List<String> qualificationFilePaths = const [],
  }) => _execute(
    () => _remoteDataSource.createDoctor(
      body: body,
      imagePath: imagePath,
      qualificationFilePaths: qualificationFilePaths,
    ),
  );

  Future<ApiResponse<BaseModel<ClinicDoctorModel>>> updateDoctor({
    required String id,
    required Map<String, dynamic> body,
    String? imagePath,
    List<String> qualificationFilePaths = const [],
  }) => _execute(
    () => _remoteDataSource.updateDoctor(
      id: id,
      body: body,
      imagePath: imagePath,
      qualificationFilePaths: qualificationFilePaths,
    ),
  );

  Future<ApiResponse<BaseModel<ClinicDoctorModel>>> updateAvailability({
    required String id,
    required bool isActive,
  }) => _execute(
    () => _remoteDataSource.updateAvailability(id: id, isActive: isActive),
  );

  Future<ApiResponse<BaseModel<BaseModels<ClinicSpecializationModel>>>>
  getSpecializations() => _execute(_remoteDataSource.getSpecializations);

  Future<ApiResponse<BaseModel<T>>> _execute<T>(
    Future<BaseModel<T>> Function() action,
  ) async {
    try {
      return ApiResponse.success(await action());
    } catch (error) {
      return ApiResponse.failure(NetworkExceptions.getException(error));
    }
  }
}
