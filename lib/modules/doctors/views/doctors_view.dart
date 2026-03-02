import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../generated/locale_keys.g.dart';
import '../controllers/doctors_controller.dart';
import 'widgets/doctor_card.dart';

class DoctorsView extends GetView<DoctorsController> {
  const DoctorsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // حقن الكنترولر
    Get.put(DoctorsController());

    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: Colors.grey[50], // خلفية فاتحة جداً
      floatingActionButton: FloatingActionButton.extended(
        onPressed: controller.goToAddDoctor,
        backgroundColor: theme.primaryColor,
        icon: Icon(Icons.add, color: Colors.white),
        label: Text(tr(LocaleKeys.doctors_page_add_button), style: TextStyle(color: Colors.white)),
      ),
      body: CustomScrollView(
        slivers: [
          // 1. App Bar عصري
          SliverAppBar(
            expandedHeight: 120.h,
            floating: true,
            pinned: true,
            backgroundColor: theme.scaffoldBackgroundColor,
            elevation: 0,
            flexibleSpace: FlexibleSpaceBar(
              titlePadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
              title: Text(
                tr(LocaleKeys.doctors_page_title),
                style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
              ),
            ),
          ),

          // 2. شريط البحث
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              child: TextField(
                controller: controller.searchController,
                onChanged: controller.runSearch,
                decoration: InputDecoration(
                  hintText: tr(LocaleKeys.doctors_page_search_hint),
                  prefixIcon: Icon(Icons.search, color: Colors.grey),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.r),
                    borderSide: BorderSide.none,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.r),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: EdgeInsets.symmetric(vertical: 14.h),
                  // ظل خفيف لحقل البحث
                ),
              ),
            ),
          ),

          // 3. القائمة
          Obx(() {
            if (controller.displayedDoctors.isEmpty) {
              return SliverFillRemaining(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.person_off_rounded, size: 80.sp, color: Colors.grey[300]),
                      20.verticalSpace,
                      Text(
                        tr(LocaleKeys.doctors_page_no_doctors),
                        style: theme.textTheme.titleMedium?.copyWith(color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              );
            }
            return SliverPadding(
              padding: EdgeInsets.all(16.w),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                      (context, index) {
                    final doctor = controller.displayedDoctors[index];
                    return DoctorCard(
                      doctor: doctor,
                      onTap: () => controller.goToDoctorDetails(doctor),
                      onToggleStatus: () => controller.toggleStatus(doctor.id!),
                    );
                  },
                  childCount: controller.displayedDoctors.length,
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}
