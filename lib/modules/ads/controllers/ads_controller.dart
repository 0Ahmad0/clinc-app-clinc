import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../app/data/account_type.dart';
import '../../../app/routes/app_routes.dart';

enum AdFlowType { single, package }

class AdPackagePlan {
  final String id;
  final String titleKey;
  final int price;
  final List<String> featuresKeys;

  const AdPackagePlan({
    required this.id,
    required this.titleKey,
    required this.price,
    required this.featuresKeys,
  });
}

class AdCampaign {
  final String id;
  final String title;
  final String description;
  final DateTime startAt;
  final DateTime endAt;
  final bool isActive;

  const AdCampaign({
    required this.id,
    required this.title,
    required this.description,
    required this.startAt,
    required this.endAt,
    required this.isActive,
  });
}

class AdsController extends GetxController {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  final RxString selectedImagePath = ''.obs;
  final Rxn<AdFlowType> selectedFlowType = Rxn<AdFlowType>();
  final RxString selectedPackageId = 'basic'.obs;
  final RxString selectedPaymentMethod = 'card'.obs;
  final Rx<AccountType> accountType = AccountType.clinic.obs;

  final RxList<AdCampaign> ads = <AdCampaign>[].obs;

  final List<AdPackagePlan> packages = const [
    AdPackagePlan(
      id: 'basic',
      titleKey: 'ads.packages.basic.title',
      price: 50,
      featuresKeys: [
        'ads.packages.basic.features.one',
        'ads.packages.basic.features.two',
        'ads.packages.basic.features.three',
      ],
    ),
    AdPackagePlan(
      id: 'advanced',
      titleKey: 'ads.packages.advanced.title',
      price: 150,
      featuresKeys: [
        'ads.packages.advanced.features.one',
        'ads.packages.advanced.features.two',
        'ads.packages.advanced.features.three',
        'ads.packages.advanced.features.four',
      ],
    ),
    AdPackagePlan(
      id: 'pro',
      titleKey: 'ads.packages.pro.title',
      price: 300,
      featuresKeys: [
        'ads.packages.pro.features.one',
        'ads.packages.pro.features.two',
        'ads.packages.pro.features.three',
        'ads.packages.pro.features.four',
        'ads.packages.pro.features.five',
      ],
    ),
  ];

  @override
  void onInit() {
    super.onInit();
    _resolveRoleFromArgs();
    _seedMockAds();
  }

  @override
  void onClose() {
    titleController.dispose();
    descriptionController.dispose();
    super.onClose();
  }

  bool get canUsePackages => accountType.value != AccountType.lab;

  int get currentPrice {
    if (selectedFlowType.value == AdFlowType.single) return 30;
    for (final plan in packages) {
      if (plan.id == selectedPackageId.value) return plan.price;
    }
    return 50;
  }

  String get currentRoleLabelKey {
    switch (accountType.value) {
      case AccountType.clinic:
        return 'ads.roles.clinic';
      case AccountType.both:
        return 'ads.roles.clinic_with_lab';
      case AccountType.lab:
        return 'ads.roles.lab';
    }
  }

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final file = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 85,
    );
    if (file != null) selectedImagePath.value = file.path;
  }

  void chooseSingleFlow() {
    selectedFlowType.value = AdFlowType.single;
    Get.toNamed(AppRoutes.adsCreateSingle);
  }

  void choosePackageFlow() {
    if (!canUsePackages) {
      Get.snackbar(
        tr('ads.messages.not_available'),
        tr('ads.messages.not_available_for_role'),
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }
    selectedFlowType.value = AdFlowType.package;
    Get.toNamed(AppRoutes.adsPackages);
  }

  void goToPayment() {
    if (!_isFormValid()) return;
    Get.toNamed(AppRoutes.adsPayment);
  }

  void completePayment() {
    final now = DateTime.now();
    final flow = selectedFlowType.value ?? AdFlowType.single;
    final duration = flow == AdFlowType.single
        ? const Duration(days: 7)
        : const Duration(days: 30);
    final createdAd = AdCampaign(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: titleController.text.trim(),
      description: descriptionController.text.trim(),
      startAt: now,
      endAt: now.add(duration),
      isActive: true,
    );
    ads.insert(0, createdAd);

    _clearFlowData();

    Get.snackbar(
      tr('ads.messages.success_title'),
      tr('ads.messages.success_body'),
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: const Color(0xFF10B981).withValues(alpha: 0.15),
      colorText: const Color(0xFF065F46),
    );

    Get.until((route) => route.settings.name == AppRoutes.ads);
  }

  String formatDateTime(DateTime value) {
    final year = value.year.toString();
    final month = value.month.toString().padLeft(2, '0');
    final day = value.day.toString().padLeft(2, '0');
    final hour = value.hour.toString().padLeft(2, '0');
    final minute = value.minute.toString().padLeft(2, '0');
    return '$year-$month-$day $hour:$minute';
  }

  String remainingForAd(AdCampaign ad) {
    final now = DateTime.now();
    if (!ad.isActive || ad.endAt.isBefore(now)) {
      return tr('ads.status.finished');
    }
    final diff = ad.endAt.difference(now);
    final days = diff.inDays;
    final hours = diff.inHours.remainder(24);
    if (days > 0) {
      return tr(
        'ads.status.remaining_days_hours',
        args: [days.toString(), hours.toString()],
      );
    }
    final minutes = diff.inMinutes.remainder(60);
    return tr(
      'ads.status.remaining_hours_minutes',
      args: [hours.toString(), minutes.toString()],
    );
  }

  void _resolveRoleFromArgs() {
    final args = Get.arguments;
    if (args is Map && args['role'] is String) {
      final role = args['role'] as String;
      accountType.value = _fromRoleName(role);
    }
  }

  AccountType _fromRoleName(String roleName) {
    switch (roleName) {
      case 'clinicWithLab':
        return AccountType.both;
      case 'lab':
        return AccountType.lab;
      default:
        return AccountType.clinic;
    }
  }

  bool _isFormValid() {
    if (titleController.text.trim().isEmpty) {
      _showValidation(tr('ads.form.title_required'));
      return false;
    }
    if (descriptionController.text.trim().isEmpty) {
      _showValidation(tr('ads.form.description_required'));
      return false;
    }
    if (selectedImagePath.value.isEmpty) {
      _showValidation(tr('ads.form.image_required'));
      return false;
    }
    if (selectedFlowType.value == AdFlowType.package &&
        selectedPackageId.value.isEmpty) {
      _showValidation(tr('ads.form.package_required'));
      return false;
    }
    return true;
  }

  void _showValidation(String message) {
    Get.snackbar(
      tr('ads.messages.validation_title'),
      message,
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  void _seedMockAds() {
    if (ads.isNotEmpty) return;

    final now = DateTime.now();
    ads.assignAll([
      AdCampaign(
        id: '1',
        title: tr('ads.mock.first_title'),
        description: tr('ads.mock.first_description'),
        startAt: now.subtract(const Duration(days: 2)),
        endAt: now.add(const Duration(days: 5, hours: 3)),
        isActive: true,
      ),
      AdCampaign(
        id: '2',
        title: tr('ads.mock.second_title'),
        description: tr('ads.mock.second_description'),
        startAt: now.subtract(const Duration(days: 20)),
        endAt: now.subtract(const Duration(days: 5)),
        isActive: false,
      ),
    ]);
  }

  void _clearFlowData() {
    titleController.clear();
    descriptionController.clear();
    selectedImagePath.value = '';
    selectedFlowType.value = null;
    selectedPackageId.value = 'basic';
    selectedPaymentMethod.value = 'card';
  }
}
