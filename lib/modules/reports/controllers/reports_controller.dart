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
      ReportModel(id: 'r1', type: ReportType.appointments, generatedAt: DateTime.now(), total: 32, completed: 20, pending: 8, cancelled: 4, pdfPathOrUrl: ''),
      ReportModel(id: 'r4', type: ReportType.appointments, generatedAt: DateTime.now().subtract(const Duration(days: 7)), total: 28, completed: 18, pending: 6, cancelled: 4, pdfPathOrUrl: ''),
      ReportModel(id: 'r5', type: ReportType.appointments, generatedAt: DateTime.now().subtract(const Duration(days: 14)), total: 25, completed: 16, pending: 5, cancelled: 4, pdfPathOrUrl: ''),
      ReportModel(id: 'r2', type: ReportType.labResults, generatedAt: DateTime.now().subtract(const Duration(days: 1)), total: 18, completed: 15, pending: 2, cancelled: 1, pdfPathOrUrl: 'mock://lab_report.pdf'),
      ReportModel(id: 'r6', type: ReportType.labResults, generatedAt: DateTime.now().subtract(const Duration(days: 8)), total: 22, completed: 17, pending: 3, cancelled: 2, pdfPathOrUrl: ''),
      ReportModel(id: 'r3', type: ReportType.revenue, generatedAt: DateTime.now().subtract(const Duration(days: 3)), total: 12, completed: 12, pending: 0, cancelled: 0, pdfPathOrUrl: '', totalRevenue: 4800),
      ReportModel(id: 'r7', type: ReportType.revenue, generatedAt: DateTime.now().subtract(const Duration(days: 10)), total: 10, completed: 10, pending: 0, cancelled: 0, pdfPathOrUrl: '', totalRevenue: 3900),
      ReportModel(id: 'r8', type: ReportType.doctors, generatedAt: DateTime.now().subtract(const Duration(days: 2)), total: 8, completed: 6, pending: 1, cancelled: 1, pdfPathOrUrl: ''),
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
      return ReportModel(id: 'empty', type: selectedType.value, generatedAt: DateTime.now(), total: 0, completed: 0, pending: 0, cancelled: 0);
    }
    return list.first;
  }

  List<DayTrend> get weeklyTrend => [
    DayTrend('أح', 4, 3, 1),
    DayTrend('اث', 6, 2, 0),
    DayTrend('ث', 5, 4, 2),
    DayTrend('ار', 8, 1, 1),
    DayTrend('خ', 3, 5, 2),
    DayTrend('ج', 0, 0, 0),
    DayTrend('س', 6, 3, 2),
  ];

  List<MonthRevenue> get monthlyRevenue => [
    MonthRevenue('يناير', 3200),
    MonthRevenue('فبراير', 4100),
    MonthRevenue('مارس', 3800),
    MonthRevenue('أبريل', 5200),
    MonthRevenue('مايو', 4600),
    MonthRevenue('يونيو', 6100),
    MonthRevenue('يوليو', 5800),
    MonthRevenue('أغسطس', 7200),
    MonthRevenue('سبتمبر', 6500),
    MonthRevenue('أكتوبر', 8100),
    MonthRevenue('نوفمبر', 7400),
    MonthRevenue('ديسمبر', 9300),
  ];

  int get totalRevenue => monthlyRevenue.fold(0, (sum, m) => sum + m.amount);
  int get totalPatients => 248;
  int get totalLabTests => 136;
  int get totalDoctors => 6;

  Future<void> generatePdfReport() async {
    isLoading.value = true;
    await Future.delayed(const Duration(milliseconds: 1200));
    isLoading.value = false;
    Get.snackbar(
      'تم إنشاء التقرير',
      'تم إنشاء تقرير PDF بنجاح وحفظه',
      backgroundColor: const Color(0xFF009688).withValues(alpha: 0.9),
      colorText: Colors.white,
      icon: const Icon(Icons.picture_as_pdf_rounded, color: Colors.white),
      snackPosition: SnackPosition.TOP,
    );
  }
}

class DayTrend {
  final String label;
  final int completed;
  final int pending;
  final int cancelled;
  DayTrend(this.label, this.completed, this.pending, this.cancelled);
}

class MonthRevenue {
  final String month;
  final int amount;
  MonthRevenue(this.month, this.amount);
}
