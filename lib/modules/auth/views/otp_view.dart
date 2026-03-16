import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../app/core/design/app_gradients.dart';
import '../../../app/core/widgets/app_gradient_header.dart';
import '../../../generated/locale_keys.g.dart';
import '../controllers/otp_controller.dart';
import 'widgets/otp_card.dart';

class OtpView extends GetView<OtpController> {
  const OtpView({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      body: Column(
        children: [
          AppGradientHeader(
            gradient: AppGradients.teal,
            icon: Icons.sms_rounded,
            iconCircleSize: 76,
            iconSize: 38,
            title: tr(LocaleKeys.otp_title),
            subtitleWidget: _OtpSubtitle(emailOrPhone: controller.emailOrPhone),
            leading: const AppHeaderBackButton(),
            badge: const _OtpBadge(),
          ),
          Expanded(
            child: SingleChildScrollView(
               
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Column(
                children: [
                  32.verticalSpace,
                  OtpCard(controller: controller),
                  24.verticalSpace,
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _OtpSubtitle extends StatelessWidget {
  final String emailOrPhone;
  const _OtpSubtitle({required this.emailOrPhone});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 40.w),
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          text: '${tr(LocaleKeys.otp_subtitle)} ',
          style: TextStyle(
            color: Colors.white.withValues(alpha: 0.78),
            fontSize: 12.sp,
            height: 1.5,
          ),
          children: [
            TextSpan(
              text: emailOrPhone,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w800,
                fontSize: 13.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _OtpBadge extends StatelessWidget {
  const _OtpBadge();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 18.r,
      height: 18.r,
      decoration: BoxDecoration(
        color: const Color(0xFFF59E0B),
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white, width: 1.5),
      ),
      child: Icon(Icons.lock_rounded, size: 9.r, color: Colors.white),
    );
  }
}
