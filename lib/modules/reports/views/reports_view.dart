import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:clinc_app_clinc/generated/locale_keys.g.dart';
import '../../../app/data/report_model.dart';
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
      floatingActionButton: Obx(
        () => FloatingActionButton(
          heroTag: 'reports_generate_fab',
          onPressed: controller.isGenerating.value
              ? null
              : () => _showFormatSheet(context),
          backgroundColor: cs.primary,
          child: controller.isGenerating.value
              ? SizedBox(
                  width: 22.r,
                  height: 22.r,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: cs.onPrimary,
                  ),
                )
              : Icon(Icons.add, color: cs.onPrimary),
        ),
      ),
      body: CustomScrollView(
        controller: controller.scrollController,
        physics: const BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
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
                    colors: [cs.primary.withValues(alpha: 0.1), cs.surface],
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
          CupertinoSliverRefreshControl(onRefresh: controller.onRefresh),

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
            final loadingMore = controller.isLoadingMore.value;
            return controller.buildReports(
              SliverPadding(
                padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 80.h),
                sliver: SliverList.separated(
                  itemBuilder: (_, index) {
                    if (index == controller.reports.length) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    return ReportListItem(report: controller.reports[index]);
                  },
                  separatorBuilder: (_, __) => 16.verticalSpace,
                  itemCount: controller.reports.length + (loadingMore ? 1 : 0),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }

  Future<void> _showFormatSheet(BuildContext context) async {
    final format = await showModalBottomSheet<ReportFormat>(
      context: context,
      builder: (context) => SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                tr('reports.formats.title'),
                style: Theme.of(
                  context,
                ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
              ),
              16.verticalSpace,
              for (final format in ReportFormat.values)
                ListTile(
                  leading: Icon(
                    format == ReportFormat.pdf
                        ? Icons.picture_as_pdf_outlined
                        : Icons.table_chart_outlined,
                  ),
                  title: Text(tr(format.key())),
                  onTap: () => Navigator.pop(context, format),
                ),
            ],
          ),
        ),
      ),
    );
    if (format != null) await controller.generateReport(format);
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
          border: Border.all(color: cs.outlineVariant.withValues(alpha: 0.2)),
          boxShadow: [
            BoxShadow(
              color: cs.shadow.withValues(alpha: 0.05),
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
                _LegendItem(
                  color: Colors.green,
                  label: tr(LocaleKeys.reports_cards_completed),
                ),
                16.horizontalSpace,
                _LegendItem(
                  color: cs.tertiary,
                  label: tr(LocaleKeys.reports_cards_pending),
                ),
                16.horizontalSpace,
                _LegendItem(
                  color: cs.error,
                  label: tr(LocaleKeys.reports_cards_cancelled),
                ),
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
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
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
