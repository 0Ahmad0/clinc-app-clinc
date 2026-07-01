import '../../../app/data/base_model.dart';
import '../models/doctor_details_model.dart';
import '../models/doctors_list_model.dart';

abstract class DoctorsDataSource {
  Future<DoctorsListResponse> getDoctors({
    String? search,
    int? specializationId,
  });

  Future<BaseModel<DoctorDetailsModel>> getDoctor(String id);
}
