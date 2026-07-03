import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app/core/configuration/locator.dart';
import '../../../app/data/appointment_model.dart';
import '../../../app/data/enums/loading.dart';
import '../../../app/domain/error_handler/network_exceptions.dart';
import '../../../app/extension/appointment_type_extensions.dart';
import '../domain/appointments_repository.dart';

class AppointmentsController extends GetxController {
  // ===== متغيرات الكود القديم =====
  final Rx<GeneralLoading> loading = GeneralLoading.initial.obs;
  final RxList<AppointmentModel> items = <AppointmentModel>[].obs;
  final Rx<AppointmentStatus?> filter = Rx<AppointmentStatus?>(null);
  final RxBool isLoadingMore = false.obs;
  final RxString errorMessage = ''.obs;
  final TextEditingController searchController = TextEditingController();
  final ScrollController scrollController = ScrollController();

  late final AppointmentsRepository _repository;
  Timer? _searchDebounce;
  int _currentPage = 0;
  int _total = 0;

  // ===== متغيرات الكود الجديد =====
  final RxBool isLoading = false.obs; // للعمليات الفردية (موافقة، رفض، إلخ)

  // ===== Getters =====
  bool get hasMore => items.length < _total;

  // ===== قائمة مفلترة (مدمجة من القديم والجديد) =====
  List<AppointmentModel> get filtered {
    final f = filter.value;
    if (f == null) return items;
    return items.where((e) => e.status == f).toList();
  }

  // ===== دورة الحياة =====
  @override
  void onInit() {
    _repository = locator<AppointmentsRepository>();
    scrollController.addListener(_onScroll);
    getAppointments(page: 1);
    super.onInit();
  }

  @override
  void onClose() {
    _searchDebounce?.cancel();
    searchController.dispose();
    scrollController.dispose();
    super.onClose();
  }

  // ===== التمرير للتحميل اللامتناهي (من الكود القديم) =====
  void _onScroll() {
    if (scrollController.position.extentAfter < 240 &&
        hasMore &&
        !isLoadingMore.value) {
      getAppointments(page: _currentPage + 1);
    }
  }

  // ===== جلب المواعيد (من الكود القديم) =====
  Future<void> getAppointments({required int page}) async {
    final isFirstPage = page == 1;
    if (isFirstPage) {
      loading.value = GeneralLoading.loading;
      errorMessage.value = '';
    } else {
      isLoadingMore.value = true;
    }

    final result = await _repository.getAppointments(
      page: page,
      search: searchController.text,
      status: filter.value,
    );

    result.when(
      success: (model) {
        if (model.status != 'success') {
          _handleFailure(model.message ?? 'Unable to load appointments');
          return;
        }
        if (isFirstPage) items.clear();
        items.addAll(model.result?.list ?? const []);
        _currentPage = model.meta?.currentPage ?? page;
        _total = model.meta?.total ?? items.length;
        isLoadingMore.value = false;
        loading.value = items.isEmpty
            ? GeneralLoading.empty
            : GeneralLoading.success;
      },
      failure: (exception) {
        _handleFailure(NetworkExceptions.getErrorMessage(exception));
      },
    );
  }

  // ===== معالجة الأخطاء (من الكود القديم) =====
  void _handleFailure(String message) {
    isLoadingMore.value = false;
    errorMessage.value = message;
    if (items.isEmpty) loading.value = GeneralLoading.failure;
  }

  // ===== تحديث القائمة (من الكود القديم) =====
  Future<void> refreshAppointments() => getAppointments(page: 1);

  // ===== البحث (من الكود القديم) =====
  void search(String value) {
    _searchDebounce?.cancel();
    _searchDebounce = Timer(
      const Duration(milliseconds: 350),
      () => getAppointments(page: 1),
    );
  }

  // ===== تعيين الفلتر (مدمج من القديم والجديد) =====
  void setFilter(AppointmentStatus? status) {
    if (filter.value == status) return;
    filter.value = status;
    getAppointments(page: 1);
  }

  // ===== البحث عن موعد بالمعرف (من الكود القديم) =====
  AppointmentModel? findById(String id) {
    final index = items.indexWhere((item) => item.id == id);
    return index < 0 ? null : items[index];
  }

  // ===== تحديث موعد (من الكود القديم) =====
  void updateItem(AppointmentModel updated) {
    final index = items.indexWhere((item) => item.id == updated.id);
    if (index < 0) return;
    items[index] = updated;
    items.refresh();
  }

  // ===== الموافقة على موعد (من الكود الجديد مع ربط قديم) =====
  Future<void> approveItem(String id) async {
    if (isLoading.value) return;
    isLoading.value = true;

    // استخدام الـ Repository من الكود القديم
    final result = await _repository.updateStatus(
      id: id,
      status: AppointmentStatus.approved,
    );

    isLoading.value = false;

    result.when(
      success: (response) {
        if (response.status != 'success') {
          _handleFailure(response.message ?? 'Failed to approve appointment');
          return;
        }
        // تحديث القائمة محلياً
        final item = findById(id);
        if (item != null) {
          updateItem(item.copyWith(status: AppointmentStatus.approved));
        }
        // إعادة جلب البيانات للتحديث
        refreshAppointments();
        Get.snackbar(
          'تمت الموافقة',
          'تمت الموافقة على الموعد بنجاح',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.green.withValues(alpha: 0.9),
          colorText: Colors.white,
        );
      },
      failure: (exception) {
        _handleFailure(NetworkExceptions.getErrorMessage(exception));
      },
    );
  }

  // ===== رفض موعد (من الكود الجديد مع ربط قديم) =====
  Future<void> rejectItem(
    String id, {
    required String reasonKey,
    required String note,
  }) async {
    if (isLoading.value) return;
    isLoading.value = true;

    final result = await _repository.updateStatus(
      id: id,
      status: AppointmentStatus.rejected,
      rejectReason: reasonKey,
      rejectNote: note,
    );

    isLoading.value = false;

    result.when(
      success: (response) {
        if (response.status != 'success') {
          _handleFailure(response.message ?? 'Failed to reject appointment');
          return;
        }
        final item = findById(id);
        if (item != null) {
          updateItem(
            item.copyWith(
              status: AppointmentStatus.rejected,
              rejectReasonKey: reasonKey,
              rejectNote: note,
            ),
          );
        }
        refreshAppointments();
        Get.snackbar(
          'تم الرفض',
          'تم رفض الموعد بنجاح',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red.withValues(alpha: 0.9),
          colorText: Colors.white,
        );
      },
      failure: (exception) {
        _handleFailure(NetworkExceptions.getErrorMessage(exception));
      },
    );
  }

  // ===== إكمال موعد (من الكود الجديد مع ربط قديم) =====
  Future<void> completeItem(String id) async {
    if (isLoading.value) return;
    isLoading.value = true;

    final result = await _repository.updateStatus(
      id: id,
      status: AppointmentStatus.completed,
    );

    isLoading.value = false;

    result.when(
      success: (response) {
        if (response.status != 'success') {
          _handleFailure(response.message ?? 'Failed to complete appointment');
          return;
        }
        final item = findById(id);
        if (item != null) {
          updateItem(item.copyWith(status: AppointmentStatus.completed));
        }
        refreshAppointments();
        Get.snackbar(
          'تم الإكمال',
          'تم إكمال الموعد بنجاح',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.blue.withValues(alpha: 0.9),
          colorText: Colors.white,
        );
      },
      failure: (exception) {
        _handleFailure(NetworkExceptions.getErrorMessage(exception));
      },
    );
  }

  // ===== رفع نتيجة موعد (من الكود الجديد مع ربط قديم) =====
  Future<void> uploadResultForItem(String id, String filePath) async {
    if (isLoading.value) return;
    isLoading.value = true;

    final result = await _repository.uploadResult(id: id, filePath: filePath);

    isLoading.value = false;

    result.when(
      success: (response) {
        if (response.status != 'success') {
          _handleFailure(response.message ?? 'Failed to upload result');
          return;
        }
        final item = findById(id);
        if (item != null) {
          updateItem(item.copyWith(resultPdfPathOrUrl: filePath));
        }
        refreshAppointments();
        Get.snackbar(
          'تم الرفع',
          'تم رفع النتيجة بنجاح',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.purple.withValues(alpha: 0.9),
          colorText: Colors.white,
        );
      },
      failure: (exception) {
        _handleFailure(NetworkExceptions.getErrorMessage(exception));
      },
    );
  }

  // ===== بيانات وهمية للاختبار (من الكود الجديد) =====
  void _seedMock() {
    // تستخدم فقط للاختبار - يمكن إزالتها في الإنتاج
    if (items.isEmpty) {
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
      ];
      loading.value = GeneralLoading.success;
    }
  }
}
