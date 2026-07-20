import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/appointment.dart';
import '../../domain/appointment_status.dart';
import '../../domain/appointment_tab.dart';
import 'appointments_state.dart';

class AppointmentsCubit extends Cubit<AppointmentsState> {
  AppointmentsCubit() : super(const AppointmentsState());

  void selectTab(AppointmentTab tab) => emit(state.copyWith(tab: tab));

  void open(int id) => emit(state.copyWith(selectedId: id));

  void closeDetail() => emit(state.copyWith(selectedId: null));

  void accept(int id) => _setStatus(id, AppointmentStatus.confirmed);

  void finish(int id) => _setStatus(id, AppointmentStatus.done);

  void reject(int id, String reason) {
    emit(
      state.copyWith(
        statusOverrides: {...state.statusOverrides, id: AppointmentStatus.rejected},
        reasons: {...state.reasons, id: reason},
      ),
    );
  }

  void _setStatus(int id, AppointmentStatus status) => emit(
    state.copyWith(statusOverrides: {...state.statusOverrides, id: status}),
  );

  /// Live status: an override wins over the seeded one.
  AppointmentStatus statusOf(Appointment appointment) =>
      state.statusOverrides[appointment.id] ?? appointment.status;

  String? reasonOf(Appointment appointment) => state.reasons[appointment.id];

  int countOf(List<Appointment> all, AppointmentStatus status) =>
      all.where((a) => statusOf(a) == status).length;

  /// Appointments matching the selected tab, using live status.
  List<Appointment> visible(List<Appointment> all) => all
      .where(
        (a) =>
            state.tab == AppointmentTab.all ||
            statusOf(a).name == state.tab.name,
      )
      .toList(growable: false);

  Appointment? selected(List<Appointment> all) {
    for (final a in all) {
      if (a.id == state.selectedId) return a;
    }
    return null;
  }
}
