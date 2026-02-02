import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:open_filex/open_filex.dart';
import '../../../app/data/report_model.dart';
import '../../../generated/locale_keys.g.dart';

class ReportDetailsView extends StatelessWidget {
  const ReportDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    final report = Get.arguments as ReportModel;
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    final generated = DateFormat('EEE, MMM d • hh:mm a').format(report.generatedAt);

    return Scaffold(
      backgroundColor: cs.surface,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // 1. Sliver App Bar with Hero
          SliverAppBar(
            pinned: true,
            expandedHeight: 200.h,
            backgroundColor: cs.surface,
            elevation: 0,
            flexibleSpace: FlexibleSpaceBar(
              background: Hero(
                tag: 'report_${report.id}',
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        _getTypeColor(report.type, cs).withOpacity(0.1),
                        cs.surface,
                      ],
                    ),
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          _getTypeIcon(report.type),
                          size: 60.sp,
                          color: _getTypeColor(report.type, cs),
                        ),
                        12.verticalSpace,
                        Text(
                          tr(report.type.key()),
                          style: theme.textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            title: Text(
              tr(LocaleKeys.reports_details_title),
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w800,
              ),
            ),
            centerTitle: true,
          ),

          // 2. Report Details
          SliverPadding(
            padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 16.h),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                // Date and Time
                Row(
                  children: [
                    Icon(
                      Icons.access_time,
                      size: 18.sp,
                      color: cs.onSurfaceVariant,
                    ),
                    8.horizontalSpace,
                    Text(
                      "${tr(LocaleKeys.reports_details_generated_at)}: $generated",
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: cs.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
                24.verticalSpace,

                // Summary Card
                _SummaryCard(report: report),
                24.verticalSpace,

                // Chart
                _ReportChart(report: report),
                24.verticalSpace,

                // Notes Section
                _NotesSection(),
                24.verticalSpace,

                // Actions
                if (report.hasPdf)
                  ElevatedButton.icon(
                    onPressed: () async {
                      await OpenFilex.open(report.pdfPathOrUrl!);
                    },
                    icon: Icon(Icons.picture_as_pdf, color: cs.onPrimary),
                    label: Text(
                      tr(LocaleKeys.reports_details_view_pdf),
                      style: theme.textTheme.labelLarge?.copyWith(
                        color: cs.onPrimary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: cs.primary,
                      padding: EdgeInsets.symmetric(vertical: 14.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                  ),
                20.verticalSpace,
              ]),
            ),
          ),
        ],
      ),
    );
  }

  IconData _getTypeIcon(ReportType type) {
    switch (type) {
      case ReportType.appointments:
        return Icons.event_note_outlined;
      case ReportType.labResults:
        return Icons.science_outlined;
      case ReportType.revenue:
        return Icons.payments_outlined;
      case ReportType.doctors:
        return Icons.badge_outlined;
    }
  }

  Color _getTypeColor(ReportType type, ColorScheme cs) {
    switch (type) {
      case ReportType.appointments:
        return cs.primary;
      case ReportType.labResults:
        return cs.secondary;
      case ReportType.revenue:
        return Colors.green;
      case ReportType.doctors:
        return cs.tertiary;
    }
  }
}

class _SummaryCard extends StatelessWidget {
  final ReportModel report;

  const _SummaryCard({required this.report});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _SummaryItem(
                value: report.total.toString(),
                label: tr(LocaleKeys.reports_cards_total),
                color: cs.primary,
              ),
              _SummaryItem(
                value: report.completed.toString(),
                label: tr(LocaleKeys.reports_cards_completed),
                color: Colors.green,
              ),
            ],
          ),
          16.verticalSpace,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _SummaryItem(
                value: report.pending.toString(),
                label: tr(LocaleKeys.reports_cards_pending),
                color: cs.tertiary,
              ),
              _SummaryItem(
                value: report.cancelled.toString(),
                label: tr(LocaleKeys.reports_cards_cancelled),
                color: cs.error,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SummaryItem extends StatelessWidget {
  final String value;
  final String label;
  final Color color;

  const _SummaryItem({
    required this.value,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          value,
          style: theme.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.w800,
            color: color,
          ),
        ),
        4.verticalSpace,
        Text(
          label,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}

class _ReportChart extends StatelessWidget {
  final ReportModel report;

  const _ReportChart({required this.report});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

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
          Text(
            tr(LocaleKeys.reports_details_visual_summary),
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
          16.verticalSpace,
          SizedBox(
            height: 200.h,
            child: PieChart(
              PieChartData(
                sectionsSpace: 2,
                centerSpaceRadius: 50.r,
                sections: [
                  PieChartSectionData(
                    value: report.completed.toDouble(),
                    color: Colors.green,
                    title: '${report.completed}',
                    radius: 25.r,
                    titleStyle: theme.textTheme.bodySmall?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  PieChartSectionData(
                    value: report.pending.toDouble(),
                    color: cs.tertiary,
                    title: '${report.pending}',
                    radius: 25.r,
                    titleStyle: theme.textTheme.bodySmall?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  PieChartSectionData(
                    value: report.cancelled.toDouble(),
                    color: cs.error,
                    title: '${report.cancelled}',
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

class _NotesSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            tr(LocaleKeys.reports_details_notes),
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
          12.verticalSpace,
          TextField(
            decoration: InputDecoration(
              hintText: tr(LocaleKeys.reports_details_add_notes),
              border: InputBorder.none,
              contentPadding: EdgeInsets.zero,
            ),
            maxLines: 3,
          ),
          12.verticalSpace,
          Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton(
              onPressed: () {
                // TODO: Save notes
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: cs.primary,
                foregroundColor: cs.onPrimary,
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 10.h),
              ),
              child: Text(
                tr(LocaleKeys.reports_actions_save),
                style: theme.textTheme.labelLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}