import 'package:easy_localization/easy_localization.dart';
import 'package:get/get.dart';

import '../../../app/core/configuration/locator.dart';
import '../../../app/core/helper/response_helper.dart';
import '../../../app/routes/app_routes.dart';
import '../../../app/services/storage_service.dart';
import '../../../generated/locale_keys.g.dart';
import '../domain/pending_approval_repository.dart';

class PendingApprovalController extends GetxController {
  final RxBool isLoading = false.obs;
  late final PendingApprovalRepository _repository;

  @override
  void onInit() {
    _repository = locator<PendingApprovalRepository>();
    super.onInit();
  }

  Future<void> checkStatus() async {
    if (isLoading.value) return;
    final reference = StorageService.instance.getPendingRegistrationReference();
    if (reference == null || reference.isEmpty) {
      ResponseHelper.onFailure(
        message: tr('pending_approval.messages.missing_reference'),
      );
      return;
    }

    isLoading.value = true;
    final result = await _repository.getRegistrationStatus(
      reference: reference,
    );
    isLoading.value = false;

    result.when(
      success: (model) async {
        if (model.status != 'success' || model.result == null) {
          ResponseHelper.onFailure(message: model.message);
          return;
        }
        switch (model.result!.status) {
          case 'approved':
            await StorageService.instance.setPendingRegistrationReference(null);
            await StorageService.instance.setProfileCompleted(
              !model.result!.needsCompletion,
            );
            ResponseHelper.onSuccess(
              message: tr(LocaleKeys.pending_approval_messages_approved),
            );
            Get.offAllNamed(
              model.result!.needsCompletion
                  ? AppRoutes.completeProfile
                  : AppRoutes.mainLayout,
            );
            break;
          case 'rejected':
            ResponseHelper.onFailure(
              message:
                  model.result!.rejectionReason ??
                  tr('pending_approval.messages.rejected'),
            );
            await logout();
            break;
          default:
            ResponseHelper.onWarning(
              message: tr(LocaleKeys.pending_approval_messages_still_pending),
            );
        }
      },
      failure: (exception) =>
          ResponseHelper.onNetworkFailure(networkException: exception),
    );
  }

  void contactSupport() {
    ResponseHelper.onWarning(
      message: tr('pending_approval.messages.support_not_configured'),
    );
  }

  Future<void> logout() async {
    await StorageService.instance.depose();
    Get.offAllNamed(AppRoutes.login);
  }
}
