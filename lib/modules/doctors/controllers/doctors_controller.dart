import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../app/data/doctor_model.dart';
import '../../../app/routes/app_routes.dart';
import '../views/doctor_details_view.dart';

class DoctorsController extends GetxController {
  // القوائم
  final RxList<DoctorModel> allDoctors = <DoctorModel>[].obs;
  final RxList<DoctorModel> displayedDoctors = <DoctorModel>[].obs;

  // البحث
  final TextEditingController searchController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    _loadMockData();
  }

  void _loadMockData() {
    // بيانات وهمية للتجربة تتطابق مع المودل السابق
    allDoctors.addAll([
      DoctorModel(
        id: '1',
        nameAr: "د. أحمد علي",
        nameEn: "Dr. Ahmed Ali",
        specialty: "Cardiology",
        fee: 150.0,
        isAvailable: true,
        phone: "0599123456",
        email: "ahmed@example.com",
        licenseNumber: "LIC-9920",
        yearsOfExperience: 10,
        about: "طبيب متخصص في أمراض القلب والأوعية الدموية بخبرة 10 سنوات.",
        imagePath: "",
        // يمكن وضع رابط صورة من النت للتجربة
        qualificationFiles: [],
        workingHours: [],
        gender: 'Male',
      ),
      DoctorModel(
        id: '2',
        nameAr: "د. سارة حسن",
        nameEn: "Dr. Sarah Hassan",
        specialty: "Dermatology",
        fee: 200.0,
        isAvailable: false,
        phone: "0599887766",
        email: "sarah@example.com",
        licenseNumber: "LIC-5541",
        yearsOfExperience: 5,
        about: "أخصائية جلدية وتجميل وعلاج بالليزر.",
        imagePath: "",
        qualificationFiles: [],
        workingHours: [],
        gender: 'Male',
      ),
    ]);
    displayedDoctors.assignAll(allDoctors);
  }

  // دالة البحث
  void runSearch(String query) {
    if (query.isEmpty) {
      displayedDoctors.assignAll(allDoctors);
    } else {
      displayedDoctors.assignAll(
        allDoctors.where((doctor) {
          final nameAr = doctor.nameAr.toLowerCase();
          final nameEn = doctor.nameEn.toLowerCase();
          final specialty = doctor.specialty.toLowerCase();
          final q = query.toLowerCase();
          return nameAr.contains(q) ||
              nameEn.contains(q) ||
              specialty.contains(q);
        }).toList(),
      );
    }
  }

  // التنقل
  void goToAddDoctor() {
    Get.toNamed(AppRoutes.addDoctor);
    // للتجربة المباشرة:
    // Get.to(() => DoctorFormView());
  }

  void goToDoctorDetails(DoctorModel doctor) {
    // نمرر الأوبجكت للصفحة
    Get.to(() => DoctorDetailsView(), arguments: doctor);
  }

  void goToEditDoctor(DoctorModel doctor) {
    // Get.toNamed(AppRoutes.addDoctor, arguments: doctor);
    // عند العودة نقوم بتحديث القائمة
  }

  // تبديل الحالة (نشط / غير نشط)
  void toggleStatus(String id) {
    int index = allDoctors.indexWhere((d) => d.id == id);
    if (index != -1) {
      // ننشئ نسخة جديدة مع عكس الحالة
      var doc = allDoctors[index];
      doc.isAvailable = !doc.isAvailable;
      allDoctors[index] = doc;

      // تحديث العرض
      runSearch(searchController.text);
      update();
    }
  }

  // حذف طبيب
  void deleteDoctor(String id) {
    allDoctors.removeWhere((d) => d.id == id);
    runSearch(searchController.text);
    Get.back(); // إغلاق الديالوج أو الصفحة
    Get.snackbar(
      "تم",
      "تم حذف الطبيب بنجاح",
      snackPosition: SnackPosition.BOTTOM,
    );
  }
}
