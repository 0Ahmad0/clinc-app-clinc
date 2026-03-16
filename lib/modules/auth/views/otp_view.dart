import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:pinput/pinput.dart';
import '../../../generated/locale_keys.g.dart';
import '../controllers/otp_controller.dart';

class OtpView extends GetView<OtpController> {
  const OtpView({super.key});

  static const _teal = Color(0xFF009688);
  static const _darkTeal = Color(0xFF004D40);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      body: Column(
        children: [
          _buildHeader(),
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Column(
                children: [
                  32.verticalSpace,
                  _buildOtpCard(context),
                  24.verticalSpace,
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [_darkTeal, _teal, Color(0xFF26A69A)],
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(36),
          bottomRight: Radius.circular(36),
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 12.h, right: 16.w, left: 16.w),
              child: Align(
                alignment: AlignmentDirectional.centerStart,
                child: GestureDetector(
                  onTap: () => Get.back(),
                  child: Container(
                    padding: EdgeInsets.all(8.r),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.18),
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white, size: 18.sp),
                  ),
                ),
              ),
            ),
            16.verticalSpace,
            Container(
              width: 76.r,
              height: 76.r,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.18),
                shape: BoxShape.circle,
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Icon(Icons.sms_rounded, size: 38.r, color: Colors.white),
                  Positioned(
                    bottom: 12.r,
                    right: 12.r,
                    child: Container(
                      width: 18.r,
                      height: 18.r,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF59E0B),
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 1.5),
                      ),
                      child: Icon(Icons.lock_rounded, size: 9.r, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
            14.verticalSpace,
            Text(
              tr(LocaleKeys.otp_title),
              style: TextStyle(color: Colors.white, fontSize: 20.sp, fontWeight: FontWeight.w900),
            ),
            10.verticalSpace,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 40.w),
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  text: '${tr(LocaleKeys.otp_subtitle)} ',
                  style: TextStyle(color: Colors.white.withValues(alpha: 0.78), fontSize: 12.sp, height: 1.5),
                  children: [
                    TextSpan(
                      text: controller.emailOrPhone,
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 13.sp),
                    ),
                  ],
                ),
              ),
            ),
            24.verticalSpace,
          ],
        ),
      ),
    );
  }

  Widget _buildOtpCard(BuildContext context) {
    final defaultTheme = PinTheme(
      width: 58.w,
      height: 58.w,
      textStyle: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.w900, color: _teal),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 8, offset: const Offset(0, 3)),
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
          BoxShadow(color: Colors.black.withValues(alpha: 0.07), blurRadius: 24, offset: const Offset(0, 6)),
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
          Obx(() {
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
                        style: TextStyle(color: _teal, fontWeight: FontWeight.w700, fontSize: 13.sp),
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
                  style: TextStyle(color: _teal, fontWeight: FontWeight.w800, fontSize: 13.sp),
                ),
              ],
            );
          }),
          24.verticalSpace,
          Obx(() => _OtpButton(
            label: tr(LocaleKeys.otp_buttons_verify),
            isLoading: controller.isLoading.value,
            onTap: controller.verifyOtp,
          )),
        ],
      ),
    );
  }
}

class _OtpButton extends StatelessWidget {
  final String label;
  final bool isLoading;
  final VoidCallback onTap;
  const _OtpButton({required this.label, required this.isLoading, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isLoading ? null : onTap,
      child: Container(
        width: double.infinity,
        height: 52.h,
        decoration: BoxDecoration(
          gradient: isLoading
              ? null
              : const LinearGradient(
                  colors: [Color(0xFF009688), Color(0xFF004D40)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
          color: isLoading ? Colors.grey.shade300 : null,
          borderRadius: BorderRadius.circular(14.r),
          boxShadow: isLoading
              ? []
              : [
                  BoxShadow(
                    color: const Color(0xFF009688).withValues(alpha: 0.38),
                    blurRadius: 14,
                    offset: const Offset(0, 5),
                  ),
                ],
        ),
        child: Center(
          child: isLoading
              ? SizedBox(
                  width: 22.r,
                  height: 22.r,
                  child: const CircularProgressIndicator(strokeWidth: 2.5, color: Colors.white),
                )
              : Text(label, style: TextStyle(color: Colors.white, fontSize: 15.sp, fontWeight: FontWeight.w800)),
        ),
      ),
    );
  }
}
