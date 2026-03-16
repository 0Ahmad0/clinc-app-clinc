import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:intl/intl.dart';
import '../../../../app/data/report_model.dart';
import '../../../../generated/locale_keys.g.dart';

class ReportDateRow extends StatelessWidget {
  final ReportModel report;
  const ReportDateRow({super.key, required this.report});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final generated =
        DateFormat('EEEE، dd MMMM yyyy – hh:mm a').format(report.generatedAt);

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
              style: theme.textTheme.labelMedium
                  ?.copyWith(color: cs.onSurfaceVariant),
            ),
          ),
        ],
      ),
    );
  }
}
