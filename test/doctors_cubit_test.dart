import 'package:clinic_app/core/data/base_model.dart';
import 'package:clinic_app/core/data/remote/api_response.dart';
import 'package:clinic_app/features/doctors/data/models/clinic_doctor_model.dart';
import 'package:clinic_app/features/doctors/data/models/clinic_specialization_model.dart';
import 'package:clinic_app/features/doctors/domain/clinic_doctors_repository.dart';
import 'package:clinic_app/features/doctors/domain/weekday.dart';
import 'package:clinic_app/features/doctors/presentation/cubit/add_doctor_cubit.dart';
import 'package:clinic_app/features/doctors/presentation/cubit/doctors_cubit.dart';
import 'package:flutter/material.dart';
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

  test('add doctor rejects active day when start is not before end', () async {
    final repository = _FakeClinicDoctorsRepository();
    final cubit = AddDoctorCubit(repository);

    cubit.selectSpecialization('1');
    cubit.setStart(Weekday.saturday, const TimeOfDay(hour: 17, minute: 0));
    cubit.setEnd(Weekday.saturday, const TimeOfDay(hour: 9, minute: 0));

    await cubit.save(
      nameAr: 'طبيب',
      nameEn: '',
      phone: '',
      email: '',
      licenseNumber: '',
      experienceYears: '',
      consultationFee: '',
      bio: '',
    );

    expect(repository.createDoctorCalls, 0);
    expect(repository.updateDoctorCalls, 0);
    expect(cubit.state.showScheduleValidation, isTrue);
    expect(cubit.state.failure, isNull);
    await cubit.close();
  });

  test('add doctor edit matches numeric specialization ids from api', () async {
    final doctor = ClinicDoctorModel.fromJson(const {
      'doctor_id': 1,
      'specialization_id': 3,
    });
    final specialization = ClinicSpecializationModel.fromJson(const {
      'specialization_id': 3,
      'name': 'Cardiology',
    });
    final cubit = AddDoctorCubit(
      _FakeClinicDoctorsRepository(),
      initialDoctor: doctor,
    );

    cubit.emit(cubit.state.copyWith(specializations: [specialization]));

    expect(cubit.state.selectedSpecializationId, '3');
    expect(cubit.state.selectedSpecialization?.name, 'Cardiology');
    await cubit.close();
  });
}

class _FakeClinicDoctorsRepository implements ClinicDoctorsRepository {
  int createDoctorCalls = 0;
  int updateDoctorCalls = 0;

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
  Future<ApiResponse<BaseModel<ClinicDoctorModel>>> createDoctor(
    Map<String, dynamic> body, {
    String? imagePath,
    List<String> qualificationFilePaths = const [],
  }) async {
    createDoctorCalls++;
    return ApiResponse.success(BaseModel(result: const ClinicDoctorModel()));
  }

  @override
  Future<ApiResponse<BaseModel<ClinicDoctorModel>>> updateDoctor({
    required String id,
    required Map<String, dynamic> body,
    String? imagePath,
    List<String> qualificationFilePaths = const [],
  }) async {
    updateDoctorCalls++;
    return ApiResponse.success(BaseModel(result: const ClinicDoctorModel()));
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
