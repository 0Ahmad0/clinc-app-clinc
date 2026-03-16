import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../app/data/doctor_model.dart';

class DoctorDetailsContactRow extends StatelessWidget {
  final DoctorModel doctor;
  const DoctorDetailsContactRow({super.key, required this.doctor});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: _ContactBtn(icon: Icons.call_rounded,  label: 'اتصال',    value: doctor.phone,         color: const Color(0xFF16B364))),
        12.horizontalSpace,
        Expanded(child: _ContactBtn(icon: Icons.email_rounded, label: 'إيميل',    value: doctor.email,         color: const Color(0xFF2E90FA))),
        12.horizontalSpace,
        Expanded(child: _ContactBtn(icon: Icons.badge_rounded, label: 'الترخيص', value: doctor.licenseNumber, color: const Color(0xFFF59E0B))),
      ],
    );
  }
}

class _ContactBtn extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color color;
  const _ContactBtn({required this.icon, required this.label, required this.value, required this.color});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: () => Get.snackbar(
        label, value,
        backgroundColor: color.withValues(alpha: 0.9),
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      ),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 14.h),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(color: color.withValues(alpha: 0.2)),
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 22.sp),
            6.verticalSpace,
            Text(label, style: theme.textTheme.labelSmall?.copyWith(color: color, fontWeight: FontWeight.w700)),
          ],
        ),
      ),
    );
  }
}
