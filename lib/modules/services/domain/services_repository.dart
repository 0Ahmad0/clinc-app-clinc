import '../../../app/data/base_model.dart';
import '../../../app/data/remote/api_response.dart';
import '../../../app/domain/error_handler/network_exceptions.dart';
import '../data/services_data_source.dart';
import '../models/clinic_service_model.dart';

class ServicesRepository {
  ServicesRepository(this._dataSource);

  final ServicesDataSource _dataSource;

  Future<ApiResponse<BaseModel<BaseModels<ClinicServiceSection>>>> getSections({
    required ClinicServiceTab type,
    required int page,
  }) {
    return _execute(() => _dataSource.getSections(type: type, page: page));
  }

  Future<ApiResponse<BaseModel<ClinicServiceSection>>> addSection({
    required ClinicServiceTab type,
    required String sectionId,
  }) {
    return _execute(
      () => _dataSource.addSection(type: type, sectionId: sectionId),
    );
  }

  Future<ApiResponse<BaseModel<ClinicServiceSection>>> updateLabTest({
    required String sectionId,
    required String testId,
    required bool isEnabled,
    required num price,
  }) {
    return _execute(
      () => _dataSource.updateLabTest(
        sectionId: sectionId,
        testId: testId,
        isEnabled: isEnabled,
        price: price,
      ),
    );
  }

  Future<ApiResponse<T>> _execute<T>(Future<T> Function() action) async {
    try {
      return ApiResponse.success(await action());
    } catch (error) {
      return ApiResponse.failure(NetworkExceptions.getException(error));
    }
  }
}
