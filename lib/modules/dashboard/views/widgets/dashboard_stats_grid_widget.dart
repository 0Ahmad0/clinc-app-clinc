import 'package:clinc_app_clinc/app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class DashboardStatsGridWidget extends StatelessWidget {
  const DashboardStatsGridWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final List<_StatCardData> data = [
      _StatCardData(
        icon: Icons.people_alt_outlined,
        label: "الأطباء",
        value: "12",
        color: const Color(0xFFD05FA3),
      ),
      _StatCardData(
        icon: Icons.groups_2_outlined,
        label: "المرضى",
        value: "120",
        color: const Color(0xFFB39DDB),
      ),
      _StatCardData(
        icon: Icons.calendar_today_outlined,
        label: "مواعيد اليوم",
        value: "8",
        color: const Color(0xFFB2CC82),
      ),
      _StatCardData(
        icon: Icons.attach_money,
        label: "الدخل اليومي",
        value: "2500",
        color: const Color(0xFF4F8CA5),
        isIncome: true,
      ),
    ];

    return SliverGrid(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 14.h,
        crossAxisSpacing: 14.w,
        childAspectRatio: 1.25,
      ),
      delegate: SliverChildBuilderDelegate(
        (context, i) => _StatCard(data: data[i]),
        childCount: data.length,
      ),
    );
  }
}

class _StatCardData {
  final IconData icon;
  final String label;
  final String value;
  final Color color;
  final bool isIncome;

  _StatCardData({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
    this.isIncome = false,
  });
}

class _StatCard extends StatefulWidget {
  final _StatCardData data;

  const _StatCard({required this.data});

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
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            widget.data.color.withValues(alpha: .8),
            widget.data.color,
          ]),
          borderRadius: BorderRadius.circular(18.r),
        ),
        padding: EdgeInsets.all(12.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(widget.data.icon, color: AppColors.white),
            Flexible(
              child: Text(
                widget.data.label,
                style: theme.textTheme.titleMedium?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            widget.data.isIncome
                ? AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    child: _showIncome
                        ? Text(
                            "${widget.data.value} \$",
                            key: const ValueKey('income'),
                            style: theme.textTheme.headlineSmall?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.2,
                            ),
                          )
                        : _BlurredIncome(key: const ValueKey('blur')),
                  )
                : Flexible(
                  child: Text(
                      widget.data.value,
                      style: theme.textTheme.headlineSmall?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
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
    // رقم مشوش (blurred)
    return Stack(
      children: [
        Text(
          "•••• \$",
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            color: Colors.white.withOpacity(0.7),
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
          ),
        ),
        Positioned.fill(
          child: IgnorePointer(
            child: Container(color: Colors.white.withOpacity(0.18)),
          ),
        ),
      ],
    );
  }
}
