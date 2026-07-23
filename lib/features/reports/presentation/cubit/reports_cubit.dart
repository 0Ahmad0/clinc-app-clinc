import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/data/pagination/pagination_state.dart';
import '../../../../core/data/remote/api_response.dart';
import '../../../../core/domain/error_handler/network_exceptions.dart';
import '../../../auth/domain/account_type.dart';
import '../../data/models/clinic_report_model.dart';
import '../../domain/clinic_reports_repository.dart';
import '../../domain/report_period.dart';
import '../../domain/report_type.dart';

part 'reports_cubit.freezed.dart';
part 'reports_state.dart';

class ReportsCubit extends Cubit<ReportsState> {
  ReportsCubit(this.accountType, this._repository)
    : availableTypes = reportTypesFor(accountType),
      super(
        ReportsState(
          type: reportTypesFor(accountType).first,
          pagination: PaginationState<ClinicGeneratedReportModel>(),
        ),
      ) {
    scrollController.addListener(_onScroll);
  }

  final AccountType accountType;
  final ClinicReportsRepository _repository;
  final ScrollController scrollController = ScrollController();

  final List<ReportType> availableTypes;

  Future<void> loadInitial() async {
    await Future.wait([loadSummary(), _loadGenerated(page: 1, reset: true)]);
  }

  Future<void> refresh() => loadInitial();

  Future<void> selectPeriod(ReportPeriod period) async {
    emit(state.copyWith(period: period, exportedReport: null));
    await loadInitial();
  }

  Future<void> selectType(ReportType type) async {
    emit(state.copyWith(type: type, exportedReport: null));
    await loadInitial();
  }

  Future<void> loadSummary() async {
    emit(state.copyWith(isSummaryLoading: true, failure: null));
    final result = await _repository.summary(
      period: state.period,
      type: state.type,
    );
    result.when(
      success: (response) => emit(
        state.copyWith(
          summary: response.result,
          isSummaryLoading: false,
          failure: null,
        ),
      ),
      failure: (exception) =>
          emit(state.copyWith(isSummaryLoading: false, failure: exception)),
    );
  }

  Future<void> loadMore() async {
    final pagination = state.pagination;
    if (pagination.isBusy || !pagination.hasMore) return;
    await _loadGenerated(page: pagination.currentPage + 1);
  }

  Future<void> exportPdf() => _export('pdf');

  Future<void> exportXlsx() => _export('xlsx');

  Future<void> _export(String format) async {
    emit(
      state.copyWith(
        isExportingPdf: format == 'pdf',
        isExportingXlsx: format == 'xlsx',
        exportedReport: null,
        failure: null,
      ),
    );
    final result = await _repository.export(
      period: state.period,
      type: state.type,
      format: format,
    );
    result.when(
      success: (response) {
        emit(
          state.copyWith(
            exportedReport: response.result,
            isExportingPdf: false,
            isExportingXlsx: false,
            failure: null,
          ),
        );
        _loadGenerated(page: 1, reset: true);
      },
      failure: (exception) => emit(
        state.copyWith(
          isExportingPdf: false,
          isExportingXlsx: false,
          failure: exception,
        ),
      ),
    );
  }

  Future<void> _loadGenerated({required int page, bool reset = false}) async {
    final pagination = state.pagination;
    if (pagination.isBusy && !reset) return;
    if (reset) pagination.reset();
    if (page == 1) pagination.isInitialLoading.value = true;
    if (page > 1) pagination.isLoadingMore.value = true;
    emit(state.copyWith(failure: null));

    final result = await _repository.generated(
      page: page,
      perPage: pagination.perPage,
      period: state.period,
      type: state.type,
    );

    result.when(
      success: (response) {
        pagination.setPage(
          data: response.result?.list ?? const [],
          page: page,
          meta: response.meta,
        );
        _clearPaginationLoading();
        emit(state.copyWith(failure: null));
      },
      failure: (exception) {
        _clearPaginationLoading();
        emit(state.copyWith(failure: exception));
      },
    );
  }

  void _clearPaginationLoading() {
    state.pagination.isInitialLoading.value = false;
    state.pagination.isLoadingMore.value = false;
    state.pagination.isRefreshing.value = false;
  }

  void _onScroll() {
    if (!scrollController.hasClients) return;
    final position = scrollController.position;
    if (position.pixels >= position.maxScrollExtent - 240) {
      loadMore();
    }
  }

  @override
  Future<void> close() {
    scrollController.dispose();
    return super.close();
  }
}
