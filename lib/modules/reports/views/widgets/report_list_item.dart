import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../../../app/data/report_model.dart';
import '../../../../generated/locale_keys.g.dart';
import '../report_details_view.dart';

class ReportListItem extends StatelessWidget {
  final ReportModel report;
  const ReportListItem({super.key, required this.report});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;
    final color = _typeColor(report.type, cs);

    // تنسيق التاريخ والوقت (من الكود القديم)
    final date = DateFormat('EEE, MMM d').format(report.generatedAt);
    final time = DateFormat('hh:mm a').format(report.generatedAt);

    return Hero(
      tag: 'report_${report.id}',
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(18.r),
          onTap: () =>
              Get.to(() => const ReportDetailsView(), arguments: report),
          child: Container(
            decoration: BoxDecoration(
              color: cs.surface,
              borderRadius: BorderRadius.circular(18.r),
              border: Border.all(
                color: isDark
                    ? cs.outlineVariant.withValues(alpha: 0.15)
                    : cs.outlineVariant.withValues(alpha: 0.3),
              ),
              boxShadow: [
                BoxShadow(
                  color: isDark
                      ? Colors.black.withValues(alpha: 0.15)
                      : color.withValues(alpha: 0.06),
                  blurRadius: 16,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: IntrinsicHeight(
              child: Row(
                children: [
                  // الشريط الجانبي الملون (من الجديد)
                  Container(
                    width: 4.w,
                    decoration: BoxDecoration(
                      color: color,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(18.r),
                        bottomRight: Radius.circular(18.r),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 14.w,
                        vertical: 14.h,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // الصف العلوي: الأيقونة + العنوان + التاريخ + السهم
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // أيقونة مع خلفية (مدمج من القديم والجديد)
                              Container(
                                width: 44.r,
                                height: 44.r,
                                decoration: BoxDecoration(
                                  color: color.withValues(alpha: 0.1),
                                  borderRadius: BorderRadius.circular(12.r),
                                ),
                                child: Icon(
                                  _getTypeIcon(report.type),
                                  color: color,
                                  size: 20.sp,
                                ),
                              ),
                              12.horizontalSpace,
                              // معلومات التقرير
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            tr(report.type.key()),
                                            style: theme.textTheme.titleSmall
                                                ?.copyWith(
                                                  fontWeight: FontWeight.w800,
                                                ),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        // أيقونة PDF (من الجديد)
                                        if (report.format == ReportFormat.pdf)
                                          Icon(
                                            Icons.picture_as_pdf_rounded,
                                            color: cs.error,
                                            size: 16.sp,
                                          ),
                                      ],
                                    ),
                                    4.verticalSpace,
                                    // التاريخ والوقت (من القديم)
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.calendar_today_rounded,
                                          size: 11.sp,
                                          color: cs.onSurfaceVariant,
                                        ),
                                        4.horizontalSpace,
                                        Text(
                                          date,
                                          style: theme.textTheme.labelSmall
                                              ?.copyWith(
                                                color: cs.onSurfaceVariant,
                                              ),
                                        ),
                                        8.horizontalSpace,
                                        Icon(
                                          Icons.access_time_rounded,
                                          size: 11.sp,
                                          color: cs.onSurfaceVariant,
                                        ),
                                        4.horizontalSpace,
                                        Text(
                                          time,
                                          style: theme.textTheme.labelSmall
                                              ?.copyWith(
                                                color: cs.onSurfaceVariant,
                                              ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              // سهم التوجيه (من القديم)
                              Icon(
                                Icons.arrow_forward_ios_rounded,
                                size: 14.sp,
                                color: cs.onSurfaceVariant,
                              ),
                            ],
                          ),
                          14.verticalSpace,

                          // شريط التقدم (مدمج من القديم والجديد)
                          _SegmentedBar(report: report, color: color),
                          10.verticalSpace,

                          // إحصائيات (مدمجة من القديم والجديد)
                          Row(
                            children: [
                              _StatBadge(
                                value: report.completed,
                                label: tr(LocaleKeys.reports_cards_completed),
                                color: const Color(0xFF10B981),
                              ),
                              8.horizontalSpace,
                              _StatBadge(
                                value: report.pending,
                                label: tr(LocaleKeys.reports_cards_pending),
                                color: const Color(0xFFF59E0B),
                              ),
                              8.horizontalSpace,
                              _StatBadge(
                                value: report.cancelled,
                                label: tr(LocaleKeys.reports_cards_cancelled),
                                color: const Color(0xFFEF4444),
                              ),
                              const Spacer(),
                              // المجموع (من القديم)
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 10.w,
                                  vertical: 4.h,
                                ),
                                decoration: BoxDecoration(
                                  color: color.withValues(alpha: 0.1),
                                  borderRadius: BorderRadius.circular(999.r),
                                ),
                                child: Text(
                                  '${report.total} ${tr(LocaleKeys.reports_cards_total)}',
                                  style: theme.textTheme.labelSmall?.copyWith(
                                    color: color,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ],
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
      ),
    );
  }

  // ===== دوال مساعدة (مدمجة من القديم والجديد) =====
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
}

// ===== شريط التقدم المجزأ (من الجديد) =====
class _SegmentedBar extends StatelessWidget {
  final ReportModel report;
  final Color color;
  const _SegmentedBar({required this.report, required this.color});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final total = report.total.toDouble();
    if (total == 0) return const SizedBox.shrink();

    final cF = report.completed / total;
    final pF = report.pending / total;
    final cxF = report.cancelled / total;

    return ClipRRect(
      borderRadius: BorderRadius.circular(4.r),
      child: Container(
        height: 6.h,
        color: cs.outlineVariant.withValues(alpha: 0.2),
        child: Row(
          children: [
            if (cF > 0)
              Expanded(
                flex: (cF * 100).round(),
                child: Container(color: const Color(0xFF10B981)),
              ),
            if (pF > 0)
              Expanded(
                flex: (pF * 100).round(),
                child: Container(color: const Color(0xFFF59E0B)),
              ),
            if (cxF > 0)
              Expanded(
                flex: (cxF * 100).round(),
                child: Container(color: const Color(0xFFEF4444)),
              ),
          ],
        ),
      ),
    );
  }
}

// ===== شارة الإحصائيات (من الجديد) =====
class _StatBadge extends StatelessWidget {
  final int value;
  final String label;
  final Color color;
  const _StatBadge({
    required this.value,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      children: [
        Container(
          width: 6.r,
          height: 6.r,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        4.horizontalSpace,
        Text(
          '$value',
          style: theme.textTheme.labelSmall?.copyWith(
            color: color,
            fontWeight: FontWeight.w700,
          ),
        ),
        2.horizontalSpace,
        Text(
          label,
          style: theme.textTheme.labelSmall?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
            fontSize: 9.sp,
          ),
        ),
      ],
    );
  }
}
