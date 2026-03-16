import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../../generated/locale_keys.g.dart';
import '../../controllers/otp_controller.dart';

class OtpResendTimer extends GetView<OtpController> {
  const OtpResendTimer({super.key});

  static const _teal = Color(0xFF009688);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final canResend = controller.canResend.value;
      final seconds = controller.remainingSeconds.value;

      if (canResend) {
        return GestureDetector(
          onTap: controller.resendCode,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
            decoration: BoxDecoration(
              color: _teal.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: _teal.withValues(alpha: 0.3)),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.refresh_rounded, color: _teal, size: 18.r),
                8.horizontalSpace,
                Text(
                  tr(LocaleKeys.otp_buttons_resend),
                  style: TextStyle(
                    color: _teal,
                    fontWeight: FontWeight.w700,
                    fontSize: 13.sp,
                  ),
                ),
              ],
            ),
          ),
        );
      }

      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.timer_outlined, size: 16.r, color: Colors.grey.shade500),
          6.horizontalSpace,
          Text(
            '${tr(LocaleKeys.otp_buttons_resend_wait)} ',
            style: TextStyle(color: Colors.grey.shade500, fontSize: 12.sp),
          ),
          Text(
            '00:${seconds.toString().padLeft(2, '0')}',
            style: TextStyle(
              color: _teal,
              fontWeight: FontWeight.w800,
              fontSize: 13.sp,
            ),
          ),
        ],
      );
    });
  }
}
