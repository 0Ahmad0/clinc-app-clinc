import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app/data/specialty_model.dart';
import '../views/widgets/icon_picker_dialog.dart';

class AddSpecialtyController extends GetxController {
  // استقبال البيانات إذا كان تعديل
  final SpecialtyModel? editModel = Get.arguments;
  bool get isEdit => editModel != null;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late TextEditingController nameController;
  late TextEditingController descController;

  // State
  final Rx<IconData> selectedIcon = Icons.local_hospital.obs;
  final Rx<Color> selectedColor = Colors.blue.obs;

  // الألوان المتاحة للاختيار
  final List<Color> availableColors = [
    Colors.blue, Colors.red, Colors.green, Colors.orange,
    Colors.purple, Colors.teal, Colors.pink, Colors.indigo
  ];

  @override
  void onInit() {
    super.onInit();
    // تعبئة البيانات إذا كان تعديل
    nameController = TextEditingController(text: editModel?.name ?? '');
    descController = TextEditingController(text: editModel?.description ?? '');
    if (isEdit) {
      selectedIcon.value = editModel!.icon;
      selectedColor.value = editModel!.color;
    }
  }

  void pickIcon() {
    Get.bottomSheet(
      const IconPickerDialog(),
      isScrollControlled: true,
    );
  }

  // يتم استدعاؤها من داخل الـ Dialog
  void setIcon(IconData icon) {
    selectedIcon.value = icon;
    Get.back();
  }

  void setColor(Color color) {
    selectedColor.value = color;
  }

  void save() {
    if (!formKey.currentState!.validate()) return;

    // Logic to save to API or Local List
    if (isEdit) {
      // Update logic...
      Get.back();
      Get.snackbar("Done", "Specialty Updated");
    } else {
      // Create logic...
      Get.back();
      Get.snackbar("Done", "Specialty Added");
    }
  }

  @override
  void onClose() {
    nameController.dispose();
    descController.dispose();
    super.onClose();
  }
}
