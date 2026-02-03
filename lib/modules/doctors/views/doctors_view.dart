import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../app/data/doctor_model.dart';
import '../controllers/doctors_controller.dart';
import 'widgets/doctor_card.dart';

class DoctorsView extends GetView<DoctorsController> {
  const DoctorsView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    return Scaffold(
      backgroundColor: cs.surface,
      floatingActionButton: FloatingActionButton(
        onPressed: controller.goToAddDoctor,
        backgroundColor: cs.primary,
        child: Icon(Icons.add, color: cs.onPrimary),
      ),
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // 1. Sliver App Bar
          SliverAppBar(
            pinned: true,
            floating: true,
            backgroundColor: cs.surface,
            elevation: 0,
            centerTitle: true,
            title: Text(
              "الأطباء",
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w800,
              ),
            ),
            actions: [
              IconButton(
                icon: Icon(Icons.search, color: cs.onSurface),
                onPressed: () {
                  // TODO: فتح شريط البحث
                },
              ),
              IconButton(
                icon: Icon(Icons.filter_list, color: cs.onSurface),
                onPressed: () {
                  // TODO: فتح فلتر الأطباء
                },
              ),
            ],
          ),

          // 2. قائمة الأطباء
          Obx(() {
            if (controller.doctorList.isEmpty) {
              return SliverFillRemaining(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.person_search_outlined,
                        size: 80.sp,
                        color: cs.onSurface.withOpacity(0.3),
                      ),
                      24.verticalSpace,
                      Text(
                        "لا يوجد أطباء",
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      8.verticalSpace,
                      Text(
                        "يمكنك إضافة طبيب جديد بالضغط على الزر أدناه",
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: cs.onSurface.withOpacity(0.6),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              );
            }

            return SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                      (context, index) {
                    final doctor = controller.doctorList[index];
                    return Padding(
                      padding: EdgeInsets.only(bottom: 16.h),
                      child: DoctorCard(
                        doctor: doctor,
                        onTap: () => controller.goToDoctorDetails(doctor.id),
                        onToggleStatus: () => controller.toggleDoctorStatus(doctor.id),
                      ),
                    );
                  },
                  childCount: controller.doctorList.length,
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}