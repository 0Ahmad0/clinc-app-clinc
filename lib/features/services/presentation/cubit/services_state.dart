part of 'services_cubit.dart';

@freezed
abstract class ServicesState with _$ServicesState {
  const ServicesState._();

  const factory ServicesState({
    required ServiceKind kind,
    ClinicLabSectionModel? detail,
    @Default([]) List<ClinicLabSectionModel> labSections,
    @Default({}) Set<int> selectedLabSectionIds,
    NetworkExceptions? failure,
    @Default(false) bool isLoading,
    @Default(false) bool isLabSectionsLoading,
    @Default(false) bool isSpecializationFiltersLoading,
    @Default(false) bool isMutating,
    @Default('') String labSearch,
    @Default('') String specializationSearch,
    @Default({}) Map<int, String> labTestPriceDrafts,
    @Default({}) Map<int, int> labSectionEnabledCounts,
    @Default({}) Set<int> busyLabTestIds,
    @Default({}) Set<int> busySpecializationIds,
    @Default(0) int version,
    required PaginationState<ClinicAvailableLabTestModel> availableLabTests,
    required PaginationState<ClinicEnabledLabTestModel> enabledLabTests,
    required PaginationState<ClinicAvailableSpecializationModel>
    availableSpecializations,
    required PaginationState<ClinicEnabledSpecializationModel>
    enabledSpecializations,
  }) = _ServicesState;

  bool get inDetail => detail != null;

  bool get isCurrentFiltersLoading => kind == ServiceKind.lab
      ? isLabSectionsLoading
      : isSpecializationFiltersLoading;

  List<ClinicLabSectionModel> get visibleLabSections {
    if (selectedLabSectionIds.isEmpty) return const [];
    return labSections
        .where((section) => selectedLabSectionIds.contains(section.sectionId))
        .toList(growable: false);
  }

  List<ClinicEnabledSpecializationModel> get activeSpecializations =>
      enabledSpecializations.items.value
          .where((item) => item.isActive)
          .toList(growable: false);

  int get activeCount =>
      enabledLabTests.items.value.where((test) => test.isActive).length +
      activeSpecializations.length;

  LabTestState testState(int? labTestId) {
    if (labTestId == null) return const LabTestState();
    final draft = labTestPriceDrafts[labTestId];
    for (final item in enabledLabTests.items.value) {
      if (item.labTestId == labTestId) {
        return LabTestState(
          enabled: item.isActive,
          price: draft ?? _formatPrice(item.price ?? item.defaultPrice),
        );
      }
    }
    ClinicAvailableLabTestModel? available;
    for (final item in availableLabTests.items.value) {
      if (item.labTestId == labTestId) {
        available = item;
        break;
      }
    }
    return LabTestState(price: draft ?? _formatPrice(available?.defaultPrice));
  }

  bool isSpecializationEnabled(int? specializationId) {
    if (specializationId == null) return false;
    return enabledSpecializations.items.value.any(
      (item) => item.specializationId == specializationId && item.isActive,
    );
  }

  bool isLabSectionAdded(int? sectionId) {
    if (sectionId == null) return false;
    return selectedLabSectionIds.contains(sectionId);
  }

  int labSectionEnabledCount(int? sectionId) {
    if (sectionId == null) return 0;
    return labSectionEnabledCounts[sectionId] ??
        enabledLabTests.items.value
            .where((item) => item.sectionId == sectionId)
            .length;
  }

  String _formatPrice(num? value) {
    if (value == null) return '';
    if (value % 1 == 0) return value.toInt().toString();
    return value.toString();
  }
}

class LabTestState {
  const LabTestState({this.enabled = false, this.price = ''});

  final bool enabled;
  final String price;
}
