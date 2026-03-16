import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../controllers/services_controller.dart';
import '../sub_tests_view.dart';
import 'add_service_sheet.dart';
import 'service_add_card.dart';
import 'service_card.dart';

/// Reactive grid of active lab categories + an "Add" card at the end.
class ServicesLabsGrid extends GetView<ServicesController> {
  const ServicesLabsGrid({super.key});

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
      itemCount: controller.activeLabCategories.length + 1,
      itemBuilder: (_, i) {
        if (i == controller.activeLabCategories.length) {
          return ServiceAddCard(
            label: 'إضافة قسم تحاليل',
            onTap: () => Get.bottomSheet(const AddLabSheet(), isScrollControlled: true),
          );
        }
        final cat = controller.activeLabCategories[i];
        return Obx(() => ServiceCard(
          title: cat.title,
          subtitle: '${cat.activeTestsCount} تحليل مفعل',
          icon: cat.icon,
          color: cat.color,
          onTap: () => Get.to(() => SubTestsView(category: cat)),
          onDelete: () => controller.confirmDelete(
            cat.title,
            () => controller.removeLabCategory(cat),
          ),
        ));
      },
    ));
  }
}
