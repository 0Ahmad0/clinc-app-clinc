import 'package:flutter/material.dart';

import '../../../../config/theme/app_shadows.dart';
import '../../../../config/theme/app_spacing.dart';
import '../../../../shared/extensions/context_extensions.dart';
import '../../../../shared/widgets/app_shimmer_placeholder.dart';

class ReportsSummaryShimmer extends StatelessWidget {
  const ReportsSummaryShimmer({super.key});

  @override
  Widget build(BuildContext context) => const Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [_ReportsStatsShimmer(), _ReportsChartShimmer()],
  );
}

class _ReportsStatsShimmer extends StatelessWidget {
  const _ReportsStatsShimmer();

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsetsDirectional.fromSTEB(
      AppSpacing.screen,
      AppSpacing.md,
      AppSpacing.screen,
      0,
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (var index = 0; index < 3; index++)
          Expanded(
            child: Padding(
              padding: EdgeInsetsDirectional.only(
                end: index == 2 ? 0 : AppSpacing.xs,
              ),
              child: const _ReportStatCardShimmer(),
            ),
          ),
      ],
    ),
  );
}

class _ReportStatCardShimmer extends StatelessWidget {
  const _ReportStatCardShimmer();

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Container(
      padding: const EdgeInsetsDirectional.symmetric(
        horizontal: AppSpacing.xs,
        vertical: AppSpacing.md,
      ),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(AppRadius.homeQuickAction),
        border: Border.all(color: colors.line, width: 1.5),
        boxShadow: AppShadows.homeCard,
      ),
      child: const Column(
        children: [
          AppShimmerPlaceholder(
            width: AppSizes.reportsStatIcon,
            height: AppSizes.reportsStatIcon,
            borderRadius: AppRadius.sm,
          ),
          AppGaps.h8,
          AppShimmerPlaceholder(width: 48, height: 24),
          SizedBox(height: AppSpacing.xxs),
          AppShimmerPlaceholder(width: 72, height: 14),
        ],
      ),
    );
  }
}

class _ReportsChartShimmer extends StatelessWidget {
  const _ReportsChartShimmer();

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

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
        children: const [
          _ChartHeaderShimmer(),
          AppGaps.h16,
          _ChartBarsShimmer(),
          AppGaps.h8,
          _ChartLabelsShimmer(),
        ],
      ),
    );
  }
}

class _ChartHeaderShimmer extends StatelessWidget {
  const _ChartHeaderShimmer();

  @override
  Widget build(BuildContext context) => Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppShimmerPlaceholder(width: 142, height: 18),
            SizedBox(height: AppSpacing.xxs),
            AppShimmerPlaceholder(width: 186, height: 12),
          ],
        ),
      ),
      Wrap(
        spacing: AppSpacing.xs,
        children: const [
          _LegendShimmer(width: 54),
          _LegendShimmer(width: 62),
          _LegendShimmer(width: 70),
        ],
      ),
    ],
  );
}

class _LegendShimmer extends StatelessWidget {
  const _LegendShimmer({required this.width});

  final double width;

  @override
  Widget build(BuildContext context) => Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      const AppShimmerPlaceholder(
        width: AppSizes.reportsLegendDot,
        height: AppSizes.reportsLegendDot,
        shape: BoxShape.circle,
      ),
      const SizedBox(width: AppSpacing.xxs),
      AppShimmerPlaceholder(width: width, height: 10),
    ],
  );
}

class _ChartBarsShimmer extends StatelessWidget {
  const _ChartBarsShimmer();

  static const _heights = <double>[92, 64, 118, 76, 132, 48, 106];

  @override
  Widget build(BuildContext context) => Container(
    height: AppSizes.reportsChartHeight,
    decoration: BoxDecoration(
      border: BorderDirectional(
        bottom: BorderSide(color: context.colors.line, width: 1.5),
      ),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        for (final height in _heights)
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                AppShimmerPlaceholder(
                  width: AppSizes.reportsBarWidthWeek,
                  height: height,
                  borderRadius: AppRadius.pill,
                ),
                const SizedBox(width: 3),
                AppShimmerPlaceholder(
                  width: AppSizes.reportsBarWidthWeek,
                  height: height * .68,
                  borderRadius: AppRadius.pill,
                ),
                const SizedBox(width: 3),
                AppShimmerPlaceholder(
                  width: AppSizes.reportsBarWidthWeek,
                  height: height * .42,
                  borderRadius: AppRadius.pill,
                ),
              ],
            ),
          ),
      ],
    ),
  );
}

class _ChartLabelsShimmer extends StatelessWidget {
  const _ChartLabelsShimmer();

  @override
  Widget build(BuildContext context) => Row(
    children: [
      for (var index = 0; index < 7; index++)
        const Expanded(
          child: Center(child: AppShimmerPlaceholder(width: 24, height: 10)),
        ),
    ],
  );
}
