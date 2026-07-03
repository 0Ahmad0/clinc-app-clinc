import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:open_filex/open_filex.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../app/core/configuration/locator.dart';
import '../../../app/core/helper/response_helper.dart';
import '../../../app/data/report_model.dart';
import '../../../generated/locale_keys.g.dart';
import '../domain/reports_repository.dart';

class ReportDetailsView extends StatelessWidget {
  const ReportDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    final report = Get.arguments as ReportModel;
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;
    final typeColor = _typeColor(report.type, cs);

    return Scaffold(
      backgroundColor: cs.surface,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // Header الجديد مع Hero من القديم
          _buildHeroHeader(context, report, typeColor, isDark),
          SliverPadding(
            padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 32.h),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                // تاريخ التقرير (مدمج)
                _DateRow(report: report, cs: cs, theme: theme),
                20.verticalSpace,

                // بطاقات الإحصائيات 2x2 (جديد)
                _StatGrid(report: report, cs: cs, theme: theme),
                20.verticalSpace,

                // نسبة الإنجاز (جديد)
                _CompletionRate(
                  report: report,
                  typeColor: typeColor,
                  theme: theme,
                  cs: cs,
                ),
                20.verticalSpace,

                // الرسم البياني (مدمج من الجديد مع تحسينات)
                _DistributionChart(report: report, cs: cs, theme: theme),
                20.verticalSpace,

                // ملاحظات (مدمج)
                _NotesCard(cs: cs, theme: theme),
                20.verticalSpace,

                // أزرار الإجراءات (مدمج من القديم والجديد)
                _ActionsRow(report: report, cs: cs, theme: theme),
                32.verticalSpace,
              ]),
            ),
          ),
        ],
      ),
    );
  }

  // ===== الهيدر مع Hero (مدمج من القديم والجديد) =====
  Widget _buildHeroHeader(
    BuildContext context,
    ReportModel report,
    Color typeColor,
    bool isDark,
  ) {
    final theme = Theme.of(context);

    return SliverAppBar(
      pinned: true,
      expandedHeight: 220.h,
      backgroundColor: typeColor,
      elevation: 0,
      surfaceTintColor: Colors.transparent,
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.light,
      ),
      leading: IconButton(
        onPressed: () => Get.back(),
        icon: Container(
          width: 34.r,
          height: 34.r,
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.2),
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.white,
            size: 16,
          ),
        ),
      ),
      title: Text(
        tr(LocaleKeys.reports_details_title),
        style: theme.textTheme.titleMedium?.copyWith(
          color: Colors.white,
          fontWeight: FontWeight.w800,
        ),
      ),
      centerTitle: true,
      actions: [
        IconButton(
          onPressed: () {
            // مشاركة التقرير
            _shareReport(report);
          },
          icon: Container(
            width: 34.r,
            height: 34.r,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.2),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.share_rounded,
              color: Colors.white,
              size: 16,
            ),
          ),
        ),
        12.horizontalSpace,
      ],
      flexibleSpace: FlexibleSpaceBar(
        collapseMode: CollapseMode.pin,
        // Hero من الكود القديم
        background: Hero(
          tag: 'report_${report.id}',
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [typeColor, typeColor.withValues(alpha: 0.75)],
              ),
            ),
            child: Stack(
              children: [
                // دوائر زخرفية (من الجديد)
                Positioned(
                  right: -30,
                  top: -20,
                  child: Container(
                    width: 130.r,
                    height: 130.r,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.07),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                Positioned(
                  left: -40,
                  bottom: -30,
                  child: Container(
                    width: 160.r,
                    height: 160.r,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.05),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                SafeArea(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        70.verticalSpace,
                        Container(
                          width: 64.r,
                          height: 64.r,
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(18.r),
                          ),
                          child: Icon(
                            _getTypeIcon(report.type),
                            color: Colors.white,
                            size: 30.sp,
                          ),
                        ),
                        12.verticalSpace,
                        Text(
                          tr(report.type.key()),
                          style: theme.textTheme.headlineSmall?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w800,
                            letterSpacing: -0.5,
                          ),
                        ),
                        6.verticalSpace,
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 12.w,
                            vertical: 4.h,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(999.r),
                          ),
                          child: Text(
                            '${report.total} ${tr(LocaleKeys.reports_cards_total)}',
                            style: theme.textTheme.labelMedium?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ===== دوال مساعدة =====
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
      case ReportType.clinic:
        return cs.secondary;
    }
  }

  IconData _getTypeIcon(ReportType type) {
    switch (type) {
      case ReportType.appointments:
        return Icons.calendar_month_rounded;
      case ReportType.labResults:
        return Icons.biotech_rounded;
      case ReportType.revenue:
        return Icons.trending_up_rounded;
      case ReportType.doctors:
        return Icons.medical_services_rounded;
      case ReportType.clinic:
        return Icons.local_hospital_rounded;
    }
  }

  Future<void> _shareReport(ReportModel report) async {
    final result = await locator<ReportsRepository>().shareReport(report);
    result.when(
      success: (model) async {
        if (model.status != 'success') {
          ResponseHelper.onFailure(message: model.message);
          return;
        }
        final shareUrl = model.result?['share_url']?.toString();
        if (shareUrl != null && shareUrl.isNotEmpty) {
          await Clipboard.setData(ClipboardData(text: shareUrl));
        }
        ResponseHelper.onSuccess(message: model.message);
      },
      failure: (exception) =>
          ResponseHelper.onNetworkFailure(networkException: exception),
    );
  }
}

// ===== صف التاريخ (جديد) =====
class _DateRow extends StatelessWidget {
  final ReportModel report;
  final ColorScheme cs;
  final ThemeData theme;
  const _DateRow({required this.report, required this.cs, required this.theme});

  @override
  Widget build(BuildContext context) {
    final generated = DateFormat(
      'EEEE، dd MMMM yyyy – hh:mm a',
    ).format(report.generatedAt);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: cs.surfaceContainerHighest.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        children: [
          Icon(Icons.schedule_rounded, size: 16.sp, color: cs.onSurfaceVariant),
          8.horizontalSpace,
          Expanded(
            child: Text(
              '${tr(LocaleKeys.reports_details_generated_at)}: $generated',
              style: theme.textTheme.labelMedium?.copyWith(
                color: cs.onSurfaceVariant,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ===== شبكة الإحصائيات 2x2 (جديد) =====
class _StatGrid extends StatelessWidget {
  final ReportModel report;
  final ColorScheme cs;
  final ThemeData theme;
  const _StatGrid({
    required this.report,
    required this.cs,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: 12.w,
      mainAxisSpacing: 12.h,
      childAspectRatio: 1.6,
      children: [
        _GridStatCard(
          value: '${report.total}',
          label: tr(LocaleKeys.reports_cards_total),
          icon: Icons.assessment_rounded,
          color: cs.primary,
          cs: cs,
          theme: theme,
        ),
        _GridStatCard(
          value: '${report.completed}',
          label: tr(LocaleKeys.reports_cards_completed),
          icon: Icons.check_circle_rounded,
          color: const Color(0xFF10B981),
          cs: cs,
          theme: theme,
        ),
        _GridStatCard(
          value: '${report.pending}',
          label: tr(LocaleKeys.reports_cards_pending),
          icon: Icons.hourglass_top_rounded,
          color: const Color(0xFFF59E0B),
          cs: cs,
          theme: theme,
        ),
        _GridStatCard(
          value: '${report.cancelled}',
          label: tr(LocaleKeys.reports_cards_cancelled),
          icon: Icons.cancel_rounded,
          color: const Color(0xFFEF4444),
          cs: cs,
          theme: theme,
        ),
      ],
    );
  }
}

class _GridStatCard extends StatelessWidget {
  final String value;
  final String label;
  final IconData icon;
  final Color color;
  final ColorScheme cs;
  final ThemeData theme;

  const _GridStatCard({
    required this.value,
    required this.label,
    required this.icon,
    required this.color,
    required this.cs,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = theme.brightness == Brightness.dark;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
      decoration: BoxDecoration(
        color: cs.surface,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: color.withValues(alpha: 0.15)),
        boxShadow: [
          BoxShadow(
            color: isDark
                ? Colors.black.withValues(alpha: 0.15)
                : color.withValues(alpha: 0.08),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 38.r,
            height: 38.r,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Icon(icon, color: color, size: 18.sp),
          ),
          12.horizontalSpace,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  value,
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w900,
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
          ),
        ],
      ),
    );
  }
}

// ===== نسبة الإنجاز (جديد) =====
class _CompletionRate extends StatelessWidget {
  final ReportModel report;
  final Color typeColor;
  final ThemeData theme;
  final ColorScheme cs;
  const _CompletionRate({
    required this.report,
    required this.typeColor,
    required this.theme,
    required this.cs,
  });

  @override
  Widget build(BuildContext context) {
    final rate = report.completionRate;
    return Container(
      padding: EdgeInsets.all(16.w),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'نسبة الإنجاز',
                style: theme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
              ),
              const Spacer(),
              Text(
                '${rate.toStringAsFixed(0)}%',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w900,
                  color: typeColor,
                ),
              ),
            ],
          ),
          12.verticalSpace,
          ClipRRect(
            borderRadius: BorderRadius.circular(6.r),
            child: LinearProgressIndicator(
              value: rate / 100,
              backgroundColor: cs.outlineVariant.withValues(alpha: 0.2),
              valueColor: AlwaysStoppedAnimation<Color>(typeColor),
              minHeight: 10.h,
            ),
          ),
          8.verticalSpace,
          Text(
            '${report.completed} من ${report.total} مكتملة',
            style: theme.textTheme.labelSmall?.copyWith(
              color: cs.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}

// ===== الرسم البياني (مدمج من الجديد مع تحسينات) =====
class _DistributionChart extends StatefulWidget {
  final ReportModel report;
  final ColorScheme cs;
  final ThemeData theme;
  const _DistributionChart({
    required this.report,
    required this.cs,
    required this.theme,
  });

  @override
  State<_DistributionChart> createState() => _DistributionChartState();
}

class _DistributionChartState extends State<_DistributionChart> {
  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    final r = widget.report;
    final cs = widget.cs;
    final theme = widget.theme;

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
          Row(
            children: [
              Text(
                tr(LocaleKeys.reports_details_visual_summary),
                style: theme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
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
                                    .touchedSection!
                                    .touchedSectionIndex;
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
                      theme: theme,
                    ),
                    16.verticalSpace,
                    _PieLegendRow(
                      color: const Color(0xFFF59E0B),
                      label: tr(LocaleKeys.reports_cards_pending),
                      value: r.pending,
                      total: r.total,
                      theme: theme,
                    ),
                    16.verticalSpace,
                    _PieLegendRow(
                      color: const Color(0xFFEF4444),
                      label: tr(LocaleKeys.reports_cards_cancelled),
                      value: r.cancelled,
                      total: r.total,
                      theme: theme,
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
  final ThemeData theme;
  const _PieLegendRow({
    required this.color,
    required this.label,
    required this.value,
    required this.total,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    final pct = total == 0 ? 0.0 : value / total * 100;
    final cs = theme.colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 10.r,
              height: 10.r,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(3.r),
              ),
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

// ===== بطاقة الملاحظات (مدمج من القديم والجديد) =====
class _NotesCard extends StatelessWidget {
  final ColorScheme cs;
  final ThemeData theme;
  const _NotesCard({required this.cs, required this.theme});

  @override
  Widget build(BuildContext context) {
    return Container(
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 0),
            child: Row(
              children: [
                Container(
                  width: 32.r,
                  height: 32.r,
                  decoration: BoxDecoration(
                    color: cs.primary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Icon(
                    Icons.notes_rounded,
                    color: cs.primary,
                    size: 16.sp,
                  ),
                ),
                10.horizontalSpace,
                Text(
                  tr(LocaleKeys.reports_details_notes),
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ),
          12.verticalSpace,
          Divider(
            height: 1,
            thickness: 1,
            color: cs.outlineVariant.withValues(alpha: 0.15),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 0),
            child: TextField(
              decoration: InputDecoration(
                hintText: tr(LocaleKeys.reports_details_add_notes),
                border: InputBorder.none,
                hintStyle: theme.textTheme.bodyMedium?.copyWith(
                  color: cs.onSurfaceVariant.withValues(alpha: 0.6),
                ),
                contentPadding: EdgeInsets.zero,
              ),
              style: theme.textTheme.bodyMedium,
              maxLines: 4,
              minLines: 2,
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 14.h),
            child: Align(
              alignment: Alignment.centerLeft,
              child: FilledButton(
                onPressed: () {
                  // TODO: حفظ الملاحظات
                  ResponseHelper.onSuccess(
                    message: tr('reports.messages.notes_saved'),
                  );
                },
                style: FilledButton.styleFrom(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.w,
                    vertical: 10.h,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                ),
                child: Text(
                  tr(LocaleKeys.reports_actions_save),
                  style: theme.textTheme.labelMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: cs.onPrimary,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ===== أزرار الإجراءات (مدمج من القديم والجديد) =====
class _ActionsRow extends StatelessWidget {
  final ReportModel report;
  final ColorScheme cs;
  final ThemeData theme;
  const _ActionsRow({
    required this.report,
    required this.cs,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (report.fileUrl.isNotEmpty)
          ElevatedButton.icon(
            onPressed: () => _openFile(report),
            icon: Icon(
              report.format == ReportFormat.pdf
                  ? Icons.picture_as_pdf
                  : Icons.table_chart,
              color: cs.onPrimary,
            ),
            label: Text(
              tr('reports.actions.view_file'),
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
              minimumSize: Size(double.infinity, 48.h),
            ),
          ),
        if (report.fileUrl.isNotEmpty) 12.verticalSpace,
        Row(
          children: [
            Expanded(
              child: OutlinedButton.icon(
                onPressed: () {
                  // تنزيل التقرير
                  _downloadReport(report);
                },
                icon: Icon(Icons.download_rounded, size: 18.sp),
                label: Text(
                  tr(LocaleKeys.reports_details_download_pdf),
                  style: const TextStyle(fontWeight: FontWeight.w700),
                ),
                style: OutlinedButton.styleFrom(
                  foregroundColor: cs.primary,
                  side: BorderSide(color: cs.primary, width: 1.5),
                  padding: EdgeInsets.symmetric(vertical: 14.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14.r),
                  ),
                ),
              ),
            ),
            if (report.fileUrl.isNotEmpty) ...[
              12.horizontalSpace,
              Expanded(
                child: FilledButton.icon(
                  onPressed: () => _openFile(report),
                  icon: Icon(Icons.picture_as_pdf_rounded, size: 18.sp),
                  label: Text(
                    tr(LocaleKeys.reports_details_view_pdf),
                    style: const TextStyle(fontWeight: FontWeight.w700),
                  ),
                  style: FilledButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 14.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14.r),
                    ),
                  ),
                ),
              ),
            ],
          ],
        ),
      ],
    );
  }

  void _openFile(ReportModel report) {
    // من الكود القديم
    if (report.fileUrl.startsWith('mock://')) {
      ResponseHelper.onWarning(message: tr('reports.messages.mock_file'));
      return;
    }
    final uri = Uri.tryParse(report.fileUrl);
    if (uri != null && (uri.scheme == 'http' || uri.scheme == 'https')) {
      launchUrl(uri, mode: LaunchMode.externalApplication);
      return;
    }
    OpenFilex.open(report.fileUrl);
  }

  void _downloadReport(ReportModel report) {
    locator<ReportsRepository>().downloadReport(report).then((result) {
      result.when(
        success: (model) {
          if (model.status != 'success') {
            ResponseHelper.onFailure(message: model.message);
            return;
          }
          ResponseHelper.onSuccess(message: model.message);
        },
        failure: (exception) =>
            ResponseHelper.onNetworkFailure(networkException: exception),
      );
    });
  }
}
