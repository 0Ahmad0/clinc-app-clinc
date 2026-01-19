import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../generated/locale_keys.g.dart';
import '../../controllers/otp_controller.dart';

class OtpTimerWidget extends GetView<OtpController> {
  const OtpTimerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final seconds = controller.remainingSeconds.value;
      final canResend = controller.canResend.value;

      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (!canResend) ...[
            const Icon(Icons.timer_outlined, size: 18, color: Colors.grey),
            5.horizontalSpace,
            Text(
              '${tr(LocaleKeys.otp_buttons_resend_wait)} ',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.grey),
            ),
            Text(
              '00:${seconds.toString().padLeft(2, '0')}',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ] else
            TextButton.icon(
              onPressed: controller.resendCode,
              icon: const Icon(Icons.refresh),
              label: Text(
                tr(LocaleKeys.otp_buttons_resend),
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
        ],
      );
    });
  }
}