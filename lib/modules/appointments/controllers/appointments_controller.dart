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
    final now = DateTime.now();
    items.value = [
      AppointmentModel(
        id: 'a1',
        patientName: 'أحمد محمد علي',
        patientPhone: '+963911000111',
        title: 'فحص دم CBC (مختبر)',
        type: AppointmentType.labTest,
        dateTime: now.add(const Duration(hours: 1, minutes: 19)),
        status: AppointmentStatus.pending,
      ),
      AppointmentModel(
        id: 'a2',
        patientName: 'سارة يوسف',
        patientPhone: '+963922000222',
        title: 'عيادة الأطفال - كشف دوري',
        type: AppointmentType.consultation,
        dateTime: now.add(const Duration(hours: 3, minutes: 19)),
        status: AppointmentStatus.pending,
      ),
      AppointmentModel(
        id: 'a3',
        patientName: 'محمود عبد الرحمن',
        patientPhone: '+963933000333',
        title: 'أشعة سينية (X-Ray)',
        type: AppointmentType.service,
        dateTime: now.add(const Duration(hours: 5, minutes: 19)),
        status: AppointmentStatus.pending,
      ),
      AppointmentModel(
        id: 'a4',
        patientName: 'فاطمة الزهراء',
        patientPhone: '+963944000444',
        title: 'تحليل سكر الدم',
        type: AppointmentType.labTest,
        dateTime: now.add(const Duration(hours: 2)),
        status: AppointmentStatus.approved,
      ),
      AppointmentModel(
        id: 'a5',
        patientName: 'خالد العمري',
        patientPhone: '+963955000555',
        title: 'كشف عيادة عامة',
        type: AppointmentType.consultation,
        dateTime: now.add(const Duration(hours: 4)),
        status: AppointmentStatus.approved,
      ),
      AppointmentModel(
        id: 'a6',
        patientName: 'منى السيد',
        patientPhone: '+963966000666',
        title: 'تحليل هرمونات الغدة',
        type: AppointmentType.labTest,
        dateTime: now.subtract(const Duration(hours: 2)),
        status: AppointmentStatus.completed,
        resultPdfPathOrUrl: '/results/a6_result.pdf',
      ),
      AppointmentModel(
        id: 'a7',
        patientName: 'يوسف التميمي',
        patientPhone: '+963977000777',
        title: 'استشارة أمراض الجهاز الهضمي',
        type: AppointmentType.consultation,
        dateTime: now.subtract(const Duration(hours: 5)),
        status: AppointmentStatus.completed,
      ),
      AppointmentModel(
        id: 'a8',
        patientName: 'ليلى حسن',
        patientPhone: '+963988000888',
        title: 'فحص شامل',
        type: AppointmentType.service,
        dateTime: now.subtract(const Duration(days: 1)),
        status: AppointmentStatus.rejected,
        rejectReasonKey: 'doctor_unavailable',
        rejectNote: 'الطبيب غير متاح في هذا الوقت، يرجى إعادة الحجز.',
      ),
      AppointmentModel(
        id: 'a9',
        patientName: 'عمر الشيخ',
        patientPhone: '+963999000999',
        title: 'تحليل فيروس كبد B',
        type: AppointmentType.labTest,
        dateTime: now.subtract(const Duration(days: 2)),
        status: AppointmentStatus.rejected,
        rejectReasonKey: 'invalid_booking',
        rejectNote: 'الحجز غير مكتمل، معلومات التأمين ناقصة.',
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
    items.refresh();
  }

  Future<void> approveItem(String id) async {
    isLoading.value = true;
    await Future.delayed(const Duration(milliseconds: 400));
    final item = findById(id);
    if (item != null) updateItem(item.copyWith(status: AppointmentStatus.approved));
    isLoading.value = false;
  }

  Future<void> rejectItem(
    String id, {
    required String reasonKey,
    required String note,
  }) async {
    isLoading.value = true;
    await Future.delayed(const Duration(milliseconds: 400));
    final item = findById(id);
    if (item != null) {
      updateItem(item.copyWith(
        status: AppointmentStatus.rejected,
        rejectReasonKey: reasonKey,
        rejectNote: note,
      ));
    }
    isLoading.value = false;
  }

  Future<void> completeItem(String id) async {
    isLoading.value = true;
    await Future.delayed(const Duration(milliseconds: 400));
    final item = findById(id);
    if (item != null) updateItem(item.copyWith(status: AppointmentStatus.completed));
    isLoading.value = false;
  }

  Future<void> uploadResultForItem(String id, String filePath) async {
    isLoading.value = true;
    await Future.delayed(const Duration(milliseconds: 500));
    final item = findById(id);
    if (item != null) updateItem(item.copyWith(resultPdfPathOrUrl: filePath));
    isLoading.value = false;
  }
}
