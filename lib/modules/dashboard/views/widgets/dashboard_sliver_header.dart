import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../app/routes/app_routes.dart';
import '../../controllers/dashboard_controller.dart';

class DashboardSliverHeader extends GetView<DashboardController> {
  const DashboardSliverHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final theme  = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return SliverAppBar(
      pinned: true,
      floating: false,
      expandedHeight: 155.h,
      backgroundColor: const Color(0xFF00695C),
      elevation: 0,
      surfaceTintColor: Colors.transparent,
      automaticallyImplyLeading: false,
      title: Text(
        'لوحة التحكم',
        style: theme.textTheme.titleMedium?.copyWith(color: Colors.white, fontWeight: FontWeight.w800),
      ),
      actions: [
        _NotificationButton(),
        _SettingsButton(),
        12.horizontalSpace,
      ],
      flexibleSpace: FlexibleSpaceBar(
        collapseMode: CollapseMode.pin,
        background: _HeaderBackground(isDark: isDark),
      ),
    );
  }
}

// ─── Action Buttons ───────────────────────────────────────────────────────────

class _NotificationButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => Get.toNamed(AppRoutes.notifications),
      icon: Stack(
        children: [
          const Icon(Icons.notifications_outlined, color: Colors.white, size: 26),
          Positioned(
            right: 0, top: 0,
            child: Container(
              width: 8, height: 8,
              decoration: const BoxDecoration(color: Color(0xFFF59E0B), shape: BoxShape.circle),
            ),
          ),
        ],
      ),
    );
  }
}

class _SettingsButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => Get.toNamed(AppRoutes.settings),
      icon: const Icon(Icons.settings_outlined, color: Colors.white, size: 24),
    );
  }
}

// ─── Flexible Space Background ────────────────────────────────────────────────

class _HeaderBackground extends GetView<DashboardController> {
  final bool isDark;
  const _HeaderBackground({required this.isDark});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final _dateStr = _buildDateString();

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: isDark
              ? [const Color(0xFF004D40), const Color(0xFF002B22)]
              : [const Color(0xFF00897B), const Color(0xFF004D40)],
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(20.w, 10.h, 20.w, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _ClinicRow(dateStr: _dateStr, theme: theme),
              16.verticalSpace,
              _StatusBadge(status: controller.clinicStatus),
            ],
          ),
        ),
      ),
    );
  }

  String _buildDateString() {
    final now    = DateTime.now();
    const months = ['يناير','فبراير','مارس','أبريل','مايو','يونيو','يوليو','أغسطس','سبتمبر','أكتوبر','نوفمبر','ديسمبر'];
    const days   = ['الأحد','الاثنين','الثلاثاء','الأربعاء','الخميس','الجمعة','السبت'];
    return '${days[now.weekday % 7]}، ${now.day} ${months[now.month - 1]}';
  }
}

class _ClinicRow extends GetView<DashboardController> {
  final String dateStr;
  final ThemeData theme;
  const _ClinicRow({required this.dateStr, required this.theme});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _ClinicAvatar(initial: controller.clinicInitial),
        14.horizontalSpace,
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                controller.clinicName,
                style: theme.textTheme.headlineSmall?.copyWith(
                  color: Colors.white, fontWeight: FontWeight.w800, letterSpacing: -0.5,
                ),
              ),
              4.verticalSpace,
              Text(
                dateStr,
                style: theme.textTheme.bodySmall?.copyWith(color: Colors.white.withValues(alpha: 0.75)),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _ClinicAvatar extends StatelessWidget {
  final String initial;
  const _ClinicAvatar({required this.initial});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.toNamed(AppRoutes.settings),
      child: Container(
        width: 50.r, height: 50.r,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF26A69A), Color(0xFF00695C)],
            begin: Alignment.topLeft, end: Alignment.bottomRight,
          ),
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white.withValues(alpha: 0.3), width: 2),
        ),
        child: Center(
          child: Text(
            initial,
            style: TextStyle(color: Colors.white, fontSize: 20.sp, fontWeight: FontWeight.w800),
          ),
        ),
      ),
    );
  }
}

class _StatusBadge extends StatelessWidget {
  final String status;
  const _StatusBadge({required this.status});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.white.withValues(alpha: 0.15)),
      ),
      child: Row(
        children: [
          Icon(Icons.circle, color: const Color(0xFF4ADE80), size: 9.r),
          8.horizontalSpace,
          Text(
            status,
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.9),
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
