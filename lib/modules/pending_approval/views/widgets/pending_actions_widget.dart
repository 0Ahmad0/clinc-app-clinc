import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../app/core/widgets/app_button_widget.dart';
import '../../../../app/core/widgets/app_loading_widget.dart';
import '../../../../generated/locale_keys.g.dart';
import '../../controllers/pending_approval_controller.dart';

class PendingActionsWidget extends GetView<PendingApprovalController> {
  const PendingActionsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // زر تحديث الحالة
        Obx(
          () => controller.isLoading.value
              ? Center(child: AppLoadingWidget())
              : AppButtonWidget(
                  text: tr(LocaleKeys.pending_approval_buttons_check_status),
                  onPressed: controller.checkStatus,
                  // يمكنك تغيير اللون لجعله Secondary إذا أحببت
                  // backgroundColor: Colors.orangeAccent,
                ),
        ),

        20.verticalSpace,

        // زر تواصل مع الدعم
        OutlinedButton.icon(
          onPressed: controller.contactSupport,
          icon: const Icon(Icons.support_agent),
          label: Text(tr(LocaleKeys.pending_approval_buttons_contact_support)),
          style: OutlinedButton.styleFrom(
            padding: EdgeInsets.symmetric(vertical: 14.h),
            side: BorderSide(color: Colors.grey.shade300),
            foregroundColor: Colors.grey[800],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.r),
            ),
          ),
        ),
      ],
    );
  }
}
