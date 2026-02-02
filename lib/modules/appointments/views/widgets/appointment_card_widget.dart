import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../../app/data/appointment_model.dart';
import '../../../../app/extension/appointment_type_extensions.dart';
import '../../../../app/routes/app_routes.dart';
import '../../../../generated/locale_keys.g.dart';

class AppointmentCardWidget extends StatelessWidget {
  final AppointmentModel item;

  const AppointmentCardWidget({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final statusColor = _getStatusColor(context, item.status);
    final dt = DateFormat('EEE, MMM d • hh:mm a').format(item.dateTime);

    return InkWell(
      borderRadius: BorderRadius.circular(18.r),
      onTap: () => Get.toNamed(AppRoutes.appointmentsDetails, arguments: item),
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: cs.surface,
          borderRadius: BorderRadius.circular(18.r),
          border: Border.all(color: cs.outlineVariant.withOpacity(0.3)),
          boxShadow: [
            BoxShadow(
              color: cs.shadow.withOpacity(0.05),
              blurRadius: 15,
              offset: const Offset(0, 5),
            ),
          ],
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              cs.surface,
              cs.surface.withOpacity(0.9),
            ],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                // Patient Avatar
                Hero(
                  tag: 'appointment_${item.id}',
                  child: CircleAvatar(
                    radius: 24.r,
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
                ),
                12.horizontalSpace,

                // Patient Info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.patientName,
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w800,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      4.verticalSpace,
                      Text(
                        item.title,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: cs.onSurfaceVariant,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),

                // Status Chip
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.w,
                    vertical: 6.h,
                  ),
                  decoration: BoxDecoration(
                    color: statusColor.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(999),
                    border: Border.all(
                      color: statusColor.withOpacity(0.3),
                    ),
                  ),
                  child: Text(
                    tr(item.status.key()),
                    style: theme.textTheme.labelMedium?.copyWith(
                      color: statusColor,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),

            16.verticalSpace,

            // Date & Time
            Row(
              children: [
                Icon(
                  Icons.schedule,
                  size: 18.sp,
                  color: cs.onSurfaceVariant,
                ),
                8.horizontalSpace,
                Text(
                  dt,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: cs.onSurfaceVariant,
                  ),
                ),
                const Spacer(),
                Icon(
                  Icons.chevron_right,
                  size: 24.sp,
                  color: cs.onSurfaceVariant,
                ),
              ],
            ),

            8.verticalSpace,

            // Type & Phone
            Row(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 8.w,
                    vertical: 4.h,
                  ),
                  decoration: BoxDecoration(
                    color: cs.secondaryContainer.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(6.r),
                  ),
                  child: Text(
                    tr(item.type.key()),
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: cs.secondary,
                    ),
                  ),
                ),
                if (item.patientPhone != null) ...[
                  8.horizontalSpace,
                  Icon(
                    Icons.phone,
                    size: 16.sp,
                    color: cs.onSurfaceVariant,
                  ),
                  4.horizontalSpace,
                  Text(
                    item.patientPhone!,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: cs.onSurfaceVariant,
                    ),
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }

  Color _getStatusColor(BuildContext context, AppointmentStatus status) {
    final cs = Theme.of(context).colorScheme;
    switch (status) {
      case AppointmentStatus.pending:
        return cs.tertiary;
      case AppointmentStatus.approved:
        return cs.primary;
      case AppointmentStatus.completed:
        return Colors.green;
      case AppointmentStatus.rejected:
        return cs.error;
    }
  }
}