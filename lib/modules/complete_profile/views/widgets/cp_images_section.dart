import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../app/core/design/app_gradients.dart';
import '../../../../generated/locale_keys.g.dart';
import '../../controllers/complete_profile_controller.dart';

class CPImagesSection extends GetView<CompleteProfileController> {
  const CPImagesSection({super.key});

  static const _purple = Color(0xFF673AB7);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 220.h,
      child: Stack(
        children: [
          _BannerArea(controller: controller),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: _ProfileCircle(controller: controller),
          ),
        ],
      ),
    );
  }
}

class _BannerArea extends StatelessWidget {
  final CompleteProfileController controller;
  const _BannerArea({required this.controller});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => controller.pickImage(true),
      child: Obx(() {
        final path = controller.bannerImagePath.value;
        return Container(
          height: 160.h,
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: AppGradients.purple,
            image: path != null
                ? DecorationImage(
                    image: FileImage(File(path)),
                    fit: BoxFit.cover,
                  )
                : null,
          ),
          child: path == null
              ? Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.add_photo_alternate_rounded,
                        color: Colors.white.withValues(alpha: 0.75),
                        size: 36.r,
                      ),
                      8.verticalSpace,
                      Text(
                        tr(LocaleKeys.complete_profile_fields_banner_hint),
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.8),
                          fontSize: 12.sp,
                        ),
                      ),
                    ],
                  ),
                )
              : null,
        );
      }),
    );
  }
}

class _ProfileCircle extends StatelessWidget {
  final CompleteProfileController controller;
  const _ProfileCircle({required this.controller});

  static const _purple = Color(0xFF673AB7);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: () => controller.pickImage(false),
        child: Obx(() {
          final path = controller.profileImagePath.value;
          return Stack(
            children: [
              Container(
                width: 110.r,
                height: 110.r,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  border: Border.all(color: Colors.white, width: 4),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.15),
                      blurRadius: 15,
                      offset: const Offset(0, 5),
                    ),
                  ],
                  image: path != null
                      ? DecorationImage(
                          image: FileImage(File(path)),
                          fit: BoxFit.cover,
                        )
                      : null,
                ),
                child: path == null
                    ? Icon(
                        Icons.add_a_photo_rounded,
                        color: _purple,
                        size: 30.r,
                      )
                    : null,
              ),
              Positioned(
                bottom: 4,
                right: 4,
                child: Container(
                  width: 28.r,
                  height: 28.r,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: AppGradients.purple,
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                  child: Icon(Icons.edit_rounded, color: Colors.white, size: 13.r),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
