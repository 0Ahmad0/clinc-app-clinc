import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/data/pagination/pagination_state.dart';
import '../../../../core/data/remote/api_response.dart';
import '../../data/models/clinic_appointment_model.dart';
import '../../domain/appointment_tab.dart';
import '../../domain/clinic_appointments_repository.dart';
import 'appointments_state.dart';

class AppointmentsCubit extends Cubit<AppointmentsState> {
  AppointmentsCubit(this._repository)
    : super(
        AppointmentsState(
          pagination: PaginationState<ClinicAppointmentModel>(),
        ),
      ) {
    scrollController.addListener(_onScroll);
  }

  final ClinicAppointmentsRepository _repository;
  final ScrollController scrollController = ScrollController();

  Future<void> loadInitial() => _loadPage(page: 1, reset: true);

  Future<void> refresh() => _loadPage(page: 1, reset: true, refreshing: true);

  Future<void> loadMore() async {
    final pagination = state.pagination;
    if (pagination.isBusy || !pagination.hasMore) return;
    await _loadPage(page: pagination.currentPage + 1);
  }

  void selectTab(AppointmentTab tab) {
    emit(state.copyWith(tab: tab));
    _loadPage(page: 1, reset: true);
  }

  Future<void> open(String id) async {
    emit(state.copyWith(selectedId: id));
    final result = await _repository.getAppointment(id);
    result.when(
      success: (response) =>
          emit(state.copyWith(selected: response.result, failure: null)),
      failure: (exception) => emit(state.copyWith(failure: exception)),
    );
  }

  void closeDetail() => emit(state.copyWith(selectedId: null, selected: null));

  Future<void> accept(String id) => _action(() => _repository.accept(id));

  Future<void> reject(String id, String reason) =>
      _action(() => _repository.reject(id: id, reason: reason));

  Future<void> finish(String id, {String? notes}) =>
      _action(() => _repository.finish(id: id, notes: notes));

  Future<void> uploadResult(String id, String filePath) =>
      _action(() => _repository.uploadResult(id: id, filePath: filePath));

  Future<void> _action(Future<ApiResponse<dynamic>> Function() action) async {
    final result = await action();
    result.when(
      success: (_) => _loadPage(page: 1, reset: true),
      failure: (exception) => emit(state.copyWith(failure: exception)),
    );
  }

  Future<void> _loadPage({
    required int page,
    bool reset = false,
    bool refreshing = false,
  }) async {
    final pagination = state.pagination;
    if (pagination.isBusy && !reset) return;
    if (reset) pagination.reset();
    if (page == 1 && !refreshing) pagination.isInitialLoading.value = true;
    if (refreshing) pagination.isRefreshing.value = true;
    if (page > 1) pagination.isLoadingMore.value = true;
    emit(state.copyWith(failure: null));

    final result = await _repository.getAppointments(
      page: page,
      perPage: pagination.perPage,
      status: _statusFilter(state.tab),
    );

    result.when(
      success: (response) {
        pagination.setPage(
          data: response.result?.list ?? const [],
          page: page,
          meta: response.meta,
        );
        _clearLoading();
        emit(state.copyWith(failure: null));
      },
      failure: (exception) {
        _clearLoading();
        emit(state.copyWith(failure: exception));
      },
    );
  }

  String? _statusFilter(AppointmentTab tab) => switch (tab) {
    AppointmentTab.all => null,
    AppointmentTab.pending => 'pending',
    AppointmentTab.confirmed => 'accepted',
    AppointmentTab.done => 'completed',
    AppointmentTab.rejected => 'rejected',
  };

  void _clearLoading() {
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
