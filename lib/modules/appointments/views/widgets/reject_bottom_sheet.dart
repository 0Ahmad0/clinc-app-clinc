import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../app/data/appointment_model.dart';
import '../../controllers/appointments_controller.dart';

class RejectBottomSheet extends StatelessWidget {
  final AppointmentModel item;
  final AppointmentsController controller;

  const RejectBottomSheet({
    super.key,
    required this.item,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final reasonKey = Rxn<String>();
    final noteCtrl = TextEditingController();
    const redColor = Color(0xFFF04438);

    final reasons = [
      {'key': 'doctor_unavailable', 'label': 'الطبيب غير متاح'},
      {'key': 'clinic_closed', 'label': 'العيادة مغلقة'},
      {'key': 'invalid_booking', 'label': 'حجز غير صحيح'},
      {'key': 'need_more_info', 'label': 'تحتاج معلومات إضافية'},
      {'key': 'other', 'label': 'أخرى'},
    ];

    return Container(
      padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 24.h),
      decoration: BoxDecoration(
        color: cs.surface,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
        boxShadow: [
          BoxShadow(
            color: redColor.withValues(alpha: 0.08),
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
                  color: redColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Icon(
                  Icons.cancel_rounded,
                  color: redColor,
                  size: 24.sp,
                ),
              ),
              12.horizontalSpace,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'رفض الموعد',
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w800,
                      color: redColor,
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
          Text(
            'سبب الرفض',
            style: theme.textTheme.labelLarge?.copyWith(
              fontWeight: FontWeight.w700,
              color: cs.onSurface,
            ),
          ),
          10.verticalSpace,
          Obx(() => Wrap(
            spacing: 8.w,
            runSpacing: 8.h,
            children: reasons.map((r) {
              final isSelected = reasonKey.value == r['key'];
              return GestureDetector(
                onTap: () => reasonKey.value = r['key'],
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: EdgeInsets.symmetric(
                    horizontal: 14.w,
                    vertical: 8.h,
                  ),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? redColor.withValues(alpha: 0.1)
                        : cs.surfaceContainerHighest.withValues(alpha: 0.5),
                    borderRadius: BorderRadius.circular(999),
                    border: Border.all(
                      color: isSelected
                          ? redColor.withValues(alpha: 0.5)
                          : cs.outlineVariant,
                      width: isSelected ? 1.5 : 1,
                    ),
                  ),
                  child: Text(
                    r['label']!,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: isSelected ? redColor : cs.onSurfaceVariant,
                      fontWeight: isSelected
                          ? FontWeight.w700
                          : FontWeight.w500,
                    ),
                  ),
                ),
              );
            }).toList(),
          )),
          16.verticalSpace,
          Text(
            'ملاحظات إضافية',
            style: theme.textTheme.labelLarge?.copyWith(
              fontWeight: FontWeight.w700,
              color: cs.onSurface,
            ),
          ),
          10.verticalSpace,
          TextField(
            controller: noteCtrl,
            maxLines: 3,
            decoration: InputDecoration(
              hintText: 'اكتب سبب الرفض بالتفصيل...',
              hintStyle: theme.textTheme.bodyMedium?.copyWith(
                color: cs.onSurfaceVariant.withValues(alpha: 0.5),
              ),
              filled: true,
              fillColor: cs.surfaceContainerHighest.withValues(alpha: 0.4),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16.r),
                borderSide: BorderSide(color: cs.outlineVariant),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16.r),
                borderSide: BorderSide(
                  color: cs.outlineVariant.withValues(alpha: 0.5),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16.r),
                borderSide: BorderSide(color: redColor, width: 1.5),
              ),
              contentPadding: EdgeInsets.all(14.r),
            ),
          ),
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
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () async {
                      if (reasonKey.value == null ||
                          noteCtrl.text.trim().isEmpty) {
                        Get.snackbar(
                          'تنبيه',
                          'يرجى اختيار السبب وكتابة ملاحظة',
                          backgroundColor: redColor.withValues(alpha: 0.9),
                          colorText: Colors.white,
                          snackPosition: SnackPosition.TOP,
                        );
                        return;
                      }
                      await controller.rejectItem(
                        item.id,
                        reasonKey: reasonKey.value!,
                        note: noteCtrl.text.trim(),
                      );
                      Get.back();
                      Get.snackbar(
                        'تم الرفض',
                        'تم رفض موعد ${item.patientName}',
                        backgroundColor: redColor.withValues(alpha: 0.9),
                        colorText: Colors.white,
                        icon: const Icon(
                          Icons.cancel_rounded,
                          color: Colors.white,
                        ),
                        snackPosition: SnackPosition.TOP,
                      );
                    },
                    borderRadius: BorderRadius.circular(14.r),
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 14.h),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            redColor.withValues(alpha: 0.85),
                            redColor,
                          ],
                        ),
                        borderRadius: BorderRadius.circular(14.r),
                        boxShadow: [
                          BoxShadow(
                            color: redColor.withValues(alpha: 0.35),
                            blurRadius: 12,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.close_rounded,
                            color: Colors.white,
                            size: 20.sp,
                          ),
                          8.horizontalSpace,
                          Text(
                            'تأكيد الرفض',
                            style: theme.textTheme.labelLarge?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
