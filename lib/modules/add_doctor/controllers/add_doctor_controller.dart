import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../../../generated/locale_keys.g.dart';
import '../../../app/data/doctor_model.dart';

class AddDoctorController extends GetxController {

  // ── Form ──────────────────────────────────────────────────────────────────
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // ── Text Controllers ──────────────────────────────────────────────────────
  late final TextEditingController nameArController;
  late final TextEditingController nameEnController;
  late final TextEditingController feeController;
  late final TextEditingController licenseController;
  late final TextEditingController experienceController;
  late final TextEditingController aboutController;
  late final TextEditingController phoneController;
  late final TextEditingController emailController;

  // ── Reactive State ────────────────────────────────────────────────────────
  final selectedImage    = ''.obs;
  final selectedSpecialty = ''.obs;
  final selectedGender   = 'Male'.obs;
  final isAvailable      = true.obs;
  final isEditMode       = false.obs;

  final qualificationFiles = <String>[].obs;
  final workingHoursList   = <WorkingHours>[].obs;
  final doctorsList        = <DoctorModel>[].obs;
  final searchResults      = <DoctorModel>[].obs;

  String? editingDoctorId;

  // ── Static Data ───────────────────────────────────────────────────────────
  final List<String> specialties = const [
    'Cardiology', 'Dermatology', 'Neurology',
    'Pediatrics', 'Dentist', 'Surgery',
  ];

  static const List<String> _weekDays = [
    'Saturday', 'Sunday', 'Monday', 'Tuesday',
    'Wednesday', 'Thursday', 'Friday',
  ];

  // ── Lifecycle ─────────────────────────────────────────────────────────────

  @override
  void onInit() {
    super.onInit();
    _initControllers();
    _initWorkingHours();
    if (Get.arguments is DoctorModel) _loadDoctorData(Get.arguments as DoctorModel);
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

  // ── Init Helpers ──────────────────────────────────────────────────────────

  void _initControllers() {
    nameArController     = TextEditingController();
    nameEnController     = TextEditingController();
    feeController        = TextEditingController();
    licenseController    = TextEditingController();
    experienceController = TextEditingController();
    aboutController      = TextEditingController();
    phoneController      = TextEditingController();
    emailController      = TextEditingController();
  }

  void _initWorkingHours() {
    workingHoursList.value = _weekDays
        .map((day) => WorkingHours(
              day: day,
              startTime: '09:00 AM',
              endTime: '05:00 PM',
              isDayOff: false,
            ))
        .toList();
  }

  // ── Edit Mode ─────────────────────────────────────────────────────────────

  void _loadDoctorData(DoctorModel doctor) {
    isEditMode.value       = true;
    editingDoctorId        = doctor.id;
    nameArController.text  = doctor.nameAr;
    nameEnController.text  = doctor.nameEn;
    feeController.text     = doctor.fee.toString();
    licenseController.text = doctor.licenseNumber;
    experienceController.text = doctor.yearsOfExperience.toString();
    aboutController.text   = doctor.about;
    phoneController.text   = doctor.phone;
    emailController.text   = doctor.email;

    selectedImage.value    = doctor.imagePath;
    selectedSpecialty.value = doctor.specialty;
    selectedGender.value   = doctor.gender;
    isAvailable.value      = doctor.isAvailable;
    qualificationFiles.value = List.from(doctor.qualificationFiles);
    workingHoursList.value = doctor.workingHours
        .map((wh) => WorkingHours(
              day: wh.day,
              startTime: wh.startTime,
              endTime: wh.endTime,
              isDayOff: wh.isDayOff,
            ))
        .toList();
  }

  // ── Image & File Picking ─────────────────────────────────────────────────

  Future<void> pickImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image != null) selectedImage.value = image.path;
  }

  Future<void> pickPDFs() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'],
        allowMultiple: true,
      );
      if (result != null) {
        qualificationFiles.addAll(result.paths.whereType<String>());
      }
    } catch (e) {
      Get.snackbar('خطأ', 'تعذّر اختيار الملفات');
    }
  }

  void removeFile(int index) {
    if (index >= 0 && index < qualificationFiles.length) {
      qualificationFiles.removeAt(index);
    }
  }

  // ── Working Hours ─────────────────────────────────────────────────────────

  void toggleDayOff(int index, bool isWorking) {
    final item = workingHoursList[index]..isDayOff = !isWorking;
    workingHoursList[index] = item;
    workingHoursList.refresh();
  }

  Future<void> selectTime(BuildContext context, int index, bool isStart) async {
    final picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (ctx, child) => MediaQuery(
        data: MediaQuery.of(ctx).copyWith(alwaysUse24HourFormat: false),
        child: child!,
      ),
    );
    if (picked == null) return;

    final formatted = picked.format(context);
    final item = workingHoursList[index];
    if (isStart) {
      item.startTime = formatted;
    } else {
      item.endTime = formatted;
    }
    workingHoursList[index] = item;
    workingHoursList.refresh();
  }

  // ── Save / Update ─────────────────────────────────────────────────────────

  void saveDoctor() {
    if (!formKey.currentState!.validate()) return;

    if (selectedSpecialty.value.isEmpty) {
      Get.snackbar(
        'خطأ',
        tr(LocaleKeys.add_doctor_validations_select_specialty),
        backgroundColor: Colors.red.withValues(alpha: 0.15),
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

    isEditMode.value ? _update(doctor) : _add(doctor);
  }

  void _update(DoctorModel doctor) {
    final index = doctorsList.indexWhere((d) => d.id == editingDoctorId);
    if (index == -1) return;
    doctorsList[index] = doctor;
    update();
    Get.back();
    _showSuccessSnackbar(tr(LocaleKeys.add_doctor_alerts_updated));
  }

  void _add(DoctorModel doctor) {
    doctorsList.add(doctor);
    _showSuccessSnackbar(tr(LocaleKeys.add_doctor_alerts_saved));
    _clearForm();
  }

  void _showSuccessSnackbar(String message) {
    Get.snackbar(
      tr(LocaleKeys.add_doctor_alerts_success),
      message,
      backgroundColor: Colors.green.withValues(alpha: 0.15),
      snackPosition: SnackPosition.TOP,
    );
  }

  // ── Reset ─────────────────────────────────────────────────────────────────

  void _clearForm() {
    for (final c in [
      nameArController, nameEnController, feeController,
      licenseController, experienceController, aboutController,
      phoneController, emailController,
    ]) {
      c.clear();
    }
    selectedImage.value    = '';
    selectedSpecialty.value = '';
    selectedGender.value   = 'Male';
    isAvailable.value      = true;
    isEditMode.value       = false;
    editingDoctorId        = null;
    qualificationFiles.clear();
    _initWorkingHours();
  }

  // ── Search ────────────────────────────────────────────────────────────────

  void searchDoctors(String query) {
    if (query.isEmpty) {
      searchResults.assignAll(doctorsList);
      return;
    }
    final q = query.toLowerCase();
    searchResults.assignAll(
      doctorsList.where((d) =>
          d.nameEn.toLowerCase().contains(q) || d.nameAr.contains(q)),
    );
  }
}
