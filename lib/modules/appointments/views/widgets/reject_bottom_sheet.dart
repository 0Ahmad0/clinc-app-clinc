import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../app/core/widgets/app_gradient_button.dart';
import '../../../../app/data/appointment_model.dart';
import '../../controllers/appointments_controller.dart';

class RejectBottomSheet extends StatelessWidget {
  final AppointmentModel item;
  final AppointmentsController controller;

  const RejectBottomSheet({super.key, required this.item, required this.controller});

  static const _red = Color(0xFFF04438);

  static const _reasons = [
    _RejectReason('doctor_unavailable', 'الطبيب غير متاح'),
    _RejectReason('clinic_closed',      'العيادة مغلقة'),
    _RejectReason('invalid_booking',    'حجز غير صحيح'),
    _RejectReason('need_more_info',     'تحتاج معلومات إضافية'),
    _RejectReason('other',              'أخرى'),
  ];

  @override
  Widget build(BuildContext context) {
    final theme      = Theme.of(context);
    final cs         = theme.colorScheme;
    final reasonKey  = Rxn<String>();
    final noteCtrl   = TextEditingController();

    return Container(
      padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 24.h),
      decoration: BoxDecoration(
        color: cs.surface,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
        boxShadow: [BoxShadow(color: _red.withValues(alpha: 0.08), blurRadius: 30, offset: const Offset(0, -10))],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _BottomSheetHandle(cs: cs),
          16.verticalSpace,
          _SheetTitle(patientName: item.patientName, theme: theme, cs: cs),
          20.verticalSpace,
          _ReasonSelector(reasons: _reasons, reasonKey: reasonKey, theme: theme, cs: cs),
          16.verticalSpace,
          _NotesField(controller: noteCtrl, theme: theme, cs: cs),
          20.verticalSpace,
          _ConfirmRow(
            onCancel: Get.back,
            onConfirm: () async {
              if (reasonKey.value == null || noteCtrl.text.trim().isEmpty) {
                Get.snackbar(
                  'تنبيه', 'يرجى اختيار السبب وكتابة ملاحظة',
                  backgroundColor: _red.withValues(alpha: 0.9),
                  colorText: Colors.white,
                  snackPosition: SnackPosition.TOP,
                );
                return;
              }
              await controller.rejectItem(item.id, reasonKey: reasonKey.value!, note: noteCtrl.text.trim());
              Get.back();
              Get.snackbar(
                'تم الرفض', 'تم رفض موعد ${item.patientName}',
                backgroundColor: _red.withValues(alpha: 0.9),
                colorText: Colors.white,
                icon: const Icon(Icons.cancel_rounded, color: Colors.white),
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

class _BottomSheetHandle extends StatelessWidget {
  final ColorScheme cs;
  const _BottomSheetHandle({required this.cs});

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

  static const _red = Color(0xFFF04438);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(10.r),
          decoration: BoxDecoration(color: _red.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(12.r)),
          child: Icon(Icons.cancel_rounded, color: _red, size: 24.sp),
        ),
        12.horizontalSpace,
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('رفض الموعد', style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800, color: _red)),
            Text(patientName, style: theme.textTheme.bodyMedium?.copyWith(color: cs.onSurfaceVariant)),
          ],
        ),
      ],
    );
  }
}

class _ReasonSelector extends StatelessWidget {
  final List<_RejectReason> reasons;
  final Rxn<String> reasonKey;
  final ThemeData theme;
  final ColorScheme cs;
  const _ReasonSelector({required this.reasons, required this.reasonKey, required this.theme, required this.cs});

  static const _red = Color(0xFFF04438);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('سبب الرفض', style: theme.textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w700)),
        10.verticalSpace,
        Obx(() => Wrap(
          spacing: 8.w, runSpacing: 8.h,
          children: reasons.map((r) {
            final isSelected = reasonKey.value == r.key;
            return GestureDetector(
              onTap: () => reasonKey.value = r.key,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
                decoration: BoxDecoration(
                  color: isSelected ? _red.withValues(alpha: 0.1) : cs.surfaceContainerHighest.withValues(alpha: 0.5),
                  borderRadius: BorderRadius.circular(999),
                  border: Border.all(
                    color: isSelected ? _red.withValues(alpha: 0.5) : cs.outlineVariant,
                    width: isSelected ? 1.5 : 1,
                  ),
                ),
                child: Text(
                  r.label,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: isSelected ? _red : cs.onSurfaceVariant,
                    fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                  ),
                ),
              ),
            );
          }).toList(),
        )),
      ],
    );
  }
}

class _NotesField extends StatelessWidget {
  final TextEditingController controller;
  final ThemeData theme;
  final ColorScheme cs;
  const _NotesField({required this.controller, required this.theme, required this.cs});

  static const _red = Color(0xFFF04438);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('ملاحظات إضافية', style: theme.textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w700)),
        10.verticalSpace,
        TextField(
          controller: controller,
          maxLines: 3,
          decoration: InputDecoration(
            hintText: 'اكتب سبب الرفض بالتفصيل...',
            hintStyle: theme.textTheme.bodyMedium?.copyWith(color: cs.onSurfaceVariant.withValues(alpha: 0.5)),
            filled: true,
            fillColor: cs.surfaceContainerHighest.withValues(alpha: 0.4),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(16.r), borderSide: BorderSide(color: cs.outlineVariant)),
            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16.r), borderSide: BorderSide(color: cs.outlineVariant.withValues(alpha: 0.5))),
            focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16.r), borderSide: BorderSide(color: _red, width: 1.5)),
            contentPadding: EdgeInsets.all(14.r),
          ),
        ),
      ],
    );
  }
}

class _ConfirmRow extends StatelessWidget {
  final VoidCallback onCancel;
  final VoidCallback onConfirm;
  final ThemeData theme;
  final ColorScheme cs;
  const _ConfirmRow({required this.onCancel, required this.onConfirm, required this.theme, required this.cs});

  static const _red = Color(0xFFF04438);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
            onPressed: onCancel,
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
          child: AppGradientButton(
            label: 'تأكيد الرفض',
            gradient: LinearGradient(colors: [_red.withValues(alpha: 0.85), _red]),
            shadowColor: _red.withValues(alpha: 0.35),
            prefixIcon: Icon(Icons.close_rounded, color: Colors.white, size: 20.sp),
            borderRadius: 14,
            height: 50,
            onTap: onConfirm,
          ),
        ),
      ],
    );
  }
}

// ─── Data ─────────────────────────────────────────────────────────────────────

class _RejectReason {
  final String key;
  final String label;
  const _RejectReason(this.key, this.label);
}
