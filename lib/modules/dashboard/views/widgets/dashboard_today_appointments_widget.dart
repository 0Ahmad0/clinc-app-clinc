import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../app/extension/localization_extension.dart';
import '../../../../app/data/appointment_model.dart';
import '../../../../app/extension/appointment_type_extensions.dart';
import '../../../../app/routes/app_routes.dart';
import '../../models/dashboard_model.dart';

class DashboardTodayAppointmentsWidget extends StatelessWidget {
  const DashboardTodayAppointmentsWidget({
    super.key,
    required this.appointments,
  });

  final List<DashboardAppointment> appointments;

  @override
  Widget build(BuildContext context) {
    if (appointments.isEmpty) {
      return SliverToBoxAdapter(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
          child: Center(child: Text(tr('dashboard.no_appointments'))),
        ),
      );
    }

    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      sliver: SliverList.separated(
        itemCount: appointments.length,
        separatorBuilder: (_, _) => 12.verticalSpace,
        itemBuilder: (context, index) =>
            _AppointmentCard(appointment: appointments[index]),
      ),
    );
  }
}

class _AppointmentCard extends StatelessWidget {
  const _AppointmentCard({required this.appointment});

  final DashboardAppointment appointment;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final statusStyle = _statusStyle(appointment.status);

    return InkWell(
      onTap: () => Get.toNamed(
        AppRoutes.appointmentsDetails,
        arguments: _detailsAppointment(),
      ),
      borderRadius: BorderRadius.circular(16.r),
      child: Container(
        padding: EdgeInsets.all(14.w),
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: theme.colorScheme.outlineVariant),
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 23.r,
              backgroundColor: theme.colorScheme.primaryContainer,
              child: Icon(
                _consultationIcon(appointment.consultationIcon),
                color: theme.colorScheme.onPrimaryContainer,
              ),
            ),
            14.horizontalSpace,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    appointment.patientName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  5.verticalSpace,
                  Text(
                    appointment.consultationType,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
            10.horizontalSpace,
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  appointment.time.trNumbers(),
                  style: theme.textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                8.verticalSpace,
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.w,
                    vertical: 4.h,
                  ),
                  decoration: BoxDecoration(
                    color: statusStyle.color.withValues(alpha: .14),
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Text(
                    tr(statusStyle.translationKey),
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: statusStyle.color,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  IconData _consultationIcon(String value) {
    switch (value) {
      case 'cardiology':
        return Icons.monitor_heart_outlined;
      case 'dental':
        return Icons.medical_services_outlined;
      case 'lab':
        return Icons.biotech_outlined;
      default:
        return Icons.health_and_safety_outlined;
    }
  }

  AppointmentModel _detailsAppointment() {
    final timeParts = appointment.time.split(':');
    final now = DateTime.now();
    return AppointmentModel(
      id: appointment.appointmentId,
      patientName: appointment.patientName,
      title: appointment.consultationType,
      type: appointment.consultationIcon == 'lab'
          ? AppointmentType.labTest
          : AppointmentType.consultation,
      dateTime: DateTime(
        now.year,
        now.month,
        now.day,
        int.tryParse(timeParts.first) ?? 0,
        int.tryParse(timeParts.last) ?? 0,
      ),
      status: _appointmentStatus(appointment.status),
    );
  }

  AppointmentStatus _appointmentStatus(String status) {
    switch (status) {
      case 'confirmed':
        return AppointmentStatus.approved;
      case 'completed':
        return AppointmentStatus.completed;
      case 'cancelled':
      case 'rejected':
        return AppointmentStatus.rejected;
      default:
        return AppointmentStatus.pending;
    }
  }

  _StatusStyle _statusStyle(String status) {
    switch (status) {
      case 'confirmed':
        return const _StatusStyle(Colors.blue, 'appointments.status.approved');
      case 'completed':
        return const _StatusStyle(
          Colors.green,
          'appointments.status.completed',
        );
      case 'cancelled':
      case 'rejected':
        return const _StatusStyle(
          Colors.redAccent,
          'appointments.status.rejected',
        );
      default:
        return const _StatusStyle(Colors.orange, 'appointments.status.pending');
    }
  }
}

class _StatusStyle {
  const _StatusStyle(this.color, this.translationKey);

  final Color color;
  final String translationKey;
}
