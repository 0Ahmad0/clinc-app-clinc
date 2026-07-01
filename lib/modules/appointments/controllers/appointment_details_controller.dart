import 'package:get/get.dart';

import '../../../app/core/configuration/locator.dart';
import '../../../app/core/helper/response_helper.dart';
import '../../../app/data/appointment_model.dart';
import '../../../app/data/base_model.dart';
import '../../../app/data/remote/api_response.dart';
import '../../../app/domain/error_handler/network_exceptions.dart';
import '../../../app/extension/appointment_type_extensions.dart';
import '../domain/appointments_repository.dart';
import 'appointments_controller.dart';

class AppointmentDetailsController extends GetxController {
  late final AppointmentModel initial;
  late final AppointmentsRepository _repository;
  final Rx<AppointmentModel> appointment = AppointmentModel(
    id: '',
    patientName: '',
    title: '',
    type: AppointmentType.consultation,
    dateTime: DateTime.fromMillisecondsSinceEpoch(0),
    status: AppointmentStatus.pending,
  ).obs;

  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    _repository = locator<AppointmentsRepository>();
    super.onInit();
    initial = Get.arguments as AppointmentModel;
    appointment.value = Get.isRegistered<AppointmentsController>()
        ? Get.find<AppointmentsController>().findById(initial.id) ?? initial
        : initial;
  }

  Future<void> approve() async {
    await _updateStatus(AppointmentStatus.approved);
  }

  Future<void> reject({required String reasonKey, required String note}) async {
    await _updateStatus(
      AppointmentStatus.rejected,
      rejectReasonKey: reasonKey,
      rejectNote: note,
    );
  }

  Future<void> complete() async {
    await _updateStatus(AppointmentStatus.completed);
  }

  Future<void> uploadPdfResult(String filePath) async {
    if (isLoading.value) return;
    isLoading.value = true;
    final result = await _repository.uploadResult(
      id: appointment.value.id,
      filePath: filePath,
    );
    isLoading.value = false;
    await _applyResult(result);
  }

  Future<void> _updateStatus(
    AppointmentStatus status, {
    String? rejectReasonKey,
    String? rejectNote,
  }) async {
    if (isLoading.value) return;
    isLoading.value = true;
    final result = await _repository.updateStatus(
      id: appointment.value.id,
      status: status,
      rejectReason: rejectReasonKey,
      rejectNote: rejectNote,
    );
    isLoading.value = false;
    await _applyResult(result);
  }

  Future<void> _applyResult(
    ApiResponse<BaseModel<AppointmentModel>> result,
  ) async {
    await result.when(
      success: (model) async {
        if (model.status != 'success' || model.result == null) {
          ResponseHelper.onFailure(message: model.message);
          return;
        }
        appointment.value = model.result!;
        if (Get.isRegistered<AppointmentsController>()) {
          final list = Get.find<AppointmentsController>();
          list.updateItem(model.result!);
          await list.refreshAppointments();
        }
      },
      failure: (exception) async {
        ResponseHelper.onFailure(
          message: NetworkExceptions.getErrorMessage(exception),
        );
      },
    );
  }
}
