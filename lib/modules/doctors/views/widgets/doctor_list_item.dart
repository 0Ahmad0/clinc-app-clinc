import 'package:clinc_app_clinc/app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../../../generated/locale_keys.g.dart';

class DoctorListItem extends StatelessWidget {
  final Map<String, dynamic> item;
  final VoidCallback onTap;

  const DoctorListItem({
    super.key,
    required this.item,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isActive = item['isActive'] as bool;

    // ألوان الحالة
    final statusColor = isActive ? const Color(0xFF00C853) : const Color(0xFFD32F2F);
    final statusText = isActive
        ? tr(LocaleKeys.doctors_page_status_active)
        : tr(LocaleKeys.doctors_page_status_inactive);

    // صورة الدكتور (لو عندك صورة حقيقية، استبدل المسار)
    final String imagePath = item['image'] ?? 'assets/images/doctor_placeholder.png';
    final String hospital = item['hospital'] ?? "Radiant Hospital";

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16.r),
        child: Container(
          decoration: BoxDecoration(
            color: colorScheme.surface,
            borderRadius: BorderRadius.circular(16.r),
            boxShadow: [
              BoxShadow(
                color: colorScheme.shadow.withOpacity(0.04),
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          padding: EdgeInsets.all(12.w),
          child: Row(
            children: [
              // صورة الدكتور مع نقطة الحالة
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadiusDirectional.only(
                      topStart: Radius.circular(14.r),
                      bottomEnd: Radius.circular(14.r),
                    ),
                    child: Container(
                      width: 80.r,
                      height: 90.r,
                      color: AppColors.primary,
                    ),
                  ),
                  Positioned(
                    top: 6,
                    left: 6,
                    child: Container(
                      width: 12.r,
                      height: 12.r,
                      decoration: BoxDecoration(
                        color: statusColor,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: colorScheme.surface,
                          width: 2,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              16.horizontalSpace,

              // معلومات الدكتور
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // اسم المستشفى/العيادة
                    Text(
                      hospital,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: colorScheme.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    2.verticalSpace,
                    // اسم الدكتور
                    Text(
                      item['name'],
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: colorScheme.onSurface,
                      ),
                    ),
                    2.verticalSpace,
                    // التخصص
                    Text(
                      item['specialty'],
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),

              // زر القائمة (3 نقاط)
              IconButton(
                onPressed: () {
                  // فتح BottomSheet للتعديل أو الحذف
                },
                icon: Icon(
                  Icons.more_vert_rounded,
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}