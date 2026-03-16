import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../controllers/services_controller.dart';
import 'add_service_sheet.dart';
import 'service_add_card.dart';
import 'service_card.dart';

/// Reactive grid of active specialties + an "Add" card at the end.
class ServicesSpecialtiesGrid extends GetView<ServicesController> {
  const ServicesSpecialtiesGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => GridView.builder(
      padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 100.h),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 14.w,
        mainAxisSpacing: 14.h,
        childAspectRatio: 0.88,
      ),
      itemCount: controller.activeSpecialties.length + 1,
      itemBuilder: (_, i) {
        if (i == controller.activeSpecialties.length) {
          return ServiceAddCard(
            label: 'إضافة تخصص',
            onTap: () => Get.bottomSheet(const AddSpecialtySheet(), isScrollControlled: true),
          );
        }
        final spec = controller.activeSpecialties[i];
        return ServiceCard(
          title: spec.title,
          subtitle: 'تخصص متاح',
          icon: spec.icon,
          color: spec.color,
          onTap: () {},
          onDelete: () => controller.confirmDelete(
            spec.title,
            () => controller.removeSpecialty(spec),
          ),
        );
      },
    ));
  }
}
