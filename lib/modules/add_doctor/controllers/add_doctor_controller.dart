import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddDoctorController extends GetxController {
  // ── Controllers ──
  final TextEditingController nameController = TextEditingController();
  final TextEditingController licenseController = TextEditingController();

  // ── State ──
  final RxString selectedSpecialty = ''.obs;
  final RxString selectedGender = 'male'.obs; // 'male' or 'female'
  final Rxn<String> selectedImagePath = Rxn<String>();

  // قائمة التخصصات
  final List<String> specialties = ['Cardiology', 'Dermatology', 'Neurology', 'Pediatrics'];

  // جدول الدوام (نفس الصورة: أيام وساعات)
  final List<Map<String, dynamic>> workingHours = [
    {'day': 'mon', 'time': '9:00 AM - 5:00 PM', 'isOff': false},
    {'day': 'tue', 'time': '9:00 AM - 5:00 PM', 'isOff': false},
    {'day': 'wed', 'time': '9:00 AM - 5:00 PM', 'isOff': false},
    {'day': 'thu', 'time': '9:00 AM - 5:00 PM', 'isOff': false},
    {'day': 'fri', 'time': '1:00 PM - 9:00 PM', 'isOff': false},
    {'day': 'sat', 'time': 'Off', 'isOff': true},
    {'day': 'sun', 'time': 'Off', 'isOff': true}, // أضفنا الأحد لإكمال الأسبوع
  ].obs;

  // ── Actions ──
  void setGender(String gender) {
    selectedGender.value = gender;
  }

  Future<void> pickImage() async {
    // منطق اختيار الصورة
    print("Picking image...");
  }

  void saveDoctor() {
    // منطق الحفظ
    Get.back();
    Get.snackbar("Success", "Doctor Added Successfully");
  }

  void cancel() {
    Get.back();
  }
}