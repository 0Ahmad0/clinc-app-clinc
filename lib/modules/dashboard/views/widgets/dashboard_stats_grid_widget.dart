import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../app/core/theme/app_colors.dart';
import '../../models/dashboard_model.dart';

class DashboardStatsGridWidget extends StatelessWidget {
  const DashboardStatsGridWidget({super.key, required this.stats});

  final DashboardStats stats;

  @override
  Widget build(BuildContext context) {
    final data = [
      _StatCardData(
        icon: Icons.people_alt_outlined,
        label: tr('dashboard.stats.doctors'),
        value: stats.doctorsCount.toString(),
        color: const Color(0xFFD05FA3),
      ),
      _StatCardData(
        icon: Icons.groups_2_outlined,
        label: tr('dashboard.stats.patients'),
        value: stats.patientsCount.toString(),
        color: const Color(0xFFB39DDB),
      ),
      _StatCardData(
        icon: Icons.calendar_today_outlined,
        label: tr('dashboard.stats.today_appointments'),
        value: stats.todayAppointmentsCount.toString(),
        color: const Color(0xFF8EAD55),
      ),
      _StatCardData(
        icon: Icons.payments_outlined,
        label: tr('dashboard.stats.daily_income'),
        value: '${stats.dailyIncome} ${tr('dashboard.currency.sar')}',
        color: const Color(0xFF4F8CA5),
        isIncome: true,
      ),
    ];

    return SliverPadding(
      padding: EdgeInsets.fromLTRB(20.w, 8.h, 20.w, 20.h),
      sliver: SliverGrid(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 14.h,
          crossAxisSpacing: 14.w,
          childAspectRatio: 1.25,
        ),
        delegate: SliverChildBuilderDelegate(
          (context, index) => _StatCard(data: data[index]),
          childCount: data.length,
        ),
      ),
    );
  }
}

class _StatCardData {
  const _StatCardData({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
    this.isIncome = false,
  });

  final IconData icon;
  final String label;
  final String value;
  final Color color;
  final bool isIncome;
}

class _StatCard extends StatefulWidget {
  const _StatCard({required this.data});

  final _StatCardData data;

  @override
  State<_StatCard> createState() => _StatCardState();
}

class _StatCardState extends State<_StatCard> {
  bool _showIncome = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: widget.data.isIncome
          ? () => setState(() => _showIncome = !_showIncome)
          : null,
      child: Container(
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              widget.data.color.withValues(alpha: .8),
              widget.data.color,
            ],
          ),
          borderRadius: BorderRadius.circular(18.r),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(widget.data.icon, color: AppColors.white),
            Text(
              widget.data.label,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: theme.textTheme.titleSmall?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            if (widget.data.isIncome)
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 250),
                child: _showIncome
                    ? Text(
                        widget.data.value,
                        key: const ValueKey('income'),
                        style: theme.textTheme.titleLarge?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    : const _BlurredIncome(key: ValueKey('hidden_income')),
              )
            else
              Text(
                widget.data.value,
                style: theme.textTheme.headlineSmall?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _BlurredIncome extends StatelessWidget {
  const _BlurredIncome({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      '••••',
      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
        color: Colors.white.withValues(alpha: .75),
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
