import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../app/data/doctor_model.dart';
import '../../doctors/controllers/doctors_controller.dart';

class AddDoctorController extends GetxController {
  // Controllers
  final TextEditingController nameController = TextEditingController();
  final TextEditingController specialtyController = TextEditingController();
  final TextEditingController licenseController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController experienceController = TextEditingController();
  final TextEditingController aboutController = TextEditingController();
  final TextEditingController hospitalController = TextEditingController();

  // State
  final RxString selectedGender = 'male'.obs;
  final Rxn<String> selectedImagePath = Rxn<String>();
  final RxBool isLoading = false.obs;
  final RxBool isActive = true.obs;

  // قائمة التخصصات
  final List<String> specialties = [
    'Cardiology',
    'Dermatology',
    'Neurology',
    'Pediatrics',
    'Orthopedics',
    'Oncology',
    'Ophthalmology',
    'Psychiatry',
    'Gynecology',
    'Urology'
  ];

  // جدول الدوام
  final RxList<Map<String, dynamic>> workingHours = [
    {'day': 'mon', 'time': '9:00 AM - 5:00 PM', 'isOff': false},
    {'day': 'tue', 'time': '9:00 AM - 5:00 PM', 'isOff': false},
    {'day': 'wed', 'time': '9:00 AM - 5:00 PM', 'isOff': false},
    {'day': 'thu', 'time': '9:00 AM - 5:00 PM', 'isOff': false},
    {'day': 'fri', 'time': '1:00 PM - 9:00 PM', 'isOff': false},
    {'day': 'sat', 'time': 'Off', 'isOff': true},
    {'day': 'sun', 'time': 'Off', 'isOff': true},
  ].obs;

  // قائمة المؤهلات العلمية
  final RxList<String> qualifications = <String>[].obs;
  final TextEditingController qualificationController = TextEditingController();

  @override
  void onClose() {
    nameController.dispose();
    specialtyController.dispose();
    licenseController.dispose();
    phoneController.dispose();
    emailController.dispose();
    experienceController.dispose();
    aboutController.dispose();
    hospitalController.dispose();
    qualificationController.dispose();
    super.onClose();
  }

  // تغيير الجنس
  void setGender(String gender) {
    selectedGender.value = gender;
  }

  // اختيار الصورة
  Future<void> pickImage() async {
    try {
      final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        selectedImagePath.value = pickedFile.path;
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to pick image: $e');
    }
  }

  // إضافة مؤهل علمي
  void addQualification() {
    if (qualificationController.text.isNotEmpty) {
      qualifications.add(qualificationController.text);
      qualificationController.clear();
    }
  }

  // إزالة مؤهل علمي
  void removeQualification(int index) {
    qualifications.removeAt(index);
  }

  // تبديل حالة يوم العمل
  void toggleDayOff(int index) {
    final updatedHours = List<Map<String, dynamic>>.from(workingHours);
    updatedHours[index] = {
      ...updatedHours[index],
      'isOff': !updatedHours[index]['isOff'],
      'time': updatedHours[index]['isOff'] ? '9:00 AM - 5:00 PM' : 'Off',
    };
    workingHours.value = updatedHours;
  }

  // تغيير وقت العمل
  void changeWorkTime(int index, String newTime) {
    final updatedHours = List<Map<String, dynamic>>.from(workingHours);
    updatedHours[index] = {
      ...updatedHours[index],
      'time': newTime,
    };
    workingHours.value = updatedHours;
  }

  // حفظ الطبيب
  Future<void> saveDoctor() async {
    if (!validateForm()) return;

    isLoading(true);
    try {
      // إنشاء نموذج الطبيب
      final newDoctor = DoctorModel(
        id: DateTime.now().millisecondsSinceEpoch,
        name: nameController.text,
        specialty: specialtyController.text,
        hospital: hospitalController.text,
        image: selectedImagePath.value,
        isActive: isActive.value,
        license: licenseController.text,
        phone: phoneController.text,
        email: emailController.text,
        experience: int.tryParse(experienceController.text) ?? 0,
        about: aboutController.text,
        qualifications: qualifications.isNotEmpty ? qualifications : null,
        workingDays: workingHours
            .where((day) => !day['isOff'])
            .map((day) => day['day'] as String)
            .toList(),
        workingHours: workingHours.firstWhere((day) => !day['isOff'], orElse: () => {'time': ''})['time'],
      );

      // الحصول على كنترولر الأطباء وإضافة الطبيب الجديد
      final doctorsController = Get.find<DoctorsController>();
      doctorsController.doctorList.add(newDoctor);

      // عرض رسالة نجاح
      Get.back();
      Get.snackbar(
        'نجاح',
        'تم إضافة الطبيب بنجاح',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } catch (e) {
      Get.snackbar(
        'خطأ',
        'فشل إضافة الطبيب: $e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading(false);
    }
  }

  // التحقق من صحة الفورم
  bool validateForm() {
    if (nameController.text.isEmpty) {
      Get.snackbar('خطأ', 'يرجى إدخال اسم الطبيب');
      return false;
    }
    if (specialtyController.text.isEmpty) {
      Get.snackbar('خطأ', 'يرجى اختيار تخصص الطبيب');
      return false;
    }
    if (licenseController.text.isEmpty) {
      Get.snackbar('خطأ', 'يرجى إدخال رقم الترخيص');
      return false;
    }
    if (phoneController.text.isEmpty) {
      Get.snackbar('خطأ', 'يرجى إدخال رقم الهاتف');
      return false;
    }
    return true;
  }

  // إلغاء العملية
  void cancel() {
    Get.back();
  }
}