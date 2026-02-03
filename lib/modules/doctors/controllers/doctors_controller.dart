import 'package:get/get.dart';
import '../../../app/data/doctor_model.dart';
import '../../../app/routes/app_routes.dart';
import '../views/doctor_details_view.dart';

class DoctorsController extends GetxController {
  final RxList<DoctorModel> doctorList = <DoctorModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    _seedMockData();
  }

  void _seedMockData() {
    doctorList.value = [
      DoctorModel(
        id: 1,
        name: 'Dr. Ethan Carter',
        specialty: 'Cardiology',
        hospital: 'Radiant Hospital',
        image: 'assets/images/doctor_1.png',
        isActive: true,
        license: 'MOH-123456',
        phone: '+963999000111',
        email: 'ethan.carter@radiant.com',
        experience: 10,
        about: 'خبرة 10 سنوات في أمراض القلب، عضو الجمعية الطبية العالمية. متابع لأحدث الأبحاث الطبية في مجال القلب والأوعية الدموية.',
        qualifications: ['MD', 'PhD', 'FACC'],
        workingDays: ['الاثنين', 'الأربعاء', 'الجمعة'],
        workingHours: '9:00 AM - 5:00 PM',
      ),
      DoctorModel(
        id: 2,
        name: 'Dr. Olivia Bennett',
        specialty: 'Dermatology',
        hospital: 'Skin Care Center',
        image: 'assets/images/doctor_2.png',
        isActive: true,
        license: 'MOH-234567',
        phone: '+963999000222',
        email: 'olivia.bennett@skincare.com',
        experience: 8,
        about: 'أخصائية جلدية معتمدة مع خبرة 8 سنوات في علاج الأمراض الجلدية والتجميلية.',
        qualifications: ['MD', 'Dermatology Specialist'],
        workingDays: ['الثلاثاء', 'الخميس'],
        workingHours: '10:00 AM - 6:00 PM',
      ),
      // أضف بقية الأطباء بنفس الطريقة
    ];
  }

  void goToAddDoctor() {
    Get.toNamed(AppRoutes.addDoctor);
  }

  void goToDoctorDetails(int id) {
    final doctor = doctorList.firstWhere((e) => e.id == id);
    Get.to(() => const DoctorDetailsView(), arguments: doctor);
  }

  void deleteDoctor(int id) {
    doctorList.removeWhere((doctor) => doctor.id == id);
    Get.back();
    Get.snackbar(
      'تم الحذف',
      'تم حذف الطبيب بنجاح',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Get.theme.colorScheme.primary,
      colorText: Get.theme.colorScheme.onPrimary,
    );
  }

  void toggleDoctorStatus(int id) {
    final index = doctorList.indexWhere((doctor) => doctor.id == id);
    if (index != -1) {
      final updatedDoctor = doctorList[index].copyWith(
        isActive: !doctorList[index].isActive,
      );
      doctorList[index] = updatedDoctor;
    }
  }

}

// إضافة امتداد copyWith إلى DoctorModel
extension DoctorCopy on DoctorModel {
  DoctorModel copyWith({
    int? id,
    String? name,
    String? specialty,
    String? hospital,
    String? image,
    bool? isActive,
    String? license,
    String? phone,
    String? email,
    int? experience,
    String? about,
    List<String>? qualifications,
    List<String>? workingDays,
    String? workingHours,
  }) {
    return DoctorModel(
      id: id ?? this.id,
      name: name ?? this.name,
      specialty: specialty ?? this.specialty,
      hospital: hospital ?? this.hospital,
      image: image ?? this.image,
      isActive: isActive ?? this.isActive,
      license: license ?? this.license,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      experience: experience ?? this.experience,
      about: about ?? this.about,
      qualifications: qualifications ?? this.qualifications,
      workingDays: workingDays ?? this.workingDays,
      workingHours: workingHours ?? this.workingHours,
    );
  }
}