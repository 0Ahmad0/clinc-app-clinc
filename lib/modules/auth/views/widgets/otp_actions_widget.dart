import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../../app/core/widgets/app_button_widget.dart';
import '../../../../app/core/widgets/app_loading_widget.dart';
import '../../../../generated/locale_keys.g.dart';
import '../../controllers/otp_controller.dart';

class OtpActionsWidget extends GetView<OtpController> {
  const OtpActionsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => controller.isLoading.value
          ? Center(child: AppLoadingWidget())
          : AppButtonWidget(
              text: tr(LocaleKeys.otp_buttons_verify),
              onPressed: () => controller.verifyOtp(),
            ),
    );
  }
}
