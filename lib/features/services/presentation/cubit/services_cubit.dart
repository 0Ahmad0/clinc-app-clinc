import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/data/pagination/pagination_state.dart';
import '../../../../core/data/remote/api_response.dart';
import '../../../../core/domain/error_handler/network_exceptions.dart';
import '../../../auth/domain/account_type.dart';
import '../../data/models/clinic_service_model.dart';
import '../../domain/clinic_services_repository.dart';
import '../../domain/service_kind.dart';

part 'services_cubit.freezed.dart';
part 'services_state.dart';

class ServicesCubit extends Cubit<ServicesState> {
  ServicesCubit(this.accountType, this._repository)
    : availableKinds = serviceKindsFor(accountType),
      super(
        ServicesState(
          kind: serviceKindsFor(accountType).first,
          availableLabTests: PaginationState<ClinicAvailableLabTestModel>(
            perPage: 50,
          ),
          enabledLabTests: PaginationState<ClinicEnabledLabTestModel>(
            perPage: 50,
          ),
          availableSpecializations:
              PaginationState<ClinicAvailableSpecializationModel>(perPage: 50),
          enabledSpecializations:
              PaginationState<ClinicEnabledSpecializationModel>(perPage: 50),
        ),
      );

  final AccountType accountType;
  final ClinicServicesRepository _repository;
  final List<ServiceKind> availableKinds;
  final Map<int, Timer> _priceDebounceTimers = {};
  Timer? _searchDebounceTimer;

  bool get _canUseLab =>
      accountType == AccountType.lab || accountType == AccountType.both;

  bool get _canUseSpecialty =>
      accountType == AccountType.clinic || accountType == AccountType.both;

  Future<void> loadInitial() async {
    emit(state.copyWith(isLoading: true, failure: null));
    final tasks = <Future<void>>[];
    if (_canUseLab) {
      tasks.addAll([_loadLabSections(), _loadEnabledLabTests(page: 1)]);
    }
    if (_canUseSpecialty) {
      tasks.addAll([
        _loadAvailableSpecializations(page: 1),
        _loadEnabledSpecializations(page: 1),
      ]);
    }
    await Future.wait(tasks);
    emit(state.copyWith(isLoading: false));
  }

  Future<void> refresh() => loadInitial();

  Future<void> selectKind(ServiceKind kind) async {
    emit(state.copyWith(kind: kind, detail: null, failure: null));
    if (kind == ServiceKind.specialty) {
      if (state.availableSpecializations.items.isEmpty) {
        await _loadAvailableSpecializations(page: 1);
      }
      if (state.enabledSpecializations.items.isEmpty) {
        await _loadEnabledSpecializations(page: 1);
      }
      return;
    }

    if (kind == ServiceKind.lab) {
      if (state.labSections.isEmpty) {
        await _loadLabSections();
      }
      if (state.enabledLabTests.items.isEmpty) {
        await _loadEnabledLabTests(page: 1);
      }
    }
  }

  Future<void> openDetail(ClinicLabSectionModel section) async {
    emit(state.copyWith(detail: section, failure: null));
    await Future.wait([
      _loadAvailableLabTests(page: 1, section: section, reset: true),
      _loadEnabledLabTests(page: 1, section: section, reset: true),
    ]);
  }

  void closeDetail() => emit(state.copyWith(detail: null));

  Future<void> addSection(ClinicLabSectionModel section) async {
    final sectionId = section.sectionId;
    if (sectionId != null && !state.selectedLabSectionIds.contains(sectionId)) {
      emit(
        state.copyWith(
          selectedLabSectionIds: {...state.selectedLabSectionIds, sectionId},
        ),
      );
    }
    await openDetail(section);
  }

  void removeSection(ClinicLabSectionModel section) {
    final sectionId = section.sectionId;
    if (sectionId == null) return;
    if (!state.selectedLabSectionIds.contains(sectionId)) return;
    final updated = {...state.selectedLabSectionIds}..remove(sectionId);
    final shouldCloseDetail = state.detail?.sectionId == sectionId;
    emit(
      state.copyWith(
        selectedLabSectionIds: updated,
        detail: shouldCloseDetail ? null : state.detail,
      ),
    );
  }

  void searchLabTests(String value) {
    emit(state.copyWith(labSearch: value));
    _searchDebounceTimer?.cancel();
    _searchDebounceTimer = Timer(const Duration(milliseconds: 450), () {
      final detail = state.detail;
      if (detail != null) {
        _loadAvailableLabTests(page: 1, section: detail, reset: true);
      }
    });
  }

  void searchSpecializations(String value) {
    emit(state.copyWith(specializationSearch: value));
    _searchDebounceTimer?.cancel();
    _searchDebounceTimer = Timer(
      const Duration(milliseconds: 450),
      () => _loadAvailableSpecializations(page: 1, reset: true),
    );
  }

  Future<void> loadMoreLabTests() async {
    final pagination = state.availableLabTests;
    if (pagination.isBusy || !pagination.hasMore || state.detail == null) {
      return;
    }
    await _loadAvailableLabTests(
      page: pagination.currentPage + 1,
      section: state.detail,
    );
  }

  Future<void> loadMoreSpecializations() async {
    final pagination = state.availableSpecializations;
    if (pagination.isBusy || !pagination.hasMore) return;
    await _loadAvailableSpecializations(page: pagination.currentPage + 1);
  }

  Future<void> addSpecialty(
    ClinicAvailableSpecializationModel specialty,
  ) async {
    final id = specialty.specializationId;
    if (id == null || state.isSpecializationEnabled(id)) return;
    _setBusySpecialization(id, true);
    final result = await _repository.enableSpecialization(
      specializationId: id,
      isActive: true,
    );
    result.when(
      success: (response) {
        final item = response.result;
        if (item != null) _upsertSpecialization(item);
        _emitVersioned();
      },
      failure: (exception) => _emitVersioned(failure: exception),
    );
    _setBusySpecialization(id, false);
  }

  Future<void> removeSpecialty(
    ClinicAvailableSpecializationModel specialty,
  ) async {
    final id = specialty.specializationId;
    if (id == null || state.busySpecializationIds.contains(id)) return;
    if (!state.isSpecializationEnabled(id)) return;
    _setBusySpecialization(id, true);
    final result = await _repository.removeSpecialization(specializationId: id);
    result.when(
      success: (_) {
        state.enabledSpecializations.items.assignAll(
          state.enabledSpecializations.items.value.where(
            (item) => item.specializationId != id,
          ),
        );
        _emitVersioned();
      },
      failure: (exception) => _emitVersioned(failure: exception),
    );
    _setBusySpecialization(id, false);
  }

  Future<void> toggleTest(int? labTestId) async {
    if (labTestId == null || state.busyLabTestIds.contains(labTestId)) return;
    final current = state.testState(labTestId);
    _setBusyLabTest(labTestId, true);

    if (current.enabled) {
      final result = await _repository.removeLabTest(labTestId: labTestId);
      result.when(
        success: (_) {
          final items = state.enabledLabTests.items.value
              .where((item) => item.labTestId != labTestId)
              .toList(growable: false);
          state.enabledLabTests.items.assignAll(items);
          _syncLabSectionEnabledCounts(
            items: items,
            sectionId: state.detail?.sectionId,
          );
          _emitVersioned();
        },
        failure: (exception) => _emitVersioned(failure: exception),
      );
    } else {
      await _saveLabTest(labTestId: labTestId, isActive: true);
    }

    _setBusyLabTest(labTestId, false);
  }

  void setTestPrice(int? labTestId, String price) {
    if (labTestId == null) return;
    emit(
      state.copyWith(
        labTestPriceDrafts: {...state.labTestPriceDrafts, labTestId: price},
      ),
    );
    if (!state.testState(labTestId).enabled) return;
    _priceDebounceTimers[labTestId]?.cancel();
    _priceDebounceTimers[labTestId] = Timer(
      const Duration(milliseconds: 450),
      () => _saveLabTest(labTestId: labTestId, isActive: true),
    );
  }

  Future<void> _loadLabSections() async {
    final result = await _repository.labSections();
    result.when(
      success: (response) => emit(
        state.copyWith(
          labSections: response.result?.list ?? const [],
          failure: null,
        ),
      ),
      failure: (exception) => _emitVersioned(failure: exception),
    );
  }

  Future<void> _loadAvailableLabTests({
    required int page,
    ClinicLabSectionModel? section,
    bool reset = false,
  }) async {
    final pagination = state.availableLabTests;
    if (pagination.isBusy && !reset) return;
    if (reset) pagination.reset();
    pagination.isInitialLoading.value = page == 1;
    pagination.isLoadingMore.value = page > 1;

    final result = await _repository.labTests(
      page: page,
      perPage: pagination.perPage,
      search: state.labSearch,
      sectionId: section?.sectionId,
      sectionSlug: section?.slug,
    );
    result.when(
      success: (response) {
        final items = response.result?.list ?? const [];
        pagination.setPage(data: items, page: page, meta: response.meta);
        _syncSelectedLabSectionsFromEnabledTests();
        _clearPaginationLoading(pagination);
        _emitVersioned();
      },
      failure: (exception) {
        _clearPaginationLoading(pagination);
        _emitVersioned(failure: exception);
      },
    );
  }

  Future<void> _loadEnabledLabTests({
    required int page,
    ClinicLabSectionModel? section,
    bool reset = false,
  }) async {
    final pagination = state.enabledLabTests;
    if (pagination.isBusy && !reset) return;
    if (reset) pagination.reset();
    pagination.isInitialLoading.value = page == 1;
    pagination.isLoadingMore.value = page > 1;

    final result = await _repository.enabledLabTests(
      page: page,
      perPage: pagination.perPage,
      search: state.labSearch,
      sectionId: section?.sectionId,
    );
    result.when(
      success: (response) {
        final items = response.result?.list ?? const [];
        pagination.setPage(data: items, page: page, meta: response.meta);
        _syncLabSectionEnabledCounts(
          items: items,
          sectionId: section?.sectionId,
          total: response.meta?.total,
        );
        _syncSelectedLabSectionsFromEnabledTests();
        _clearPaginationLoading(pagination);
        _emitVersioned();
      },
      failure: (exception) {
        _clearPaginationLoading(pagination);
        _emitVersioned(failure: exception);
      },
    );
  }

  Future<void> _loadAvailableSpecializations({
    required int page,
    bool reset = true,
  }) async {
    final pagination = state.availableSpecializations;
    if (pagination.isBusy && !reset) return;
    if (reset) pagination.reset();
    pagination.isInitialLoading.value = page == 1;
    pagination.isLoadingMore.value = page > 1;

    final result = await _repository.specializations(
      page: page,
      perPage: pagination.perPage,
      search: state.specializationSearch,
    );
    result.when(
      success: (response) {
        pagination.setPage(
          data: response.result?.list ?? const [],
          page: page,
          meta: response.meta,
        );
        _clearPaginationLoading(pagination);
        _emitVersioned();
      },
      failure: (exception) {
        _clearPaginationLoading(pagination);
        _emitVersioned(failure: exception);
      },
    );
  }

  Future<void> _loadEnabledSpecializations({
    required int page,
    bool reset = true,
  }) async {
    final pagination = state.enabledSpecializations;
    if (pagination.isBusy && !reset) return;
    if (reset) pagination.reset();
    pagination.isInitialLoading.value = page == 1;
    pagination.isLoadingMore.value = page > 1;

    final result = await _repository.enabledSpecializations(
      page: page,
      perPage: pagination.perPage,
      search: state.specializationSearch,
    );
    result.when(
      success: (response) {
        pagination.setPage(
          data: response.result?.list ?? const [],
          page: page,
          meta: response.meta,
        );
        _clearPaginationLoading(pagination);
        _emitVersioned();
      },
      failure: (exception) {
        _clearPaginationLoading(pagination);
        _emitVersioned(failure: exception);
      },
    );
  }

  Future<void> _saveLabTest({
    required int labTestId,
    required bool isActive,
  }) async {
    final price = num.tryParse(state.testState(labTestId).price);
    if (price == null) return;

    final exists = state.enabledLabTests.items.value.any(
      (item) => item.labTestId == labTestId,
    );
    final result = exists
        ? await _repository.updateLabTest(
            labTestId: labTestId,
            price: price,
            isActive: isActive,
          )
        : await _repository.enableLabTest(
            labTestId: labTestId,
            price: price,
            isActive: isActive,
          );

    result.when(
      success: (response) {
        final item = response.result;
        if (item != null) _upsertLabTest(item);
        _emitVersioned();
      },
      failure: (exception) => _emitVersioned(failure: exception),
    );
  }

  void _upsertLabTest(ClinicEnabledLabTestModel item) {
    final items = [...state.enabledLabTests.items.value];
    final index = items.indexWhere((test) => test.labTestId == item.labTestId);
    if (index == -1) {
      items.add(item);
    } else {
      items[index] = item;
    }
    state.enabledLabTests.items.assignAll(items);
    _syncLabSectionEnabledCounts(items: items, sectionId: item.sectionId);
    final sectionId = item.sectionId;
    if (sectionId != null && !state.selectedLabSectionIds.contains(sectionId)) {
      emit(
        state.copyWith(
          selectedLabSectionIds: {...state.selectedLabSectionIds, sectionId},
        ),
      );
    }
  }

  void _upsertSpecialization(ClinicEnabledSpecializationModel item) {
    final items = [...state.enabledSpecializations.items.value];
    final index = items.indexWhere(
      (specialty) => specialty.specializationId == item.specializationId,
    );
    if (index == -1) {
      items.add(item);
    } else {
      items[index] = item;
    }
    state.enabledSpecializations.items.assignAll(items);
  }

  void _syncLabSectionEnabledCounts({
    required List<ClinicEnabledLabTestModel> items,
    int? sectionId,
    int? total,
  }) {
    final counts = {...state.labSectionEnabledCounts};
    if (sectionId != null) {
      counts[sectionId] = total ?? items.where((item) => item.isActive).length;
    } else {
      counts
        ..clear()
        ..addAll(_groupEnabledLabCounts(items));
    }
    emit(state.copyWith(labSectionEnabledCounts: counts));
  }

  Map<int, int> _groupEnabledLabCounts(List<ClinicEnabledLabTestModel> items) {
    final counts = <int, int>{};
    for (final item in items) {
      final sectionId = item.sectionId;
      if (sectionId == null || !item.isActive) continue;
      counts[sectionId] = (counts[sectionId] ?? 0) + 1;
    }
    return counts;
  }

  void _emitVersioned({NetworkExceptions? failure}) {
    emit(state.copyWith(version: state.version + 1, failure: failure));
  }

  void _setBusyLabTest(int id, bool busy) {
    final ids = {...state.busyLabTestIds};
    busy ? ids.add(id) : ids.remove(id);
    emit(state.copyWith(busyLabTestIds: ids));
  }

  void _setBusySpecialization(int id, bool busy) {
    final ids = {...state.busySpecializationIds};
    busy ? ids.add(id) : ids.remove(id);
    emit(state.copyWith(busySpecializationIds: ids));
  }

  void _clearPaginationLoading<T>(PaginationState<T> pagination) {
    pagination.isInitialLoading.value = false;
    pagination.isLoadingMore.value = false;
    pagination.isRefreshing.value = false;
  }

  void _syncSelectedLabSectionsFromEnabledTests() {
    final enabledSectionIds = state.enabledLabTests.items.value
        .map((item) => item.sectionId)
        .whereType<int>()
        .toSet();
    if (enabledSectionIds.isEmpty) return;
    final merged = {...state.selectedLabSectionIds, ...enabledSectionIds};
    if (merged.length == state.selectedLabSectionIds.length) return;
    emit(state.copyWith(selectedLabSectionIds: merged));
  }

  @override
  Future<void> close() {
    for (final timer in _priceDebounceTimers.values) {
      timer.cancel();
    }
    _searchDebounceTimer?.cancel();
    return super.close();
  }
}
