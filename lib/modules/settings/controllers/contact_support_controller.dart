import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../app/core/configuration/locator.dart';
import '../../../app/core/helper/response_helper.dart';
import '../../../app/domain/error_handler/network_exceptions.dart';
import '../domain/settings_repository.dart';

class ContactSupportController extends GetxController {
  static const subjects = [
    'technical',
    'account',
    'appointment',
    'payment',
    'suggestion',
    'other',
  ];

  final formKey = GlobalKey<FormState>();
  final customSubjectController = TextEditingController();
  final descriptionController = TextEditingController();
  final selectedSubject = RxnString();
  final imagePaths = <String>[].obs;
  final isLoading = false.obs;
  late final SettingsRepository _repository;

  bool get isOther => selectedSubject.value == 'other';

  @override
  void onInit() {
    _repository = locator<SettingsRepository>();
    super.onInit();
  }

  String? validateRequired(String? value) {
    if (value == null || value.trim().isEmpty) {
      return tr('settings.validation_required');
    }
    return null;
  }

  Future<void> pickImages() async {
    final images = await ImagePicker().pickMultiImage(imageQuality: 80);
    imagePaths.addAll(
      images
          .map((image) => image.path)
          .where((path) => !imagePaths.contains(path)),
    );
  }

  void removeImage(int index) {
    if (index >= 0 && index < imagePaths.length) imagePaths.removeAt(index);
  }

  Future<void> submit() async {
    if (isLoading.value || !(formKey.currentState?.validate() ?? false)) return;
    if (selectedSubject.value == null) {
      ResponseHelper.onFailure(
        message: tr('settings.support.subject_required'),
      );
      return;
    }
    final subject = isOther
        ? customSubjectController.text.trim()
        : tr('settings.support.subjects.${selectedSubject.value}');
    isLoading.value = true;
    final result = await _repository.submitSupportRequest(
      subject: subject,
      description: descriptionController.text.trim(),
      imagePaths: List<String>.from(imagePaths),
    );
    isLoading.value = false;
    result.when(
      success: (model) {
        if (model.status != 'success' || model.result == null) {
          ResponseHelper.onFailure(message: model.message);
          return;
        }
        ResponseHelper.onSuccess(message: model.message);
        Get.back();
      },
      failure: (exception) {
        ResponseHelper.onFailure(
          message: NetworkExceptions.getErrorMessage(exception),
        );
      },
    );
  }

  @override
  void onClose() {
    customSubjectController.dispose();
    descriptionController.dispose();
    super.onClose();
  }
}
