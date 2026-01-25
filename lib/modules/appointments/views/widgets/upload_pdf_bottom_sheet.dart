import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../../../generated/locale_keys.g.dart';
import '../../controllers/appointment_details_controller.dart';

class UploadPdfBottomSheet extends StatefulWidget {
  const UploadPdfBottomSheet({super.key});

  @override
  State<UploadPdfBottomSheet> createState() => _UploadPdfBottomSheetState();
}

class _UploadPdfBottomSheetState extends State<UploadPdfBottomSheet> {
  String? _filePath;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final controller = Get.find<AppointmentDetailsController>();

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
            Text(tr(LocaleKeys.appointments_upload_title),
                style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800)),
            16.verticalSpace,

            Container(
              padding: EdgeInsets.all(14.w),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.r),
                border: Border.all(color: cs.outlineVariant),
                color: cs.surface,
              ),
              child: Row(
                children: [
                  Icon(Icons.picture_as_pdf, color: cs.error),
                  10.horizontalSpace,
                  Expanded(
                    child: Text(
                      _filePath ?? tr(LocaleKeys.appointments_upload_no_file),
                      style: theme.textTheme.bodyMedium?.copyWith(color: cs.onSurfaceVariant),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),

            12.verticalSpace,

            OutlinedButton.icon(
              onPressed: () async {
                // Mock file selection
                setState(() => _filePath = '/storage/mock/result_${DateTime.now().millisecondsSinceEpoch}.pdf');
              },
              icon: const Icon(Icons.attach_file),
              label: Text(tr(LocaleKeys.appointments_upload_pick_pdf)),
            ),

            16.verticalSpace,

            ElevatedButton(
              onPressed: () async {
                if ((_filePath ?? '').isEmpty) {
                  Get.snackbar('Error', tr(LocaleKeys.appointments_upload_validation_pdf_required));
                  return;
                }
                await controller.uploadPdfResult(_filePath!);
                Get.back();
                Get.snackbar('OK', tr(LocaleKeys.appointments_upload_success));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: cs.primary,
                foregroundColor: cs.onPrimary,
                padding: EdgeInsets.symmetric(vertical: 14.h),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
              ),
              child: Text(tr(LocaleKeys.appointments_actions_save),
                  style: theme.textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w800)),
            ),
          ],
        ),
      ),
    );
  }
}