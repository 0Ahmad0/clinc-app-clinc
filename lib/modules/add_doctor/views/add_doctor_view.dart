import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../app/core/design/app_gradients.dart';
import '../../../app/core/widgets/app_gradient_button.dart';
import '../../../app/core/widgets/app_section_card.dart';
import '../../../generated/locale_keys.g.dart';
import '../controllers/add_doctor_controller.dart';
import 'widgets/add_doctor_hero_header.dart';
import 'widgets/basic_info_section.dart';
import 'widgets/professional_section.dart';
import 'widgets/files_section.dart';
import 'widgets/working_hours_section.dart';
import 'widgets/availability_section.dart';

class AddDoctorView extends GetView<AddDoctorController> {
  const AddDoctorView({super.key});

  static const _indigoColor = Color(0xFF3949AB);
  static const _blueColor   = Color(0xFF1565C0);
  static const _purpleColor = Color(0xFF6A1B9A);
  static const _tealColor   = Color(0xFF00695C);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Form(
        key: controller.formKey,
        child: CustomScrollView(
           
          slivers: [
            const AddDoctorHeroHeader(),
            SliverPadding(
              padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 120.h),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  24.verticalSpace,
                  AppSectionCard(
                    icon: Icons.person_rounded,
                    title: 'المعلومات الأساسية',
                    color: _indigoColor,
                    child: BasicInfoSection(controller: controller),
                  ),
                  20.verticalSpace,
                  AppSectionCard(
                    icon: Icons.work_rounded,
                    title: 'المعلومات المهنية',
                    color: _blueColor,
                    child: ProfessionalSection(controller: controller),
                  ),
                  20.verticalSpace,
                  AppSectionCard(
                    icon: Icons.attach_file_rounded,
                    title: tr(LocaleKeys.add_doctor_labels_qualification_files),
                    color: _purpleColor,
                    child: FilesSection(controller: controller),
                  ),
                  20.verticalSpace,
                  AppSectionCard(
                    icon: Icons.schedule_rounded,
                    title: tr(LocaleKeys.working_hours_title),
                    color: _tealColor,
                    child: WorkingHoursSection(controller: controller),
                  ),
                  20.verticalSpace,
                  AvailabilitySection(controller: controller),
                ]),
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: _SubmitFab(controller: controller),
    );
  }
}

// ─── Submit FAB ───────────────────────────────────────────────────────────────

class _SubmitFab extends StatelessWidget {
  final AddDoctorController controller;
  const _SubmitFab({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Obx(() => AppGradientButton(
        label: controller.isEditMode.value
            ? tr(LocaleKeys.add_doctor_buttons_update)
            : tr(LocaleKeys.add_doctor_buttons_save),
        gradient: AppGradients.indigo,
        shadowColor: AppGradients.indigoShadow,
        borderRadius: 16,
        height: 54,
        prefixIcon: Icon(Icons.save_rounded, color: Colors.white, size: 20.sp),
        onTap: controller.saveDoctor,
      )),
    );
  }
}
