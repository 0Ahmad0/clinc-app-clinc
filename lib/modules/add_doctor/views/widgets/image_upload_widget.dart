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

    return GestureDetector(
      onTap: controller.pickImage,
      child: Container(
        height: 180.h,
        width: double.infinity,
        decoration: BoxDecoration(
          color: colorScheme.surfaceVariant.withOpacity(0.3), // لون خلفية خفيف جداً
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: colorScheme.outline.withOpacity(0.4),
            style: BorderStyle.solid, // محاكاة للدقة، يمكن استخدام DottedBorder package
            width: 1.5,
          ),
        ),
        // لمحاكاة الـ Dashed Border بدون مكتبات، نستخدم CustomPaint أو نكتفي بالـ Solid للتسريع
        // سأضع المحتوى الداخلي مطابق للصورة
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.cloud_upload_outlined, size: 40.sp, color: Colors.grey),
            12.verticalSpace,
            Text(
              tr(LocaleKeys.add_doctor_upload_drag_drop),
              style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            4.verticalSpace,
            Text(tr(LocaleKeys.add_doctor_upload_or), style: TextStyle(color: Colors.grey)),
            4.verticalSpace,
            Text(
              tr(LocaleKeys.add_doctor_upload_browse),
              style: TextStyle(color: colorScheme.primary, fontWeight: FontWeight.bold),
            ),
            12.verticalSpace,
            Text(
              tr(LocaleKeys.add_doctor_upload_support),
              style: theme.textTheme.bodySmall?.copyWith(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}