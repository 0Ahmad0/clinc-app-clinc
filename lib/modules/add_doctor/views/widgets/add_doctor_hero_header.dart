import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../../generated/locale_keys.g.dart';
import '../../controllers/add_doctor_controller.dart';

class AddDoctorHeroHeader extends GetView<AddDoctorController> {
  const AddDoctorHeroHeader({super.key});

  static const _indigoDark  = Color(0xFF1A237E);
  static const _indigo      = Color(0xFF3949AB);
  static const _cameraGrad1 = Color(0xFF7C4DFF);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return SliverAppBar(
      expandedHeight: 220.h,
      pinned: true,
      backgroundColor: _indigo,
      elevation: 0,
      surfaceTintColor: Colors.transparent,
      leading: IconButton(
        onPressed: Get.back,
        icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white),
      ),
      title: Obx(() => Text(
        controller.isEditMode.value
            ? tr(LocaleKeys.add_doctor_edit_title)
            : tr(LocaleKeys.add_doctor_title),
        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w800),
      )),
      flexibleSpace: FlexibleSpaceBar(
        collapseMode: CollapseMode.pin,
        background: _HeroBackground(isDark: isDark),
      ),
    );
  }
}

// ─── Background ─────────────────────────────────────────────────────────────

class _HeroBackground extends GetView<AddDoctorController> {
  final bool isDark;
  const _HeroBackground({required this.isDark});

  static const _indigoDark  = Color(0xFF1A237E);
  static const _indigo      = Color(0xFF3949AB);
  static const _indigo283   = Color(0xFF283593);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: isDark
              ? [_indigoDark, _indigo283]
              : [_indigo, _indigoDark],
        ),
      ),
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            40.verticalSpace,
            Obx(() => _AvatarPicker(imagePath: controller.selectedImage.value)),
            12.verticalSpace,
            Obx(() => Text(
              controller.isEditMode.value
                  ? tr(LocaleKeys.add_doctor_edit_title)
                  : tr(LocaleKeys.add_doctor_title),
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.sp,
                fontWeight: FontWeight.w800,
                letterSpacing: -0.3,
              ),
            )),
            4.verticalSpace,
            Text(
              'أدخل بيانات الطبيب بشكل كامل',
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.7),
                fontSize: 12.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Avatar Picker ────────────────────────────────────────────────────────────

class _AvatarPicker extends GetView<AddDoctorController> {
  final String imagePath;
  const _AvatarPicker({required this.imagePath});

  static const _cameraGrad1 = Color(0xFF7C4DFF);
  static const _indigo      = Color(0xFF3949AB);

  @override
  Widget build(BuildContext context) {
    final hasImage = imagePath.isNotEmpty;

    return GestureDetector(
      onTap: controller.pickImage,
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          Container(
            width: 90.r,
            height: 90.r,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white.withValues(alpha: 0.15),
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.5),
                width: 2.5,
              ),
              image: hasImage
                  ? DecorationImage(
                      image: FileImage(File(imagePath)),
                      fit: BoxFit.cover,
                    )
                  : null,
            ),
            child: hasImage
                ? null
                : Icon(
                    Icons.person_rounded,
                    color: Colors.white.withValues(alpha: 0.8),
                    size: 42.sp,
                  ),
          ),
          Container(
            width: 28.r,
            height: 28.r,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [_cameraGrad1, _indigo],
              ),
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 2),
            ),
            child: Icon(Icons.camera_alt_rounded, color: Colors.white, size: 14.sp),
          ),
        ],
      ),
    );
  }
}
