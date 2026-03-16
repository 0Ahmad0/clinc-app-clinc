import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:pinput/pinput.dart';
import '../../../../app/core/design/app_gradients.dart';
import '../../../../app/core/widgets/app_gradient_button.dart';
import '../../../../generated/locale_keys.g.dart';
import '../../controllers/otp_controller.dart';
import 'otp_resend_timer.dart';

class OtpCard extends StatelessWidget {
  final OtpController controller;
  const OtpCard({super.key, required this.controller});

  static const _teal = Color(0xFF009688);

  @override
  Widget build(BuildContext context) {
    final defaultTheme = PinTheme(
      width: 58.w,
      height: 58.w,
      textStyle: TextStyle(
        fontSize: 22.sp,
        fontWeight: FontWeight.w900,
        color: _teal,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
    );

    final focusedTheme = defaultTheme.copyWith(
      decoration: defaultTheme.decoration!.copyWith(
        border: const Border.fromBorderSide(BorderSide(color: _teal, width: 2.0)),
        color: const Color(0xFFF0FFFE),
      ),
    );

    final errorTheme = defaultTheme.copyWith(
      decoration: defaultTheme.decoration!.copyWith(
        border: Border.all(color: Colors.red.shade400, width: 1.5),
        color: Colors.red.shade50,
      ),
    );

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.07),
            blurRadius: 24,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      padding: EdgeInsets.all(24.r),
      child: Column(
        children: [
          Pinput(
            autofocus: true,
            controller: controller.otpController,
            length: 4,
            defaultPinTheme: defaultTheme,
            focusedPinTheme: focusedTheme,
            errorPinTheme: errorTheme,
            showCursor: true,
            pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
            onCompleted: (_) => controller.verifyOtp(),
          ),
          28.verticalSpace,
          const OtpResendTimer(),
          24.verticalSpace,
          Obx(() => AppGradientButton(
            label: tr(LocaleKeys.otp_buttons_verify),
            isLoading: controller.isLoading.value,
            onTap: controller.verifyOtp,
            gradient: AppGradients.teal,
            shadowColor: AppGradients.tealShadow,
          )),
        ],
      ),
    );
  }
}
