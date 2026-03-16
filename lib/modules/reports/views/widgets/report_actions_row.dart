import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../app/data/report_model.dart';
import '../../../../generated/locale_keys.g.dart';

Future<void> _openUrl(String url) async {
  final uri = Uri.tryParse(url);
  if (uri != null) await launchUrl(uri);
}

class ReportActionsRow extends StatelessWidget {
  final ReportModel report;
  const ReportActionsRow({super.key, required this.report});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Row(
      children: [
        Expanded(
          child: OutlinedButton.icon(
            onPressed: () {},
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
        if (report.hasPdf) ...[
          12.horizontalSpace,
          Expanded(
            child: FilledButton.icon(
              onPressed: report.pdfPathOrUrl != null &&
                      report.pdfPathOrUrl!.isNotEmpty
                  ? () => _openUrl(report.pdfPathOrUrl!)
                  : null,
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
    );
  }
}
