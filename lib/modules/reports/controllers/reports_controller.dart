import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../app/data/report_model.dart';

class ReportsController extends GetxController {
  final RxBool isLoading = false.obs;

  final Rx<ReportType> selectedType = ReportType.appointments.obs;
  final Rx<ReportRange> selectedRange = ReportRange.week.obs;

  final Rxn<DateTimeRange> customRange = Rxn<DateTimeRange>();

  final RxList<ReportModel> reports = <ReportModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    _seedMock();
  }

  void _seedMock() {
    reports.value = [
      ReportModel(
        id: 'r1',
        type: ReportType.appointments,
        generatedAt: DateTime.now(),
        total: 32,
        completed: 20,
        pending: 8,
        cancelled: 4,
        pdfPathOrUrl: '',
      ),
      ReportModel(
        id: 'r2',
        type: ReportType.labResults,
        generatedAt: DateTime.now().subtract(const Duration(days: 1)),
        total: 18,
        completed: 15,
        pending: 2,
        cancelled: 1,
        pdfPathOrUrl: 'mock://lab_report.pdf',
      ),
      ReportModel(
        id: 'r3',
        type: ReportType.revenue,
        generatedAt: DateTime.now().subtract(const Duration(days: 3)),
        total: 12,
        completed: 12,
        pending: 0,
        cancelled: 0,
        pdfPathOrUrl: '',
      ),
    ];
  }

  void changeType(ReportType type) => selectedType.value = type;

  void changeRange(ReportRange range) => selectedRange.value = range;

  void setCustomRange(DateTimeRange range) {
    customRange.value = range;
    selectedRange.value = ReportRange.custom;
  }

  List<ReportModel> get filteredReports {
    final type = selectedType.value;
    return reports.where((r) => r.type == type).toList();
  }

  ReportModel get summary {
    // ملخص سريع من نوع التقرير المختار (آخر تقرير)
    final list = filteredReports;
    if (list.isEmpty) {
      return ReportModel(
        id: 'empty',
        type: selectedType.value,
        generatedAt: DateTime.now(),
        total: 0,
        completed: 0,
        pending: 0,
        cancelled: 0,
      );
    }
    // نأخذ أحدث تقرير
    list.sort((a, b) => b.generatedAt.compareTo(a.generatedAt));
    return list.first;
  }
}