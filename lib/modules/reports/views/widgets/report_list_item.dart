import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../../../app/data/report_model.dart';
import '../report_details_view.dart';

class ReportListItem extends StatelessWidget {
  final ReportModel report;
  const ReportListItem({super.key, required this.report});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    final date = DateFormat('EEE, MMM d').format(report.generatedAt);

    return InkWell(
      borderRadius: BorderRadius.circular(16.r),
      onTap: () => Get.to(() => const ReportDetailsView(), arguments: report),
      child: Container(
        padding: EdgeInsets.all(14.w),
        decoration: BoxDecoration(
          color: cs.surface,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: cs.outlineVariant),
          boxShadow: [
            BoxShadow(color: cs.shadow.withOpacity(0.03), blurRadius: 12, offset: const Offset(0, 6)),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 46.r,
              height: 46.r,
              decoration: BoxDecoration(
                color: cs.primaryContainer,
                borderRadius: BorderRadius.circular(14.r),
              ),
              child: Icon(_icon(report.type), color: cs.onPrimaryContainer),
            ),
            12.horizontalSpace,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(tr(report.type.key()), style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800)),
                  6.verticalSpace,
                  Text(date, style: theme.textTheme.bodySmall?.copyWith(color: cs.onSurfaceVariant)),
                ],
              ),
            ),
            if (report.hasPdf)
              Icon(Icons.picture_as_pdf, color: cs.error),
            10.horizontalSpace,
            Icon(Icons.arrow_forward_ios, size: 16.sp, color: cs.onSurfaceVariant),
          ],
        ),
      ),
    );
  }

  IconData _icon(ReportType t) {
    switch (t) {
      case ReportType.appointments:
        return Icons.event_note_outlined;
      case ReportType.revenue:
        return Icons.payments_outlined;
      case ReportType.labResults:
        return Icons.science_outlined;
      case ReportType.doctors:
        return Icons.badge_outlined;
    }
  }
}