import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../../../generated/locale_keys.g.dart';
import '../../../app/core/configuration/locator.dart';
import '../../../app/data/doctor_model.dart';
import '../../../app/domain/error_handler/network_exceptions.dart';
import '../../doctors/domain/doctors_repository.dart';
import '../../doctors/models/doctors_list_model.dart';
import '../domain/add_doctor_repository.dart';
import '../models/add_doctor_model.dart';

class AddDoctorController extends GetxController {
  // --- Global Key for Form Validation ---
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // --- Text Controllers ---
  late TextEditingController nameArController;
  late TextEditingController nameEnController;
  late TextEditingController feeController;
  late TextEditingController licenseController;
  late TextEditingController experienceController;
  late TextEditingController aboutController;
  late TextEditingController phoneController;
  late TextEditingController emailController;

  // --- Observable Variables (Reactive) ---
  var selectedImage = ''.obs;
  final selectedSpecialtyId = RxnInt();
  var selectedGender = 'Male'.obs;
  var isAvailable = true.obs;
  final isLoading = false.obs;
  final isLoadingSpecializations = false.obs;
  final specializations = <DoctorSpecialization>[].obs;
  late final AddDoctorRepository _repository;
  late final DoctorsRepository _doctorsRepository;

  // Lists
  var qualificationFiles = <String>[].obs;
  var workingHoursList = <WorkingHours>[].obs;

  // --- Edit Mode Control ---
  var isEditMode = false.obs;
  String? editingDoctorId;

  // --- Static Data ---
  final List<String> weekDays = [
    'Saturday',
    'Sunday',
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
  ];

  // ===========================================================================
  // Lifecycle Methods
  // ===========================================================================

  @override
  void onInit() {
    super.onInit();
    _repository = locator<AddDoctorRepository>();
    _doctorsRepository = locator<DoctorsRepository>();
    _initializeControllers();
    _initializeWorkingHours();
    _loadSpecializations();
  }

  Future<void> _loadSpecializations() async {
    isLoadingSpecializations.value = true;
    final result = await _doctorsRepository.getDoctors();
    isLoadingSpecializations.value = false;
    result.when(
      success: (response) {
        if (response.isSuccess && response.data != null) {
          specializations.assignAll(response.data!.specializations);
          if (Get.arguments is DoctorModel) {
            _loadDoctorData(Get.arguments as DoctorModel);
          }
        } else {
          _showError(response.message);
        }
      },
      failure: (exception) {
        _showError(NetworkExceptions.getErrorMessage(exception));
      },
    );
  }

  @override
  void onClose() {
    nameArController.dispose();
    nameEnController.dispose();
    feeController.dispose();
    licenseController.dispose();
    experienceController.dispose();
    aboutController.dispose();
    phoneController.dispose();
    emailController.dispose();
    super.onClose();
  }

  // ===========================================================================
  // Initialization & Helper Methods
  // ===========================================================================

  void _initializeControllers() {
    nameArController = TextEditingController();
    nameEnController = TextEditingController();
    feeController = TextEditingController();
    licenseController = TextEditingController();
    experienceController = TextEditingController();
    aboutController = TextEditingController();
    phoneController = TextEditingController();
    emailController = TextEditingController();
  }

  void _initializeWorkingHours() {
    workingHoursList.value = weekDays
        .map(
          (day) => WorkingHours(
            day: day,
            startTime: "09:00 AM",
            endTime: "05:00 PM",
            isDayOff: false,
          ),
        )
        .toList();
  }

  // ===========================================================================
  // Edit Mode Logic
  // ===========================================================================

  void _loadDoctorData(DoctorModel doctor) {
    isEditMode.value = true;
    editingDoctorId = doctor.id;

    nameArController.text = doctor.nameAr;
    nameEnController.text = doctor.nameEn;
    feeController.text = doctor.fee.toString();
    licenseController.text = doctor.licenseNumber;
    experienceController.text = doctor.yearsOfExperience.toString();
    aboutController.text = doctor.about;
    phoneController.text = doctor.phone;
    emailController.text = doctor.email;

    selectedImage.value = doctor.imagePath;
    final matches = specializations.where(
      (item) =>
          item.nameAr == doctor.specialty || item.nameEn == doctor.specialty,
    );
    selectedSpecialtyId.value = matches.isEmpty ? null : matches.first.id;
    selectedGender.value = doctor.gender;
    isAvailable.value = doctor.isAvailable;
    qualificationFiles.value = List.from(doctor.qualificationFiles);

    workingHoursList.value = doctor.workingHours
        .map(
          (wh) => WorkingHours(
            day: wh.day,
            startTime: wh.startTime,
            endTime: wh.endTime,
            isDayOff: wh.isDayOff,
          ),
        )
        .toList();
  }

  // ===========================================================================
  // File & Image Handling
  // ===========================================================================

  Future<void> pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      selectedImage.value = image.path;
    }
  }

  Future<void> pickPDFs() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'],
        allowMultiple: true,
      );

      if (result != null) {
        List<String> paths = result.paths.whereType<String>().toList();
        qualificationFiles.addAll(paths);
      }
    } catch (e) {
      debugPrint("Error picking files: $e");
      Get.snackbar("Error", "Could not pick files");
    }
  }

  void removeFile(int index) {
    if (index >= 0 && index < qualificationFiles.length) {
      qualificationFiles.removeAt(index);
    }
  }

  // ===========================================================================
  // Working Hours Logic (NEW)
  // ===========================================================================

  void toggleDayOff(int index, bool val) {
    // val here comes from Switch: true means "Working Day", false means "Day Off"
    var item = workingHoursList[index];
    // We want isDayOff to be false when switch is active (true)
    item.isDayOff = !val;
    workingHoursList[index] = item;
    workingHoursList.refresh();
  }

  Future<void> selectTime(
    BuildContext context,
    int index,
    bool isStartTime,
  ) async {
    TimeOfDay initialTime = TimeOfDay.now();

    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: initialTime,
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
          child: child!,
        );
      },
    );

    if (picked != null && context.mounted) {
      String formattedTime = picked.format(context);
      var item = workingHoursList[index];
      if (isStartTime) {
        item.startTime = formattedTime;
      } else {
        item.endTime = formattedTime;
      }
      workingHoursList[index] = item;
      workingHoursList.refresh();
    }
  }

  // ===========================================================================
  // Save & Update Logic
  // ===========================================================================

  Future<void> saveDoctor() async {
    if (!formKey.currentState!.validate()) return;

    if (selectedSpecialtyId.value == null) {
      Get.snackbar(
        'خطأ',
        tr(LocaleKeys.add_doctor_validations_select_specialty),
        backgroundColor: Colors.red.withValues(alpha: 0.2),
        colorText: Colors.red,
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    isLoading.value = true;
    final request = AddDoctorRequest(
      nameAr: nameArController.text.trim(),
      nameEn: nameEnController.text.trim(),
      specializationId: selectedSpecialtyId.value!,
      consultationFee: num.tryParse(feeController.text.trim()) ?? 0,
      licenseNumber: licenseController.text.trim(),
      experienceYears: int.tryParse(experienceController.text.trim()) ?? 0,
      biography: aboutController.text.trim(),
      phone: phoneController.text.trim(),
      email: emailController.text.trim(),
      imagePath: selectedImage.value.isEmpty ? null : selectedImage.value,
      qualificationFiles: List<String>.from(qualificationFiles),
      isAvailable: isAvailable.value,
      schedule: workingHoursList
          .map(DoctorScheduleRequest.fromWorkingHours)
          .toList(),
    );
    final result = isEditMode.value
        ? await _repository.updateDoctor(editingDoctorId!, request)
        : await _repository.addDoctor(request);
    isLoading.value = false;
    result.when(
      success: (response) {
        if (response.status != 'success' || response.result == null) {
          _showError(response.message ?? 'Unable to save doctor');
          return;
        }
        Get.back(result: _buildDoctor(response.result!.doctorId));
        Get.snackbar(
          tr(LocaleKeys.add_doctor_alerts_success),
          tr(
            isEditMode.value
                ? LocaleKeys.add_doctor_alerts_updated
                : LocaleKeys.add_doctor_alerts_saved,
          ),
          backgroundColor: Colors.green.withValues(alpha: 0.2),
          snackPosition: SnackPosition.TOP,
        );
      },
      failure: (exception) {
        _showError(NetworkExceptions.getErrorMessage(exception));
      },
    );
  }

  DoctorModel _buildDoctor(String id) {
    final specialization = specializations.firstWhere(
      (item) => item.id == selectedSpecialtyId.value,
    );
    return DoctorModel(
      id: id,
      imagePath: selectedImage.value,
      nameAr: nameArController.text,
      nameEn: nameEnController.text,
      specialty: Get.context?.locale.languageCode == 'ar'
          ? specialization.nameAr
          : specialization.nameEn,
      fee: double.tryParse(feeController.text) ?? 0.0,
      gender: selectedGender.value,
      licenseNumber: licenseController.text,
      yearsOfExperience: int.tryParse(experienceController.text) ?? 0,
      about: aboutController.text,
      phone: phoneController.text,
      email: emailController.text,
      qualificationFiles: List.from(qualificationFiles),
      isAvailable: isAvailable.value,
      workingHours: List.from(workingHoursList),
    );
  }

  void _showError(String message) {
    Get.snackbar(
      tr(LocaleKeys.add_doctor_alerts_success),
      message,
      backgroundColor: Colors.red.withValues(alpha: 0.2),
      colorText: Colors.red,
      snackPosition: SnackPosition.BOTTOM,
    );
  }
}
