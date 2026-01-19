import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../app/core/widgets/app_button_widget.dart';
import '../../../../app/core/widgets/app_loading_widget.dart';
import '../../../../generated/locale_keys.g.dart';
import '../../controllers/forgot_password_controller.dart';

class ForgotPasswordActionsWidget extends GetView<ForgotPasswordController> {
  const ForgotPasswordActionsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AppButtonWidget(
          isLoading: controller.isLoading.value,
          text: tr(LocaleKeys.forgot_password_buttons_submit),
          onPressed: controller.sendResetLink,
        ),

        24.verticalSpace,

        // زر العودة (اختياري، لكنه لطيف)
        TextButton.icon(
          onPressed: controller.backToLogin,
          icon: const Icon(Icons.arrow_back, size: 18),
          label: Text(
            tr(LocaleKeys.forgot_password_buttons_back_to_login),
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
          style: TextButton.styleFrom(foregroundColor: Colors.grey[700]),
        ),
      ],
    );
  }
}
