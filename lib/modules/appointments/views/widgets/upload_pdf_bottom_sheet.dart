import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../../generated/locale_keys.g.dart';
import '../../controllers/appointment_details_controller.dart';

class UploadPdfBottomSheet extends StatelessWidget {
  const UploadPdfBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AppointmentDetailsController>();
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    // GetX Reactive Variables
    final filePath = Rxn<String>();
    final fileName = Rxn<String>();

    Future<void> pickPdf() async {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: const ['pdf'],
        withData: false,
      );

      if (result == null) return;
      final file = result.files.single;
      if (file.path == null) return;

      filePath.value = file.path!;
      fileName.value = file.name;
    }

    return SafeArea(
      child: Container(
        padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 16.h),
        decoration: BoxDecoration(
          color: cs.surface,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
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
            14.verticalSpace,
            Text(
              tr(LocaleKeys.appointments_upload_title),
              style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800),
            ),
            16.verticalSpace,

            Obx(() => Container(
              padding: EdgeInsets.all(14.w),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.r),
                border: Border.all(color: cs.outlineVariant),
              ),
              child: Row(
                children: [
                  Icon(Icons.picture_as_pdf, color: cs.error),
                  10.horizontalSpace,
                  Expanded(
                    child: Text(
                      fileName.value ?? tr(LocaleKeys.appointments_upload_no_file),
                      style: theme.textTheme.bodyMedium?.copyWith(color: cs.onSurfaceVariant),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            )),

            12.verticalSpace,

            OutlinedButton.icon(
              onPressed: pickPdf,
              icon: const Icon(Icons.attach_file),
              label: Text(tr(LocaleKeys.appointments_upload_pick_pdf)),
            ),

            16.verticalSpace,

            ElevatedButton(
              onPressed: () async {
                if (filePath.value == null) {
                  Get.snackbar('Error', tr(LocaleKeys.appointments_upload_validation_pdf_required));
                  return;
                }
                await controller.uploadPdfResult(filePath.value!);
                Get.back();
                Get.snackbar('Success', tr(LocaleKeys.appointments_upload_success));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: cs.primary,
                foregroundColor: cs.onPrimary,
                padding: EdgeInsets.symmetric(vertical: 14.h),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
              ),
              child: Text(
                tr(LocaleKeys.appointments_actions_save),
                style: theme.textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w800),
              ),
            ),
          ],
        ),
      ),
    );
  }
}