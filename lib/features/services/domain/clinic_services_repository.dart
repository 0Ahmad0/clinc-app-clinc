import '../../../core/data/base_model.dart';
import '../../../core/data/remote/api_response.dart';
import '../../../core/domain/error_handler/network_exceptions.dart';
import '../data/clinic_services_remote_data_source.dart';
import '../data/models/clinic_service_model.dart';

class ClinicServicesRepository {
  ClinicServicesRepository(this._remoteDataSource);

  final ClinicServicesRemoteDataSource _remoteDataSource;

  Future<ApiResponse<BaseModel<BaseModels<ClinicLabSectionModel>>>>
  labSections() => _execute(_remoteDataSource.labSections);

  Future<ApiResponse<BaseModel<BaseModels<ClinicAvailableLabTestModel>>>>
  labTests({
    required int page,
    required int perPage,
    String? search,
    int? sectionId,
    String? sectionSlug,
  }) => _execute(
    () => _remoteDataSource.labTests(
      page: page,
      perPage: perPage,
      search: search,
      sectionId: sectionId,
      sectionSlug: sectionSlug,
    ),
  );

  Future<ApiResponse<BaseModel<BaseModels<ClinicEnabledLabTestModel>>>>
  enabledLabTests({
    required int page,
    required int perPage,
    String? search,
    int? sectionId,
    bool? isActive,
  }) => _execute(
    () => _remoteDataSource.enabledLabTests(
      page: page,
      perPage: perPage,
      search: search,
      sectionId: sectionId,
      isActive: isActive,
    ),
  );

  Future<ApiResponse<BaseModel<ClinicEnabledLabTestModel>>> enableLabTest({
    required int labTestId,
    required num price,
    required bool isActive,
  }) => _execute(
    () => _remoteDataSource.enableLabTest(
      labTestId: labTestId,
      price: price,
      isActive: isActive,
    ),
  );

  Future<ApiResponse<BaseModel<ClinicEnabledLabTestModel>>> updateLabTest({
    required int labTestId,
    required num price,
    required bool isActive,
  }) => _execute(
    () => _remoteDataSource.updateLabTest(
      labTestId: labTestId,
      price: price,
      isActive: isActive,
    ),
  );

  Future<ApiResponse<BaseModel<ClinicServiceRemovalModel>>> removeLabTest({
    required int labTestId,
  }) => _execute(() => _remoteDataSource.removeLabTest(labTestId: labTestId));

  Future<ApiResponse<BaseModel<BaseModels<ClinicAvailableSpecializationModel>>>>
  specializations({required int page, required int perPage, String? search}) =>
      _execute(
        () => _remoteDataSource.specializations(
          page: page,
          perPage: perPage,
          search: search,
        ),
      );

  Future<ApiResponse<BaseModel<BaseModels<ClinicEnabledSpecializationModel>>>>
  enabledSpecializations({
    required int page,
    required int perPage,
    String? search,
    bool? isActive,
  }) => _execute(
    () => _remoteDataSource.enabledSpecializations(
      page: page,
      perPage: perPage,
      search: search,
      isActive: isActive,
    ),
  );

  Future<ApiResponse<BaseModel<ClinicEnabledSpecializationModel>>>
  enableSpecialization({
    required int specializationId,
    required bool isActive,
  }) => _execute(
    () => _remoteDataSource.enableSpecialization(
      specializationId: specializationId,
      isActive: isActive,
    ),
  );

  Future<ApiResponse<BaseModel<ClinicEnabledSpecializationModel>>>
  updateSpecialization({
    required int specializationId,
    required bool isActive,
  }) => _execute(
    () => _remoteDataSource.updateSpecialization(
      specializationId: specializationId,
      isActive: isActive,
    ),
  );

  Future<ApiResponse<BaseModel<ClinicServiceRemovalModel>>>
  removeSpecialization({required int specializationId}) => _execute(
    () => _remoteDataSource.removeSpecialization(
      specializationId: specializationId,
    ),
  );

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
