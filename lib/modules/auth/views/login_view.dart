import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../generated/locale_keys.g.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

  static const _teal = Color(0xFF009688);
  static const _darkTeal = Color(0xFF004D40);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      body: Column(
        children: [
          _buildHeader(context),
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Column(
                children: [
                  28.verticalSpace,
                  _buildCard(context),
                  24.verticalSpace,
                  _buildRegisterRow(context),
                  24.verticalSpace,
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [_darkTeal, _teal, Color(0xFF00ACC1)],
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
            20.verticalSpace,
            Container(
              width: 80.r,
              height: 80.r,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.18),
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.local_hospital_rounded, size: 40.r, color: Colors.white),
            ),
            16.verticalSpace,
            Text(
              tr(LocaleKeys.login_title),
              style: TextStyle(color: Colors.white, fontSize: 22.sp, fontWeight: FontWeight.w900),
            ),
            8.verticalSpace,
            Text(
              tr(LocaleKeys.login_subtitle),
              style: TextStyle(color: Colors.white.withValues(alpha: 0.78), fontSize: 13.sp),
            ),
            28.verticalSpace,
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
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.07),
            blurRadius: 24,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      padding: EdgeInsets.all(22.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _AuthField(
            controller: controller.identifierController,
            label: tr(LocaleKeys.login_fields_identifier_hint),
            icon: Icons.email_outlined,
            inputAction: TextInputAction.next,
            validator: controller.validateRequired,
          ),
          16.verticalSpace,
          Obx(() => _AuthField(
            controller: controller.passwordController,
            label: tr(LocaleKeys.login_fields_password),
            icon: Icons.lock_outline,
            isPassword: controller.isPassHidden.value,
            inputAction: TextInputAction.done,
            validator: controller.validateRequired,
            onSubmitted: (_) => controller.login(),
          )),
          6.verticalSpace,
          Align(
            alignment: AlignmentDirectional.centerEnd,
            child: TextButton(
              onPressed: controller.toForgotPassword,
              style: TextButton.styleFrom(foregroundColor: _teal),
              child: Text(
                tr(LocaleKeys.login_fields_forgot_password),
                style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w600),
              ),
            ),
          ),
          16.verticalSpace,
          Obx(() => _GradientButton(
            label: tr(LocaleKeys.login_buttons_login),
            isLoading: controller.isLoading.value,
            onTap: controller.login,
          )),
        ],
      ),
    );
  }

  Widget _buildRegisterRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          tr(LocaleKeys.login_buttons_register_text),
          style: TextStyle(color: Colors.grey.shade600, fontSize: 13.sp),
        ),
        6.horizontalSpace,
        GestureDetector(
          onTap: controller.toRegister,
          child: Text(
            tr(LocaleKeys.login_buttons_register_action),
            style: TextStyle(color: _teal, fontSize: 13.sp, fontWeight: FontWeight.w800),
          ),
        ),
      ],
    );
  }
}

class _AuthField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final IconData icon;
  final bool isPassword;
  final TextInputAction inputAction;
  final String? Function(String?)? validator;
  final Function(String)? onSubmitted;
  final TextInputType? keyboardType;

  const _AuthField({
    required this.controller,
    required this.label,
    required this.icon,
    this.isPassword = false,
    this.inputAction = TextInputAction.next,
    this.validator,
    this.onSubmitted,
    this.keyboardType,
  });

  static const _teal = Color(0xFF009688);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: isPassword,
      textInputAction: inputAction,
      keyboardType: keyboardType,
      validator: validator,
      onFieldSubmitted: onSubmitted,
      style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.grey.shade500, fontSize: 13.sp),
        prefixIcon: Icon(icon, color: _teal, size: 20.sp),
        filled: true,
        fillColor: const Color(0xFFF8FFFE),
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
          borderSide: const BorderSide(color: _teal, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14.r),
          borderSide: BorderSide(color: Colors.red.shade400),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
      ),
    );
  }
}

class _GradientButton extends StatelessWidget {
  final String label;
  final bool isLoading;
  final VoidCallback onTap;
  const _GradientButton({required this.label, required this.isLoading, required this.onTap});

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
                    blurRadius: 16,
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
              : Text(
                  label,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.3,
                  ),
                ),
        ),
      ),
    );
  }
}
