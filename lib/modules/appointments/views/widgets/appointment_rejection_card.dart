import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../app/core/widgets/app_detail_card.dart';
import '../../../../app/core/widgets/app_info_row.dart';
import '../../../../app/data/appointment_model.dart';
import 'appointment_helpers.dart';

class AppointmentRejectionCard extends StatelessWidget {
  final AppointmentModel appointment;
  const AppointmentRejectionCard({super.key, required this.appointment});

  static const _red = Color(0xFFF04438);

  @override
  Widget build(BuildContext context) {
    final theme        = Theme.of(context);
    final a            = appointment;
    final reasonLabel  = AppointmentHelper.rejectReasonLabel(a.rejectReasonKey);
    final hasNote      = (a.rejectNote ?? '').isNotEmpty;

    return AppDetailCard(
      icon: Icons.cancel_rounded,
      title: 'سبب الرفض',
      iconColor: _red,
      backgroundColor: _red.withValues(alpha: 0.04),
      borderColor: _red.withValues(alpha: 0.2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppInfoRow(
            icon: Icons.label_important_rounded,
            label: 'السبب',
            value: reasonLabel,
            valueColor: _red,
            isLast: !hasNote,
          ),
          if (hasNote)
            Padding(
              padding: EdgeInsets.only(top: 8.h),
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(12.r),
                decoration: BoxDecoration(
                  color: _red.withValues(alpha: 0.06),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Text(
                  a.rejectNote!,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: _red.withValues(alpha: 0.8),
                    height: 1.6,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
