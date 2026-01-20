import 'package:clinc_app_clinc/modules/services/views/add_service_view.dart';
import 'package:clinc_app_clinc/modules/services/views/add_specialty_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app/data/service_model.dart';
import '../../../app/data/specialty_model.dart';

class ServicesController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late TabController tabController;

  // ── Data Lists (Mock) ──
  final RxList<SpecialtyModel> specialties = <SpecialtyModel>[
    SpecialtyModel(
      id: '1',
      name: 'Cardiology',
      description: 'Heart Health',
      icon: Icons.monitor_heart_outlined,
      color: Colors.redAccent,
    ),
    SpecialtyModel(
      id: '2',
      name: 'Dermatology',
      description: 'Skin Care',
      icon: Icons.face_retouching_natural,
      color: Colors.purpleAccent,
    ),
    SpecialtyModel(
      id: '3',
      name: 'Neurology',
      description: 'Brain Health',
      icon: Icons.psychology,
      color: Colors.blueAccent,
    ),
    SpecialtyModel(
      id: '4',
      name: 'Orthopedics',
      description: 'Bone Health',
      icon: Icons.accessibility_new,
      color: Colors.teal,
    ),
    SpecialtyModel(
      id: '5',
      name: 'Laboratory',
      description: 'Medical Tests',
      icon: Icons.science,
      color: Colors.orange,
    ),
  ].obs;

  final RxList<ServiceModel> services = <ServiceModel>[
    ServiceModel(
      id: '1',
      name: 'ECG',
      specialtyId: '1',
      specialtyName: 'Cardiology',
      price: 150.0,
      durationMin: 30,
    ),
    ServiceModel(
      id: '2',
      name: 'EEG',
      specialtyId: '3',
      specialtyName: 'Neurology',
      price: 250.0,
      durationMin: 60,
    ),
    ServiceModel(
      id: '3',
      name: 'X-Ray',
      specialtyId: '4',
      specialtyName: 'Orthopedics',
      price: 120.0,
      durationMin: 45,
      isActive: false,
    ),
    ServiceModel(
      id: '4',
      name: 'Complete Blood Count',
      specialtyId: '5',
      specialtyName: 'Laboratory',
      price: 50.0,
      durationMin: 15,
    ),
  ].obs;

  // ── Icon Picking Logic ──
  // هذه القائمة التي ستظهر في واجهة إضافة قسم
  final List<Map<String, dynamic>> availableIcons = [
    {'icon': Icons.local_hospital, 'name': 'General'},
    {'icon': Icons.monitor_heart, 'name': 'Heart'},
    {'icon': Icons.psychology, 'name': 'Brain'},
    {'icon': Icons.science, 'name': 'Lab'},
    {'icon': Icons.visibility, 'name': 'Eye'},
    {'icon': Icons.child_care, 'name': 'Kids'},
    {'icon': Icons.pregnant_woman, 'name': 'Woman'},
    {'icon': Icons.accessibility, 'name': 'Bones'},
    {'icon': Icons.face, 'name': 'Skin'},
    {'icon': Icons.medication, 'name': 'Pharma'},
    {'icon': Icons.healing, 'name': 'Bandage'},
    {'icon': Icons.vaccines, 'name': 'Injection'},
  ];

  final Rx<IconData> selectedIcon = Icons.local_hospital.obs;

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 2, vsync: this);
  }

  void selectIcon(IconData icon) {
    selectedIcon.value = icon;
    Get.back();
  }

  // ── Navigation ──
  void goToAddService() {
    Get.to(AddServiceView());

    // Get.toNamed(Routes.ADD_SERVICE);
  }

  void goToAddSpecialty() {
    Get.to(AddSpecialtyView());
    // Get.toNamed(Routes.ADD_SPECIALTY);
  }
}
