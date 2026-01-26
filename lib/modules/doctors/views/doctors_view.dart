import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../generated/locale_keys.g.dart';
import '../controllers/doctors_controller.dart';
import 'widgets/add_doctor_button.dart';
import 'widgets/doctor_list_item.dart';

class DoctorsView extends GetView<DoctorsController> {
  const DoctorsView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            pinned: true,
            backgroundColor: colorScheme.background,
            elevation: 0,
            centerTitle: true,
            title: Text(
              tr(LocaleKeys.doctors_page_title),
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: colorScheme.onBackground,
              ),
            ),
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: colorScheme.onBackground),
              onPressed: () => Get.back(),
            ),
          ),

          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
            sliver: SliverToBoxAdapter(
              child: const AddDoctorButton(),
            ),
          ),

          SliverPadding(
            padding: EdgeInsets.fromLTRB(20.w, 10.h, 20.w, 10.h),
            sliver: SliverToBoxAdapter(
              child: Text(
                tr(LocaleKeys.doctors_page_registered_title),
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: colorScheme.onBackground,
                ),
              ),
            ),
          ),

          Obx(() => SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                    (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(bottom: 12.h),
                    child: DoctorListItem(
                      item: controller.doctorList[index],
                      onTap: () => controller.goToDoctorDetails(
                          controller.doctorList[index]['id'] as int
                      ),
                    ),
                  );
                },
                childCount: controller.doctorList.length,
              ),
            ),
          )),

          // مسافة سفلية
          SliverToBoxAdapter(child: SizedBox(height: 20.h)),
        ],
      ),
    );
  }
}