import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../app/data/doctor_model.dart';
import '../../controllers/doctors_controller.dart';

class DoctorCard extends StatelessWidget {
  final DoctorModel doctor;
  final VoidCallback onTap;
  final VoidCallback onToggleStatus;

  const DoctorCard({
    Key? key,
    required this.doctor,
    required this.onTap,
    required this.onToggleStatus,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final specColor = DoctorsController.specialtyColor(doctor.specialty);
    final initials = _getInitials(doctor.nameAr);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: cs.surface,
          borderRadius: BorderRadius.circular(20.r),
          border: Border(
            right: BorderSide(color: specColor, width: 4),
          ),
          boxShadow: [
            BoxShadow(
              color: specColor.withValues(alpha: 0.08),
              blurRadius: 20,
              offset: const Offset(0, 6),
            ),
            BoxShadow(
              color: cs.shadow.withValues(alpha: 0.04),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.all(14.w),
          child: Row(
            children: [
              _Avatar(
                  initials: initials, color: specColor, gender: doctor.gender),
              14.horizontalSpace,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            doctor.nameAr,
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w800,
                              letterSpacing: -0.2,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        _AvailabilityBadge(isAvailable: doctor.isAvailable),
                      ],
                    ),
                    6.verticalSpace,
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 10.w, vertical: 4.h),
                      decoration: BoxDecoration(
                        color: specColor.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(999),
                      ),
                      child: Text(
                        doctor.specialty,
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: specColor,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    8.verticalSpace,
                    Row(
                      children: [
                        _StatBadge(
                          icon: Icons.workspace_premium_rounded,
                          value: '${doctor.yearsOfExperience} سنوات',
                          color: const Color(0xFFF59E0B),
                          cs: cs,
                          theme: theme,
                        ),
                        8.horizontalSpace,
                        _StatBadge(
                          icon: Icons.payments_rounded,
                          value: '\$${doctor.fee.toInt()}',
                          color: const Color(0xFF16B364),
                          cs: cs,
                          theme: theme,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              12.horizontalSpace,
              Column(
                children: [
                  GestureDetector(
                    onTap: onToggleStatus,
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 250),
                      width: 40.r,
                      height: 22.r,
                      decoration: BoxDecoration(
                        color: doctor.isAvailable
                            ? const Color(0xFF16B364)
                            : cs.outlineVariant,
                        borderRadius: BorderRadius.circular(999),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(3.r),
                        child: AnimatedAlign(
                          duration: const Duration(milliseconds: 250),
                          alignment: doctor.isAvailable
                              ? Alignment.centerLeft
                              : Alignment.centerRight,
                          child: Container(
                            width: 16.r,
                            height: 16.r,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  6.verticalSpace,
                  Icon(
                    Icons.chevron_left_rounded,
                    size: 20.sp,
                    color: cs.onSurfaceVariant.withValues(alpha: 0.5),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _getInitials(String name) {
    final parts = name.replaceAll('د.', '').trim().split(' ');
    if (parts.length >= 2) {
      return '${parts[0][0]}${parts[1][0]}';
    }
    return parts[0].isNotEmpty ? parts[0][0] : '؟';
  }
}

class _Avatar extends StatelessWidget {
  final String initials;
  final Color color;
  final String gender;

  const _Avatar(
      {required this.initials, required this.color, required this.gender});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 56.r,
      height: 56.r,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [color.withValues(alpha: 0.7), color],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.3),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Center(
        child: Text(
          initials,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w900,
            fontSize: 16.sp,
          ),
        ),
      ),
    );
  }
}

class _AvailabilityBadge extends StatelessWidget {
  final bool isAvailable;
  const _AvailabilityBadge({required this.isAvailable});

  @override
  Widget build(BuildContext context) {
    final color =
        isAvailable ? const Color(0xFF16B364) : const Color(0xFF6B7280);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 6.r,
            height: 6.r,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          4.horizontalSpace,
          Text(
            isAvailable ? 'متاح' : 'غير متاح',
            style: TextStyle(
              color: color,
              fontSize: 10.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

class _StatBadge extends StatelessWidget {
  final IconData icon;
  final String value;
  final Color color;
  final ColorScheme cs;
  final ThemeData theme;

  const _StatBadge({
    required this.icon,
    required this.value,
    required this.color,
    required this.cs,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 12.sp, color: color),
        4.horizontalSpace,
        Text(
          value,
          style: theme.textTheme.bodySmall?.copyWith(
            color: cs.onSurfaceVariant,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
