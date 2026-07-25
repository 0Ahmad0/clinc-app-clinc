import '../../../core/data/base_model.dart';
import '../../../core/domain/services/api_service.dart';
import '../../../core/utils/app_url.dart';
import 'models/clinic_service_model.dart';

class ClinicServicesRemoteDataSource {
  ClinicServicesRemoteDataSource(this._apiServices);

  final ApiServices _apiServices;

  Future<BaseModel<BaseModels<ClinicLabSectionModel>>> labSections() async {
    final response = await _apiServices.get(AppUrl.clinicServicesLabSections);

    return BaseModel.fromJson(
      Map<String, dynamic>.from(response as Map),
      (json) => BaseModels.fromJson(
        json,
        (itemJson) => ClinicLabSectionModel.fromJson(
          Map<String, dynamic>.from(itemJson as Map),
        ),
      ),
    );
  }

  Future<BaseModel<BaseModels<ClinicAvailableLabTestModel>>> labTests({
    required int page,
    required int perPage,
    String? search,
    int? sectionId,
    String? sectionSlug,
  }) async {
    final response = await _apiServices.get(
      AppUrl.clinicServicesLabTests,
      queryParams: {
        'page': page,
        'per_page': perPage,
        if (search != null && search.trim().isNotEmpty) 'search': search,
        if (sectionId != null) 'section_id': sectionId,
        if (sectionSlug != null && sectionSlug.trim().isNotEmpty)
          'section_slug': sectionSlug,
      },
    );

    return BaseModel.fromJson(
      _normalizePaginatedResponse(Map<String, dynamic>.from(response as Map)),
      (json) => BaseModels.fromJson(
        json,
        (itemJson) => ClinicAvailableLabTestModel.fromJson(
          Map<String, dynamic>.from(itemJson as Map),
        ),
      ),
    );
  }

  Future<BaseModel<BaseModels<ClinicEnabledLabTestModel>>> enabledLabTests({
    required int page,
    required int perPage,
    String? search,
    int? sectionId,
    bool? isActive,
  }) async {
    final response = await _apiServices.get(
      AppUrl.clinicServicesEnabledLabTests,
      queryParams: {
        'page': page,
        'per_page': perPage,
        if (search != null && search.trim().isNotEmpty) 'search': search,
        if (sectionId != null) 'section_id': sectionId,
        if (isActive != null) 'is_active': isActive,
      },
    );

    return BaseModel.fromJson(
      _normalizePaginatedResponse(Map<String, dynamic>.from(response as Map)),
      (json) => BaseModels.fromJson(
        json,
        (itemJson) => ClinicEnabledLabTestModel.fromJson(
          Map<String, dynamic>.from(itemJson as Map),
        ),
      ),
    );
  }

  Future<BaseModel<ClinicEnabledLabTestModel>> enableLabTest({
    required int labTestId,
    required num price,
    required bool isActive,
  }) async {
    final response = await _apiServices.post(
      AppUrl.clinicServicesLabTest(labTestId),
      body: {'price': price, 'is_active': isActive},
    );

    return BaseModel.fromJson(
      Map<String, dynamic>.from(response as Map),
      (json) => ClinicEnabledLabTestModel.fromJson(
        Map<String, dynamic>.from(json as Map),
      ),
    );
  }

  Future<BaseModel<ClinicEnabledLabTestModel>> updateLabTest({
    required int labTestId,
    required num price,
    required bool isActive,
  }) async {
    final response = await _apiServices.put(
      AppUrl.clinicServicesLabTest(labTestId),
      body: {'price': price, 'is_active': isActive},
    );

    return BaseModel.fromJson(
      Map<String, dynamic>.from(response as Map),
      (json) => ClinicEnabledLabTestModel.fromJson(
        Map<String, dynamic>.from(json as Map),
      ),
    );
  }

  Future<BaseModel<ClinicServiceRemovalModel>> removeLabTest({
    required int labTestId,
  }) async {
    final response = await _apiServices.delete(
      AppUrl.clinicServicesLabTest(labTestId),
    );

    return BaseModel.fromJson(
      Map<String, dynamic>.from(response as Map),
      (json) => ClinicServiceRemovalModel.fromJson(
        Map<String, dynamic>.from(json as Map),
      ),
    );
  }

  Future<BaseModel<BaseModels<ClinicAvailableSpecializationModel>>>
  specializations({
    required int page,
    required int perPage,
    String? search,
  }) async {
    final response = await _apiServices.get(
      AppUrl.clinicServicesSpecializations,
      queryParams: {
        'page': page,
        'per_page': perPage,
        if (search != null && search.trim().isNotEmpty) 'search': search,
      },
    );

    return BaseModel.fromJson(
      _normalizePaginatedResponse(Map<String, dynamic>.from(response as Map)),
      (json) => BaseModels.fromJson(
        json,
        (itemJson) => ClinicAvailableSpecializationModel.fromJson(
          Map<String, dynamic>.from(itemJson as Map),
        ),
      ),
    );
  }

  Future<BaseModel<BaseModels<ClinicEnabledSpecializationModel>>>
  enabledSpecializations({
    required int page,
    required int perPage,
    String? search,
    bool? isActive,
  }) async {
    final response = await _apiServices.get(
      AppUrl.clinicServicesEnabledSpecializations,
      queryParams: {
        'page': page,
        'per_page': perPage,
        if (search != null && search.trim().isNotEmpty) 'search': search,
        if (isActive != null) 'is_active': isActive,
      },
    );

    return BaseModel.fromJson(
      _normalizePaginatedResponse(Map<String, dynamic>.from(response as Map)),
      (json) => BaseModels.fromJson(
        json,
        (itemJson) => ClinicEnabledSpecializationModel.fromJson(
          Map<String, dynamic>.from(itemJson as Map),
        ),
      ),
    );
  }

  Future<BaseModel<ClinicEnabledSpecializationModel>> enableSpecialization({
    required int specializationId,
    required bool isActive,
  }) async {
    final response = await _apiServices.post(
      AppUrl.clinicServicesSpecialization(specializationId),
      body: {'is_active': isActive},
    );

    return BaseModel.fromJson(
      Map<String, dynamic>.from(response as Map),
      (json) => ClinicEnabledSpecializationModel.fromJson(
        Map<String, dynamic>.from(json as Map),
      ),
    );
  }

  Future<BaseModel<ClinicEnabledSpecializationModel>> updateSpecialization({
    required int specializationId,
    required bool isActive,
  }) async {
    final response = await _apiServices.put(
      AppUrl.clinicServicesSpecialization(specializationId),
      body: {'is_active': isActive},
    );

    return BaseModel.fromJson(
      Map<String, dynamic>.from(response as Map),
      (json) => ClinicEnabledSpecializationModel.fromJson(
        Map<String, dynamic>.from(json as Map),
      ),
    );
  }

  Future<BaseModel<ClinicServiceRemovalModel>> removeSpecialization({
    required int specializationId,
  }) async {
    final response = await _apiServices.delete(
      AppUrl.clinicServicesSpecialization(specializationId),
    );

    return BaseModel.fromJson(
      Map<String, dynamic>.from(response as Map),
      (json) => ClinicServiceRemovalModel.fromJson(
        Map<String, dynamic>.from(json as Map),
      ),
    );
  }

  Map<String, dynamic> _normalizePaginatedResponse(Map<String, dynamic> json) {
    final data = json['data'];
    if (data is Map && data['meta'] is Map) {
      final meta = Map<String, dynamic>.from(data['meta'] as Map);
      final currentPage = int.tryParse('${meta['currentPage']}') ?? 1;
      final perPage = int.tryParse('${meta['perPage']}') ?? 0;
      data['meta'] = {
        'current_page': currentPage,
        'per_page': perPage,
        'total': meta['total'],
        'to': (meta['hasMore'] == true)
            ? currentPage * perPage
            : meta['total'] ?? currentPage * perPage,
      };
    }
    return json;
  }
}
