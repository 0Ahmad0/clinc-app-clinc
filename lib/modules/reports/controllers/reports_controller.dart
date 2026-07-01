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

class ReportsController extends GetxController {
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

  bool get hasMore => reports.length < _total;

  @override
  void onInit() {
    _repository = locator<ReportsRepository>();
    scrollController.addListener(_onScroll);
    getReports(pageKey: 1);
    super.onInit();
  }

  void _onScroll() {
    if (scrollController.position.extentAfter < 240 &&
        hasMore &&
        !isLoadingMore.value) {
      getReports(pageKey: _currentPage + 1);
    }
  }

  Future<void> onRefresh() => getReports(pageKey: 1);

  Future<void> changeType(ReportType type) async {
    if (selectedType.value == type) return;
    selectedType.value = type;
    await getReports(pageKey: 1);
  }

  void changeRange(ReportRange range) => selectedRange.value = range;

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

  void _handleFailure(NetworkExceptions exception, bool firstPage) {
    isLoadingMore.value = false;
    if (firstPage) reportsLoading.value = GeneralLoading.failure;
    ResponseHelper.onNetworkFailure(networkException: exception);
  }

  ReportModel get summary {
    if (reports.isNotEmpty) return reports.first;
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

  @override
  void onClose() {
    scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.onClose();
  }
}
