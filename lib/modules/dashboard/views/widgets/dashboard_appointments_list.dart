import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../app/routes/app_routes.dart';
import '../../controllers/dashboard_controller.dart';
import '../../models/dashboard_models.dart';

class DashboardAppointmentsList extends GetView<DashboardController> {
  const DashboardAppointmentsList({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      sliver: SliverList.separated(
        itemCount: controller.todayAppointments.length,
        separatorBuilder: (_, __) => 10.verticalSpace,
        itemBuilder: (_, i) => _AppointmentTile(appt: controller.todayAppointments[i]),
      ),
    );
  }
}

// ─── Appointment Tile ─────────────────────────────────────────────────────────

class _AppointmentTile extends StatelessWidget {
  final DashboardAppointment appt;
  const _AppointmentTile({required this.appt});

  static const _statusMap = {
    DashboardApptStatus.completed: (Color(0xFF10B981), 'مكتمل'),
    DashboardApptStatus.cancelled: (Color(0xFFEF4444), 'ملغي'),
    DashboardApptStatus.upcoming:  (Color(0xFFF59E0B), 'قادم'),
  };

  @override
  Widget build(BuildContext context) {
    final theme                = Theme.of(context);
    final cs                   = theme.colorScheme;
    final (statusColor, label) = _statusMap[appt.status]!;

    return GestureDetector(
      onTap: () => Get.toNamed(AppRoutes.appointments),
      child: Container(
        padding: EdgeInsets.all(14.r),
        decoration: BoxDecoration(
          color: cs.surface,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: statusColor.withValues(alpha: 0.15)),
          boxShadow: [
            BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 10, offset: const Offset(0, 3)),
          ],
        ),
        child: Row(
          children: [
            _ServiceIcon(icon: appt.icon, statusColor: statusColor),
            14.horizontalSpace,
            Expanded(child: _PatientInfo(appt: appt, theme: theme, cs: cs)),
            12.horizontalSpace,
            _TimeAndStatus(time: appt.time, label: label, statusColor: statusColor, theme: theme),
          ],
        ),
      ),
    );
  }
}

class _ServiceIcon extends StatelessWidget {
  final IconData icon;
  final Color statusColor;
  const _ServiceIcon({required this.icon, required this.statusColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 44.r, height: 44.r,
      decoration: BoxDecoration(
        color: statusColor.withValues(alpha: 0.1),
        shape: BoxShape.circle,
        border: Border.all(color: statusColor.withValues(alpha: 0.25), width: 1.5),
      ),
      child: Icon(icon, color: statusColor, size: 20.sp),
    );
  }
}

class _PatientInfo extends StatelessWidget {
  final DashboardAppointment appt;
  final ThemeData theme;
  final ColorScheme cs;
  const _PatientInfo({required this.appt, required this.theme, required this.cs});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          appt.name,
          style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700),
          maxLines: 1, overflow: TextOverflow.ellipsis,
        ),
        4.verticalSpace,
        Text(appt.service, style: theme.textTheme.bodySmall?.copyWith(color: cs.onSurfaceVariant)),
      ],
    );
  }
}

class _TimeAndStatus extends StatelessWidget {
  final String time;
  final String label;
  final Color statusColor;
  final ThemeData theme;
  const _TimeAndStatus({required this.time, required this.label, required this.statusColor, required this.theme});

  @override
  Widget build(BuildContext context) {
    final cs = theme.colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(time, style: theme.textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w700, color: cs.onSurface)),
        6.verticalSpace,
        Container(
          padding: EdgeInsets.symmetric(horizontal: 9.w, vertical: 3.h),
          decoration: BoxDecoration(
            color: statusColor.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(20.r),
          ),
          child: Text(label, style: TextStyle(color: statusColor, fontSize: 10.sp, fontWeight: FontWeight.w700)),
        ),
      ],
    );
  }
}
