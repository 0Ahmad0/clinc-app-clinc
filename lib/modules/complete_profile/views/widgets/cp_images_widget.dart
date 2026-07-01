import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:io';

import '../../../../generated/locale_keys.g.dart';
import '../../controllers/complete_profile_controller.dart';

class CPImagesWidget extends GetView<CompleteProfileController> {
  const CPImagesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // تعريف متغيرات الثيم لسهولة الاستخدام
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return SizedBox(
      height: 220.h,
      child: Stack(
        children: [
          // Banner Image
          GestureDetector(
            onTap: () => controller.pickImage(true),
            child: Obx(
              () => Container(
                height: 160.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  // لون الخلفية من الثيم (surfaceVariant عادة رمادي فاتح)
                  color: colorScheme.surfaceContainerHighest,
                  image: controller.coverImage.value != null
                      ? DecorationImage(
                          image: FileImage(
                            File(controller.coverImage.value!.path),
                          ),
                          fit: BoxFit.cover,
                        )
                      : null,
                ),
                child: controller.coverImage.value == null
                    ? Center(
                        child: Text(
                          tr(LocaleKeys.complete_profile_fields_banner_hint),
                          // ستايل النص من الثيم
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: colorScheme.onSurfaceVariant,
                          ),
                        ),
                      )
                    : null,
              ),
            ),
          ),

          // Profile Image
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Center(
              child: GestureDetector(
                onTap: () => controller.pickImage(false),
                child: Stack(
                  children: [
                    Obx(
                      () => Container(
                        height: 110.h,
                        width: 110.h,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: colorScheme.surface,
                          // لون خلفية التطبيق
                          border: Border.all(
                            color: colorScheme.surface,
                            width: 4,
                          ),
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 5,
                              color: colorScheme.shadow.withValues(alpha: 0.1),
                            ),
                          ],
                          image: controller.logoImage.value != null
                              ? DecorationImage(
                                  image: FileImage(
                                    File(controller.logoImage.value!.path),
                                  ),
                                  fit: BoxFit.cover,
                                )
                              : null,
                        ),
                        child: controller.logoImage.value == null
                            ? Icon(
                                Icons.add_a_photo,
                                color: colorScheme.onSurfaceVariant,
                                size: 30.sp,
                              )
                            : null,
                      ),
                    ),

                    // أيقونة التعديل الصغيرة
                    Positioned(
                      bottom: 5,
                      right: 5,
                      child: CircleAvatar(
                        radius: 14.r,
                        // اللون الرئيسي للتطبيق
                        backgroundColor: colorScheme.primary,
                        child: Icon(
                          Icons.edit,
                          // اللون المناسب فوق اللون الرئيسي (عادة أبيض)
                          color: colorScheme.onPrimary,
                          size: 14.sp,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
