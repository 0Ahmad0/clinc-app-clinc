import 'package:clinc_app_clinc/app/core/widgets/app_text_filed_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../generated/locale_keys.g.dart';
import '../../controllers/forgot_password_controller.dart';

class ForgotPasswordFormWidget extends GetView<ForgotPasswordController> {
  const ForgotPasswordFormWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: controller.formKey,
      child: Column(
        children: [
          AppTextFormFieldWidget(
            controller: controller.identifierController,
            hintText: tr(LocaleKeys.forgot_password_fields_identifier_hint),
            prefixIcon: Icons.mail_outline,
            keyboardType: TextInputType.emailAddress,
            validator: controller.validateRequired,
            textInputAction: TextInputAction.done,
            onFieldSubmitted: (_) => controller.sendResetLink(),
          ),
        ],
      ),
    );
  }
}