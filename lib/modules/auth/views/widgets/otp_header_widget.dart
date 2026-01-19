import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../app/core/widgets/app_svg_widget.dart';
import '../../../../generated/locale_keys.g.dart';
import '../../controllers/otp_controller.dart';

class OtpHeaderWidget extends GetView<OtpController> {
  const OtpHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppSvgWidget(
          path: 'assets/icons/otp_verification.svg',
          height: 120.h,
          width: 120.w,
        ),
        32.verticalSpace,
        Text(
          tr(LocaleKeys.otp_title),
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        12.verticalSpace,
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            text: '${tr(LocaleKeys.otp_subtitle)}\n',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Colors.grey,
              height: 1.5,
            ),
            children: [
              TextSpan(
                text: controller.emailOrPhone,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}