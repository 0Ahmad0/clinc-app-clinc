import 'package:get/get.dart';
import '../../../app/data/appointment_model.dart';
import '../../../app/extension/appointment_type_extensions.dart';
import 'appointments_controller.dart';

class AppointmentDetailsController extends GetxController {
  final AppointmentsController listController =
      Get.find<AppointmentsController>();

  late final AppointmentModel initial;
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
    super.onInit();
    initial = Get.arguments as AppointmentModel;
    // لو صار تحديث بالقائمة قبل ما يفتح التفاصيل:
    appointment.value = listController.findById(initial.id) ?? initial;
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
    try {
      isLoading.value = true;
      await Future.delayed(const Duration(milliseconds: 500)); // mock delay

      final updated = appointment.value.copyWith(resultPdfPathOrUrl: filePath);
      appointment.value = updated;
      listController.updateItem(updated);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> _updateStatus(
    AppointmentStatus status, {
    String? rejectReasonKey,
    String? rejectNote,
  }) async {
    try {
      isLoading.value = true;
      await Future.delayed(const Duration(milliseconds: 450)); // mock delay

      final updated = appointment.value.copyWith(
        status: status,
        rejectReasonKey: rejectReasonKey,
        rejectNote: rejectNote,
      );

      appointment.value = updated;
      listController.updateItem(updated);
    } finally {
      isLoading.value = false;
    }
  }
}
