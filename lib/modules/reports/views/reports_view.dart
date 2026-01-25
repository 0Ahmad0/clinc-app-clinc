import 'package:clinc_app_clinc/modules/reports/views/widgets/report_filters_widget.dart';
import 'package:clinc_app_clinc/modules/reports/views/widgets/report_list_item.dart';
import 'package:clinc_app_clinc/modules/reports/views/widgets/report_summary_grid.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:clinc_app_clinc/generated/locale_keys.g.dart';
import '../controllers/reports_controller.dart';

class ReportsView extends GetView<ReportsController> {
  const ReportsView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    return Scaffold(
      backgroundColor: cs.surface,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            pinned: true,
            floating: true,
            backgroundColor: cs.surface,
            elevation: 0,
            centerTitle: true,
            title: Text(
              tr(LocaleKeys.reports_title),
              style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800),
            ),
          ),

          SliverPadding(
            padding: EdgeInsets.fromLTRB(16.w, 10.h, 16.w, 0),
            sliver: const SliverToBoxAdapter(child: ReportFiltersWidget()),
          ),

          SliverPadding(
            padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 0),
            sliver: SliverToBoxAdapter(
              child: Text(
                tr(LocaleKeys.reports_sections_summary),
                style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800),
              ),
            ),
          ),

          SliverPadding(
            padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 0),
            sliver: const SliverToBoxAdapter(child: ReportSummaryGrid()),
          ),

          SliverPadding(
            padding: EdgeInsets.fromLTRB(16.w, 20.h, 16.w, 10.h),
            sliver: SliverToBoxAdapter(
              child: Text(
                tr(LocaleKeys.reports_sections_list),
                style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800),
              ),
            ),
          ),

          Obx(() {
            final list = controller.filteredReports;
            if (list.isEmpty) {
              return SliverFillRemaining(
                hasScrollBody: false,
                child: Center(
                  child: Text(
                    tr(LocaleKeys.reports_messages_empty),
                    style: theme.textTheme.bodyLarge?.copyWith(color: cs.onSurfaceVariant),
                    textAlign: TextAlign.center,
                  ),
                ),
              );
            }

            return SliverPadding(
              padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 16.h),
              sliver: SliverList.separated(
                itemBuilder: (_, i) => ReportListItem(report: list[i]),
                separatorBuilder: (_, __) => 12.verticalSpace,
                itemCount: list.length,
              ),
            );
          }),
        ],
      ),
    );
  }
}