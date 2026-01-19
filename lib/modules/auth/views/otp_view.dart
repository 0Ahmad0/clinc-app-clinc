import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../app/core/widgets/app_padding_widget.dart';
import '../../../app/core/widgets/app_scaffold_widget.dart';
import '../controllers/otp_controller.dart';
import 'widgets/otp_actions_widget.dart';
import 'widgets/otp_header_widget.dart';
import 'widgets/otp_input_widget.dart';
import 'widgets/otp_timer_widget.dart';

class OtpView extends GetView<OtpController> {
  const OtpView({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffoldWidget(
      body: AppPaddingWidget(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Center(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const OtpHeaderWidget(),
                40.verticalSpace,
                const OtpInputWidget(),
                32.verticalSpace,
                const OtpTimerWidget(),
                24.verticalSpace,
                const OtpActionsWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
