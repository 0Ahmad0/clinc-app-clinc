import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../app/core/design/app_gradients.dart';
import '../../../../app/core/widgets/app_gradient_button.dart';
import '../../../../generated/locale_keys.g.dart';
import '../../controllers/pending_approval_controller.dart';

/// Check-status + contact-support action buttons.
class PendingActionsCard extends GetView<PendingApprovalController> {
  const PendingActionsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Obx(() => AppGradientButton(
          label: tr(LocaleKeys.pending_approval_buttons_check_status),
          isLoading: controller.isLoading.value,
          onTap: controller.checkStatus,
          gradient: AppGradients.amber,
          shadowColor: AppGradients.amberShadow,
          prefixIcon: Icon(Icons.refresh_rounded, color: Colors.white, size: 18.r),
        )),
        16.verticalSpace,
        AppOutlineGradientButton(
          label: tr(LocaleKeys.pending_approval_buttons_contact_support),
          onTap: controller.contactSupport,
          borderColor: Colors.grey.shade200,
          textColor: Colors.grey.shade700,
          prefixIcon: Icon(Icons.support_agent_rounded, color: Colors.grey.shade600, size: 18.r),
        ),
      ],
    );
  }
}
