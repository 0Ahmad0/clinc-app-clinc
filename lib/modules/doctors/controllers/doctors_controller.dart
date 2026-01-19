import 'package:get/get.dart';

class DoctorsController extends GetxController {

  final doctorList = [
    {'id': 1, 'name': 'Dr. Ethan Carter', 'specialty': 'Cardiology', 'isActive': true},
    {'id': 2, 'name': 'Dr. Olivia Bennett', 'specialty': 'Dermatology', 'isActive': true},
    {'id': 3, 'name': 'Dr. Noah Thompson', 'specialty': 'Neurology', 'isActive': false},
    {'id': 4, 'name': 'Dr. Sophia Harper', 'specialty': 'Pediatrics', 'isActive': true},
    {'id': 5, 'name': 'Dr. Liam Foster', 'specialty': 'Orthopedics', 'isActive': true},
    {'id': 6, 'name': 'Dr. Ava Morgan', 'specialty': 'Oncology', 'isActive': false},
  ].obs;

  void goToAddDoctor() {
    // Get.toNamed(Routes.ADD_DOCTOR);
  }

  void goToDoctorDetails(int id) {
    // Get.toNamed(Routes.DOCTOR_DETAILS, arguments: id);
    // للتجربة السريعة سنطبع الاسم
    final doc = doctorList.firstWhere((e) => e['id'] == id);
    print("Open details for ${doc['name']}");
  }
}