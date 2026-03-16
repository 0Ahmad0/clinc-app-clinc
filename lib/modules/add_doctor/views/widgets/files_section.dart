import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../../generated/locale_keys.g.dart';
import '../../controllers/add_doctor_controller.dart';

class FilesSection extends StatelessWidget {
  final AddDoctorController controller;
  const FilesSection({super.key, required this.controller});

  static const _color = Color(0xFF6A1B9A);

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Column(
      children: [
        _UploadArea(onTap: controller.pickPDFs),
        Obx(() {
          if (controller.qualificationFiles.isEmpty) return const SizedBox.shrink();
          return Column(
            children: [
              12.verticalSpace,
              ...controller.qualificationFiles.asMap().entries.map(
                (e) => _FileItem(
                  name: e.value.split('/').last,
                  onRemove: () => controller.removeFile(e.key),
                  cs: cs,
                ),
              ),
            ],
          );
        }),
      ],
    );
  }
}

// ─── Upload Button ────────────────────────────────────────────────────────────

class _UploadArea extends StatelessWidget {
  final VoidCallback onTap;
  const _UploadArea({required this.onTap});

  static const _color = Color(0xFF6A1B9A);

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 16.h),
        decoration: BoxDecoration(
          border: Border.all(
            color: _color.withValues(alpha: 0.4),
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(14.r),
          color: _color.withValues(alpha: 0.05),
        ),
        child: Column(
          children: [
            Icon(Icons.upload_file_rounded, color: _color, size: 32.sp),
            8.verticalSpace,
            Text(
              tr(LocaleKeys.add_doctor_buttons_upload_files),
              style: TextStyle(
                color: _color,
                fontWeight: FontWeight.w700,
                fontSize: 13.sp,
              ),
            ),
            4.verticalSpace,
            Text(
              'PDF فقط',
              style: TextStyle(color: cs.onSurfaceVariant, fontSize: 11.sp),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── File Row ─────────────────────────────────────────────────────────────────

class _FileItem extends StatelessWidget {
  final String name;
  final VoidCallback onRemove;
  final ColorScheme cs;

  const _FileItem({
    required this.name,
    required this.onRemove,
    required this.cs,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      margin: EdgeInsets.only(bottom: 8.h),
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: cs.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        children: [
          Icon(Icons.picture_as_pdf_rounded, color: Colors.red.shade400, size: 20.sp),
          10.horizontalSpace,
          Expanded(
            child: Text(
              name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: theme.textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w600),
            ),
          ),
          IconButton(
            onPressed: onRemove,
            icon: Icon(Icons.close_rounded, color: Colors.red.shade400, size: 18.sp),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
          ),
        ],
      ),
    );
  }
}
