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
          _buildPeriodTabs(theme, cs),
          _buildTypeFilters(theme, cs),
          _buildSummaryCards(theme, cs),
          _buildChartSection(theme, cs),
          _buildExportRow(theme, cs),
          _buildListHeader(theme, cs),
          _buildReportsList(cs),
        ],
      ),
    );
  }

  Widget _buildPeriodTabs(ThemeData theme, ColorScheme cs) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.fromLTRB(16.w, 20.h, 16.w, 0),
        child: Obx(() {
          final sel = controller.selectedPeriodTab.value;
          return Container(
            padding: EdgeInsets.all(4.w),
            decoration: BoxDecoration(
              color: cs.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(14.r),
            ),
            child: Row(
              children: [
                _PeriodTab(
                  label: 'أسبوعي',
                  icon: Icons.view_week_rounded,
                  isSelected: sel == 0,
                  color: const Color(0xFF009688),
                  onTap: () => controller.changePeriodTab(0),
                ),
                _PeriodTab(
                  label: 'شهري',
                  icon: Icons.calendar_month_rounded,
                  isSelected: sel == 1,
                  color: const Color(0xFF3949AB),
                  onTap: () => controller.changePeriodTab(1),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }

  Widget _buildExportRow(ThemeData theme, ColorScheme cs) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 0),
        child: Row(
          children: [
            Expanded(
              child: Obx(() {
                final loading = controller.isLoading.value;
                return _ExportButton(
                  label: 'تصدير PDF',
                  icon: Icons.picture_as_pdf_rounded,
                  gradientColors: const [Color(0xFF004D40), Color(0xFF009688)],
                  shadowColor: const Color(0xFF009688),
                  isLoading: loading,
                  onTap: loading ? null : controller.generatePdfReport,
                );
              }),
            ),
            12.horizontalSpace,
            Expanded(
              child: Obx(() {
                final loading = controller.isCsvLoading.value;
                return _ExportButton(
                  label: 'تصدير CSV',
                  icon: Icons.table_chart_rounded,
                  gradientColors: const [Color(0xFF1A237E), Color(0xFF3949AB)],
                  shadowColor: const Color(0xFF3949AB),
                  isLoading: loading,
                  onTap: loading ? null : controller.exportCsvReport,
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  // ─────────────────────────────────────────────
  // Header
  // ─────────────────────────────────────────────
  Widget _buildHeader(ThemeData theme, ColorScheme cs, bool isDark) {
    return SliverToBoxAdapter(
      child: Container(
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
          bottom: false,
          child: Padding(
            padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 20.h),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(10.r),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(14.r),
                  ),
                  child: Icon(
                    Icons.analytics_rounded,
                    color: Colors.white,
                    size: 26.sp,
                  ),
                ),
                14.horizontalSpace,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        tr(LocaleKeys.reports_title),
                        style: theme.textTheme.headlineSmall?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w900,
                          letterSpacing: -0.5,
                        ),
                      ),
                      Obx(() {
                        final s = controller.summary;
                        return Text(
                          '${s.total} ${tr(LocaleKeys.reports_cards_total)} • ${s.completed} ${tr(LocaleKeys.reports_cards_completed)}',
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: Colors.white.withValues(alpha: 0.8),
                          ),
                        );
                      }),
                    ],
                  ),
                ),
                Obx(() {
                  final s = controller.summary;
                  return _HeaderStat(
                    value: '${s.pending}',
                    label: 'قيد',
                    color: const Color(0xFFFBBF24),
                  );
                }),
              ],
            ),
          ),
        ),
      ),
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
  // Chart Section (switches with period tab)
  // ─────────────────────────────────────────────
  Widget _buildChartSection(ThemeData theme, ColorScheme cs) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 0),
        child: Obx(() {
          final period = controller.selectedPeriodTab.value;
          return AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: period == 0
                ? _WeeklyBarChart(key: const ValueKey('weekly'), controller: controller)
                : _MonthlyRevenueChart(key: const ValueKey('monthly'), controller: controller),
          );
        }),
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
// Period Tab
// ═══════════════════════════════════════════════
class _PeriodTab extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool isSelected;
  final Color color;
  final VoidCallback onTap;

  const _PeriodTab({
    required this.label,
    required this.icon,
    required this.isSelected,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          curve: Curves.easeInOut,
          padding: EdgeInsets.symmetric(vertical: 11.h),
          decoration: BoxDecoration(
            gradient: isSelected
                ? LinearGradient(
                    colors: [color, color.withValues(alpha: 0.75)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  )
                : null,
            borderRadius: BorderRadius.circular(10.r),
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: color.withValues(alpha: 0.3),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ]
                : [],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 16.sp,
                color: isSelected
                    ? Colors.white
                    : theme.colorScheme.onSurfaceVariant,
              ),
              6.horizontalSpace,
              Text(
                label,
                style: TextStyle(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w700,
                  color: isSelected
                      ? Colors.white
                      : theme.colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════
// Export Button
// ═══════════════════════════════════════════════
class _ExportButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final List<Color> gradientColors;
  final Color shadowColor;
  final bool isLoading;
  final VoidCallback? onTap;

  const _ExportButton({
    required this.label,
    required this.icon,
    required this.gradientColors,
    required this.shadowColor,
    required this.isLoading,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: gradientColors,
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(14.r),
        boxShadow: [
          BoxShadow(
            color: shadowColor.withValues(alpha: 0.35),
            blurRadius: 14,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(14.r),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 14.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (isLoading)
                  SizedBox(
                    width: 16.r,
                    height: 16.r,
                    child: const CircularProgressIndicator(
                        color: Colors.white, strokeWidth: 2),
                  )
                else
                  Icon(icon, color: Colors.white, size: 18.sp),
                8.horizontalSpace,
                Text(
                  isLoading ? 'جاري...' : label,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                    fontSize: 13.sp,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
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
// Monthly Revenue Line Chart
// ═══════════════════════════════════════════════
class _MonthlyRevenueChart extends StatelessWidget {
  final ReportsController controller;
  const _MonthlyRevenueChart({required this.controller});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;
    final data = controller.monthlyRevenue;
    const lineColor = Color(0xFF009688);
    final maxY = data.map((m) => m.amount).reduce((a, b) => a > b ? a : b).toDouble();

    final spots = data.asMap().entries.map((e) {
      return FlSpot(e.key.toDouble(), e.value.amount.toDouble());
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
                      'الإيراد الشهري',
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    Text(
                      '\$${(controller.totalRevenue / 1000).toStringAsFixed(1)}k إجمالي العام',
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: cs.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: lineColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.trending_up_rounded,
                        size: 14.sp, color: lineColor),
                    4.horizontalSpace,
                    Text(
                      '+14%',
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: lineColor,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          20.verticalSpace,
          SizedBox(
            height: 160.h,
            child: LineChart(
              LineChartData(
                minY: 0,
                maxY: maxY * 1.2,
                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: false,
                  horizontalInterval: maxY / 4,
                  getDrawingHorizontalLine: (_) => FlLine(
                    color: cs.outlineVariant.withValues(alpha: 0.2),
                    strokeWidth: 1,
                  ),
                ),
                borderData: FlBorderData(show: false),
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
                      reservedSize: 22.h,
                      interval: 2,
                      getTitlesWidget: (val, meta) {
                        final idx = val.toInt();
                        if (idx < 0 || idx >= data.length) {
                          return const SizedBox.shrink();
                        }
                        return Text(
                          data[idx].month.substring(0, 3),
                          style: TextStyle(
                            fontSize: 9.sp,
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
                      reservedSize: 36.w,
                      interval: maxY / 4,
                      getTitlesWidget: (val, meta) {
                        return Text(
                          '\$${(val / 1000).toStringAsFixed(1)}k',
                          style: TextStyle(
                            fontSize: 8.sp,
                            color: cs.onSurfaceVariant,
                          ),
                        );
                      },
                    ),
                  ),
                ),
                lineTouchData: LineTouchData(
                  enabled: true,
                  touchTooltipData: LineTouchTooltipData(
                    getTooltipItems: (spots) => spots.map((s) {
                      return LineTooltipItem(
                        '\$${s.y.toInt()}',
                        TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 12.sp,
                        ),
                      );
                    }).toList(),
                  ),
                ),
                lineBarsData: [
                  LineChartBarData(
                    spots: spots,
                    isCurved: true,
                    color: lineColor,
                    barWidth: 2.5,
                    isStrokeCapRound: true,
                    dotData: const FlDotData(show: false),
                    belowBarData: BarAreaData(
                      show: true,
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          lineColor.withValues(alpha: 0.25),
                          lineColor.withValues(alpha: 0.0),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
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

class _HeaderStat extends StatelessWidget {
  final String value;
  final String label;
  final Color color;
  const _HeaderStat({required this.value, required this.label, required this.color});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: TextStyle(
              color: color,
              fontSize: 18.sp,
              fontWeight: FontWeight.w900,
            ),
          ),
          Text(
            label,
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.8),
              fontSize: 10.sp,
            ),
          ),
        ],
      ),
    );
  }
}
