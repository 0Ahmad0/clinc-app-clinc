import '../../../app/data/base_model.dart';
import '../models/add_doctor_model.dart';

abstract class AddDoctorDataSource {
  Future<BaseModel<AddedDoctorModel>> addDoctor(AddDoctorRequest request);

  Future<BaseModel<AddedDoctorModel>> updateDoctor(
    String id,
    AddDoctorRequest request,
  );
}
