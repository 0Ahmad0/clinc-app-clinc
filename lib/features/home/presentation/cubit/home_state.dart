import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/domain/error_handler/network_exceptions.dart';
import '../../data/models/clinic_dashboard_model.dart';

part 'home_state.freezed.dart';

@freezed
abstract class HomeState with _$HomeState {
  const factory HomeState({
    @Default(false) bool isLoading,
    ClinicDashboardModel? dashboard,
    String? message,
    NetworkExceptions? failure,
  }) = _HomeState;
}
