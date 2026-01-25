import 'package:clinc_app_clinc/app/routes/app_routes.dart';
import 'package:clinc_app_clinc/modules/appointments/views/appointment_details_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../../app/data/appointment_model.dart';
import '../../../../app/extension/appointment_type_extensions.dart';
import '../../controllers/appointment_details_controller.dart';

class AppointmentCardWidget extends StatelessWidget {
  final AppointmentModel item;

  const AppointmentCardWidget({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    final statusColor = _statusColor(context, item.status);
    final dt = DateFormat('EEE, MMM d • hh:mm a').format(item.dateTime);

    return InkWell(
      borderRadius: BorderRadius.circular(18.r),
      onTap: () => Get.toNamed(AppRoutes.appointmentsDetails, arguments: item),
      child: Container(
        padding: EdgeInsets.all(14.w),
        decoration: BoxDecoration(
          color: cs.surface,
          borderRadius: BorderRadius.circular(18.r),
          border: Border.all(color: cs.outlineVariant),
          boxShadow: [
            BoxShadow(
              color: cs.shadow.withOpacity(0.04),
              blurRadius: 14,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 22.r,
              backgroundColor: cs.primaryContainer,
              child: Text(
                item.patientName.isNotEmpty
                    ? item.patientName[0].toUpperCase()
                    : '?',
                style: theme.textTheme.titleMedium?.copyWith(
                  color: cs.onPrimaryContainer,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            12.horizontalSpace,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.patientName,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  4.verticalSpace,
                  Text(
                    item.title,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: cs.onSurfaceVariant,
                    ),
                  ),
                  6.verticalSpace,
                  Row(
                    children: [
                      Icon(
                        Icons.schedule,
                        size: 16.sp,
                        color: cs.onSurfaceVariant,
                      ),
                      6.horizontalSpace,
                      Expanded(
                        child: Text(
                          dt,
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: cs.onSurfaceVariant,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            10.horizontalSpace,
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.w,
                    vertical: 6.h,
                  ),
                  decoration: BoxDecoration(
                    color: statusColor.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: Text(
                    tr(item.status.key().replaceAll('.', '_')),
                    // لو LocaleKeys ما فيه keys للحالات
                    // الأفضل: استخدم tr(LocaleKeys.appointments_status_pending...) إن كان موجود
                    style: theme.textTheme.labelMedium?.copyWith(
                      color: statusColor,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                10.verticalSpace,
                Text(
                  tr(item.type.key().replaceAll('.', '_')),
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: cs.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Color _statusColor(BuildContext context, AppointmentStatus s) {
    final cs = Theme.of(context).colorScheme;
    switch (s) {
      case AppointmentStatus.pending:
        return cs.tertiary;
      case AppointmentStatus.approved:
        return cs.primary;
      case AppointmentStatus.completed:
        // إذا بدك 100% theme-only نعمل ThemeExtension لـ success
        return Colors.green;
      case AppointmentStatus.rejected:
        return cs.error;
    }
  }
}
