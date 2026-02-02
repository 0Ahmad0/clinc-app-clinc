import 'package:get/get.dart';
import '../../../app/data/appointment_model.dart';
import '../../../app/extension/appointment_type_extensions.dart';

class AppointmentsController extends GetxController {
  final RxBool isLoading = false.obs;
  final RxList<AppointmentModel> items = <AppointmentModel>[].obs;
  final Rx<AppointmentStatus?> filter = Rx<AppointmentStatus?>(null);

  @override
  void onInit() {
    super.onInit();
    _seedMock();
  }

  void _seedMock() {
    items.value = [
      AppointmentModel(
        id: 'a1',
        patientName: 'Liam Harper',
        patientPhone: '+963999000111',
        title: 'ECG',
        type: AppointmentType.service,
        dateTime: DateTime.now().add(const Duration(hours: 2)),
        status: AppointmentStatus.pending,
      ),
      AppointmentModel(
        id: 'a2',
        patientName: 'Olivia Bennett',
        title: 'Blood Test',
        type: AppointmentType.labTest,
        dateTime: DateTime.now().add(const Duration(hours: 5)),
        status: AppointmentStatus.approved,
      ),
      AppointmentModel(
        id: 'a3',
        patientName: 'Noah Thompson',
        title: 'Consultation',
        type: AppointmentType.consultation,
        dateTime: DateTime.now().subtract(const Duration(days: 1)),
        status: AppointmentStatus.completed,
      ),
      AppointmentModel(
        id: 'a4',
        patientName: 'Sarah Connor',
        title: 'Vitamin D Test',
        type: AppointmentType.labTest,
        dateTime: DateTime.now().subtract(const Duration(days: 2)),
        status: AppointmentStatus.completed,
        resultPdfPathOrUrl: '', // Not uploaded
      ),
      AppointmentModel(
        id: 'a5',
        patientName: 'Mike Ross',
        title: 'X-Ray',
        type: AppointmentType.service,
        dateTime: DateTime.now().add(const Duration(days: 1, hours: 1)),
        status: AppointmentStatus.rejected,
        rejectReasonKey: 'clinic_closed',
        rejectNote: 'Clinic is closed for maintenance.',
      ),
    ];
  }

  void setFilter(AppointmentStatus? status) => filter.value = status;

  List<AppointmentModel> get filtered {
    final f = filter.value;
    if (f == null) return items;
    return items.where((e) => e.status == f).toList();
  }

  AppointmentModel? findById(String id) {
    final idx = items.indexWhere((e) => e.id == id);
    if (idx < 0) return null;
    return items[idx];
  }

  void updateItem(AppointmentModel updated) {
    final idx = items.indexWhere((e) => e.id == updated.id);
    if (idx < 0) return;
    items[idx] = updated;
  }
}