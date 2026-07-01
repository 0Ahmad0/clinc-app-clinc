import '../../../app/data/base_model.dart';
import '../../doctors/data/doctors_mock_data_source.dart';
import '../models/add_doctor_model.dart';
import 'add_doctor_data_source.dart';

class AddDoctorMockDataSource implements AddDoctorDataSource {
  @override
  Future<BaseModel<AddedDoctorModel>> addDoctor(
    AddDoctorRequest request,
  ) async {
    await Future<void>.delayed(const Duration(milliseconds: 600));
    final doctorId = 'D-${DateTime.now().millisecondsSinceEpoch}';
    DoctorsMockDataSource.addMockDoctor(_doctorMap(doctorId, request));
    return BaseModel.fromJson(
      {
        'status': 'success',
        'message': 'Doctor added successfully',
        'data': {
          'doctor_id': doctorId,
          'name_ar': request.nameAr,
          'name_en': request.nameEn,
        },
        'meta': null,
      },
      (json) =>
          AddedDoctorModel.fromJson(Map<String, dynamic>.from(json as Map)),
    );
  }

  @override
  Future<BaseModel<AddedDoctorModel>> updateDoctor(
    String id,
    AddDoctorRequest request,
  ) async {
    await Future<void>.delayed(const Duration(milliseconds: 600));
    final updated = DoctorsMockDataSource.updateMockDoctor(
      id,
      _doctorMap(id, request),
    );
    return BaseModel.fromJson(
      {
        'status': updated ? 'success' : 'error',
        'message': updated ? 'Doctor updated successfully' : 'Doctor not found',
        'data': updated
            ? {
                'doctor_id': id,
                'name_ar': request.nameAr,
                'name_en': request.nameEn,
              }
            : null,
        'error': null,
      },
      (json) =>
          AddedDoctorModel.fromJson(Map<String, dynamic>.from(json as Map)),
    );
  }

  Map<String, dynamic> _doctorMap(String id, AddDoctorRequest request) {
    return {
      'doctor_id': id,
      'name_ar': request.nameAr,
      'name_en': request.nameEn,
      'specialization': DoctorsMockDataSource.specializationById(
        request.specializationId,
      ),
      'image': request.imagePath,
      'is_available': request.isAvailable,
      'experience_years': request.experienceYears,
      'consultation_fee': request.consultationFee,
      'currency': 'SAR',
      'phone': request.phone,
      'license_number': request.licenseNumber,
      'email': request.email,
      'biography': request.biography,
      'qualification_files': request.qualificationFiles,
      'schedule': request.schedule.map((item) => item.toJson()).toList(),
    };
  }
}
