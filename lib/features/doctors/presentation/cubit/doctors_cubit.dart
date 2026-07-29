import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/data/pagination/pagination_state.dart';
import '../../../../core/data/remote/api_response.dart';
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
    final result = await _repository.updateAvailability(
      id: id,
      isActive: !doctor.isActive,
    );
    result.when(
      success: (response) {
        if (state.selectedDoctor?.doctorId == id) {
          emit(state.copyWith(selectedDoctor: response.result, failure: null));
        }
        _loadPage(page: 1, reset: true);
      },
      failure: (exception) => emit(state.copyWith(failure: exception)),
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
    if (reset) pagination.reset();
    if (page == 1 && !refreshing) pagination.isInitialLoading.value = true;
    if (refreshing) pagination.isRefreshing.value = true;
    if (page > 1) pagination.isLoadingMore.value = true;
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
        _clearLoading();
        emit(state.copyWith(failure: null));
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

  @override
  Future<void> close() {
    _debounce?.cancel();
    scrollController.dispose();
    return super.close();
  }
}
