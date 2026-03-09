import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../generated/locale_keys.g.dart';
import '../controllers/forgot_password_controller.dart';

class ForgotPasswordView extends GetView<ForgotPasswordController> {
  const ForgotPasswordView({super.key});

  static const _orange = Color(0xFFF59E0B);
  static const _darkOrange = Color(0xFFB45309);
  static const _teal = Color(0xFF009688);

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
                  36.verticalSpace,
                  _buildCard(context),
                  32.verticalSpace,
                  GestureDetector(
                    onTap: controller.backToLogin,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.arrow_back_ios_rounded, size: 13.r, color: Colors.grey.shade600),
                        6.horizontalSpace,
                        Text(
                          tr(LocaleKeys.forgot_password_buttons_back_to_login),
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
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
          colors: [Color(0xFF92400E), _darkOrange, _orange],
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
              child: Icon(Icons.lock_reset_rounded, size: 38.r, color: Colors.white),
            ),
            14.verticalSpace,
            Text(
              tr(LocaleKeys.forgot_password_title),
              style: TextStyle(color: Colors.white, fontSize: 20.sp, fontWeight: FontWeight.w900),
            ),
            10.verticalSpace,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 36.w),
              child: Text(
                tr(LocaleKeys.forgot_password_subtitle),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white.withValues(alpha: 0.8), fontSize: 12.sp, height: 1.5),
              ),
            ),
            24.verticalSpace,
          ],
        ),
      ),
    );
  }

  Widget _buildCard(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24.r),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.07), blurRadius: 24, offset: const Offset(0, 6)),
        ],
      ),
      padding: EdgeInsets.all(22.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(14.r),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [_orange.withValues(alpha: 0.12), _orange.withValues(alpha: 0.04)],
              ),
              borderRadius: BorderRadius.circular(14.r),
              border: Border.all(color: _orange.withValues(alpha: 0.2)),
            ),
            child: Row(
              children: [
                Icon(Icons.info_outline_rounded, color: _orange, size: 18.r),
                10.horizontalSpace,
                Expanded(
                  child: Text(
                    'سنرسل لك رابط إعادة تعيين كلمة المرور على بريدك الإلكتروني أو رقم هاتفك',
                    style: TextStyle(color: _darkOrange, fontSize: 11.sp, height: 1.5),
                  ),
                ),
              ],
            ),
          ),
          20.verticalSpace,
          Form(
            key: controller.formKey,
            child: TextFormField(
              controller: controller.identifierController,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.done,
              onFieldSubmitted: (_) => controller.sendResetLink(),
              validator: controller.validateRequired,
              style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
              decoration: InputDecoration(
                labelText: tr(LocaleKeys.forgot_password_fields_identifier_hint),
                labelStyle: TextStyle(color: Colors.grey.shade500, fontSize: 13.sp),
                prefixIcon: Icon(Icons.email_outlined, color: _orange, size: 20.sp),
                filled: true,
                fillColor: const Color(0xFFFFFDF0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14.r),
                  borderSide: BorderSide(color: Colors.grey.shade200),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14.r),
                  borderSide: BorderSide(color: Colors.grey.shade200),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14.r),
                  borderSide: BorderSide(color: _orange, width: 1.5),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14.r),
                  borderSide: BorderSide(color: Colors.red.shade400),
                ),
                contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
              ),
            ),
          ),
          24.verticalSpace,
          Obx(() => GestureDetector(
            onTap: controller.isLoading.value ? null : controller.sendResetLink,
            child: Container(
              width: double.infinity,
              height: 52.h,
              decoration: BoxDecoration(
                gradient: controller.isLoading.value
                    ? null
                    : const LinearGradient(
                        colors: [_orange, Color(0xFFD97706)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                color: controller.isLoading.value ? Colors.grey.shade300 : null,
                borderRadius: BorderRadius.circular(14.r),
                boxShadow: controller.isLoading.value
                    ? []
                    : [
                        BoxShadow(
                          color: _orange.withValues(alpha: 0.38),
                          blurRadius: 14,
                          offset: const Offset(0, 5),
                        ),
                      ],
              ),
              child: Center(
                child: controller.isLoading.value
                    ? SizedBox(
                        width: 22.r,
                        height: 22.r,
                        child: const CircularProgressIndicator(strokeWidth: 2.5, color: Colors.white),
                      )
                    : Text(
                        tr(LocaleKeys.forgot_password_buttons_submit),
                        style: TextStyle(color: Colors.white, fontSize: 15.sp, fontWeight: FontWeight.w800),
                      ),
              ),
            ),
          )),
        ],
      ),
    );
  }
}
