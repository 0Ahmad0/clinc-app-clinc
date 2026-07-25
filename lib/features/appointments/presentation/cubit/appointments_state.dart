import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/data/pagination/pagination_state.dart';
import '../../../../core/domain/error_handler/network_exceptions.dart';
import '../../data/models/clinic_appointment_model.dart';
import '../../domain/appointment_tab.dart';

part 'appointments_state.freezed.dart';

@freezed
abstract class AppointmentsState with _$AppointmentsState {
  const factory AppointmentsState({
    required PaginationState<ClinicAppointmentModel> pagination,
    @Default(AppointmentTab.all) AppointmentTab tab,
    @Default(0) int totalCount,
    @Default(0) int pendingCount,
    @Default(0) int confirmedCount,
    @Default(0) int doneCount,
    @Default(0) int rejectedCount,
    String? selectedId,
    ClinicAppointmentModel? selected,
    NetworkExceptions? failure,
  }) = _AppointmentsState;
}
