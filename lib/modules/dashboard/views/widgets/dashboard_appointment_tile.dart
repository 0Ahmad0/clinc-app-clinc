import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../../../generated/locale_keys.g.dart';

class DashboardAppointmentTile extends StatelessWidget {
  final Map<String, String> item;

  const DashboardAppointmentTile({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final status = item['status']!;

    // تحديد ألوان الحالة بناءً على الثيم إذا أمكن، أو ألوان ثابتة منطقية
    Color statusBg;
    Color statusText;
    String statusKey;

    switch (status) {
      case 'upcoming':
        statusBg = const Color(0xFFFFF8E1); // أصفر فاتح جداً
        statusText = const Color(0xFFFBC02D);
        statusKey = LocaleKeys.dashboard_status_upcoming;
        break;
      case 'cancelled':
        statusBg = colorScheme.errorContainer;
        statusText = colorScheme.error;
        statusKey = LocaleKeys.dashboard_status_cancelled;
        break;
      case 'completed':
        statusBg = const Color(0xFFE8F5E9);
        statusText = const Color(0xFF43A047);
        statusKey = LocaleKeys.dashboard_status_completed;
        break;
      default:
        statusBg = colorScheme.surfaceVariant;
        statusText = colorScheme.onSurface;
        statusKey = '';
    }

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
              color: colorScheme.shadow.withOpacity(0.04),
              blurRadius: 10,
              offset: const Offset(0, 2)
          )
        ],
      ),
      child: Row(
        children: [
          // الصورة
          Container(
            width: 50.r,
            height: 50.r,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: colorScheme.surfaceVariant,
              image: const DecorationImage(
                image: AssetImage('assets/images/placeholder_patient.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          16.horizontalSpace,

          // المعلومات
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item['name']!,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: colorScheme.onSurface,
                  ),
                ),
                4.verticalSpace,
                Text(
                  item['doc']!,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),

          // الوقت والبادج
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                item['time']!,
                style: theme.textTheme.labelLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: colorScheme.onSurface,
                ),
              ),
              8.verticalSpace,
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: statusBg,
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Text(
                  tr(statusKey),
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: statusText,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}