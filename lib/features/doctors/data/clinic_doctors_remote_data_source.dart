import '../../../core/data/base_model.dart';
import '../../../core/domain/services/api_service.dart';
import '../../../core/utils/app_url.dart';
import 'models/clinic_doctor_model.dart';
import 'models/clinic_specialization_model.dart';

class ClinicDoctorsRemoteDataSource {
  ClinicDoctorsRemoteDataSource(this._apiServices);

  final ApiServices _apiServices;

  Future<BaseModel<BaseModels<ClinicDoctorModel>>> getDoctors({
    required int page,
    required int perPage,
    String? search,
    String? specializationId,
    bool? isActive,
  }) async {
    final response = await _apiServices.get(
      AppUrl.clinicDoctors,
      queryParams: {
        'page': page,
        'per_page': perPage,
        if (search != null && search.trim().isNotEmpty) 'search': search.trim(),
        if (specializationId != null) 'specialization_id': specializationId,
        if (isActive != null) 'is_active': isActive,
      },
    );

    return BaseModel.fromJson(
      _normalizePaginatedResponse(Map<String, dynamic>.from(response as Map)),
      (json) => BaseModels.fromJson(
        json,
        (itemJson) => ClinicDoctorModel.fromJson(
          Map<String, dynamic>.from(itemJson as Map),
        ),
      ),
    );
  }

  Future<BaseModel<ClinicDoctorModel>> getDoctor(String id) async {
    final response = await _apiServices.get(AppUrl.clinicDoctor(id));
    return _doctorResponse(response);
  }

  Future<BaseModel<ClinicDoctorModel>> updateAvailability({
    required String id,
    required bool isActive,
  }) async {
    final response = await _apiServices.patch(
      AppUrl.clinicDoctorAvailability(id),
      body: {'is_active': isActive},
    );
    return _doctorResponse(response);
  }

  Future<BaseModel<BaseModels<ClinicSpecializationModel>>>
  getSpecializations() async {
    final response = await _apiServices.get(AppUrl.clinicSpecializations);
    return BaseModel.fromJson(
      Map<String, dynamic>.from(response as Map),
      (json) => BaseModels.fromJson(
        json,
        (itemJson) => ClinicSpecializationModel.fromJson(
          Map<String, dynamic>.from(itemJson as Map),
        ),
      ),
    );
  }

  BaseModel<ClinicDoctorModel> _doctorResponse(dynamic response) {
    return BaseModel.fromJson(
      Map<String, dynamic>.from(response as Map),
      (json) =>
          ClinicDoctorModel.fromJson(Map<String, dynamic>.from(json as Map)),
    );
  }

  Map<String, dynamic> _normalizePaginatedResponse(Map<String, dynamic> json) {
    final data = json['data'];
    if (data is Map && data['meta'] is Map) {
      final meta = Map<String, dynamic>.from(data['meta'] as Map);
      data['meta'] = {
        'current_page': meta['currentPage'],
        'per_page': meta['perPage'],
        'total': meta['total'],
        'to':
            ((meta['currentPage'] ?? 1) as int) *
            ((meta['perPage'] ?? 0) as int),
      };
    }
    return json;
  }
}
