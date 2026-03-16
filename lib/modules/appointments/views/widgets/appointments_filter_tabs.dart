import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../app/colors/status_colors.dart';
import '../../../../app/extension/appointment_type_extensions.dart';
import '../../controllers/appointments_controller.dart';

// ─── Tab Data Model ───────────────────────────────────────────────────────────

class _FilterTab {
  final String label;
  final AppointmentStatus? status;
  final IconData icon;
  const _FilterTab({required this.label, required this.status, required this.icon});
}

const _kTabs = [
  _FilterTab(label: 'الكل',          status: null,                           icon: Icons.apps_rounded),
  _FilterTab(label: 'قيد المراجعة',  status: AppointmentStatus.pending,     icon: Icons.pending_actions_rounded),
  _FilterTab(label: 'المؤكد',        status: AppointmentStatus.approved,    icon: Icons.check_circle_outline_rounded),
  _FilterTab(label: 'المكتمل',       status: AppointmentStatus.completed,   icon: Icons.task_alt_rounded),
  _FilterTab(label: 'المرفوض',       status: AppointmentStatus.rejected,    icon: Icons.cancel_outlined),
];

// ─── Sliver Delegate ──────────────────────────────────────────────────────────

class AppointmentTabBarDelegate extends SliverPersistentHeaderDelegate {
  const AppointmentTabBarDelegate();

  @override double get minExtent => 56.0;
  @override double get maxExtent => 56.0;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      decoration: BoxDecoration(
        color: cs.surface,
        boxShadow: shrinkOffset > 0
            ? [BoxShadow(color: cs.shadow.withValues(alpha: 0.08), blurRadius: 12, offset: const Offset(0, 4))]
            : [],
      ),
      child: const AppointmentsFilterTabs(),
    );
  }

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate _) => false;
}

// ─── Filter Chips Row ─────────────────────────────────────────────────────────

class AppointmentsFilterTabs extends GetView<AppointmentsController> {
  const AppointmentsFilterTabs({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs    = theme.colorScheme;

    return Obx(() {
      final current = controller.filter.value;
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 7.h),
        child: Row(
          children: _kTabs.map((tab) {
            final isSelected = current == tab.status;
            final tabColor = tab.status != null
                ? AppStatusColors.forStatus(tab.status!)
                : cs.primary;
            return Padding(
              padding: EdgeInsets.only(left: 8.w),
              child: _FilterChip(
                tab: tab,
                isSelected: isSelected,
                tabColor: tabColor,
                theme: theme,
                cs: cs,
                onTap: () => controller.setFilter(tab.status),
                count: tab.status == null
                    ? controller.items.length
                    : controller.items.where((e) => e.status == tab.status).length,
              ),
            );
          }).toList(),
        ),
      );
    });
  }
}

// ─── Single Chip ─────────────────────────────────────────────────────────────

class _FilterChip extends StatelessWidget {
  final _FilterTab tab;
  final bool isSelected;
  final Color tabColor;
  final ThemeData theme;
  final ColorScheme cs;
  final VoidCallback onTap;
  final int count;

  const _FilterChip({
    required this.tab,
    required this.isSelected,
    required this.tabColor,
    required this.theme,
    required this.cs,
    required this.onTap,
    required this.count,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeInOut,
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
        decoration: BoxDecoration(
          gradient: isSelected
              ? LinearGradient(colors: [tabColor.withValues(alpha: 0.85), tabColor])
              : null,
          color: isSelected ? null : cs.surfaceContainerHighest.withValues(alpha: 0.5),
          borderRadius: BorderRadius.circular(999),
          border: Border.all(
            color: isSelected ? Colors.transparent : cs.outlineVariant.withValues(alpha: 0.5),
          ),
          boxShadow: isSelected
              ? [BoxShadow(color: tabColor.withValues(alpha: 0.3), blurRadius: 10, offset: const Offset(0, 3))]
              : [],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              tab.icon,
              size: 15.sp,
              color: isSelected ? Colors.white : cs.onSurfaceVariant.withValues(alpha: 0.7),
            ),
            6.horizontalSpace,
            Text(
              tab.label,
              style: theme.textTheme.labelMedium?.copyWith(
                color: isSelected ? Colors.white : cs.onSurfaceVariant.withValues(alpha: 0.8),
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
              ),
            ),
            if (count > 0 || tab.status == null) ...[
              6.horizontalSpace,
              _CountBadge(count: count, isSelected: isSelected, tabColor: tabColor, theme: theme),
            ],
          ],
        ),
      ),
    );
  }
}

class _CountBadge extends StatelessWidget {
  final int count;
  final bool isSelected;
  final Color tabColor;
  final ThemeData theme;

  const _CountBadge({
    required this.count,
    required this.isSelected,
    required this.tabColor,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 7.w, vertical: 2.h),
      decoration: BoxDecoration(
        color: isSelected
            ? Colors.white.withValues(alpha: 0.25)
            : tabColor.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        '$count',
        style: theme.textTheme.labelSmall?.copyWith(
          color: isSelected ? Colors.white : tabColor,
          fontWeight: FontWeight.w800,
          fontSize: 10.sp,
        ),
      ),
    );
  }
}
