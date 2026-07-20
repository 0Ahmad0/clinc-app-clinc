import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../auth/domain/account_type.dart';
import '../../domain/clinic_specialty.dart';
import '../../domain/lab_section.dart';
import '../../domain/service_kind.dart';
import 'services_state.dart';

class ServicesCubit extends Cubit<ServicesState> {
  ServicesCubit(this.accountType)
    : availableKinds = serviceKindsFor(accountType),
      super(ServicesState(kind: serviceKindsFor(accountType).first));

  final AccountType accountType;

  /// Tabs this facility may see — role-scoped, computed once.
  final List<ServiceKind> availableKinds;

  void selectKind(ServiceKind kind) => emit(state.copyWith(kind: kind));

  void openDetail(LabSection section) =>
      emit(state.copyWith(detail: section));

  void closeDetail() => emit(state.copyWith(clearDetail: true));

  void addSection(LabSection section) {
    if (state.sections.contains(section)) return;
    emit(state.copyWith(sections: [...state.sections, section]));
  }

  void addSpecialty(ClinicSpecialty specialty) {
    if (state.specialties.contains(specialty)) return;
    emit(state.copyWith(specialties: [...state.specialties, specialty]));
  }

  void toggleTest(String code) {
    final current = state.testState(code);
    emit(_withTest(code, current.copyWith(enabled: !current.enabled)));
  }

  void setTestPrice(String code, String price) =>
      emit(_withTest(code, state.testState(code).copyWith(price: price)));

  ServicesState _withTest(String code, LabTestState value) =>
      state.copyWith(tests: {...state.tests, code: value});
}
