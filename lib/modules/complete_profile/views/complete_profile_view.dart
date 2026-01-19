import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../app/core/widgets/app_button_widget.dart';
import '../../../app/core/widgets/app_scaffold_widget.dart';
import '../../../generated/locale_keys.g.dart';
import '../controllers/complete_profile_controller.dart';
import 'widgets/cp_images_widget.dart';
import 'widgets/cp_info_widget.dart';
import 'widgets/cp_schedule_widget.dart';

class CompleteProfileView extends GetView<CompleteProfileController> {
  const CompleteProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffoldWidget(
      appBar: AppBar(
        title: Text(tr(LocaleKeys.complete_profile_title)),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          TextButton(
            onPressed: controller.skip,
            child: Text(
              tr(LocaleKeys.complete_profile_skip),
              style: TextStyle(color: Colors.grey, fontSize: 14.sp),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.only(bottom: 40.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // 1. قسم الصور (بانر + بروفايل)
            const CPImagesWidget(),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  24.verticalSpace,
                  // 2. قسم المعلومات (اختصاص + هاتف)
                  const CPInfoWidget(),

                  32.verticalSpace,
                  Text(
                    tr(LocaleKeys.complete_profile_sections_schedule),
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  16.verticalSpace,

                  // 3. جدول الدوام (الوحش)
                  const CPScheduleWidget(),

                  40.verticalSpace,

                  // زر الحفظ
                  AppButtonWidget(
                    text: tr(LocaleKeys.complete_profile_buttons_save_finish),
                    onPressed: controller.saveDataAndFinish,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
