import '../../../app/core/utils/app_url.dart';
import '../../../app/data/base_model.dart';
import '../../../app/domain/services/api_service.dart';
import '../models/clinic_service_model.dart';
import 'services_data_source.dart';

class ServicesRemoteDataSource implements ServicesDataSource {
  ServicesRemoteDataSource(this._apiServices);

  final ApiServices _apiServices;

  @override
  Future<BaseModel<BaseModels<ClinicServiceSection>>> getSections({
    required ClinicServiceTab type,
    required int page,
  }) async {
    final response = await _apiServices.get(
      AppUrl.clinicServices,
      queryParams: {'type': type.name, 'page': page},
      hasToken: true,
    );
    return BaseModel.fromJson(
      response,
      (json) => BaseModels.fromJson(
        json,
        (item) => ClinicServiceSection.fromJson(
          Map<String, dynamic>.from(item as Map),
        ),
      ),
    );
  }

  @override
  Future<BaseModel<ClinicServiceSection>> addSection({
    required ClinicServiceTab type,
    required String sectionId,
  }) async {
    final response = await _apiServices.post(
      '${AppUrl.clinicServices}/sections',
      body: {'type': type.name, 'section_id': sectionId},
      hasToken: true,
    );
    return _sectionResponse(response);
  }

  @override
  Future<BaseModel<ClinicServiceSection>> updateLabTest({
    required String sectionId,
    required String testId,
    required bool isEnabled,
    required num price,
  }) async {
    final response = await _apiServices.put(
      '${AppUrl.clinicServices}/lab-tests/$testId',
      body: {'section_id': sectionId, 'is_enabled': isEnabled, 'price': price},
      hasToken: true,
    );
    return _sectionResponse(response);
  }

  BaseModel<ClinicServiceSection> _sectionResponse(
    Map<String, dynamic> response,
  ) {
    return BaseModel.fromJson(
      response,
      (json) =>
          ClinicServiceSection.fromJson(Map<String, dynamic>.from(json as Map)),
    );
  }
}
