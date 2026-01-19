import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../app/core/widgets/app_button_widget.dart';
import '../../../../app/core/widgets/app_loading_widget.dart';
import '../../../../app/core/widgets/app_text_button_widget.dart';
import '../../../../generated/locale_keys.g.dart';
import '../../controllers/login_controller.dart';

class LoginActionsWidget extends GetView<LoginController> {
  const LoginActionsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // زر الدخول
        Obx(
          () => controller.isLoading.value
              ? Center(child: AppLoadingWidget())
              : AppButtonWidget(
                  text: tr(LocaleKeys.login_buttons_login),
                  onPressed: controller.login,
                  // height: 50.h,
                ),
        ),

        32.verticalSpace,

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              tr(LocaleKeys.login_buttons_register_text),
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            5.horizontalSpace,
            AppTextButtonWidget(
              text: tr(LocaleKeys.login_buttons_register_action),
              onPressed: controller.toRegister,
              // color: Theme.of(context).primaryColor,
            ),
          ],
        ),
      ],
    );
  }
}
