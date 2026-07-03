import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app/core/configuration/locator.dart';
import '../../../app/core/helper/response_helper.dart';
import '../../../app/core/widgets/widgets_Informative/empty_data_view.dart';
import '../../../app/core/widgets/widgets_Informative/error_view.dart';
import '../../../app/core/widgets/widgets_Informative/loading_data_view.dart';
import '../../../app/data/enums/loading.dart';
import '../../../app/domain/error_handler/network_exceptions.dart';
import '../../../app/services/storage_service.dart';
import '../domain/services_repository.dart';
import '../models/clinic_service_model.dart';
import '../views/services_view.dart';

class ServicesController extends GetxController {
  final RxInt currentTab = 0.obs;
  final RxList<MainLabCategoryModel> activeLabCategories =
      <MainLabCategoryModel>[].obs;
  final RxList<MainLabCategoryModel> availableLabCategories =
      <MainLabCategoryModel>[].obs;
  final RxList<SpecialtyModel> activeSpecialties = <SpecialtyModel>[].obs;
  final RxList<SpecialtyModel> availableSpecialties = <SpecialtyModel>[].obs;

  List<MainLabCategoryModel> get unaddedLabCategories => availableLabCategories
      .where((item) => !activeLabCategories.contains(item))
      .toList();
  List<SpecialtyModel> get unaddedSpecialties => availableSpecialties
      .where((item) => !activeSpecialties.contains(item))
      .toList();

  void changeTab(int index) => currentTab.value = index;
  void addLabCategory(MainLabCategoryModel item) =>
      activeLabCategories.add(item);
  void removeLabCategory(MainLabCategoryModel item) =>
      activeLabCategories.remove(item);
  void addSpecialty(SpecialtyModel item) => activeSpecialties.add(item);
  void removeSpecialty(SpecialtyModel item) => activeSpecialties.remove(item);
  void removeSpecialtyService(
    SpecialtyModel specialty,
    SpecialtyServiceModel service,
  ) => specialty.services.remove(service);
  void addSpecialtyService(
    SpecialtyModel specialty, {
    required String name,
    required int price,
  }) => specialty.services.add(
    SpecialtyServiceModel(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      name: name,
      price: price,
    ),
  );

  final Rx<ClinicServiceTab> selectedTab = ClinicServiceTab.medical.obs;
  final Rx<GeneralLoading> labLoading = GeneralLoading.initial.obs;
  final Rx<GeneralLoading> medicalLoading = GeneralLoading.initial.obs;
  final RxList<ClinicServiceSection> labSections = <ClinicServiceSection>[].obs;
  final RxList<ClinicServiceSection> medicalSections =
      <ClinicServiceSection>[].obs;
  final RxSet<String> loadingSectionIds = <String>{}.obs;
  final RxSet<String> loadingTestIds = <String>{}.obs;
  final RxBool isLoadingMore = false.obs;
  final ScrollController scrollController = ScrollController();
  late final ServicesRepository _repository;
  final Map<ClinicServiceTab, int> _currentPages = {
    ClinicServiceTab.lab: 0,
    ClinicServiceTab.medical: 0,
  };
  final Map<ClinicServiceTab, int> _totals = {
    ClinicServiceTab.lab: 0,
    ClinicServiceTab.medical: 0,
  };

  List<ClinicServiceTab> get allowedTabs {
    final type = StorageService.instance.getCachedClinic()?['type'];
    if (type == 'lab') return const [ClinicServiceTab.lab];
    if (type == 'clinic') return const [ClinicServiceTab.medical];
    return ClinicServiceTab.values;
  }

  List<ClinicServiceSection> sectionsFor(ClinicServiceTab tab) {
    return tab == ClinicServiceTab.lab ? labSections : medicalSections;
  }

  Rx<GeneralLoading> loadingFor(ClinicServiceTab tab) {
    return tab == ClinicServiceTab.lab ? labLoading : medicalLoading;
  }

  bool hasMore(ClinicServiceTab tab) {
    return sectionsFor(tab).length < (_totals[tab] ?? 0);
  }

  @override
  void onInit() {
    _repository = locator<ServicesRepository>();
    selectedTab.value = allowedTabs.first;
    scrollController.addListener(_onScroll);
    getSections(selectedTab.value, pageKey: 1);
    super.onInit();
  }

  void _onScroll() {
    final tab = selectedTab.value;
    if (scrollController.position.extentAfter < 240 &&
        hasMore(tab) &&
        !isLoadingMore.value) {
      getSections(tab, pageKey: (_currentPages[tab] ?? 0) + 1);
    }
  }

  Future<void> selectTab(ClinicServiceTab tab) async {
    if (selectedTab.value == tab) return;
    selectedTab.value = tab;
    if (sectionsFor(tab).isEmpty) await getSections(tab, pageKey: 1);
  }

  Future<void> onRefresh() => getSections(selectedTab.value, pageKey: 1);

  Future<void> getSections(ClinicServiceTab tab, {required int pageKey}) async {
    final firstPage = pageKey == 1;
    if (firstPage) {
      loadingFor(tab).value = GeneralLoading.loading;
    } else {
      isLoadingMore.value = true;
    }

    final result = await _repository.getSections(type: tab, page: pageKey);
    result.when(
      success: (model) {
        if (model.status != 'success') {
          _handleFailure(
            tab,
            NetworkExceptions.defaultError(model.message ?? ''),
            firstPage,
          );
          return;
        }
        final items =
            model.result?.list.whereType<ClinicServiceSection>() ?? [];
        final target = sectionsFor(tab);
        if (firstPage) target.clear();
        target.addAll(items);
        _currentPages[tab] = model.meta?.currentPage ?? pageKey;
        _totals[tab] = model.meta?.total ?? target.length;
        loadingFor(tab).value = target.isEmpty
            ? GeneralLoading.empty
            : GeneralLoading.success;
        isLoadingMore.value = false;
      },
      failure: (exception) => _handleFailure(tab, exception, firstPage),
    );
  }

  void _handleFailure(
    ClinicServiceTab tab,
    NetworkExceptions exception,
    bool firstPage,
  ) {
    isLoadingMore.value = false;
    if (firstPage) loadingFor(tab).value = GeneralLoading.failure;
    ResponseHelper.onNetworkFailure(networkException: exception);
  }

  Future<void> addSection(ClinicServiceSection section) async {
    final tab = selectedTab.value;
    if (loadingSectionIds.contains(section.id)) return;
    loadingSectionIds.add(section.id);
    final result = await _repository.addSection(
      type: tab,
      sectionId: section.id,
    );
    loadingSectionIds.remove(section.id);
    result.when(
      success: (model) {
        if (model.status != 'success' || model.result == null) {
          ResponseHelper.onFailure(message: model.message);
          return;
        }
        _replaceSection(tab, model.result!);
        ResponseHelper.onSuccess(message: model.message);
      },
      failure: (exception) =>
          ResponseHelper.onNetworkFailure(networkException: exception),
    );
  }

  Future<void> updateLabTest({
    required ClinicServiceSection section,
    required LabTestOption test,
    required bool isEnabled,
    required num price,
  }) async {
    if (isEnabled && price <= 0) {
      ResponseHelper.onFailure(
        message: 'services_page.messages.price_required'.tr,
      );
      return;
    }
    if (loadingTestIds.contains(test.id)) return;
    loadingTestIds.add(test.id);
    final result = await _repository.updateLabTest(
      sectionId: section.id,
      testId: test.id,
      isEnabled: isEnabled,
      price: price,
    );
    loadingTestIds.remove(test.id);
    result.when(
      success: (model) {
        if (model.status != 'success' || model.result == null) {
          ResponseHelper.onFailure(message: model.message);
          return;
        }
        _replaceSection(ClinicServiceTab.lab, model.result!);
        ResponseHelper.onSuccess(message: model.message);
      },
      failure: (exception) =>
          ResponseHelper.onNetworkFailure(networkException: exception),
    );
  }

  void _replaceSection(ClinicServiceTab tab, ClinicServiceSection updated) {
    final target = sectionsFor(tab);
    final index = target.indexWhere((section) => section.id == updated.id);
    if (index != -1) target[index] = updated;
  }

  Widget buildSections(ClinicServiceTab tab, Widget child) {
    return loadingFor(tab).value.maybeWhen(
      loading: () => const LoadingDataBaseView(),
      failure: () => const ErrorView(),
      empty: () => const EmptyDataView(text: 'services_page.messages.empty'),
      success: () => child,
      orElse: () => const SizedBox.shrink(),
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
