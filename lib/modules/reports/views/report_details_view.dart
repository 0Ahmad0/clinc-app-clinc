import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../app/data/report_model.dart';
import 'widgets/report_details_hero_header.dart';
import 'widgets/report_date_row.dart';
import 'widgets/report_stat_grid.dart';
import 'widgets/report_completion_rate.dart';
import 'widgets/report_distribution_chart.dart';
import 'widgets/report_notes_card.dart';
import 'widgets/report_actions_row.dart';

class ReportDetailsView extends StatelessWidget {
  const ReportDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    final report = Get.arguments as ReportModel;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: CustomScrollView(
         
        slivers: [
          ReportDetailsHeroHeader(report: report),
          SliverPadding(
            padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 32.h),
            sliver: SliverList.list(
              children: [
                20.verticalSpace,
                ReportDateRow(report: report),
                20.verticalSpace,
                ReportStatGrid(report: report),
                20.verticalSpace,
                ReportCompletionRate(report: report),
                20.verticalSpace,
                ReportDistributionChart(report: report),
                20.verticalSpace,
                const ReportNotesCard(),
                20.verticalSpace,
                ReportActionsRow(report: report),
                32.verticalSpace,
              ],
            ),
          ),
        ],
      ),
    );
  }
}
