import '../../../app/core/utils/app_url.dart';
import '../../../app/data/base_model.dart';
import '../../../app/domain/services/api_service.dart';
import '../models/doctor_details_model.dart';
import '../models/doctors_list_model.dart';
import 'doctors_data_source.dart';

class DoctorsRemoteDataSource implements DoctorsDataSource {
  DoctorsRemoteDataSource(this._apiServices);

  final ApiServices _apiServices;

  @override
  Future<DoctorsListResponse> getDoctors({
    String? search,
    int? specializationId,
  }) async {
    final response = await _apiServices.get(
      AppUrl.clinicDoctors,
      queryParams: {
        if (search != null && search.trim().isNotEmpty) 'search': search.trim(),
        if (specializationId != null) 'specialization_id': specializationId,
      },
      hasToken: true,
    );
    return DoctorsListResponse.fromJson(response);
  }

  @override
  Future<BaseModel<DoctorDetailsModel>> getDoctor(String id) async {
    final response = await _apiServices.get(
      '${AppUrl.clinicDoctors}/$id',
      hasToken: true,
    );
    return BaseModel.fromJson(
      Map<String, dynamic>.from(response as Map),
      (json) =>
          DoctorDetailsModel.fromJson(Map<String, dynamic>.from(json as Map)),
    );
  }
}
