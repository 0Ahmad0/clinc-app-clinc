import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../app/core/widgets/app_detail_card.dart';
import '../../../../app/core/widgets/app_gradient_button.dart';
import '../../../../app/data/appointment_model.dart';
import '../../../../app/extension/appointment_type_extensions.dart';
import '../../controllers/appointment_details_controller.dart';
import 'reject_bottom_sheet.dart';
import 'upload_result_bottom_sheet.dart';

class AppointmentActionsCard extends GetView<AppointmentDetailsController> {
  const AppointmentActionsCard({super.key});

  static const _teal  = Color(0xFF009688);
  static const _green = Color(0xFF16B364);
  static const _red   = Color(0xFFF04438);
  static const _blue  = Color(0xFF2E90FA);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final a       = controller.appointment.value;
      final loading = controller.isLoading.value;

      if (a.status == AppointmentStatus.completed ||
          a.status == AppointmentStatus.rejected) {
        return const SizedBox.shrink();
      }

      return AppDetailCard(
        icon: Icons.touch_app_rounded,
        title: 'الإجراءات',
        iconColor: _teal,
        child: Column(
          children: [
            if (loading)
              Padding(
                padding: EdgeInsets.only(bottom: 12.h),
                child: LinearProgressIndicator(
                  color: _teal,
                  backgroundColor: _teal.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(999),
                ),
              ),
            if (a.status == AppointmentStatus.pending)
              _PendingButtons(a: a, loading: loading),
            if (a.status == AppointmentStatus.approved)
              _ApprovedButtons(a: a, loading: loading),
          ],
        ),
      );
    });
  }
}

// ─── Pending Buttons ──────────────────────────────────────────────────────────

class _PendingButtons extends GetView<AppointmentDetailsController> {
  final AppointmentModel a;
  final bool loading;
  const _PendingButtons({required this.a, required this.loading});

  static const _red   = Color(0xFFF04438);
  static const _green = Color(0xFF16B364);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: AppOutlineGradientButton(
            label: 'رفض',
            borderColor: _red,
            textColor: _red,
            prefixIcon: Icon(Icons.close_rounded, color: _red, size: 18.sp),
            height: 48,
            onTap: loading
                ? null
                : () => Get.bottomSheet(
                      RejectBottomSheet(item: a, controller: controller.listController),
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                    ),
          ),
        ),
        12.horizontalSpace,
        Expanded(
          child: AppGradientButton(
            label: 'قبول',
            gradient: LinearGradient(colors: [_green.withValues(alpha: 0.85), _green]),
            shadowColor: _green.withValues(alpha: 0.35),
            prefixIcon: Icon(Icons.check_rounded, color: Colors.white, size: 18.sp),
            height: 48,
            onTap: loading ? null : controller.approve,
          ),
        ),
      ],
    );
  }
}

// ─── Approved Buttons ─────────────────────────────────────────────────────────

class _ApprovedButtons extends GetView<AppointmentDetailsController> {
  final AppointmentModel a;
  final bool loading;
  const _ApprovedButtons({required this.a, required this.loading});

  static const _teal = Color(0xFF009688);
  static const _blue = Color(0xFF2E90FA);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (a.type == AppointmentType.labTest)
          Padding(
            padding: EdgeInsets.only(bottom: 10.h),
            child: AppGradientButton(
              label: 'رفع نتيجة التحليل',
              gradient: LinearGradient(colors: [_blue.withValues(alpha: 0.85), _blue]),
              shadowColor: _blue.withValues(alpha: 0.35),
              prefixIcon: Icon(Icons.upload_file_rounded, color: Colors.white, size: 18.sp),
              height: 48,
              onTap: loading
                  ? null
                  : () => Get.bottomSheet(
                        UploadResultBottomSheet(item: a, controller: controller.listController),
                        isScrollControlled: true,
                        backgroundColor: Colors.transparent,
                      ),
            ),
          ),
        AppGradientButton(
          label: 'إكمال الموعد',
          gradient: LinearGradient(colors: [_teal.withValues(alpha: 0.85), _teal]),
          shadowColor: _teal.withValues(alpha: 0.35),
          prefixIcon: Icon(Icons.task_alt_rounded, color: Colors.white, size: 18.sp),
          height: 48,
          onTap: loading ? null : controller.complete,
        ),
      ],
    );
  }
}
