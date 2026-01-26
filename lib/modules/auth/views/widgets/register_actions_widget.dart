import 'package:clinc_app_clinc/app/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../app/core/widgets/app_button_widget.dart';
import '../../../../app/core/widgets/app_loading_widget.dart';
import '../../../../app/core/widgets/app_text_button_widget.dart';
import '../../../../generated/locale_keys.g.dart';
import '../../controllers/register_controller.dart';

class RegisterActionsWidget extends GetView<RegisterController> {
  const RegisterActionsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AppButtonWidget(
          isLoading: controller.isLoading.value,
          text: tr(LocaleKeys.register_buttons_submit),
          onPressed: controller.register,
          // height: 50.h,
        ),

        14.verticalSpace,

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              tr(LocaleKeys.register_buttons_login_text),
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            5.horizontalSpace,
            AppTextButtonWidget(
              text: tr(LocaleKeys.register_buttons_login_action),
              onPressed: () {
                Get.offAllNamed(AppRoutes.login);
              },
            ),
          ],
        ),
      ],
    );
  }
}
