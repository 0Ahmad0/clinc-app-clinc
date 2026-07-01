import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../../app/core/configuration/locator.dart';
import '../../../app/core/helper/response_helper.dart';
import '../../../app/domain/error_handler/network_exceptions.dart';
import '../../../app/routes/app_routes.dart';
import '../../../app/services/storage_service.dart';
import '../domain/complete_profile_repository.dart';
import '../models/complete_profile_model.dart';
import '../models/day_schedule_model.dart';

class CompleteProfileController extends GetxController {
  final TextEditingController phoneController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final Rxn<XFile> logoImage = Rxn<XFile>();
  final Rxn<XFile> coverImage = Rxn<XFile>();
  final RxBool isLoading = false.obs;
  final RxBool isLoadingInsurances = false.obs;
  final RxList<InsuranceModel> insurances = <InsuranceModel>[].obs;
  final RxSet<int> selectedInsuranceIds = <int>{}.obs;
  final ImagePicker _imagePicker = ImagePicker();
  late final CompleteProfileRepository _repository;

  final RxList<DaySchedule> weekSchedule = <DaySchedule>[
    DaySchedule(dayKey: 'sat'),
    DaySchedule(dayKey: 'sun'),
    DaySchedule(dayKey: 'mon'),
    DaySchedule(dayKey: 'tue'),
    DaySchedule(dayKey: 'wed'),
    DaySchedule(dayKey: 'thu'),
    DaySchedule(dayKey: 'fri', isDayOff: true),
  ].obs;

  @override
  void onInit() {
    _repository = locator<CompleteProfileRepository>();
    _loadInsurances();
    super.onInit();
  }

  Future<void> _loadInsurances() async {
    isLoadingInsurances.value = true;
    final result = await _repository.getInsurances();
    isLoadingInsurances.value = false;
    result.when(
      success: insurances.assignAll,
      failure: (exception) => ResponseHelper.onFailure(
        message: NetworkExceptions.getErrorMessage(exception),
      ),
    );
  }

  Future<void> pickImage(bool isCover) async {
    final image = await _imagePicker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 85,
      maxWidth: 1920,
    );
    if (image == null) return;
    if (isCover) {
      coverImage.value = image;
    } else {
      logoImage.value = image;
    }
  }

  void toggleInsurance(int id, bool selected) {
    selected ? selectedInsuranceIds.add(id) : selectedInsuranceIds.remove(id);
  }

  Future<void> pickTime(BuildContext context, int index, bool isStart) async {
    final day = weekSchedule[index];
    final current = isStart ? day.startTime : day.endTime;
    final parts = current.split(':');
    final picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(
        hour: int.tryParse(parts.first) ?? 9,
        minute: int.tryParse(parts.last) ?? 0,
      ),
    );
    if (picked == null) return;

    final formatted =
        '${picked.hour.toString().padLeft(2, '0')}:'
        '${picked.minute.toString().padLeft(2, '0')}';
    if (isStart) {
      day.startTime = formatted;
    } else {
      day.endTime = formatted;
    }
    weekSchedule.refresh();
  }

  void toggleDayOff(int index, bool isDayOff) {
    weekSchedule[index].isDayOff = isDayOff;
    weekSchedule.refresh();
  }

  String? validatePhone(String? value) {
    final phone = value?.trim() ?? '';
    if (phone.isEmpty) return tr('complete_profile.messages.phone_required');
    if (!GetUtils.isPhoneNumber(phone)) {
      return tr('complete_profile.messages.phone_invalid');
    }
    return null;
  }

  bool _hasValidSchedule() {
    final workDays = weekSchedule.where((day) => !day.isDayOff);
    if (workDays.isEmpty) return false;
    return workDays.every(
      (day) => _minutes(day.endTime) > _minutes(day.startTime),
    );
  }

  int _minutes(String value) {
    final parts = value.split(':').map(int.parse).toList();
    return parts.first * 60 + parts.last;
  }

  Future<void> saveDataAndFinish() async {
    if (isLoading.value || !(formKey.currentState?.validate() ?? false)) return;
    if (logoImage.value == null || coverImage.value == null) {
      ResponseHelper.onFailure(
        message: tr('complete_profile.messages.images_required'),
      );
      return;
    }
    if (!_hasValidSchedule()) {
      ResponseHelper.onFailure(
        message: tr('complete_profile.messages.schedule_invalid'),
      );
      return;
    }

    isLoading.value = true;
    final result = await _repository.completeProfile(
      CompleteClinicProfileRequest(
        phone: phoneController.text.trim(),
        insuranceIds: selectedInsuranceIds.toList(),
        schedule: weekSchedule,
        logoPath: logoImage.value!.path,
        coverPath: coverImage.value!.path,
      ),
    );
    isLoading.value = false;

    result.when(
      success: (response) {
        if (!response.isSuccess) {
          ResponseHelper.onFailure(message: response.message);
          return;
        }
        StorageService.instance.setProfileCompleted(true).then((_) {
          ResponseHelper.onSuccess(message: response.message);
          Get.offAllNamed(AppRoutes.mainLayout);
        });
      },
      failure: (exception) => ResponseHelper.onFailure(
        message: NetworkExceptions.getErrorMessage(exception),
      ),
    );
  }

  Future<void> skip() async {
    await StorageService.instance.setProfileCompleted(false);
    Get.offAllNamed(AppRoutes.mainLayout);
  }

  @override
  void onClose() {
    phoneController.dispose();
    super.onClose();
  }
}
