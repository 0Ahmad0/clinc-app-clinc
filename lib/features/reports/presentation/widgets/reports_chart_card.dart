import 'package:flutter/material.dart';

import '../../../../config/theme/app_motion.dart';
import '../../../../config/theme/app_shadows.dart';
import '../../../../config/theme/app_spacing.dart';
import '../../../../shared/extensions/context_extensions.dart';
import '../../domain/report_outcome.dart';
import '../../domain/report_period.dart';
import '../reports_catalog.dart';
import '../reports_l10n.dart';

/// Grouped bar chart: three bars (done/pending/cancelled) per period bucket,
/// growing in on load and whenever the period changes.
class ReportsChartCard extends StatelessWidget {
  const ReportsChartCard({
    super.key,
    required this.period,
    required this.chart,
  });

  final ReportPeriod period;
  final List<ReportBar> chart;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final l10n = context.l10n;
    final max = chart
        .expand((bar) => ReportOutcome.values.map(bar.$2.count))
        .fold(1, (a, b) => b > a ? b : a);
    final barWidth = period == ReportPeriod.week
        ? AppSizes.reportsBarWidthWeek
        : AppSizes.reportsBarWidthMonth;

    return Container(
      margin: const EdgeInsetsDirectional.fromSTEB(
        AppSpacing.screen,
        AppSpacing.md,
        AppSpacing.screen,
        0,
      ),
      padding: const EdgeInsetsDirectional.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(AppRadius.card),
        border: Border.all(color: colors.line),
        boxShadow: AppShadows.homeCard,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      period.chartTitle(l10n),
                      style: context.textTheme.titleSmall?.copyWith(
                        color: colors.ink,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xxs),
                    Text(
                      period.chartSub(l10n),
                      style: context.textTheme.labelSmall?.copyWith(
                        color: colors.muted,
                      ),
                    ),
                  ],
                ),
              ),
              Wrap(
                spacing: AppSpacing.xs,
                children: [
                  for (final outcome in ReportOutcome.values)
                    _LegendDot(
                      color: outcome.barColor(colors),
                      label: outcome.shortLabel(l10n),
                    ),
                ],
              ),
            ],
          ),
          AppGaps.h16,
          Container(
            height: AppSizes.reportsChartHeight,
            decoration: BoxDecoration(
              border: BorderDirectional(
                bottom: BorderSide(color: colors.line, width: 1.5),
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                for (final bar in chart)
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        for (final outcome in ReportOutcome.values)
                          Padding(
                            padding: const EdgeInsetsDirectional.symmetric(
                              horizontal: 1.5,
                            ),
                            child: _Bar(
                              width: barWidth,
                              heightFactor: bar.$2.count(outcome) / max,
                              color: outcome.barColor(colors),
                            ),
                          ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
          AppGaps.h8,
          Row(
            children: [
              for (final bar in chart)
                Expanded(
                  child: Text(
                    bar.$1,
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: context.textTheme.labelSmall?.copyWith(
                      color: colors.muted,
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class _Bar extends StatelessWidget {
  const _Bar({
    required this.width,
    required this.heightFactor,
    required this.color,
  });

  final double width;
  final double heightFactor;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final empty = heightFactor <= 0;
    final target =
        (empty ? 0.04 : heightFactor) * AppSizes.reportsChartHeight;
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: target),
      duration: AppMotion.slide,
      curve: AppMotion.emphasized,
      builder: (context, height, _) => Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: color.withValues(alpha: empty ? 0.25 : 1),
          borderRadius: BorderRadius.circular(AppRadius.pill),
        ),
      ),
    );
  }
}

class _LegendDot extends StatelessWidget {
  const _LegendDot({required this.color, required this.label});

  final Color color;
  final String label;

  @override
  Widget build(BuildContext context) => Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Container(
        width: AppSizes.reportsLegendDot,
        height: AppSizes.reportsLegendDot,
        decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      ),
      const SizedBox(width: AppSpacing.xxs),
      Text(
        label,
        style: context.textTheme.labelSmall?.copyWith(
          color: context.colors.gray,
        ),
      ),
    ],
  );
}
