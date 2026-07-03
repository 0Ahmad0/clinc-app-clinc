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
  // ===== متغيرات الكود القديم =====
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

  // ===== متغيرات الكود الجديد =====
  final RxList<DoctorModel> allDoctors = <DoctorModel>[].obs;
  final RxList<DoctorModel> displayedDoctors = <DoctorModel>[].obs;
  final RxString selectedSpecialty = ''.obs;

  // ===== Getters (من الكود الجديد) =====
  List<String> get specialties {
    final set = <String>{};
    for (final d in allDoctors) {
      set.add(d.specialty);
    }
    return set.toList();
  }

  // ===== دورة الحياة (مدمجة) =====
  @override
  void onInit() {
    _repository = locator<DoctorsRepository>();
    loadDoctors();
    super.onInit();
  }

  @override
  void onClose() {
    _searchDebounce?.cancel();
    searchController.dispose();
    super.onClose();
  }

  // ===== تحميل الأطباء (من الكود القديم مع دعم الجديد) =====
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
        // تحديث القوائم القديمة
        doctors.assignAll(response.data!.doctors);
        specializations.assignAll(response.data!.specializations);

        // تحويل ClinicDoctor إلى DoctorModel للقوائم الجديدة
        final convertedDoctors = response.data!.doctors.map((clinicDoctor) {
          return _convertToDoctorModel(clinicDoctor);
        }).toList();

        allDoctors.assignAll(convertedDoctors);
        _applyFilters(searchController.text, selectedSpecialty.value);
      },
      failure: (exception) {
        errorMessage.value = NetworkExceptions.getErrorMessage(exception);
      },
    );
  }

  // ===== تحويل ClinicDoctor إلى DoctorModel (مساعد) =====
  DoctorModel _convertToDoctorModel(ClinicDoctor clinicDoctor) {
    return DoctorModel(
      id: clinicDoctor.doctorId,
      nameAr: clinicDoctor.nameAr,
      nameEn: clinicDoctor.nameEn,
      specialty: clinicDoctor.specialization.nameAr,
      fee: clinicDoctor.consultationFee.toDouble(),
      isAvailable: clinicDoctor.isAvailable,
      phone: '',
      email: '',
      licenseNumber: '',
      yearsOfExperience: clinicDoctor.experienceYears,
      about: '',
      imagePath: clinicDoctor.image ?? '',
      qualificationFiles: const [],
      gender: 'Male',
      workingHours: const [],
    );
  }

  // ===== البحث (من الكود القديم مع دعم الجديد) =====
  void runSearch(String query) {
    _searchDebounce?.cancel();
    _searchDebounce = Timer(const Duration(milliseconds: 350), () {
      loadDoctors();
      _applyFilters(query, selectedSpecialty.value);
    });
  }

  // ===== فلتر التخصص (من الكود القديم مع دعم الجديد) =====
  void selectSpecialization(int? id) {
    if (selectedSpecializationId.value == id) return;
    selectedSpecializationId.value = id;
    loadDoctors();

    // تحديث الفلتر الجديد
    if (id == null) {
      selectedSpecialty.value = '';
    } else {
      final spec = specializations.firstWhereOrNull((s) => s.id == id);
      if (spec != null) {
        final name = Get.context?.locale.languageCode == 'ar'
            ? spec.nameAr
            : spec.nameEn;
        selectedSpecialty.value = name ?? '';
      }
    }
    _applyFilters(searchController.text, selectedSpecialty.value);
  }

  // ===== فلتر التخصص (من الكود الجديد) =====
  void filterBySpecialty(String specialty) {
    selectedSpecialty.value = specialty;
    // مزامنة مع الفلتر القديم
    if (specialty.isEmpty) {
      selectedSpecializationId.value = null;
    } else {
      final spec = specializations.firstWhereOrNull((s) {
        final name = Get.context?.locale.languageCode == 'ar'
            ? s.nameAr
            : s.nameEn;
        return name == specialty;
      });
      selectedSpecializationId.value = spec?.id;
    }
    _applyFilters(searchController.text, specialty);
    loadDoctors();
  }

  // ===== تطبيق الفلاتر (من الكود الجديد) =====
  void _applyFilters(String query, String specialty) {
    var list = allDoctors.toList();
    if (specialty.isNotEmpty) {
      list = list.where((d) => d.specialty == specialty).toList();
    }
    if (query.isNotEmpty) {
      final q = query.toLowerCase();
      list = list.where((d) {
        return d.nameAr.toLowerCase().contains(q) ||
            d.nameEn.toLowerCase().contains(q) ||
            d.specialty.toLowerCase().contains(q);
      }).toList();
    }
    displayedDoctors.assignAll(list);
  }

  // ===== الانتقال لإضافة طبيب (من الكود القديم) =====
  Future<void> goToAddDoctor() async {
    final result = await Get.toNamed(AppRoutes.addDoctor);
    if (result is DoctorModel) await loadDoctors(force: true);
  }

  // ===== الانتقال لتفاصيل الطبيب (مدمج) =====
  Future<void> goToDoctorDetails(ClinicDoctor doctor) async {
    // استخدام الطريقة القديمة لجلب التفاصيل الكاملة
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

  // ===== الانتقال لتفاصيل الطبيب (من الكود الجديد) =====
  void goToDoctorDetailsNew(DoctorModel doctor) {
    Get.to(() => const DoctorDetailsView(), arguments: doctor);
  }

  // ===== الانتقال لتعديل طبيب (من الكود القديم) =====
  Future<void> goToEditDoctor(DoctorModel doctor) async {
    final result = await Get.toNamed(AppRoutes.addDoctor, arguments: doctor);
    if (result is! DoctorModel) return;
    selectedDoctor.value = result;
    await loadDoctors(force: true);
    Get.back(result: result);
  }

  // ===== تبديل حالة التوفر (مدمج) =====
  void toggleStatus(String id) {
    // تحديث في القائمة القديمة (ClinicDoctor)
    final index = doctors.indexWhere((d) => d.doctorId == id);
    if (index != -1) {
      doctors.removeAt(index);
    }

    // تحديث في القائمة الجديدة (DoctorModel)
    final newIndex = allDoctors.indexWhere((d) => d.id == id);
    if (newIndex != -1) {
      final doc = allDoctors[newIndex];
      doc.isAvailable = !doc.isAvailable;
      allDoctors[newIndex] = doc;
      _applyFilters(searchController.text, selectedSpecialty.value);
      update();
    }

    Get.snackbar(
      tr('doctors_page.messages.status_updated'),
      tr('doctors_page.messages.status_updated_desc'),
      backgroundColor: const Color(0xFF10B981).withValues(alpha: 0.9),
      colorText: Colors.white,
      snackPosition: SnackPosition.TOP,
    );
  }

  // ===== حذف طبيب (مدمج) =====
  void deleteDoctor(String id) {
    // حذف من القائمة القديمة
    doctors.removeWhere((d) => d.doctorId == id);

    // حذف من القائمة الجديدة
    allDoctors.removeWhere((d) => d.id == id);
    _applyFilters(searchController.text, selectedSpecialty.value);

    Get.back();
    Get.back();
    Get.snackbar(
      tr('doctors_page.messages.deleted'),
      tr('doctors_page.messages.deleted_desc'),
      backgroundColor: const Color(0xFFF04438).withValues(alpha: 0.9),
      colorText: Colors.white,
      snackPosition: SnackPosition.TOP,
    );
  }

  // ===== لون التخصص (من الكود الجديد) =====
  static Color specialtyColor(String specialty) {
    const map = <String, Color>{
      'أمراض القلب': Color(0xFFEF4444),
      'الجلدية والتجميل': Color(0xFF8B5CF6),
      'طب الأطفال': Color(0xFF3B82F6),
      'طب العيون': Color(0xFF06B6D4),
      'العظام والمفاصل': Color(0xFFF59E0B),
      'الأعصاب': Color(0xFF009688),
    };
    return map[specialty] ?? const Color(0xFF6B7280);
  }

  // ===== بيانات وهمية للاختبار (من الكود الجديد) =====
  void _loadMockData() {
    // تستخدم فقط للاختبار - يمكن إزالتها في الإنتاج
    if (allDoctors.isEmpty) {
      allDoctors.addAll([
        DoctorModel(
          id: '1',
          nameAr: 'د. أحمد محمد علي',
          nameEn: 'Dr. Ahmed Mohammed Ali',
          specialty: 'أمراض القلب',
          fee: 150.0,
          isAvailable: true,
          phone: '+963911000111',
          email: 'ahmed@clinic.com',
          licenseNumber: 'LIC-9920',
          yearsOfExperience: 12,
          about: 'طبيب متخصص في أمراض القلب والأوعية الدموية',
          imagePath: '',
          qualificationFiles: [],
          gender: 'Male',
          workingHours: [],
        ),
        // ... المزيد من البيانات
      ]);
      displayedDoctors.assignAll(allDoctors);
    }
  }
}
