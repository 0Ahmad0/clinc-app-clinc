import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../app/core/widgets/app_section_card.dart';
import '../../../app/data/doctor_model.dart';
import '../controllers/doctors_controller.dart';
import 'widgets/doctor_details_contact_row.dart';
import 'widgets/doctor_details_hero_appbar.dart';
import 'widgets/doctor_details_stats_row.dart';
import 'widgets/doctor_weekly_schedule.dart';

class DoctorDetailsView extends GetView<DoctorsController> {
  const DoctorDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    final doctor    = Get.arguments as DoctorModel;
    final specColor = DoctorsController.specialtyColor(doctor.specialty);
    final initials  = DoctorsController.getInitials(doctor.nameAr);

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          DoctorDetailsHeroAppBar(doctor: doctor, specColor: specColor, initials: initials),
          SliverPadding(
            padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 40.h),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                DoctorDetailsStatsRow(doctor: doctor, specColor: specColor),
                20.verticalSpace,
                DoctorDetailsContactRow(doctor: doctor),
                20.verticalSpace,
                AppSectionCard(
                  icon: Icons.info_outline_rounded,
                  title: 'نبذة عن الطبيب',
                  color: specColor,
                  child: Text(
                    doctor.about,
                    style: TextStyle(
                      fontSize: 14.sp,
                      height: 1.7,
                      color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.8),
                    ),
                  ),
                ),
                20.verticalSpace,
                AppSectionCard(
                  icon: Icons.calendar_month_rounded,
                  title: 'جدول الدوام الأسبوعي',
                  color: specColor,
                  child: DoctorWeeklySchedule(workingHours: doctor.workingHours, specColor: specColor),
                ),
                20.verticalSpace,
              ]),
            ),
          ),
        ],
      ),
    );
  }
}
