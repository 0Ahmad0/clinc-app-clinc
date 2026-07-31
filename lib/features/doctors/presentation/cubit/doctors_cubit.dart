import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/data/pagination/pagination_state.dart';
import '../../../../core/data/remote/api_response.dart';
import '../../../../core/domain/error_handler/network_exceptions.dart';
import '../../data/models/clinic_doctor_model.dart';
import '../../domain/clinic_doctors_repository.dart';
import 'doctors_state.dart';

class DoctorsCubit extends Cubit<DoctorsState> {
  DoctorsCubit(this._repository)
    : super(DoctorsState(pagination: PaginationState<ClinicDoctorModel>())) {
    scrollController.addListener(_onScroll);
  }

  final ClinicDoctorsRepository _repository;
  final ScrollController scrollController = ScrollController();
  Timer? _debounce;

  Future<void> loadInitial() async {
    await loadSpecializations();
    await _loadPage(page: 1, reset: true);
  }

  Future<void> refresh() => _loadPage(page: 1, reset: true, refreshing: true);

  Future<void> loadMore() async {
    final pagination = state.pagination;
    if (pagination.isBusy || !pagination.hasMore) return;
    await _loadPage(page: pagination.currentPage + 1);
  }

  void search(String query) {
    emit(state.copyWith(query: query));
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 450), () {
      _loadPage(page: 1, reset: true);
    });
  }

  void selectSpecialization(String? specializationId) {
    emit(state.copyWith(selectedSpecializationId: specializationId));
    _loadPage(page: 1, reset: true);
  }

  Future<void> toggleAvailability(ClinicDoctorModel doctor) async {
    final id = doctor.doctorId;
    if (id == null) return;
    if (state.busyDoctorIds.contains(id)) return;
    emit(state.copyWith(busyDoctorIds: {...state.busyDoctorIds, id}));
    final result = await _repository.updateAvailability(
      id: id,
      isActive: !doctor.isActive,
    );
    result.when(
      success: (response) {
        final updatedDoctor =
            response.result ?? doctor.copyWith(isActive: !doctor.isActive);
        _replaceDoctor(updatedDoctor);
        if (state.selectedDoctor?.doctorId == id) {
          emit(state.copyWith(selectedDoctor: updatedDoctor));
        }
        _emitDoctorCounts(failure: null, clearBusyId: id);
      },
      failure: (exception) => emit(
        state.copyWith(failure: exception, busyDoctorIds: _clearBusy(id)),
      ),
    );
  }

  Future<void> loadDoctor(String? id) async {
    if (id == null || id.isEmpty) return;
    emit(state.copyWith(isDetailsLoading: true, failure: null));
    final result = await _repository.getDoctor(id);
    result.when(
      success: (response) => emit(
        state.copyWith(
          selectedDoctor: response.result,
          isDetailsLoading: false,
          failure: null,
        ),
      ),
      failure: (exception) =>
          emit(state.copyWith(isDetailsLoading: false, failure: exception)),
    );
  }

  void updateSelectedDoctor(ClinicDoctorModel doctor) {
    _replaceDoctor(doctor);
    emit(state.copyWith(selectedDoctor: doctor, failure: null));
    _emitDoctorCounts();
  }

  Future<void> loadSpecializations() async {
    emit(state.copyWith(isFiltersLoading: true, failure: null));
    final result = await _repository.getSpecializations();
    result.when(
      success: (response) {
        emit(
          state.copyWith(
            specializations: response.result?.list ?? const [],
            isFiltersLoading: false,
            failure: null,
          ),
        );
      },
      failure: (exception) =>
          emit(state.copyWith(isFiltersLoading: false, failure: exception)),
    );
  }

  Future<void> _loadPage({
    required int page,
    bool reset = false,
    bool refreshing = false,
  }) async {
    final pagination = state.pagination;
    if (pagination.isBusy && !reset) return;
    if (page == 1 && !refreshing) pagination.isInitialLoading.value = true;
    if (refreshing) pagination.isRefreshing.value = true;
    if (page > 1) pagination.isLoadingMore.value = true;
    if (reset) pagination.reset();
    emit(state.copyWith(failure: null));

    final result = await _repository.getDoctors(
      page: page,
      perPage: pagination.perPage,
      search: state.query,
      specializationId: state.selectedSpecializationId,
    );

    result.when(
      success: (response) {
        pagination.setPage(
          data: response.result?.list ?? const [],
          page: page,
          meta: response.meta,
        );
        final items = pagination.items.value;
        final availableCount = items.where((doctor) => doctor.isActive).length;
        final totalCount = response.meta?.total ?? items.length;
        _clearLoading();
        emit(
          state.copyWith(
            totalCount: totalCount,
            availableCount: availableCount,
            unavailableCount: (totalCount - availableCount).clamp(
              0,
              totalCount,
            ),
            busyDoctorIds: const {},
            failure: null,
          ),
        );
      },
      failure: (exception) {
        _clearLoading();
        emit(state.copyWith(failure: exception));
      },
    );
  }

  void _onScroll() {
    final position = scrollController.position;
    if (position.pixels >= position.maxScrollExtent - 240) loadMore();
  }

  void _clearLoading() {
    state.pagination.isInitialLoading.value = false;
    state.pagination.isLoadingMore.value = false;
    state.pagination.isRefreshing.value = false;
  }

  void _replaceDoctor(ClinicDoctorModel doctor) {
    final id = doctor.doctorId;
    final items = [...state.pagination.items.value];
    final index = items.indexWhere((item) => item.doctorId == id);
    if (index == -1) return;
    items[index] = doctor;
    state.pagination.items.assignAll(items);
  }

  void _emitDoctorCounts({NetworkExceptions? failure, String? clearBusyId}) {
    final items = state.pagination.items.value;
    final totalCount = state.totalCount == 0 ? items.length : state.totalCount;
    final availableCount = items.where((doctor) => doctor.isActive).length;
    emit(
      state.copyWith(
        totalCount: totalCount,
        availableCount: availableCount,
        unavailableCount: (totalCount - availableCount).clamp(0, totalCount),
        busyDoctorIds: clearBusyId == null
            ? state.busyDoctorIds
            : _clearBusy(clearBusyId),
        failure: failure,
      ),
    );
  }

  Set<String> _clearBusy(String id) =>
      state.busyDoctorIds.where((doctorId) => doctorId != id).toSet();

  @override
  Future<void> close() {
    _debounce?.cancel();
    scrollController.dispose();
    return super.close();
  }
}
