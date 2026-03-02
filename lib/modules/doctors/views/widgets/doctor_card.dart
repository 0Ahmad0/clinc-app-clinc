import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../../app/data/doctor_model.dart';
import 'dart:io';

import '../../../../generated/locale_keys.g.dart';

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

    // تحديد اللغة لعرض الاسم المناسب
    final bool isAr = context.locale.languageCode == 'ar';
    final String displayName = isAr ? doctor.nameAr : doctor.nameEn;

    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(20.r),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(20.r),
          child: Padding(
            padding: EdgeInsets.all(12.w),
            child: Row(
              children: [
                // 1. الصورة مع مؤشر الحالة
                Stack(
                  children: [
                    Container(
                      width: 80.r,
                      height: 80.r,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16.r),
                        color: theme.primaryColor.withOpacity(0.1),
                        image: doctor.imagePath.isNotEmpty
                            ? DecorationImage(
                          image: FileImage(File(doctor.imagePath)),
                          fit: BoxFit.cover,
                        )
                            : const DecorationImage(
                          image: NetworkImage('https://via.placeholder.com/150'), // Placeholder
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 6,
                      right: 6,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                        decoration: BoxDecoration(
                          color: doctor.isAvailable ? Colors.green : Colors.red,
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Text(
                          doctor.isAvailable
                              ? tr(LocaleKeys.doctors_page_status_active)
                              : tr(LocaleKeys.doctors_page_status_inactive),
                          style: TextStyle(color: Colors.white, fontSize: 8.sp, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
                16.horizontalSpace,

                // 2. المعلومات
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        displayName,
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 16.sp,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      6.verticalSpace,
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                        decoration: BoxDecoration(
                          color: theme.primaryColor.withOpacity(0.08),
                          borderRadius: BorderRadius.circular(6.r),
                        ),
                        child: Text(
                          doctor.specialty,
                          style: TextStyle(
                            color: theme.primaryColor,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      6.verticalSpace,
                      Row(
                        children: [
                          Icon(Icons.star, color: Colors.amber, size: 14.sp),
                          4.horizontalSpace,
                          Text(
                            "${doctor.yearsOfExperience} ${tr(LocaleKeys.doctor_details_labels_experience)}", // يمكن تعديل النص ليظهر "5 سنوات" فقط
                            style: theme.textTheme.bodySmall?.copyWith(color: Colors.grey),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // 3. زر التبديل السريع
                Column(
                  children: [
                    IconButton(
                      onPressed: onToggleStatus,
                      icon: Icon(
                        doctor.isAvailable ? Icons.check_circle : Icons.do_not_disturb_on,
                        color: doctor.isAvailable ? Colors.green : Colors.grey,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
