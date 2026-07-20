import 'package:equatable/equatable.dart';

import '../../domain/appointment_status.dart';
import '../../domain/appointment_tab.dart';

class AppointmentsState extends Equatable {
  const AppointmentsState({
    this.tab = AppointmentTab.all,
    this.selectedId,
    this.statusOverrides = const {},
    this.reasons = const {},
  });

  final AppointmentTab tab;
  final int? selectedId;
  final Map<int, AppointmentStatus> statusOverrides;
  final Map<int, String> reasons;

  static const Object _keep = Object();

  AppointmentsState copyWith({
    AppointmentTab? tab,
    Object? selectedId = _keep,
    Map<int, AppointmentStatus>? statusOverrides,
    Map<int, String>? reasons,
  }) => AppointmentsState(
    tab: tab ?? this.tab,
    selectedId: identical(selectedId, _keep)
        ? this.selectedId
        : selectedId as int?,
    statusOverrides: statusOverrides ?? this.statusOverrides,
    reasons: reasons ?? this.reasons,
  );

  @override
  List<Object?> get props => [tab, selectedId, statusOverrides, reasons];
}
