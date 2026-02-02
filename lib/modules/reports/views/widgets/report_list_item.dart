import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
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
    final date = DateFormat('EEE, MMM d').format(report.generatedAt);
    final time = DateFormat('hh:mm a').format(report.generatedAt);

    return Hero(
      tag: 'report_${report.id}',
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16.r),
          onTap: () => Get.to(() => const ReportDetailsView(), arguments: report),
          child: Container(
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
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  cs.surface,
                  cs.surface.withOpacity(0.9),
                ],
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    // Icon with background
                    Container(
                      width: 48.r,
                      height: 48.r,
                      decoration: BoxDecoration(
                        color: _getTypeColor(report.type, cs).withOpacity(0.15),
                        borderRadius: BorderRadius.circular(14.r),
                      ),
                      child: Icon(
                        _getTypeIcon(report.type),
                        color: _getTypeColor(report.type, cs),
                      ),
                    ),
                    12.horizontalSpace,

                    // Report Info
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            tr(report.type.key()),
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w800,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          4.verticalSpace,
                          Text(
                            date,
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: cs.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // PDF Icon and Arrow
                    if (report.hasPdf)
                      Icon(Icons.picture_as_pdf, color: cs.error, size: 20.sp),
                    8.horizontalSpace,
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 16.sp,
                      color: cs.onSurfaceVariant,
                    ),
                  ],
                ),
                12.verticalSpace,

                // Progress Bar
                _ReportProgressBar(report: report),
                8.verticalSpace,

                // Time and Stats
                Row(
                  children: [
                    Icon(
                      Icons.access_time,
                      size: 16.sp,
                      color: cs.onSurfaceVariant,
                    ),
                    6.horizontalSpace,
                    Text(
                      time,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: cs.onSurfaceVariant,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      '${report.total} ${tr(LocaleKeys.reports_cards_total)}',
                      style: theme.textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
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

class _ReportProgressBar extends StatelessWidget {
  final ReportModel report;

  const _ReportProgressBar({required this.report});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    final total = report.total.toDouble();
    final completed = report.completed.toDouble();
    final pending = report.pending.toDouble();
    final cancelled = report.cancelled.toDouble();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Progress Bar
        Container(
          height: 6.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(3.r),
            color: cs.outlineVariant.withOpacity(0.3),
          ),
          child: Row(
            children: [
              if (completed > 0)
                Expanded(
                  flex: (completed / total * 100).round(),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(3.r),
                      color: Colors.green,
                    ),
                  ),
                ),
              if (pending > 0)
                Expanded(
                  flex: (pending / total * 100).round(),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(3.r),
                      color: cs.tertiary,
                    ),
                  ),
                ),
              if (cancelled > 0)
                Expanded(
                  flex: (cancelled / total * 100).round(),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(3.r),
                      color: cs.error,
                    ),
                  ),
                ),
            ],
          ),
        ),
        4.verticalSpace,

        // Progress Labels
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '${report.completed} ${tr(LocaleKeys.reports_cards_completed)}',
              style: theme.textTheme.labelSmall?.copyWith(
                color: Colors.green,
              ),
            ),
            Text(
              '${report.pending} ${tr(LocaleKeys.reports_cards_pending)}',
              style: theme.textTheme.labelSmall?.copyWith(
                color: cs.tertiary,
              ),
            ),
            Text(
              '${report.cancelled} ${tr(LocaleKeys.reports_cards_cancelled)}',
              style: theme.textTheme.labelSmall?.copyWith(
                color: cs.error,
              ),
            ),
          ],
        ),
      ],
    );
  }
}