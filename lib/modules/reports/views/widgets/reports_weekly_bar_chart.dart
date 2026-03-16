import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../controllers/reports_controller.dart';

class ReportsWeeklyBarChart extends GetView<ReportsController> {
  const ReportsWeeklyBarChart({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;
    final trend = controller.weeklyTrend;

    final groups = trend.asMap().entries.map((e) {
      final i = e.key;
      final d = e.value;
      return BarChartGroupData(
        x: i,
        barRods: [
          BarChartRodData(
            toY: d.completed.toDouble(),
            color: const Color(0xFF10B981),
            width: 6.w,
            borderRadius: BorderRadius.circular(3.r),
          ),
          BarChartRodData(
            toY: d.pending.toDouble(),
            color: const Color(0xFFF59E0B),
            width: 6.w,
            borderRadius: BorderRadius.circular(3.r),
          ),
          BarChartRodData(
            toY: d.cancelled.toDouble(),
            color: const Color(0xFFEF4444),
            width: 6.w,
            borderRadius: BorderRadius.circular(3.r),
          ),
        ],
        barsSpace: 3.w,
      );
    }).toList();

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: cs.surface,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: cs.outlineVariant.withValues(alpha: 0.15)),
        boxShadow: [
          BoxShadow(
            color: isDark
                ? Colors.black.withValues(alpha: 0.2)
                : Colors.black.withValues(alpha: 0.05),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'الأداء الأسبوعي',
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    Text(
                      'توزيع المواعيد خلال الأسبوع',
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: cs.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  _ChartLegend(color: const Color(0xFF10B981), label: 'مكتمل'),
                  8.horizontalSpace,
                  _ChartLegend(color: const Color(0xFFF59E0B), label: 'قيد'),
                  8.horizontalSpace,
                  _ChartLegend(color: const Color(0xFFEF4444), label: 'ملغي'),
                ],
              ),
            ],
          ),
          20.verticalSpace,
          SizedBox(
            height: 160.h,
            child: BarChart(
              BarChartData(
                alignment: BarChartAlignment.spaceAround,
                maxY: 12,
                barTouchData: BarTouchData(enabled: false),
                titlesData: FlTitlesData(
                  show: true,
                  rightTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  topTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 24.h,
                      getTitlesWidget: (val, meta) {
                        final labels = trend.map((d) => d.label).toList();
                        final idx = val.toInt();
                        if (idx < 0 || idx >= labels.length) {
                          return const SizedBox.shrink();
                        }
                        return Text(
                          labels[idx],
                          style: TextStyle(
                            fontSize: 10.sp,
                            color: cs.onSurfaceVariant,
                            fontWeight: FontWeight.w600,
                          ),
                        );
                      },
                    ),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 28.w,
                      interval: 4,
                      getTitlesWidget: (val, meta) => Text(
                        val.toInt().toString(),
                        style: TextStyle(
                          fontSize: 9.sp,
                          color: cs.onSurfaceVariant,
                        ),
                      ),
                    ),
                  ),
                ),
                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: false,
                  horizontalInterval: 4,
                  getDrawingHorizontalLine: (_) => FlLine(
                    color: cs.outlineVariant.withValues(alpha: 0.2),
                    strokeWidth: 1,
                  ),
                ),
                borderData: FlBorderData(show: false),
                barGroups: groups,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ChartLegend extends StatelessWidget {
  final Color color;
  final String label;
  const _ChartLegend({required this.color, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 8.r,
          height: 8.r,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        4.horizontalSpace,
        Text(
          label,
          style: TextStyle(
            fontSize: 9.sp,
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}
