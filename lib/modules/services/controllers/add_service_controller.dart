import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../app/data/service_model.dart';
import 'services_controller.dart';

class AddServiceController extends GetxController {
  final ServiceModel? editModel = Get.arguments;
  bool get isEdit => editModel != null;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  late TextEditingController nameController;
  late TextEditingController priceController;
  late TextEditingController durationController;

  final RxString selectedSpecialtyId = ''.obs;
  final RxBool isActive = true.obs;

  // نحصل على قائمة الأقسام من الكنترولر الرئيسي
  final ServicesController mainController = Get.find();

  @override
  void onInit() {
    super.onInit();
    nameController = TextEditingController(text: editModel?.name ?? '');
    priceController = TextEditingController(text: editModel?.price.toString() ?? '');
    durationController = TextEditingController(text: editModel?.durationMin.toString() ?? '');

    if (isEdit) {
      selectedSpecialtyId.value = editModel!.specialtyId;
      isActive.value = editModel!.isActive;
    } else if (mainController.specialties.isNotEmpty) {
      // Default selection
      selectedSpecialtyId.value = mainController.specialties.first.id;
    }
  }

  void save() {
    if (!formKey.currentState!.validate()) return;
    if (selectedSpecialtyId.value.isEmpty) {
      Get.snackbar("Error", "Please select a specialty");
      return;
    }

    // Save Logic Here...
    Get.back();
    Get.snackbar("Done", isEdit ? "Service Updated" : "Service Added");
  }

  @override
  void onClose() {
    nameController.dispose();
    priceController.dispose();
    durationController.dispose();
    super.onClose();
  }
}