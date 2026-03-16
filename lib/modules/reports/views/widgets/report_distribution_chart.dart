import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../../../app/data/report_model.dart';
import '../../../../generated/locale_keys.g.dart';

class ReportDistributionChart extends StatefulWidget {
  final ReportModel report;
  const ReportDistributionChart({super.key, required this.report});

  @override
  State<ReportDistributionChart> createState() =>
      _ReportDistributionChartState();
}

class _ReportDistributionChartState extends State<ReportDistributionChart> {
  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final r = widget.report;

    final sections = [
      if (r.completed > 0)
        PieChartSectionData(
          value: r.completed.toDouble(),
          color: const Color(0xFF10B981),
          radius: touchedIndex == 0 ? 62.r : 54.r,
          title: touchedIndex == 0 ? '${r.completed}' : '',
          titleStyle: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w800,
            fontSize: 14.sp,
          ),
        ),
      if (r.pending > 0)
        PieChartSectionData(
          value: r.pending.toDouble(),
          color: const Color(0xFFF59E0B),
          radius: touchedIndex == 1 ? 62.r : 54.r,
          title: touchedIndex == 1 ? '${r.pending}' : '',
          titleStyle: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w800,
            fontSize: 14.sp,
          ),
        ),
      if (r.cancelled > 0)
        PieChartSectionData(
          value: r.cancelled.toDouble(),
          color: const Color(0xFFEF4444),
          radius: touchedIndex == 2 ? 62.r : 54.r,
          title: touchedIndex == 2 ? '${r.cancelled}' : '',
          titleStyle: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w800,
            fontSize: 14.sp,
          ),
        ),
    ];

    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: cs.surface,
        borderRadius: BorderRadius.circular(18.r),
        border: Border.all(color: cs.outlineVariant.withValues(alpha: 0.15)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Align(
            alignment: AlignmentDirectional.centerStart,
            child: Text(
              tr(LocaleKeys.reports_details_visual_summary),
              style: theme.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          20.verticalSpace,
          Row(
            children: [
              SizedBox(
                width: 160.r,
                height: 160.r,
                child: sections.isEmpty
                    ? Center(
                        child: Text(
                          'لا بيانات',
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: cs.onSurfaceVariant,
                          ),
                        ),
                      )
                    : PieChart(
                        PieChartData(
                          sectionsSpace: 3,
                          centerSpaceRadius: 36.r,
                          pieTouchData: PieTouchData(
                            touchCallback: (event, pieTouchResponse) {
                              setState(() {
                                if (pieTouchResponse == null ||
                                    pieTouchResponse.touchedSection == null) {
                                  touchedIndex = -1;
                                  return;
                                }
                                touchedIndex = pieTouchResponse
                                    .touchedSection!.touchedSectionIndex;
                              });
                            },
                          ),
                          sections: sections,
                        ),
                      ),
              ),
              20.horizontalSpace,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _PieLegendRow(
                      color: const Color(0xFF10B981),
                      label: tr(LocaleKeys.reports_cards_completed),
                      value: r.completed,
                      total: r.total,
                    ),
                    16.verticalSpace,
                    _PieLegendRow(
                      color: const Color(0xFFF59E0B),
                      label: tr(LocaleKeys.reports_cards_pending),
                      value: r.pending,
                      total: r.total,
                    ),
                    16.verticalSpace,
                    _PieLegendRow(
                      color: const Color(0xFFEF4444),
                      label: tr(LocaleKeys.reports_cards_cancelled),
                      value: r.cancelled,
                      total: r.total,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _PieLegendRow extends StatelessWidget {
  final Color color;
  final String label;
  final int value;
  final int total;

  const _PieLegendRow({
    required this.color,
    required this.label,
    required this.value,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final pct = total == 0 ? 0.0 : value / total * 100;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 10.r,
              height: 10.r,
              decoration: BoxDecoration(
                  color: color, borderRadius: BorderRadius.circular(3.r)),
            ),
            6.horizontalSpace,
            Expanded(
              child: Text(
                label,
                style: theme.textTheme.labelSmall?.copyWith(
                  color: cs.onSurfaceVariant,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Text(
              '$value',
              style: theme.textTheme.labelMedium?.copyWith(
                fontWeight: FontWeight.w800,
                color: color,
              ),
            ),
          ],
        ),
        6.verticalSpace,
        ClipRRect(
          borderRadius: BorderRadius.circular(3.r),
          child: LinearProgressIndicator(
            value: pct / 100,
            backgroundColor: color.withValues(alpha: 0.12),
            valueColor: AlwaysStoppedAnimation<Color>(color),
            minHeight: 4.h,
          ),
        ),
      ],
    );
  }
}
