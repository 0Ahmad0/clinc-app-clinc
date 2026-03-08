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
        id: 'r4',
        type: ReportType.appointments,
        generatedAt: DateTime.now().subtract(const Duration(days: 7)),
        total: 28,
        completed: 18,
        pending: 6,
        cancelled: 4,
        pdfPathOrUrl: '',
      ),
      ReportModel(
        id: 'r5',
        type: ReportType.appointments,
        generatedAt: DateTime.now().subtract(const Duration(days: 14)),
        total: 25,
        completed: 16,
        pending: 5,
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
        id: 'r6',
        type: ReportType.labResults,
        generatedAt: DateTime.now().subtract(const Duration(days: 8)),
        total: 22,
        completed: 17,
        pending: 3,
        cancelled: 2,
        pdfPathOrUrl: '',
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
        totalRevenue: 4800,
      ),
      ReportModel(
        id: 'r7',
        type: ReportType.revenue,
        generatedAt: DateTime.now().subtract(const Duration(days: 10)),
        total: 10,
        completed: 10,
        pending: 0,
        cancelled: 0,
        pdfPathOrUrl: '',
        totalRevenue: 3900,
      ),
      ReportModel(
        id: 'r8',
        type: ReportType.doctors,
        generatedAt: DateTime.now().subtract(const Duration(days: 2)),
        total: 8,
        completed: 6,
        pending: 1,
        cancelled: 1,
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
    return reports.where((r) => r.type == type).toList()
      ..sort((a, b) => b.generatedAt.compareTo(a.generatedAt));
  }

  ReportModel get summary {
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
    return list.first;
  }

  // Weekly trend data — 7 days: Sun..Sat
  List<DayTrend> get weeklyTrend => [
        DayTrend('أح', 4, 3, 1),
        DayTrend('اث', 6, 2, 0),
        DayTrend('ث', 5, 4, 2),
        DayTrend('ار', 8, 1, 1),
        DayTrend('خ', 3, 5, 2),
        DayTrend('ج', 0, 0, 0),
        DayTrend('س', 6, 3, 2),
      ];
}

class DayTrend {
  final String label;
  final int completed;
  final int pending;
  final int cancelled;
  DayTrend(this.label, this.completed, this.pending, this.cancelled);
}
