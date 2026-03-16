import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../app/data/appointment_model.dart';
import 'appointment_helpers.dart';

class AppointmentHeroHeader extends StatelessWidget {
  final AppointmentModel appointment;
  final Color statusColor;
  const AppointmentHeroHeader({super.key, required this.appointment, required this.statusColor});

  @override
  Widget build(BuildContext context) {
    final theme       = Theme.of(context);
    final a           = appointment;
    final statusLabel = AppointmentHelper.statusLabel(a.status);
    final typeLabel   = AppointmentHelper.typeLabel(a.type);
    final typeIcon    = AppointmentHelper.typeIcon(a.type);

    return SliverAppBar(
      pinned: true,
      expandedHeight: 240.h,
      backgroundColor: statusColor,
      elevation: 0,
      leading: Padding(
        padding: EdgeInsets.all(8.r),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.2),
            shape: BoxShape.circle,
          ),
          child: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white, size: 18),
            onPressed: Get.back,
          ),
        ),
      ),
      flexibleSpace: FlexibleSpaceBar(
        collapseMode: CollapseMode.pin,
        background: _HeroBackground(
          appointment: a,
          statusColor: statusColor,
          statusLabel: statusLabel,
          typeLabel: typeLabel,
          typeIcon: typeIcon,
        ),
      ),
    );
  }
}

// ─── Background ───────────────────────────────────────────────────────────────

class _HeroBackground extends StatelessWidget {
  final AppointmentModel appointment;
  final Color statusColor;
  final String statusLabel;
  final String typeLabel;
  final IconData typeIcon;

  const _HeroBackground({
    required this.appointment,
    required this.statusColor,
    required this.statusLabel,
    required this.typeLabel,
    required this.typeIcon,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final a     = appointment;

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [statusColor, statusColor.withValues(alpha: 0.75)],
        ),
      ),
      child: Stack(
        children: [
          _DecorativeCircle(top: -30, right: -30, size: 160),
          _DecorativeCircle(bottom: -20, left: -20, size: 120),
          SafeArea(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  60.verticalSpace,
                  _PatientAvatar(appointment: a),
                  10.verticalSpace,
                  Text(
                    a.patientName,
                    style: theme.textTheme.titleLarge?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  8.verticalSpace,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _HeaderBadge(icon: typeIcon, label: typeLabel),
                      8.horizontalSpace,
                      _HeaderBadge(label: statusLabel),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DecorativeCircle extends StatelessWidget {
  final double? top;
  final double? bottom;
  final double? left;
  final double? right;
  final double size;
  const _DecorativeCircle({this.top, this.bottom, this.left, this.right, required this.size});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: top, bottom: bottom, left: left, right: right,
      child: Container(
        width: size.r, height: size.r,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white.withValues(alpha: 0.07),
        ),
      ),
    );
  }
}

class _PatientAvatar extends StatelessWidget {
  final AppointmentModel appointment;
  const _PatientAvatar({required this.appointment});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Hero(
      tag: 'appt_avatar_${appointment.id}',
      child: Container(
        width: 72.r, height: 72.r,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white.withValues(alpha: 0.25),
          border: Border.all(color: Colors.white.withValues(alpha: 0.5), width: 2),
        ),
        child: Center(
          child: Text(
            appointment.patientName.isNotEmpty ? appointment.patientName[0] : '؟',
            style: theme.textTheme.headlineMedium?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
      ),
    );
  }
}

class _HeaderBadge extends StatelessWidget {
  final IconData? icon;
  final String label;
  const _HeaderBadge({this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 5.h),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: Colors.white.withValues(alpha: icon != null ? 0.4 : 0)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 13.sp, color: Colors.white),
            5.horizontalSpace,
          ],
          Text(
            label,
            style: theme.textTheme.labelMedium?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
