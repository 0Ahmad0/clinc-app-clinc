import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../app/core/widgets/app_detail_card.dart';
import '../../../../app/data/appointment_model.dart';

class AppointmentLabResultCard extends StatelessWidget {
  final AppointmentModel appointment;
  const AppointmentLabResultCard({super.key, required this.appointment});

  static const _blue   = Color(0xFF2E90FA);
  static const _green  = Color(0xFF16B364);
  static const _amber  = Color(0xFFF59E0B);
  static const _red    = Color(0xFFF04438);

  @override
  Widget build(BuildContext context) {
    final theme     = Theme.of(context);
    final hasResult = appointment.hasResult;
    final stateColor = hasResult ? _green : _amber;

    return AppDetailCard(
      icon: Icons.science_rounded,
      title: 'نتيجة التحليل',
      iconColor: _blue,
      backgroundColor: _blue.withValues(alpha: 0.04),
      borderColor: _blue.withValues(alpha: 0.2),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(10.r),
            decoration: BoxDecoration(
              color: stateColor.withValues(alpha: 0.12),
              shape: BoxShape.circle,
            ),
            child: Icon(
              hasResult ? Icons.check_circle_rounded : Icons.hourglass_empty_rounded,
              color: stateColor,
              size: 22.sp,
            ),
          ),
          12.horizontalSpace,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  hasResult ? 'تم رفع النتيجة' : 'لم يتم رفع النتيجة بعد',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: stateColor,
                  ),
                ),
                if (hasResult)
                  Text(
                    'اضغط لفتح الملف',
                    style: theme.textTheme.bodySmall?.copyWith(color: _blue),
                  ),
              ],
            ),
          ),
          if (hasResult)
            Icon(Icons.picture_as_pdf_rounded, color: _red, size: 28.sp),
        ],
      ),
    );
  }
}
