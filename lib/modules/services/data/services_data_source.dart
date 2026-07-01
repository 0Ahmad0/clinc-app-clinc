import '../../../app/data/base_model.dart';
import '../models/clinic_service_model.dart';

abstract class ServicesDataSource {
  Future<BaseModel<BaseModels<ClinicServiceSection>>> getSections({
    required ClinicServiceTab type,
    required int page,
  });

  Future<BaseModel<ClinicServiceSection>> addSection({
    required ClinicServiceTab type,
    required String sectionId,
  });

  Future<BaseModel<ClinicServiceSection>> updateLabTest({
    required String sectionId,
    required String testId,
    required bool isEnabled,
    required num price,
  });
}
