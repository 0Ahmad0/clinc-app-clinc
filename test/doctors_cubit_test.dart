import 'package:clinic_app/core/data/base_model.dart';
import 'package:clinic_app/core/data/remote/api_response.dart';
import 'package:clinic_app/features/doctors/data/models/clinic_doctor_model.dart';
import 'package:clinic_app/features/doctors/data/models/clinic_specialization_model.dart';
import 'package:clinic_app/features/doctors/domain/clinic_doctors_repository.dart';
import 'package:clinic_app/features/doctors/presentation/cubit/doctors_cubit.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('doctors cubit updates search and specialization filters', () async {
    final cubit = DoctorsCubit(_FakeClinicDoctorsRepository());

    cubit.search('cardio');
    cubit.selectSpecialization('1');

    expect(cubit.state.query, 'cardio');
    expect(cubit.state.selectedSpecializationId, '1');
    await Future<void>.delayed(Duration.zero);
    await cubit.close();
  });
}

class _FakeClinicDoctorsRepository implements ClinicDoctorsRepository {
  @override
  Future<ApiResponse<BaseModel<BaseModels<ClinicDoctorModel>>>> getDoctors({
    required int page,
    required int perPage,
    String? search,
    String? specializationId,
    bool? isActive,
  }) async => ApiResponse.success(
    BaseModel(result: BaseModels<ClinicDoctorModel>(list: [])),
  );

  @override
  Future<ApiResponse<BaseModel<BaseModels<ClinicSpecializationModel>>>>
  getSpecializations() async => ApiResponse.success(
    BaseModel(result: BaseModels<ClinicSpecializationModel>(list: [])),
  );

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
