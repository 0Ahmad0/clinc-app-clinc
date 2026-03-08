import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:clinc_app_clinc/generated/locale_keys.g.dart';
import '../controllers/reports_controller.dart';
import '../../../app/data/report_model.dart';
import 'widgets/report_list_item.dart';

class ReportsView extends GetView<ReportsController> {
  const ReportsView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: cs.surface,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          _buildHeader(theme, cs, isDark),
          _buildTypeFilters(theme, cs),
          _buildRangeFilters(theme, cs),
          _buildSummaryCards(theme, cs),
          _buildChartSection(theme, cs),
          _buildListHeader(theme, cs),
          _buildReportsList(cs),
        ],
      ),
      floatingActionButton: _buildFab(cs),
    );
  }

  // ─────────────────────────────────────────────
  // Header
  // ─────────────────────────────────────────────
  Widget _buildHeader(ThemeData theme, ColorScheme cs, bool isDark) {
    return SliverAppBar(
      pinned: true,
      floating: false,
      expandedHeight: 160.h,
      backgroundColor: cs.primary,
      elevation: 0,
      surfaceTintColor: Colors.transparent,
      flexibleSpace: FlexibleSpaceBar(
        collapseMode: CollapseMode.pin,
        background: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: isDark
                  ? [const Color(0xFF00695C), const Color(0xFF004D40)]
                  : [const Color(0xFF00897B), const Color(0xFF004D40)],
            ),
          ),
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 42.r,
                        height: 42.r,
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: Icon(
                          Icons.analytics_rounded,
                          color: Colors.white,
                          size: 22.sp,
                        ),
                      ),
                      12.horizontalSpace,
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              tr(LocaleKeys.reports_title),
                              style: theme.textTheme.headlineSmall?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w800,
                                letterSpacing: -0.5,
                              ),
                            ),
                            4.verticalSpace,
                            Obx(() {
                              final s = controller.summary;
                              return Text(
                                '${s.total} ${tr(LocaleKeys.reports_cards_total)} • ${s.completed} ${tr(LocaleKeys.reports_cards_completed)}',
                                style: theme.textTheme.bodySmall?.copyWith(
                                  color: Colors.white.withValues(alpha: 0.75),
                                ),
                              );
                            }),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      title: Text(
        tr(LocaleKeys.reports_title),
        style: theme.textTheme.titleMedium?.copyWith(
          color: Colors.white,
          fontWeight: FontWeight.w800,
        ),
      ),
      centerTitle: false,
    );
  }

  // ─────────────────────────────────────────────
  // Type Filters
  // ─────────────────────────────────────────────
  Widget _buildTypeFilters(ThemeData theme, ColorScheme cs) {
    return SliverToBoxAdapter(
      child: Container(
        color: cs.surface,
        padding: EdgeInsets.fromLTRB(16.w, 20.h, 16.w, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              tr(LocaleKeys.reports_filters_type),
              style: theme.textTheme.labelMedium?.copyWith(
                color: cs.onSurfaceVariant,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.5,
              ),
            ),
            12.verticalSpace,
            Obx(() {
              final selected = controller.selectedType.value;
              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: ReportType.values.map((t) {
                    final isSelected = t == selected;
                    final color = _typeColor(t, cs);
                    return Padding(
                      padding: EdgeInsets.only(left: 8.w),
                      child: _TypeFilterChip(
                        type: t,
                        isSelected: isSelected,
                        color: color,
                        onTap: () => controller.changeType(t),
                      ),
                    );
                  }).toList(),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  // ─────────────────────────────────────────────
  // Range Filters
  // ─────────────────────────────────────────────
  Widget _buildRangeFilters(ThemeData theme, ColorScheme cs) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 0),
        child: Obx(() {
          final selected = controller.selectedRange.value;
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                for (final r in ReportRange.values) ...[
                  _RangeChip(
                    label: tr(r.key()),
                    isSelected: r == selected,
                    onTap: r == ReportRange.custom
                        ? () async {
                            final now = DateTime.now();
                            final range = await showDateRangePicker(
                              context: Get.context!,
                              firstDate: DateTime(now.year - 1),
                              lastDate: DateTime(now.year + 1),
                              initialDateRange: DateTimeRange(
                                start: now.subtract(const Duration(days: 7)),
                                end: now,
                              ),
                              builder: (context, child) => Theme(
                                data: Theme.of(context).copyWith(
                                  colorScheme: Theme.of(context).colorScheme,
                                ),
                                child: child!,
                              ),
                            );
                            if (range != null) {
                              controller.setCustomRange(range);
                            }
                          }
                        : () => controller.changeRange(r),
                  ),
                  8.horizontalSpace,
                ],
              ],
            ),
          );
        }),
      ),
    );
  }

  // ─────────────────────────────────────────────
  // Summary KPI Cards
  // ─────────────────────────────────────────────
  Widget _buildSummaryCards(ThemeData theme, ColorScheme cs) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.fromLTRB(16.w, 20.h, 16.w, 0),
        child: Obx(() {
          final s = controller.summary;
          return Row(
            children: [
              Expanded(
                child: _KpiCard(
                  value: '${s.completed}',
                  label: tr(LocaleKeys.reports_cards_completed),
                  icon: Icons.check_circle_rounded,
                  color: const Color(0xFF10B981),
                ),
              ),
              10.horizontalSpace,
              Expanded(
                child: _KpiCard(
                  value: '${s.pending}',
                  label: tr(LocaleKeys.reports_cards_pending),
                  icon: Icons.hourglass_top_rounded,
                  color: const Color(0xFFF59E0B),
                ),
              ),
              10.horizontalSpace,
              Expanded(
                child: _KpiCard(
                  value: '${s.cancelled}',
                  label: tr(LocaleKeys.reports_cards_cancelled),
                  icon: Icons.cancel_rounded,
                  color: const Color(0xFFEF4444),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }

  // ─────────────────────────────────────────────
  // Chart Section
  // ─────────────────────────────────────────────
  Widget _buildChartSection(ThemeData theme, ColorScheme cs) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 0),
        child: _WeeklyBarChart(controller: controller),
      ),
    );
  }

  // ─────────────────────────────────────────────
  // List Header
  // ─────────────────────────────────────────────
  Widget _buildListHeader(ThemeData theme, ColorScheme cs) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.fromLTRB(16.w, 24.h, 16.w, 12.h),
        child: Obx(() {
          final count = controller.filteredReports.length;
          return Row(
            children: [
              Text(
                tr(LocaleKeys.reports_sections_list),
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
              ),
              8.horizontalSpace,
              Container(
                padding:
                    EdgeInsets.symmetric(horizontal: 10.w, vertical: 2.h),
                decoration: BoxDecoration(
                  color: cs.primary.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Text(
                  '$count',
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: cs.primary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }

  // ─────────────────────────────────────────────
  // Reports List
  // ─────────────────────────────────────────────
  Widget _buildReportsList(ColorScheme cs) {
    return Obx(() {
      final list = controller.filteredReports;
      if (list.isEmpty) {
        return SliverFillRemaining(
          hasScrollBody: false,
          child: _EmptyState(cs: cs),
        );
      }
      return SliverPadding(
        padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 100.h),
        sliver: SliverList.separated(
          itemBuilder: (_, i) => ReportListItem(report: list[i]),
          separatorBuilder: (_, __) => 12.verticalSpace,
          itemCount: list.length,
        ),
      );
    });
  }

  // ─────────────────────────────────────────────
  // FAB
  // ─────────────────────────────────────────────
  Widget _buildFab(ColorScheme cs) {
    return FloatingActionButton.extended(
      onPressed: () {},
      backgroundColor: cs.primary,
      foregroundColor: cs.onPrimary,
      elevation: 4,
      icon: const Icon(Icons.add_rounded),
      label: Text(
        tr(LocaleKeys.reports_actions_generate),
        style: const TextStyle(fontWeight: FontWeight.w700),
      ),
    );
  }

  Color _typeColor(ReportType type, ColorScheme cs) {
    switch (type) {
      case ReportType.appointments:
        return cs.primary;
      case ReportType.labResults:
        return const Color(0xFF6366F1);
      case ReportType.revenue:
        return const Color(0xFF10B981);
      case ReportType.doctors:
        return const Color(0xFFF59E0B);
    }
  }
}

// ═══════════════════════════════════════════════
// Type Filter Chip
// ═══════════════════════════════════════════════
class _TypeFilterChip extends StatelessWidget {
  final ReportType type;
  final bool isSelected;
  final Color color;
  final VoidCallback onTap;

  const _TypeFilterChip({
    required this.type,
    required this.isSelected,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
        decoration: BoxDecoration(
          color: isSelected ? color : cs.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(999.r),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: color.withValues(alpha: 0.35),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ]
              : [],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              _icon(type),
              size: 16.sp,
              color: isSelected ? Colors.white : cs.onSurfaceVariant,
            ),
            6.horizontalSpace,
            Text(
              tr(type.key()),
              style: theme.textTheme.labelMedium?.copyWith(
                fontWeight: FontWeight.w700,
                color: isSelected ? Colors.white : cs.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }

  IconData _icon(ReportType t) {
    switch (t) {
      case ReportType.appointments:
        return Icons.calendar_month_rounded;
      case ReportType.labResults:
        return Icons.biotech_rounded;
      case ReportType.revenue:
        return Icons.trending_up_rounded;
      case ReportType.doctors:
        return Icons.medical_services_rounded;
    }
  }
}

// ═══════════════════════════════════════════════
// Range Chip
// ═══════════════════════════════════════════════
class _RangeChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _RangeChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: isSelected
              ? cs.primary.withValues(alpha: 0.12)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(999.r),
          border: Border.all(
            color: isSelected ? cs.primary : cs.outlineVariant,
            width: isSelected ? 1.5 : 1,
          ),
        ),
        child: Text(
          label,
          style: theme.textTheme.labelMedium?.copyWith(
            fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
            color: isSelected ? cs.primary : cs.onSurfaceVariant,
          ),
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════
// KPI Card
// ═══════════════════════════════════════════════
class _KpiCard extends StatelessWidget {
  final String value;
  final String label;
  final IconData icon;
  final Color color;

  const _KpiCard({
    required this.value,
    required this.label,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 14.h),
      decoration: BoxDecoration(
        color: cs.surface,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: color.withValues(alpha: 0.18),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.08),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 32.r,
            height: 32.r,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Icon(icon, color: color, size: 16.sp),
          ),
          8.verticalSpace,
          Text(
            value,
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.w800,
              color: color,
              height: 1,
            ),
          ),
          4.verticalSpace,
          Text(
            label,
            style: theme.textTheme.labelSmall?.copyWith(
              color: cs.onSurfaceVariant,
              fontSize: 10.sp,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════
// Weekly Bar Chart
// ═══════════════════════════════════════════════
class _WeeklyBarChart extends StatelessWidget {
  final ReportsController controller;

  const _WeeklyBarChart({required this.controller});

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
                      reservedSize: 24.h,
                    ),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 28.w,
                      interval: 4,
                      getTitlesWidget: (val, meta) {
                        return Text(
                          val.toInt().toString(),
                          style: TextStyle(
                            fontSize: 9.sp,
                            color: cs.onSurfaceVariant,
                          ),
                        );
                      },
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

// ═══════════════════════════════════════════════
// Empty State
// ═══════════════════════════════════════════════
class _EmptyState extends StatelessWidget {
  final ColorScheme cs;
  const _EmptyState({required this.cs});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: Padding(
        padding: EdgeInsets.all(32.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 100.r,
              height: 100.r,
              decoration: BoxDecoration(
                color: cs.primary.withValues(alpha: 0.08),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.bar_chart_rounded,
                size: 48.sp,
                color: cs.primary.withValues(alpha: 0.5),
              ),
            ),
            24.verticalSpace,
            Text(
              tr(LocaleKeys.reports_messages_empty_title),
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w800,
              ),
              textAlign: TextAlign.center,
            ),
            10.verticalSpace,
            Text(
              tr(LocaleKeys.reports_messages_empty_subtitle),
              style: theme.textTheme.bodyMedium?.copyWith(
                color: cs.onSurfaceVariant,
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
            28.verticalSpace,
            FilledButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.add_rounded),
              label: Text(tr(LocaleKeys.reports_actions_generate)),
              style: FilledButton.styleFrom(
                padding:
                    EdgeInsets.symmetric(horizontal: 24.w, vertical: 14.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14.r),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
