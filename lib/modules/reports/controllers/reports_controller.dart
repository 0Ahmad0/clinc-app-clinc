import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app/core/configuration/locator.dart';
import '../../../app/core/helper/response_helper.dart';
import '../../../app/core/widgets/widgets_Informative/empty_data_view.dart';
import '../../../app/core/widgets/widgets_Informative/error_view.dart';
import '../../../app/core/widgets/widgets_Informative/loading_data_view.dart';
import '../../../app/data/enums/loading.dart';
import '../../../app/data/report_model.dart';
import '../../../app/domain/error_handler/network_exceptions.dart';
import '../domain/reports_repository.dart';

// ===== نماذج البيانات الإضافية (من الجديد) =====
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

class ReportsController extends GetxController {
  // ===== متغيرات الحالة (من الكود القديم) =====
  final Rx<GeneralLoading> reportsLoading = GeneralLoading.initial.obs;
  final Rx<ReportType> selectedType = ReportType.appointments.obs;
  final Rx<ReportRange> selectedRange = ReportRange.week.obs;
  final RxList<ReportModel> reports = <ReportModel>[].obs;
  final RxBool isGenerating = false.obs;
  final RxBool isLoadingMore = false.obs;
  final ScrollController scrollController = ScrollController();

  late final ReportsRepository _repository;
  int _currentPage = 0;
  int _total = 0;

  // ===== متغيرات إضافية من الجديد =====
  final RxBool isLoading = false.obs; // للتصدير PDF
  final RxBool isCsvLoading = false.obs; // للتصدير CSV
  final RxInt selectedPeriodTab = 0.obs; // 0 = weekly, 1 = monthly, 2 = yearly
  final Rxn<DateTimeRange> customRange = Rxn<DateTimeRange>();

  // ===== Getters =====
  bool get hasMore => reports.length < _total;

  // ===== قائمة التقارير المفلترة (من الجديد) =====
  List<ReportModel> get filteredReports {
    final type = selectedType.value;
    return reports.where((r) => r.type == type).toList()
      ..sort((a, b) => b.generatedAt.compareTo(a.generatedAt));
  }

  // ===== ملخص التقارير (مدمج من القديم والجديد) =====
  ReportModel get summary {
    final list = filteredReports;
    if (list.isEmpty) {
      return ReportModel(
        id: 'empty',
        type: selectedType.value,
        range: selectedRange.value,
        format: ReportFormat.pdf,
        generatedAt: DateTime.now(),
        total: 0,
        completed: 0,
        pending: 0,
        cancelled: 0,
        fileUrl: '',
      );
    }
    return list.first;
  }

  // ===== بيانات الرسم البياني الأسبوعي (من الجديد) =====
  List<DayTrend> get weeklyTrend => [
    DayTrend('أح', 4, 3, 1),
    DayTrend('اث', 6, 2, 0),
    DayTrend('ث', 5, 4, 2),
    DayTrend('ار', 8, 1, 1),
    DayTrend('خ', 3, 5, 2),
    DayTrend('ج', 0, 0, 0),
    DayTrend('س', 6, 3, 2),
  ];

  // ===== بيانات الإيراد الشهري (من الجديد) =====
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

  // ===== إحصائيات إضافية (من الجديد) =====
  int get totalRevenue => monthlyRevenue.fold(0, (sum, m) => sum + m.amount);
  int get totalPatients => 248;
  int get totalLabTests => 136;
  int get totalDoctors => 6;

  // ===== دورة الحياة =====
  @override
  void onInit() {
    _repository = locator<ReportsRepository>();
    scrollController.addListener(_onScroll);
    getReports(pageKey: 1);
    super.onInit();
  }

  @override
  void onClose() {
    scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.onClose();
  }

  // ===== التحكم بالتمرير (من الكود القديم) =====
  void _onScroll() {
    if (scrollController.position.extentAfter < 240 &&
        hasMore &&
        !isLoadingMore.value) {
      getReports(pageKey: _currentPage + 1);
    }
  }

  // ===== التحديث بالسحب (من الكود القديم) =====
  Future<void> onRefresh() => getReports(pageKey: 1);

  // ===== تغيير نوع التقرير (من الكود القديم) =====
  Future<void> changeType(ReportType type) async {
    if (selectedType.value == type) return;
    selectedType.value = type;
    await getReports(pageKey: 1);
  }

  // ===== تغيير المدى الزمني (من الكود القديم) =====
  void changeRange(ReportRange range) => selectedRange.value = range;

  // ===== تغيير تبويب الفترة (من الجديد) =====
  void changePeriodTab(int index) {
    selectedPeriodTab.value = index;
    selectedRange.value = switch (index) {
      1 => ReportRange.month,
      2 => ReportRange.year,
      _ => ReportRange.week,
    };
  }

  // ===== تعيين مدى مخصص (من الجديد) =====
  void setCustomRange(DateTimeRange range) {
    customRange.value = range;
    selectedRange.value = ReportRange.custom;
  }

  // ===== جلب التقارير (من الكود القديم) =====
  Future<void> getReports({required int pageKey}) async {
    final firstPage = pageKey == 1;
    if (firstPage) {
      reportsLoading.value = GeneralLoading.loading;
    } else {
      isLoadingMore.value = true;
    }

    final result = await _repository.getReports(
      page: pageKey,
      type: selectedType.value,
    );

    result.when(
      success: (model) {
        if (model.status != 'success') {
          _handleFailure(
            NetworkExceptions.defaultError(model.message ?? ''),
            firstPage,
          );
          return;
        }
        final items = model.result?.list.whereType<ReportModel>() ?? [];
        if (firstPage) reports.clear();
        reports.addAll(items);
        _currentPage = model.meta?.currentPage ?? pageKey;
        _total = model.meta?.total ?? reports.length;
        reportsLoading.value = reports.isEmpty
            ? GeneralLoading.empty
            : GeneralLoading.success;
        isLoadingMore.value = false;
      },
      failure: (exception) => _handleFailure(exception, firstPage),
    );
  }

  // ===== إنشاء تقرير (من الكود القديم) =====
  Future<void> generateReport(ReportFormat format) async {
    if (isGenerating.value) return;
    isGenerating.value = true;

    final result = await _repository.generateReport(
      type: selectedType.value,
      range: selectedRange.value,
      format: format,
    );

    isGenerating.value = false;

    result.when(
      success: (model) async {
        if (model.status != 'success' || model.result == null) {
          ResponseHelper.onFailure(message: model.message);
          return;
        }
        ResponseHelper.onSuccess(message: model.message);
        await getReports(pageKey: 1);
      },
      failure: (exception) =>
          ResponseHelper.onNetworkFailure(networkException: exception),
    );
  }

  Future<void> downloadReport(ReportModel report) async {
    final result = await _repository.downloadReport(report);
    result.when(
      success: (model) {
        if (model.status != 'success') {
          ResponseHelper.onFailure(message: model.message);
          return;
        }
        ResponseHelper.onSuccess(message: model.message);
      },
      failure: (exception) =>
          ResponseHelper.onNetworkFailure(networkException: exception),
    );
  }

  Future<void> shareReport(ReportModel report) async {
    final result = await _repository.shareReport(report);
    result.when(
      success: (model) {
        if (model.status != 'success') {
          ResponseHelper.onFailure(message: model.message);
          return;
        }
        ResponseHelper.onSuccess(message: model.message);
      },
      failure: (exception) =>
          ResponseHelper.onNetworkFailure(networkException: exception),
    );
  }

  // ===== تصدير PDF (من الجديد مع ربط قديم) =====
  Future<void> generatePdfReport() async {
    if (isLoading.value) return;
    isLoading.value = true;

    // استخدام نفس منطق generateReport مع تنسيق PDF
    final result = await _repository.generateReport(
      type: selectedType.value,
      range: selectedRange.value,
      format: ReportFormat.pdf,
    );

    isLoading.value = false;

    result.when(
      success: (model) async {
        if (model.status != 'success' || model.result == null) {
          ResponseHelper.onFailure(message: model.message);
          return;
        }
        ResponseHelper.onSuccess(message: 'تم إنشاء تقرير PDF بنجاح وحفظه');
        Get.snackbar(
          'تم إنشاء التقرير',
          'تم إنشاء تقرير PDF بنجاح وحفظه',
          backgroundColor: const Color(0xFF009688).withValues(alpha: 0.9),
          colorText: Colors.white,
          icon: const Icon(Icons.picture_as_pdf_rounded, color: Colors.white),
          snackPosition: SnackPosition.TOP,
        );
        await getReports(pageKey: 1);
      },
      failure: (exception) {
        ResponseHelper.onNetworkFailure(networkException: exception);
      },
    );
  }

  // ===== تصدير CSV (من الجديد مع ربط قديم) =====
  Future<void> exportCsvReport() async {
    if (isCsvLoading.value) return;
    isCsvLoading.value = true;

    final result = await _repository.generateReport(
      type: selectedType.value,
      range: selectedRange.value,
      format: ReportFormat.excel, // استخدام CSV/Excel
    );

    isCsvLoading.value = false;

    result.when(
      success: (model) async {
        if (model.status != 'success' || model.result == null) {
          ResponseHelper.onFailure(message: model.message);
          return;
        }
        Get.snackbar(
          'تم تصدير CSV',
          'تم حفظ ملف CSV في مجلد التنزيلات',
          backgroundColor: const Color(0xFF3949AB).withValues(alpha: 0.9),
          colorText: Colors.white,
          icon: const Icon(Icons.table_chart_rounded, color: Colors.white),
          snackPosition: SnackPosition.TOP,
        );
        await getReports(pageKey: 1);
      },
      failure: (exception) {
        ResponseHelper.onNetworkFailure(networkException: exception);
      },
    );
  }

  // ===== معالجة الأخطاء (من الكود القديم) =====
  void _handleFailure(NetworkExceptions exception, bool firstPage) {
    isLoadingMore.value = false;
    if (firstPage) reportsLoading.value = GeneralLoading.failure;
    ResponseHelper.onNetworkFailure(networkException: exception);
  }

  // ===== بناء واجهة التقارير (من الكود القديم) =====
  Widget buildReports(Widget child) {
    return reportsLoading.value.maybeWhen(
      loading: () => const SliverFillRemaining(child: LoadingDataView()),
      failure: () => const SliverFillRemaining(child: ErrorView()),
      empty: () => const SliverFillRemaining(
        child: EmptyDataView(text: 'reports.messages.empty_title'),
      ),
      success: () => child,
      orElse: () => const SliverToBoxAdapter(child: SizedBox.shrink()),
    );
  }
}
