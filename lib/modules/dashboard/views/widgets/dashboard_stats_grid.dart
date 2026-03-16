import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../controllers/dashboard_controller.dart';
import '../../models/dashboard_models.dart';

class DashboardStatsGrid extends GetView<DashboardController> {
  const DashboardStatsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      sliver: SliverGrid(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 12.h,
          crossAxisSpacing: 12.w,
          childAspectRatio: 1.4,
        ),
        delegate: SliverChildBuilderDelegate(
          (_, i) => _StatCard(stat: controller.stats[i]),
          childCount: controller.stats.length,
        ),
      ),
    );
  }
}

// ─── Stat Card ────────────────────────────────────────────────────────────────

class _StatCard extends StatefulWidget {
  final DashboardStat stat;
  const _StatCard({required this.stat});

  @override
  State<_StatCard> createState() => _StatCardState();
}

class _StatCardState extends State<_StatCard> {
  bool _incomeVisible = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final stat  = widget.stat;

    return GestureDetector(
      onTap: stat.isIncome ? () => setState(() => _incomeVisible = !_incomeVisible) : null,
      child: Container(
        padding: EdgeInsets.all(14.r),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [stat.color.withValues(alpha: 0.85), stat.color],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(18.r),
          boxShadow: [
            BoxShadow(color: stat.color.withValues(alpha: 0.3), blurRadius: 12, offset: const Offset(0, 4)),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _CardTopRow(stat: stat),
            _CardBottomSection(stat: stat, incomeVisible: _incomeVisible),
          ],
        ),
      ),
    );
  }
}

class _CardTopRow extends StatelessWidget {
  final DashboardStat stat;
  const _CardTopRow({required this.stat});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Icon(stat.icon, color: Colors.white.withValues(alpha: 0.9), size: 20.sp),
        _BadgeChip(badge: stat.badge),
      ],
    );
  }
}

class _BadgeChip extends StatelessWidget {
  final String badge;
  const _BadgeChip({required this.badge});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Text(badge, style: TextStyle(color: Colors.white, fontSize: 10.sp, fontWeight: FontWeight.w600)),
    );
  }
}

class _CardBottomSection extends StatelessWidget {
  final DashboardStat stat;
  final bool incomeVisible;
  const _CardBottomSection({required this.stat, required this.incomeVisible});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (stat.isIncome)
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: incomeVisible
                ? Text(stat.value,
                    key: const ValueKey('visible'),
                    style: TextStyle(color: Colors.white, fontSize: 24.sp, fontWeight: FontWeight.w800, height: 1))
                : _BlurValue(key: const ValueKey('blur'), value: stat.value),
          )
        else
          Text(stat.value,
              style: TextStyle(color: Colors.white, fontSize: 24.sp, fontWeight: FontWeight.w800, height: 1)),
        4.verticalSpace,
        Text(stat.label,
            style: TextStyle(color: Colors.white.withValues(alpha: 0.85), fontSize: 12.sp, fontWeight: FontWeight.w600)),
        // if (stat.isIncome)
        //   Text('اضغط للإظهار',
        //       style: TextStyle(color: Colors.white.withValues(alpha: 0.5), fontSize: 9.sp)),
      ],
    );
  }
}

class _BlurValue extends StatelessWidget {
  final String value;
  const _BlurValue({super.key, required this.value});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Text(value,
            style: TextStyle(color: Colors.transparent, fontSize: 24.sp, fontWeight: FontWeight.w800, height: 1)),
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.25),
              borderRadius: BorderRadius.circular(6.r),
            ),
          ),
        ),
      ],
    );
  }
}
