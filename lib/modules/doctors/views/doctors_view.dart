import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../controllers/doctors_controller.dart';
import 'doctor_details_view.dart';
import 'widgets/doctor_card.dart';
import 'widgets/doctors_add_fab.dart';
import 'widgets/doctors_empty_state.dart';
import 'widgets/doctors_header.dart';
import 'widgets/doctors_search_filter.dart';

class DoctorsView extends GetView<DoctorsController> {
  const DoctorsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: NestedScrollView(
        headerSliverBuilder: (_, __) => [
          SliverToBoxAdapter(child: DoctorsHeader()),
          const DoctorsSearchFilter(),
        ],
        body: Obx(() {
          final list = controller.displayedDoctors;
          if (list.isEmpty) return const DoctorsEmptyState();

          return ListView.separated(
            padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 100.h),
             
            itemCount: list.length,
            separatorBuilder: (_, __) => 12.verticalSpace,
            itemBuilder: (_, i) => DoctorCard(
              doctor: list[i],
              onTap: () => Get.to(() => const DoctorDetailsView(), arguments: list[i]),
              onToggleStatus: () => controller.toggleStatus(list[i].id!),
            ),
          );
        }),
      ),
      floatingActionButton: const DoctorsAddFab(),
    );
  }
}
