import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../../../app/data/service_model.dart';
import '../../../../generated/locale_keys.g.dart';

class ServiceCardWidget extends StatelessWidget {
  final ServiceModel service;

  const ServiceCardWidget({super.key, required this.service});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(color: colorScheme.outlineVariant.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  service.name,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                4.verticalSpace,
                Text(
                  service.specialtyName, // عرض اسم القسم
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
                8.verticalSpace,

                // Price & Duration
                Row(
                  children: [
                    Text(
                      "${tr(LocaleKeys.services_module_cards_currency)}${service.price}",
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: colorScheme.primary,
                      ),
                    ),
                    8.horizontalSpace,
                    Container(
                      width: 4.r,
                      height: 4.r,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        shape: BoxShape.circle,
                      ),
                    ),
                    8.horizontalSpace,
                    Text(
                      "${service.durationMin} ${tr(LocaleKeys.services_module_cards_min)}",
                      style: theme.textTheme.bodySmall,
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Status Dot & Edit Button
          Column(
            children: [
              Container(
                width: 8.r,
                height: 8.r,
                decoration: BoxDecoration(
                  color: service.isActive ? Colors.green : Colors.red,
                  shape: BoxShape.circle,
                ),
              ),
              16.verticalSpace,
              Container(
                decoration: BoxDecoration(
                  color: colorScheme.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.edit,
                    size: 18.sp,
                    color: colorScheme.primary,
                  ),
                  constraints: const BoxConstraints(), // تقليل حجم الزر
                  padding: EdgeInsets.all(8.w),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
