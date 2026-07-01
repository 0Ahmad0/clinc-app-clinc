import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app/core/configuration/locator.dart';
import '../../../app/data/appointment_model.dart';
import '../../../app/data/enums/loading.dart';
import '../../../app/domain/error_handler/network_exceptions.dart';
import '../../../app/extension/appointment_type_extensions.dart';
import '../domain/appointments_repository.dart';

class AppointmentsController extends GetxController {
  final Rx<GeneralLoading> loading = GeneralLoading.initial.obs;
  final RxList<AppointmentModel> items = <AppointmentModel>[].obs;
  final Rx<AppointmentStatus?> filter = Rx<AppointmentStatus?>(null);
  final RxBool isLoadingMore = false.obs;
  final RxString errorMessage = ''.obs;
  final TextEditingController searchController = TextEditingController();
  final ScrollController scrollController = ScrollController();
  late final AppointmentsRepository _repository;
  Timer? _searchDebounce;
  int _currentPage = 0;
  int _total = 0;

  bool get hasMore => items.length < _total;
  List<AppointmentModel> get filtered => items;

  @override
  void onInit() {
    _repository = locator<AppointmentsRepository>();
    scrollController.addListener(_onScroll);
    getAppointments(page: 1);
    super.onInit();
  }

  void _onScroll() {
    if (scrollController.position.extentAfter < 240 &&
        hasMore &&
        !isLoadingMore.value) {
      getAppointments(page: _currentPage + 1);
    }
  }

  Future<void> getAppointments({required int page}) async {
    final isFirstPage = page == 1;
    if (isFirstPage) {
      loading.value = GeneralLoading.loading;
      errorMessage.value = '';
    } else {
      isLoadingMore.value = true;
    }
    final result = await _repository.getAppointments(
      page: page,
      search: searchController.text,
      status: filter.value,
    );
    result.when(
      success: (model) {
        if (model.status != 'success') {
          _handleFailure(model.message ?? 'Unable to load appointments');
          return;
        }
        if (isFirstPage) items.clear();
        items.addAll(model.result?.list ?? const []);
        _currentPage = model.meta?.currentPage ?? page;
        _total = model.meta?.total ?? items.length;
        isLoadingMore.value = false;
        loading.value = items.isEmpty
            ? GeneralLoading.empty
            : GeneralLoading.success;
      },
      failure: (exception) {
        _handleFailure(NetworkExceptions.getErrorMessage(exception));
      },
    );
  }

  void _handleFailure(String message) {
    isLoadingMore.value = false;
    errorMessage.value = message;
    if (items.isEmpty) loading.value = GeneralLoading.failure;
  }

  Future<void> refreshAppointments() => getAppointments(page: 1);

  void search(String value) {
    _searchDebounce?.cancel();
    _searchDebounce = Timer(
      const Duration(milliseconds: 350),
      () => getAppointments(page: 1),
    );
  }

  void setFilter(AppointmentStatus? status) {
    if (filter.value == status) return;
    filter.value = status;
    getAppointments(page: 1);
  }

  AppointmentModel? findById(String id) {
    final index = items.indexWhere((item) => item.id == id);
    return index < 0 ? null : items[index];
  }

  void updateItem(AppointmentModel updated) {
    final index = items.indexWhere((item) => item.id == updated.id);
    if (index < 0) return;
    items[index] = updated;
  }

  @override
  void onClose() {
    _searchDebounce?.cancel();
    searchController.dispose();
    scrollController.dispose();
    super.onClose();
  }
}
