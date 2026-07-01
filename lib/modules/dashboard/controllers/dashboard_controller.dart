import 'package:get/get.dart';

import '../../../app/core/configuration/locator.dart';
import '../../../app/domain/error_handler/network_exceptions.dart';
import '../domain/dashboard_repository.dart';
import '../models/dashboard_model.dart';

class DashboardController extends GetxController {
  final Rxn<DashboardModel> dashboard = Rxn<DashboardModel>();
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;
  late final DashboardRepository _repository;

  @override
  void onInit() {
    _repository = locator<DashboardRepository>();
    loadDashboard();
    super.onInit();
  }

  Future<void> loadDashboard() async {
    if (isLoading.value) return;
    isLoading.value = true;
    errorMessage.value = '';
    final result = await _repository.getDashboard();
    isLoading.value = false;

    result.when(
      success: (response) {
        if (!response.isSuccess || response.data == null) {
          errorMessage.value = response.message;
          return;
        }
        dashboard.value = response.data;
      },
      failure: (exception) {
        errorMessage.value = NetworkExceptions.getErrorMessage(exception);
      },
    );
  }
}
