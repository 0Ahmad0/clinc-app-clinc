import 'package:clinc_app_clinc/app/routes/app_routes.dart';
import 'package:clinc_app_clinc/modules/doctors/views/doctor_details_view.dart';
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
    Get.toNamed(AppRoutes.addDoctor);
  }

  void goToDoctorDetails(int id) {
    Get.to(DoctorDetailsView());
    final doc = doctorList.firstWhere((e) => e['id'] == id);
    print("Open details for ${doc['name']}");
  }
}