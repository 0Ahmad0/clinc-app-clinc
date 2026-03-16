import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../app/extension/appointment_type_extensions.dart';
import '../../controllers/appointments_controller.dart';

class AppointmentsHeader extends GetView<AppointmentsController> {
  const AppointmentsHeader({super.key});

  static const _gradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF00695C), Color(0xFF009688), Color(0xFF26A69A)],
  );

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      decoration: const BoxDecoration(gradient: _gradient),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 20.h),
          child: Row(
            children: [
              _PageIcon(),
              14.horizontalSpace,
              Expanded(child: _TitleColumn(theme: theme)),
              _StatsRow(),
            ],
          ),
        ),
      ),
    );
  }
}

// ─── Icon Box ─────────────────────────────────────────────────────────────────

class _PageIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.r),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(14.r),
      ),
      child: Icon(Icons.calendar_month_rounded, color: Colors.white, size: 26.sp),
    );
  }
}

// ─── Title + Subtitle ─────────────────────────────────────────────────────────

class _TitleColumn extends GetView<AppointmentsController> {
  final ThemeData theme;
  const _TitleColumn({required this.theme});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'المواعيد',
          style: theme.textTheme.headlineSmall?.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.w900,
            letterSpacing: -0.5,
          ),
        ),
        Obx(() {
          final total   = controller.items.length;
          final pending = controller.items
              .where((e) => e.status == AppointmentStatus.pending)
              .length;
          return Text(
            '$total موعد • $pending قيد المراجعة',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: Colors.white.withValues(alpha: 0.8),
            ),
          );
        }),
      ],
    );
  }
}

// ─── Mini Stats ───────────────────────────────────────────────────────────────

class _StatsRow extends GetView<AppointmentsController> {
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final approved  = controller.items.where((e) => e.status == AppointmentStatus.approved).length;
      final completed = controller.items.where((e) => e.status == AppointmentStatus.completed).length;
      return Row(
        children: [
          _MiniStat(count: approved,  label: 'مؤكد',   color: const Color(0xFF80CBC4)),
          8.horizontalSpace,
          _MiniStat(count: completed, label: 'مكتمل',  color: const Color(0xFFA5D6A7)),
        ],
      );
    });
  }
}

class _MiniStat extends StatelessWidget {
  final int count;
  final String label;
  final Color color;
  const _MiniStat({required this.count, required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.white.withValues(alpha: 0.2)),
      ),
      child: Column(
        children: [
          Text(
            '$count',
            style: theme.textTheme.titleMedium?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w900,
            ),
          ),
          Text(
            label,
            style: theme.textTheme.labelSmall?.copyWith(
              color: Colors.white.withValues(alpha: 0.75),
              fontSize: 9.sp,
            ),
          ),
        ],
      ),
    );
  }
}
