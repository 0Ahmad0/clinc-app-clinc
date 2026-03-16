import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../controllers/doctors_controller.dart';

class DoctorsHeader extends GetView<DoctorsController> {
  const DoctorsHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF1A237E), Color(0xFF3949AB), Color(0xFF5C6BC0)],
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 20.h),
          child: Row(
            children: [
              _PageIcon(),
              14.horizontalSpace,
              Expanded(child: _TitleSection(theme: theme)),
              _HeaderStats(theme: theme),
            ],
          ),
        ),
      ),
    );
  }
}

// ─── Page Icon ────────────────────────────────────────────────────────────────

class _PageIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.r),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(14.r),
      ),
      child: Icon(Icons.people_rounded, color: Colors.white, size: 26.sp),
    );
  }
}

// ─── Title + Subtitle ─────────────────────────────────────────────────────────

class _TitleSection extends GetView<DoctorsController> {
  final ThemeData theme;
  const _TitleSection({required this.theme});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'الأطباء',
          style: theme.textTheme.headlineSmall?.copyWith(
            color: Colors.white, fontWeight: FontWeight.w900, letterSpacing: -0.5,
          ),
        ),
        Obx(() {
          final total  = controller.allDoctors.length;
          final active = controller.allDoctors.where((d) => d.isAvailable).length;
          return Text(
            '$total طبيب • $active متاح الآن',
            style: theme.textTheme.bodyMedium?.copyWith(color: Colors.white.withValues(alpha: 0.8)),
          );
        }),
      ],
    );
  }
}

// ─── Mini Stats ───────────────────────────────────────────────────────────────

class _HeaderStats extends GetView<DoctorsController> {
  final ThemeData theme;
  const _HeaderStats({required this.theme});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final total    = controller.allDoctors.length;
      final inactive = controller.allDoctors.where((d) => !d.isAvailable).length;
      return Row(
        children: [
          _MiniStat(count: total,    label: 'إجمالي',   theme: theme),
          8.horizontalSpace,
          _MiniStat(count: inactive, label: 'غير متاح', theme: theme),
        ],
      );
    });
  }
}

class _MiniStat extends StatelessWidget {
  final int count;
  final String label;
  final ThemeData theme;
  const _MiniStat({required this.count, required this.label, required this.theme});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.white.withValues(alpha: 0.2)),
      ),
      child: Column(
        children: [
          Text('$count', style: theme.textTheme.titleMedium?.copyWith(color: Colors.white, fontWeight: FontWeight.w900)),
          Text(label,   style: theme.textTheme.labelSmall?.copyWith(color: Colors.white.withValues(alpha: 0.75), fontSize: 9.sp)),
        ],
      ),
    );
  }
}
