import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../app/data/appointment_model.dart';
import '../../controllers/appointments_controller.dart';

class UploadResultBottomSheet extends StatelessWidget {
  final AppointmentModel item;
  final AppointmentsController controller;

  const UploadResultBottomSheet({super.key, required this.item, required this.controller});

  static const _blue = Color(0xFF2E90FA);

  @override
  Widget build(BuildContext context) {
    final theme     = Theme.of(context);
    final cs        = theme.colorScheme;
    final fileName  = Rxn<String>();

    return Container(
      padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 24.h),
      decoration: BoxDecoration(
        color: cs.surface,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
        boxShadow: [BoxShadow(color: _blue.withValues(alpha: 0.08), blurRadius: 30, offset: const Offset(0, -10))],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _Handle(cs: cs),
          16.verticalSpace,
          _SheetTitle(patientName: item.patientName, theme: theme, cs: cs),
          20.verticalSpace,
          Obx(() => _UploadArea(fileName: fileName.value, onTap: () => fileName.value = '${item.id}_result.pdf', theme: theme, cs: cs)),
          20.verticalSpace,
          _ActionRow(
            fileName: fileName,
            onUpload: () async {
              await controller.uploadResultForItem(item.id, '/uploads/${fileName.value}');
              Get.back();
              Get.snackbar(
                'تم الرفع', 'تم رفع نتيجة التحليل بنجاح',
                backgroundColor: _blue.withValues(alpha: 0.9),
                colorText: Colors.white,
                icon: const Icon(Icons.check_circle_rounded, color: Colors.white),
                snackPosition: SnackPosition.TOP,
              );
            },
            theme: theme,
            cs: cs,
          ),
        ],
      ),
    );
  }
}

// ─── Sub-widgets ──────────────────────────────────────────────────────────────

class _Handle extends StatelessWidget {
  final ColorScheme cs;
  const _Handle({required this.cs});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 44.w, height: 4.h,
        decoration: BoxDecoration(color: cs.outlineVariant, borderRadius: BorderRadius.circular(999)),
      ),
    );
  }
}

class _SheetTitle extends StatelessWidget {
  final String patientName;
  final ThemeData theme;
  final ColorScheme cs;
  const _SheetTitle({required this.patientName, required this.theme, required this.cs});

  static const _blue = Color(0xFF2E90FA);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(10.r),
          decoration: BoxDecoration(color: _blue.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(12.r)),
          child: Icon(Icons.upload_file_rounded, color: _blue, size: 24.sp),
        ),
        12.horizontalSpace,
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('رفع نتيجة التحليل', style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800, color: _blue)),
            Text(patientName, style: theme.textTheme.bodyMedium?.copyWith(color: cs.onSurfaceVariant)),
          ],
        ),
      ],
    );
  }
}

class _UploadArea extends StatelessWidget {
  final String? fileName;
  final VoidCallback onTap;
  final ThemeData theme;
  final ColorScheme cs;
  const _UploadArea({required this.fileName, required this.onTap, required this.theme, required this.cs});

  static const _blue = Color(0xFF2E90FA);

  @override
  Widget build(BuildContext context) {
    final hasFile = fileName != null;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        padding: EdgeInsets.all(20.r),
        decoration: BoxDecoration(
          color: hasFile ? _blue.withValues(alpha: 0.06) : cs.surfaceContainerHighest.withValues(alpha: 0.4),
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(
            color: hasFile ? _blue.withValues(alpha: 0.4) : cs.outlineVariant,
            width: hasFile ? 1.5 : 1,
          ),
        ),
        child: Column(
          children: [
            Container(
              width: 64.r, height: 64.r,
              decoration: BoxDecoration(
                color: hasFile ? _blue.withValues(alpha: 0.1) : cs.outlineVariant.withValues(alpha: 0.3),
                shape: BoxShape.circle,
              ),
              child: Icon(
                hasFile ? Icons.picture_as_pdf_rounded : Icons.cloud_upload_rounded,
                size: 32.sp,
                color: hasFile ? _blue : cs.onSurfaceVariant.withValues(alpha: 0.5),
              ),
            ),
            12.verticalSpace,
            Text(
              fileName ?? 'اضغط لاختيار ملف PDF',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: hasFile ? _blue : cs.onSurfaceVariant,
                fontWeight: hasFile ? FontWeight.w700 : FontWeight.w500,
              ),
            ),
            if (!hasFile) ...[
              6.verticalSpace,
              Text('PDF فقط • حجم أقصى 10MB', style: theme.textTheme.bodySmall?.copyWith(color: cs.onSurfaceVariant.withValues(alpha: 0.5))),
            ],
          ],
        ),
      ),
    );
  }
}

class _ActionRow extends StatelessWidget {
  final Rxn<String> fileName;
  final VoidCallback onUpload;
  final ThemeData theme;
  final ColorScheme cs;
  const _ActionRow({required this.fileName, required this.onUpload, required this.theme, required this.cs});

  static const _blue = Color(0xFF2E90FA);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final hasFile = fileName.value != null;
      return Row(
        children: [
          Expanded(
            child: OutlinedButton(
              onPressed: Get.back,
              style: OutlinedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 14.h),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14.r)),
                side: BorderSide(color: cs.outlineVariant),
              ),
              child: Text('إلغاء', style: theme.textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w700, color: cs.onSurfaceVariant)),
            ),
          ),
          12.horizontalSpace,
          Expanded(
            flex: 2,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: hasFile
                      ? [_blue.withValues(alpha: 0.85), _blue]
                      : [cs.outlineVariant, cs.outlineVariant],
                ),
                borderRadius: BorderRadius.circular(14.r),
                boxShadow: hasFile
                    ? [BoxShadow(color: _blue.withValues(alpha: 0.35), blurRadius: 12, offset: const Offset(0, 4))]
                    : [],
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: hasFile ? onUpload : null,
                  borderRadius: BorderRadius.circular(14.r),
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 14.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.upload_rounded, color: Colors.white, size: 20.sp),
                        8.horizontalSpace,
                        Text('رفع الملف', style: theme.textTheme.labelLarge?.copyWith(color: Colors.white, fontWeight: FontWeight.w800)),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      );
    });
  }
}
