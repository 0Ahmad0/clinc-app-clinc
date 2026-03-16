import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../app/core/design/app_gradients.dart';
import '../../../app/core/widgets/app_gradient_button.dart';
import '../../../generated/locale_keys.g.dart';
import '../controllers/complete_profile_controller.dart';
import 'widgets/cp_images_section.dart';
import 'widgets/cp_info_card.dart';
import 'widgets/cp_schedule_card.dart';

class CompleteProfileView extends GetView<CompleteProfileController> {
  const CompleteProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: Container(
          decoration: const BoxDecoration(gradient: AppGradients.purple),
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: Text(
              tr(LocaleKeys.complete_profile_title),
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w800,
              ),
            ),
            centerTitle: true,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_rounded, color: Colors.white),
              onPressed: () => Get.back(),
            ),
            actions: [
              TextButton(
                onPressed: controller.skip,
                child: Text(
                  tr(LocaleKeys.complete_profile_skip),
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.85),
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
         
        padding: EdgeInsets.only(bottom: 40.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const CPImagesSection(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  24.verticalSpace,
                  const CPInfoCard(),
                  24.verticalSpace,
                  const CPScheduleCard(),
                  32.verticalSpace,
                  Obx(() => AppGradientButton(
                    label: tr(LocaleKeys.complete_profile_buttons_save_finish),
                    isLoading: controller.isLoading.value,
                    onTap: controller.saveDataAndFinish,
                    gradient: AppGradients.purple,
                    shadowColor: AppGradients.purpleShadow,
                  )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
