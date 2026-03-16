import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../../generated/locale_keys.g.dart';
import '../../controllers/reports_controller.dart';
import 'report_list_item.dart';

class ReportsListSection extends GetView<ReportsController> {
  const ReportsListSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final list = controller.filteredReports;
      if (list.isEmpty) {
        return SliverFillRemaining(
          hasScrollBody: false,
          child: _EmptyState(),
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
}

class _EmptyState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

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
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 14.h),
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
