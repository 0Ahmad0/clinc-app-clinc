import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../app/data/doctor_model.dart';

class DoctorDetailsStatsRow extends StatelessWidget {
  final DoctorModel doctor;
  final Color specColor;
  const DoctorDetailsStatsRow({super.key, required this.doctor, required this.specColor});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: _StatCard(value: '${doctor.yearsOfExperience}', label: 'سنة خبرة',   icon: Icons.workspace_premium_rounded, color: const Color(0xFFF59E0B))),
        8.horizontalSpace,
        Expanded(child: _StatCard(value: '\$${doctor.fee.toInt()}',     label: 'رسوم الكشف', icon: Icons.payments_rounded,          color: const Color(0xFF16B364))),
        8.horizontalSpace,
        Expanded(
          child: _StatCard(
            value: doctor.isAvailable ? 'متاح' : 'مشغول',
            label: 'الحالة',
            icon:  doctor.isAvailable ? Icons.check_circle_rounded : Icons.cancel_rounded,
            color: doctor.isAvailable ? const Color(0xFF16B364) : const Color(0xFFF04438),
          ),
        ),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  final String value;
  final String label;
  final IconData icon;
  final Color color;
  const _StatCard({required this.value, required this.label, required this.icon, required this.color});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs    = theme.colorScheme;

    return Container(
      padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 8.w),
      decoration: BoxDecoration(
        color: cs.surface,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: color.withValues(alpha: 0.2)),
        boxShadow: [
          BoxShadow(color: color.withValues(alpha: 0.08), blurRadius: 12, offset: const Offset(0, 4)),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(8.r),
            decoration: BoxDecoration(color: color.withValues(alpha: 0.1), shape: BoxShape.circle),
            child: Icon(icon, color: color, size: 18.sp),
          ),
          8.verticalSpace,
          Text(value, style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w900), textAlign: TextAlign.center),
          4.verticalSpace,
          Text(label, style: theme.textTheme.labelSmall?.copyWith(color: cs.onSurfaceVariant.withValues(alpha: 0.6)), textAlign: TextAlign.center),
        ],
      ),
    );
  }
}
