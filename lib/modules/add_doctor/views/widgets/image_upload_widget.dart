import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../../generated/locale_keys.g.dart';
import '../../controllers/add_doctor_controller.dart';

class ImageUploadWidget extends GetView<AddDoctorController> {
  const ImageUploadWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Obx(() => GestureDetector(
      onTap: controller.pickImage,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            height: 180.h,
            width: 180.w,
            decoration: BoxDecoration(
              color: colorScheme.surfaceVariant.withOpacity(0.3),
              borderRadius: BorderRadius.circular(20.r),
              border: Border.all(
                color: colorScheme.outline.withOpacity(0.4),
                width: 1.5,
              ),
              image: controller.selectedImagePath.value != null
                  ? DecorationImage(
                image: FileImage(File(controller.selectedImagePath.value!)),
                fit: BoxFit.cover,
              )
                  : null,
            ),
            child: controller.selectedImagePath.value == null
                ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.cloud_upload_outlined,
                  size: 40.sp,
                  color: colorScheme.onSurfaceVariant,
                ),
                12.verticalSpace,
                Text(
                  tr(LocaleKeys.add_doctor_labels_upload_drag_drop),
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: colorScheme.onSurface,
                  ),
                ),
                4.verticalSpace,
                Text(
                  tr(LocaleKeys.add_doctor_labels_upload_or),
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
                4.verticalSpace,
                Text(
                  tr(LocaleKeys.add_doctor_labels_upload_browse),
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            )
                : null,
          ),
          if (controller.selectedImagePath.value != null)
            Positioned(
              top: 8.h,
              right: 8.w,
              child: InkWell(
                onTap: () => controller.selectedImagePath.value = null,
                child: Container(
                  padding: EdgeInsets.all(4.w),
                  decoration: BoxDecoration(
                    color: colorScheme.error,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.close,
                    color: colorScheme.onError,
                    size: 20.sp,
                  ),
                ),
              ),
            ),
        ],
      ),
    ));
  }
}