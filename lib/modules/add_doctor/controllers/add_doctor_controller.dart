import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../../../generated/locale_keys.g.dart';
import '../../../app/data/doctor_model.dart';

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
  var selectedSpecialty = ''.obs;
  var selectedGender = 'Male'.obs;
  var isAvailable = true.obs;

  // Lists
  var qualificationFiles = <String>[].obs;
  var workingHoursList = <WorkingHours>[].obs;

  // --- Doctor Data Management ---
  var doctorsList = <DoctorModel>[].obs;
  var searchResults = <DoctorModel>[].obs;

  // --- Edit Mode Control ---
  var isEditMode = false.obs;
  String? editingDoctorId;

  // --- Static Data ---
  final List<String> specialties = [
    'Cardiology',
    'Dermatology',
    'Neurology',
    'Pediatrics',
    'Dentist',
    'Surgery',
  ];
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
    _initializeControllers();
    _initializeWorkingHours();

    if (Get.arguments != null && Get.arguments is DoctorModel) {
      _loadDoctorData(Get.arguments as DoctorModel);
    }
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
    selectedSpecialty.value = doctor.specialty;
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
      print("Error picking files: $e");
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

    if (picked != null) {
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

  void saveDoctor() {
    if (!formKey.currentState!.validate()) return;

    if (selectedSpecialty.value.isEmpty) {
      Get.snackbar(
        'خطأ',
        tr(LocaleKeys.add_doctor_validations_select_specialty),
        backgroundColor: Colors.red.withOpacity(0.2),
        colorText: Colors.red,
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    final doctor = DoctorModel(
      id: isEditMode.value
          ? editingDoctorId
          : DateTime.now().millisecondsSinceEpoch.toString(),
      imagePath: selectedImage.value,
      nameAr: nameArController.text,
      nameEn: nameEnController.text,
      specialty: selectedSpecialty.value,
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

    if (isEditMode.value) {
      _updateExistingDoctor(doctor);
    } else {
      _addNewDoctor(doctor);
    }
  }

  void _updateExistingDoctor(DoctorModel doctor) {
    int index = doctorsList.indexWhere((d) => d.id == editingDoctorId);
    if (index != -1) {
      doctorsList[index] = doctor;
      Get.back();
      Get.snackbar(
        tr(LocaleKeys.add_doctor_alerts_success),
        tr(LocaleKeys.add_doctor_alerts_updated),
        backgroundColor: Colors.green.withOpacity(0.2),
        snackPosition: SnackPosition.TOP,
      );
      update();
    }
  }

  void _addNewDoctor(DoctorModel doctor) {
    doctorsList.add(doctor);
    Get.snackbar(
      tr(LocaleKeys.add_doctor_alerts_success),
      tr(LocaleKeys.add_doctor_alerts_saved),
      backgroundColor: Colors.green.withOpacity(0.2),
      snackPosition: SnackPosition.TOP,
    );
    _clearForm();
  }

  // ===========================================================================
  // Reset Logic
  // ===========================================================================

  void _clearForm() {
    nameArController.clear();
    nameEnController.clear();
    feeController.clear();
    licenseController.clear();
    experienceController.clear();
    aboutController.clear();
    phoneController.clear();
    emailController.clear();

    selectedImage.value = '';
    selectedSpecialty.value = '';
    selectedGender.value = 'Male';
    isAvailable.value = true;
    isEditMode.value = false;
    editingDoctorId = null;

    qualificationFiles.clear();
    _initializeWorkingHours();
  }

  // ===========================================================================
  // Search Logic
  // ===========================================================================

  void searchDoctors(String query) {
    if (query.isEmpty) {
      searchResults.assignAll(doctorsList);
    } else {
      searchResults.assignAll(
        doctorsList.where((doc) {
          final nameEn = doc.nameEn.toLowerCase();
          final nameAr = doc.nameAr;
          final q = query.toLowerCase();
          return nameEn.contains(q) || nameAr.contains(q);
        }).toList(),
      );
    }
  }
}
