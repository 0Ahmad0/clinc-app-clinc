import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../app/data/appointment_model.dart';
import '../../controllers/appointments_controller.dart';

class UploadResultBottomSheet extends StatelessWidget {
  final AppointmentModel item;
  final AppointmentsController controller;

  const UploadResultBottomSheet({
    super.key,
    required this.item,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    const blueColor = Color(0xFF2E90FA);
    final fileName = Rxn<String>();

    return Container(
      padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 24.h),
      decoration: BoxDecoration(
        color: cs.surface,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
        boxShadow: [
          BoxShadow(
            color: blueColor.withValues(alpha: 0.08),
            blurRadius: 30,
            offset: const Offset(0, -10),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(
            child: Container(
              width: 44.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: cs.outlineVariant,
                borderRadius: BorderRadius.circular(999),
              ),
            ),
          ),
          16.verticalSpace,
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(10.r),
                decoration: BoxDecoration(
                  color: blueColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Icon(
                  Icons.upload_file_rounded,
                  color: blueColor,
                  size: 24.sp,
                ),
              ),
              12.horizontalSpace,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'رفع نتيجة التحليل',
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w800,
                      color: blueColor,
                    ),
                  ),
                  Text(
                    item.patientName,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: cs.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ],
          ),
          20.verticalSpace,
          Obx(() => GestureDetector(
            onTap: () {
              fileName.value = '${item.id}_result.pdf';
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              padding: EdgeInsets.all(20.w),
              decoration: BoxDecoration(
                color: fileName.value != null
                    ? blueColor.withValues(alpha: 0.06)
                    : cs.surfaceContainerHighest.withValues(alpha: 0.4),
                borderRadius: BorderRadius.circular(20.r),
                border: Border.all(
                  color: fileName.value != null
                      ? blueColor.withValues(alpha: 0.4)
                      : cs.outlineVariant,
                  width: fileName.value != null ? 1.5 : 1,
                  style: fileName.value == null
                      ? BorderStyle.solid
                      : BorderStyle.solid,
                ),
              ),
              child: Column(
                children: [
                  Container(
                    width: 64.r,
                    height: 64.r,
                    decoration: BoxDecoration(
                      color: fileName.value != null
                          ? blueColor.withValues(alpha: 0.1)
                          : cs.outlineVariant.withValues(alpha: 0.3),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      fileName.value != null
                          ? Icons.picture_as_pdf_rounded
                          : Icons.cloud_upload_rounded,
                      size: 32.sp,
                      color: fileName.value != null
                          ? blueColor
                          : cs.onSurfaceVariant.withValues(alpha: 0.5),
                    ),
                  ),
                  12.verticalSpace,
                  Text(
                    fileName.value ?? 'اضغط لاختيار ملف PDF',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: fileName.value != null
                          ? blueColor
                          : cs.onSurfaceVariant,
                      fontWeight: fileName.value != null
                          ? FontWeight.w700
                          : FontWeight.w500,
                    ),
                  ),
                  if (fileName.value == null) ...[
                    6.verticalSpace,
                    Text(
                      'PDF فقط • حجم أقصى 10MB',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: cs.onSurfaceVariant.withValues(alpha: 0.5),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          )),
          20.verticalSpace,
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () => Get.back(),
                  style: OutlinedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 14.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14.r),
                    ),
                    side: BorderSide(color: cs.outlineVariant),
                  ),
                  child: Text(
                    'إلغاء',
                    style: theme.textTheme.labelLarge?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: cs.onSurfaceVariant,
                    ),
                  ),
                ),
              ),
              12.horizontalSpace,
              Expanded(
                flex: 2,
                child: Obx(() => Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: fileName.value == null
                        ? null
                        : () async {
                            await controller.uploadResultForItem(
                              item.id,
                              '/uploads/${fileName.value}',
                            );
                            Get.back();
                            Get.snackbar(
                              'تم الرفع',
                              'تم رفع نتيجة التحليل بنجاح',
                              backgroundColor:
                                  blueColor.withValues(alpha: 0.9),
                              colorText: Colors.white,
                              icon: const Icon(
                                Icons.check_circle_rounded,
                                color: Colors.white,
                              ),
                              snackPosition: SnackPosition.TOP,
                            );
                          },
                    borderRadius: BorderRadius.circular(14.r),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding: EdgeInsets.symmetric(vertical: 14.h),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: fileName.value != null
                              ? [
                                  blueColor.withValues(alpha: 0.85),
                                  blueColor,
                                ]
                              : [
                                  cs.outlineVariant,
                                  cs.outlineVariant,
                                ],
                        ),
                        borderRadius: BorderRadius.circular(14.r),
                        boxShadow: fileName.value != null
                            ? [
                                BoxShadow(
                                  color: blueColor.withValues(alpha: 0.35),
                                  blurRadius: 12,
                                  offset: const Offset(0, 4),
                                ),
                              ]
                            : [],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.upload_rounded,
                            color: Colors.white,
                            size: 20.sp,
                          ),
                          8.horizontalSpace,
                          Text(
                            'رفع الملف',
                            style: theme.textTheme.labelLarge?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
