import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../models/doctors_list_model.dart';

class DoctorCard extends StatelessWidget {
  const DoctorCard({super.key, required this.doctor, required this.onTap});

  final ClinicDoctor doctor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isArabic = context.locale.languageCode == 'ar';
    final name = isArabic ? doctor.nameAr : doctor.nameEn;
    final specialty = isArabic
        ? doctor.specialization.nameAr
        : doctor.specialization.nameEn;
    final statusColor = doctor.isAvailable ? Colors.green : Colors.redAccent;

    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Material(
        color: theme.colorScheme.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.r),
          side: BorderSide(color: theme.colorScheme.outlineVariant),
        ),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(18.r),
          child: Padding(
            padding: EdgeInsets.all(12.w),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(14.r),
                  child: Container(
                    width: 76.r,
                    height: 76.r,
                    color: theme.colorScheme.primaryContainer,
                    child: doctor.image?.isNotEmpty == true
                        ? doctor.image!.startsWith('http')
                              ? Image.network(
                                  doctor.image!,
                                  fit: BoxFit.cover,
                                  errorBuilder: (_, _, _) =>
                                      _DoctorPlaceholder(name: name),
                                )
                              : Image.file(
                                  File(doctor.image!),
                                  fit: BoxFit.cover,
                                  errorBuilder: (_, _, _) =>
                                      _DoctorPlaceholder(name: name),
                                )
                        : _DoctorPlaceholder(name: name),
                  ),
                ),
                14.horizontalSpace,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      5.verticalSpace,
                      Text(
                        specialty,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.primary,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      9.verticalSpace,
                      Row(
                        children: [
                          Icon(
                            Icons.workspace_premium_outlined,
                            size: 16.sp,
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                          4.horizontalSpace,
                          Text(
                            tr(
                              'doctors_page.experience_years',
                              args: [doctor.experienceYears.toString()],
                            ),
                            style: theme.textTheme.bodySmall,
                          ),
                          const Spacer(),
                          Text(
                            '${doctor.consultationFee} '
                            '${tr('dashboard.currency.sar')}',
                            style: theme.textTheme.bodySmall?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                10.horizontalSpace,
                Tooltip(
                  message: tr(
                    doctor.isAvailable
                        ? 'doctors_page.status.active'
                        : 'doctors_page.status.inactive',
                  ),
                  child: Container(
                    width: 10.r,
                    height: 10.r,
                    decoration: BoxDecoration(
                      color: statusColor,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _DoctorPlaceholder extends StatelessWidget {
  const _DoctorPlaceholder({required this.name});

  final String name;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        name.characters.first,
        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
          color: Theme.of(context).colorScheme.onPrimaryContainer,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
