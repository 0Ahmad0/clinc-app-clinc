import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:get/get.dart';

import '../../../../app/data/doctor_model.dart';
import '../../controllers/doctors_controller.dart';
import '../../models/doctors_list_model.dart';

class DoctorCard extends StatelessWidget {
  // دعم كل من ClinicDoctor (قديم) و DoctorModel (جديد)
  final ClinicDoctor? clinicDoctor;
  final DoctorModel? doctorModel;
  final VoidCallback onTap;
  final VoidCallback? onToggleStatus;

  const DoctorCard({
    super.key,
    this.clinicDoctor,
    this.doctorModel,
    required this.onTap,
    this.onToggleStatus,
  });

  // ===== Getters للوصول الموحد =====
  String get id => clinicDoctor?.doctorId ?? doctorModel?.id ?? '';

  String get name {
    final isArabic = Get.context?.locale.languageCode == 'ar' ?? true;
    if (clinicDoctor != null) {
      return isArabic ? clinicDoctor!.nameAr : clinicDoctor!.nameEn;
    }
    return isArabic ? doctorModel!.nameAr : doctorModel!.nameEn;
  }

  String get specialty {
    final isArabic = Get.context?.locale.languageCode == 'ar' ?? true;
    if (clinicDoctor != null) {
      return isArabic
          ? clinicDoctor!.specialization.nameAr
          : clinicDoctor!.specialization.nameEn;
    }
    return doctorModel!.specialty;
  }

  bool get isAvailable {
    return clinicDoctor?.isAvailable ?? doctorModel?.isAvailable ?? false;
  }

  int get experienceYears {
    return clinicDoctor?.experienceYears ?? doctorModel?.yearsOfExperience ?? 0;
  }

  double get fee {
    return clinicDoctor?.consultationFee.toDouble() ?? doctorModel?.fee ?? 0.0;
  }

  String get imagePath {
    return clinicDoctor?.image ?? doctorModel?.imagePath ?? '';
  }

  String get gender {
    return doctorModel?.gender ?? 'Male';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final specColor = DoctorsController.specialtyColor(specialty);
    final initials = _getInitials(name);
    final isArabic = context.locale.languageCode == 'ar';

    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: cs.surface,
          borderRadius: BorderRadius.circular(20.r),
          border: Border(right: BorderSide(color: specColor, width: 4)),
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
              // الصورة أو الأحرف الأولى (مدمج من القديم والجديد)
              _Avatar(
                imagePath: imagePath,
                initials: initials,
                color: specColor,
                gender: gender,
              ),
              14.horizontalSpace,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            name,
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w800,
                              letterSpacing: -0.2,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        // حالة التوفر (من الجديد)
                        _AvailabilityBadge(isAvailable: isAvailable),
                      ],
                    ),
                    6.verticalSpace,
                    // التخصص (من الجديد)
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10.w,
                        vertical: 4.h,
                      ),
                      decoration: BoxDecoration(
                        color: specColor.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(999),
                      ),
                      child: Text(
                        specialty,
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: specColor,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    8.verticalSpace,
                    // الإحصائيات (مدمجة من القديم والجديد)
                    Wrap(
                      spacing: 8.w,
                      runSpacing: 6.h,
                      children: [
                        _StatBadge(
                          icon: Icons.workspace_premium_rounded,
                          value: tr(
                            'doctors_page.experience_years',
                            args: [experienceYears.toString()],
                          ),
                          color: const Color(0xFFF59E0B),
                          cs: cs,
                          theme: theme,
                        ),
                        _StatBadge(
                          icon: Icons.payments_rounded,
                          value:
                              '${fee.toInt()} ${tr('dashboard.currency.sar')}',
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
              // زر تبديل الحالة (من الجديد) + السهم (من القديم)
              Column(
                children: [
                  if (onToggleStatus != null)
                    GestureDetector(
                      onTap: onToggleStatus,
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 250),
                        width: 40.r,
                        height: 22.r,
                        decoration: BoxDecoration(
                          color: isAvailable
                              ? const Color(0xFF16B364)
                              : cs.outlineVariant,
                          borderRadius: BorderRadius.circular(999),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(3.r),
                          child: AnimatedAlign(
                            duration: const Duration(milliseconds: 250),
                            alignment: isAvailable
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
                  // السهم (من القديم)
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

// ===== الصورة الرمزية (مدمجة من القديم والجديد) =====
class _Avatar extends StatelessWidget {
  final String imagePath;
  final String initials;
  final Color color;
  final String gender;

  const _Avatar({
    required this.imagePath,
    required this.initials,
    required this.color,
    required this.gender,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bool hasImage = imagePath.isNotEmpty;

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
      child: ClipRRect(
        borderRadius: BorderRadius.circular(28.r),
        child: hasImage
            ? _buildImage()
            : Center(
                child: Text(
                  initials,
                  style: theme.textTheme.headlineSmall?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
      ),
    );
  }

  Widget _buildImage() {
    if (imagePath.startsWith('http')) {
      return Image.network(
        imagePath,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => _buildPlaceholder(),
      );
    }
    return Image.file(
      File(imagePath),
      fit: BoxFit.cover,
      errorBuilder: (_, __, ___) => _buildPlaceholder(),
    );
  }

  Widget _buildPlaceholder() {
    return Center(
      child: Text(
        initials,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w900,
          fontSize: 16.sp,
        ),
      ),
    );
  }
}

// ===== شارة الحالة (من الجديد) =====
class _AvailabilityBadge extends StatelessWidget {
  final bool isAvailable;
  const _AvailabilityBadge({required this.isAvailable});

  @override
  Widget build(BuildContext context) {
    final color = isAvailable
        ? const Color(0xFF16B364)
        : const Color(0xFF6B7280);
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
            isAvailable
                ? tr('doctors_page.status.active')
                : tr('doctors_page.status.inactive'),
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

// ===== شارة الإحصائية (من الجديد) =====
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
