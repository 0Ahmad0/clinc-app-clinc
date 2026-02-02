import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:clinc_app_clinc/generated/locale_keys.g.dart';
import '../controllers/reports_controller.dart';
import 'widgets/report_filters_widget.dart';
import 'widgets/report_list_item.dart';

class ReportsView extends GetView<ReportsController> {
  const ReportsView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    return Scaffold(
      backgroundColor: cs.surface,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO: Generate new report
        },
        backgroundColor: cs.primary,
        child: Icon(Icons.add, color: cs.onPrimary),
      ),
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // 1. Sliver App Bar with Gradient Background
          SliverAppBar(
            pinned: true,
            floating: true,
            expandedHeight: 180.h,
            backgroundColor: cs.surface,
            elevation: 0,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      cs.primary.withOpacity(0.1),
                      cs.surface,
                    ],
                  ),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.analytics_outlined,
                        size: 48.sp,
                        color: cs.primary,
                      ),
                      8.verticalSpace,
                      Text(
                        tr(LocaleKeys.reports_title),
                        style: theme.textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            title: Text(
              tr(LocaleKeys.reports_title),
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w800,
              ),
            ),
            centerTitle: true,
          ),

          // 2. Filters Section
          SliverPadding(
            padding: EdgeInsets.fromLTRB(16.w, 10.h, 16.w, 0),
            sliver: const SliverToBoxAdapter(child: ReportFiltersWidget()),
          ),

          // 3. Summary Section with Chart
          SliverPadding(
            padding: EdgeInsets.fromLTRB(16.w, 20.h, 16.w, 0),
            sliver: SliverToBoxAdapter(
              child: Text(
                tr(LocaleKeys.reports_sections_summary),
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ),

          SliverPadding(
            padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 0),
            sliver: const SliverToBoxAdapter(child: _ReportSummaryChart()),
          ),

          // 4. Reports List Section
          SliverPadding(
            padding: EdgeInsets.fromLTRB(16.w, 24.h, 16.w, 10.h),
            sliver: SliverToBoxAdapter(
              child: Text(
                tr(LocaleKeys.reports_sections_list),
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ),

          Obx(() {
            final list = controller.filteredReports;
            if (list.isEmpty) {
              return SliverFillRemaining(
                hasScrollBody: false,
                child: const _EmptyReportsState(),
              );
            }

            return SliverPadding(
              padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 80.h),
              sliver: SliverList.separated(
                itemBuilder: (_, i) => ReportListItem(report: list[i]),
                separatorBuilder: (_, __) => 16.verticalSpace,
                itemCount: list.length,
              ),
            );
          }),
        ],
      ),
    );
  }
}

class _ReportSummaryChart extends GetView<ReportsController> {
  const _ReportSummaryChart();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    return Obx(() {
      final s = controller.summary;

      return Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: cs.surface,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: cs.outlineVariant.withOpacity(0.2)),
          boxShadow: [
            BoxShadow(
              color: cs.shadow.withOpacity(0.05),
              blurRadius: 15,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          children: [
            // Chart
            SizedBox(
              height: 200.h,
              child: PieChart(
                PieChartData(
                  sectionsSpace: 2,
                  centerSpaceRadius: 50.r,
                  sections: [
                    PieChartSectionData(
                      value: s.completed.toDouble(),
                      color: Colors.green,
                      title: '${s.completed}',
                      radius: 25.r,
                      titleStyle: theme.textTheme.bodySmall?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    PieChartSectionData(
                      value: s.pending.toDouble(),
                      color: cs.tertiary,
                      title: '${s.pending}',
                      radius: 25.r,
                      titleStyle: theme.textTheme.bodySmall?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    PieChartSectionData(
                      value: s.cancelled.toDouble(),
                      color: cs.error,
                      title: '${s.cancelled}',
                      radius: 25.r,
                      titleStyle: theme.textTheme.bodySmall?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            16.verticalSpace,

            // Legend
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _LegendItem(color: Colors.green, label: tr(LocaleKeys.reports_cards_completed)),
                16.horizontalSpace,
                _LegendItem(color: cs.tertiary, label: tr(LocaleKeys.reports_cards_pending)),
                16.horizontalSpace,
                _LegendItem(color: cs.error, label: tr(LocaleKeys.reports_cards_cancelled)),
              ],
            ),
          ],
        ),
      );
    });
  }
}

class _LegendItem extends StatelessWidget {
  final Color color;
  final String label;

  const _LegendItem({required this.color, required this.label});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      children: [
        Container(
          width: 12.w,
          height: 12.h,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        6.horizontalSpace,
        Text(
          label,
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}

class _EmptyReportsState extends StatelessWidget {
  const _EmptyReportsState();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.insert_chart_outlined,
            size: 80.sp,
            color: cs.onSurface.withOpacity(0.3),
          ),
          24.verticalSpace,
          Text(
            tr(LocaleKeys.reports_messages_empty_title),
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          8.verticalSpace,
          Text(
            tr(LocaleKeys.reports_messages_empty_subtitle),
            style: theme.textTheme.bodyMedium?.copyWith(
              color: cs.onSurface.withOpacity(0.6),
            ),
            textAlign: TextAlign.center,
          ),
          24.verticalSpace,
          ElevatedButton.icon(
            onPressed: () {
              // TODO: Generate first report
            },
            icon: const Icon(Icons.add),
            label: Text(tr(LocaleKeys.reports_actions_generate)),
            style: ElevatedButton.styleFrom(
              backgroundColor: cs.primary,
              foregroundColor: cs.onPrimary,
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
            ),
          ),
        ],
      ),
    );
  }
}