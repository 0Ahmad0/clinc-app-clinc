import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/reports_controller.dart';
import 'widgets/reports_header.dart';
import 'widgets/reports_period_tabs.dart';
import 'widgets/reports_type_filters.dart';
import 'widgets/reports_kpi_section.dart';
import 'widgets/reports_chart_section.dart';
import 'widgets/reports_export_row.dart';
import 'widgets/reports_list_header.dart';
import 'widgets/reports_list_section.dart';

class ReportsView extends GetView<ReportsController> {
  const ReportsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: CustomScrollView(
         
        slivers: const [
          ReportsHeader(),
          ReportsPeriodTabs(),
          ReportsTypeFilters(),
          ReportsKpiSection(),
          ReportsChartSection(),
          ReportsExportRow(),
          ReportsListHeader(),
          ReportsListSection(),
        ],
      ),
    );
  }
}
