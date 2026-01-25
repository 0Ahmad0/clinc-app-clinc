import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:clinc_app_clinc/generated/locale_keys.g.dart';

import '../../../app/data/report_model.dart';

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
        slivers: [
          SliverAppBar(
            pinned: true,
            backgroundColor: cs.surface,
            elevation: 0,
            centerTitle: true,
            title: Text(
              tr(LocaleKeys.reports_details_title),
              style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800),
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 16.h),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                Text(tr(report.type.key()), style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w900)),
                8.verticalSpace,
                Text(
                  "${tr(LocaleKeys.reports_details_generated_at)}: $generated",
                  style: theme.textTheme.bodyMedium?.copyWith(color: cs.onSurfaceVariant),
                ),
                16.verticalSpace,

                // Summary card (reuse)
                // (للتفاصيل نعرض القيم داخل كارد بسيط)
                Container(
                  padding: EdgeInsets.all(14.w),
                  decoration: BoxDecoration(
                    color: cs.surface,
                    borderRadius: BorderRadius.circular(16.r),
                    border: Border.all(color: cs.outlineVariant),
                  ),
                  child: Column(
                    children: [
                      _RowItem(label: tr(LocaleKeys.reports_cards_total), value: report.total.toString()),
                      _RowItem(label: tr(LocaleKeys.reports_cards_completed), value: report.completed.toString()),
                      _RowItem(label: tr(LocaleKeys.reports_cards_pending), value: report.pending.toString()),
                      _RowItem(label: tr(LocaleKeys.reports_cards_cancelled), value: report.cancelled.toString()),
                    ],
                  ),
                ),
                20.verticalSpace,

                if (report.hasPdf) ...[
                  ElevatedButton.icon(
                    onPressed: () {
                      // لاحقاً: open pdf
                    },
                    icon: const Icon(Icons.picture_as_pdf),
                    label: Text(tr(LocaleKeys.reports_details_view_pdf)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: cs.primary,
                      foregroundColor: cs.onPrimary,
                      padding: EdgeInsets.symmetric(vertical: 14.h),
                    ),
                  ),
                ],
                20.verticalSpace,
              ]),
            ),
          ),
        ],
      ),
    );
  }
}

class _RowItem extends StatelessWidget {
  final String label;
  final String value;
  const _RowItem({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6.h),
      child: Row(
        children: [
          Expanded(child: Text(label, style: theme.textTheme.bodyMedium?.copyWith(color: cs.onSurfaceVariant))),
          Text(value, style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w800)),
        ],
      ),
    );
  }
}