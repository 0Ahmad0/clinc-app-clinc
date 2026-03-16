import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../controllers/reports_controller.dart';
import 'reports_weekly_bar_chart.dart';
import 'reports_monthly_chart.dart';

class ReportsChartSection extends GetView<ReportsController> {
  const ReportsChartSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 0),
        child: Obx(() {
          final period = controller.selectedPeriodTab.value;
          return AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: period == 0
                ? const ReportsWeeklyBarChart(key: ValueKey('weekly'))
                : const ReportsMonthlyChart(key: ValueKey('monthly')),
          );
        }),
      ),
    );
  }
}
