import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app/core/configuration/locator.dart';
import '../../../app/core/helper/response_helper.dart';
import '../../../app/data/doctor_model.dart';
import '../../../app/domain/error_handler/network_exceptions.dart';
import '../../../app/routes/app_routes.dart';
import '../domain/doctors_repository.dart';
import '../models/doctors_list_model.dart';
import '../views/doctor_details_view.dart';

class DoctorsController extends GetxController {
  final TextEditingController searchController = TextEditingController();
  final RxList<ClinicDoctor> doctors = <ClinicDoctor>[].obs;
  final RxList<DoctorSpecialization> specializations =
      <DoctorSpecialization>[].obs;
  final RxnInt selectedSpecializationId = RxnInt();
  final RxBool isLoading = false.obs;
  final RxnString loadingDetailsDoctorId = RxnString();
  final Rxn<DoctorModel> selectedDoctor = Rxn<DoctorModel>();
  final RxString errorMessage = ''.obs;
  late final DoctorsRepository _repository;
  Timer? _searchDebounce;
  int _loadRequest = 0;

  @override
  void onInit() {
    _repository = locator<DoctorsRepository>();
    loadDoctors();
    super.onInit();
  }

  Future<void> loadDoctors({bool force = false}) async {
    if (isLoading.value && !force) return;
    final requestId = ++_loadRequest;
    isLoading.value = true;
    errorMessage.value = '';
    final result = await _repository.getDoctors(
      search: searchController.text,
      specializationId: selectedSpecializationId.value,
    );
    if (requestId != _loadRequest) return;
    isLoading.value = false;

    result.when(
      success: (response) {
        if (!response.isSuccess || response.data == null) {
          errorMessage.value = response.message;
          return;
        }
        doctors.assignAll(response.data!.doctors);
        specializations.assignAll(response.data!.specializations);
      },
      failure: (exception) {
        errorMessage.value = NetworkExceptions.getErrorMessage(exception);
      },
    );
  }

  void runSearch(String _) {
    _searchDebounce?.cancel();
    _searchDebounce = Timer(const Duration(milliseconds: 350), loadDoctors);
  }

  void selectSpecialization(int? id) {
    if (selectedSpecializationId.value == id) return;
    selectedSpecializationId.value = id;
    loadDoctors();
  }

  Future<void> goToAddDoctor() async {
    final result = await Get.toNamed(AppRoutes.addDoctor);
    if (result is DoctorModel) await loadDoctors(force: true);
  }

  Future<void> goToDoctorDetails(ClinicDoctor doctor) async {
    if (loadingDetailsDoctorId.value != null) return;
    loadingDetailsDoctorId.value = doctor.doctorId;
    final result = await _repository.getDoctor(doctor.doctorId);
    loadingDetailsDoctorId.value = null;
    result.when(
      success: (response) {
        if (response.status != 'success' || response.result == null) {
          ResponseHelper.onFailure(message: response.message);
          return;
        }
        selectedDoctor.value = response.result!.toDoctorModel(
          isArabic: Get.context?.locale.languageCode == 'ar',
        );
        Get.to(() => const DoctorDetailsView());
      },
      failure: (exception) {
        ResponseHelper.onFailure(
          message: NetworkExceptions.getErrorMessage(exception),
        );
      },
    );
  }

  Future<void> goToEditDoctor(DoctorModel doctor) async {
    final result = await Get.toNamed(AppRoutes.addDoctor, arguments: doctor);
    if (result is! DoctorModel) return;
    selectedDoctor.value = result;
    await loadDoctors(force: true);
  }

  void toggleStatus(String id) {
    ResponseHelper.onWarning(
      message: tr('doctors_page.messages.status_from_details'),
    );
  }

  void deleteDoctor(String id) {
    ResponseHelper.onWarning(
      message: tr('doctors_page.messages.delete_from_details'),
    );
  }

  @override
  void onClose() {
    _searchDebounce?.cancel();
    searchController.dispose();
    super.onClose();
  }
}
