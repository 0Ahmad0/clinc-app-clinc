import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/data/remote/api_response.dart';
import '../../domain/clinic_dashboard_repository.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this._repository) : super(const HomeState());

  final ClinicDashboardRepository _repository;

  Future<void> loadDashboard({String? date}) async {
    if (state.isLoading) return;

    emit(state.copyWith(isLoading: true, failure: null, message: null));

    final result = await _repository.getDashboard(date: date);

    result.when(
      success: (response) {
        emit(
          state.copyWith(
            isLoading: false,
            dashboard: response.result,
            message: response.message,
          ),
        );
      },
      failure: (exception) {
        emit(state.copyWith(isLoading: false, failure: exception));
      },
    );
  }
}
