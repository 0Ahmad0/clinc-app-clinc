import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../generated/locale_keys.g.dart';
import '../controllers/register_controller.dart';

class RegisterView extends GetView<RegisterController> {
  const RegisterView({super.key});

  static const _teal = Color(0xFF009688);
  static const _darkTeal = Color(0xFF004D40);
  static const _indigo = Color(0xFF3949AB);

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
                  24.verticalSpace,
                  _AccountTypeCard(controller: controller),
                  16.verticalSpace,
                  _FormCard(controller: controller),
                  20.verticalSpace,
                  Obx(() => _GradientAuthButton(
                    label: tr(LocaleKeys.register_buttons_register),
                    isLoading: controller.isLoading.value,
                    onTap: controller.register,
                  )),
                  20.verticalSpace,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        tr(LocaleKeys.register_buttons_login_text),
                        style: TextStyle(color: Colors.grey.shade600, fontSize: 13.sp),
                      ),
                      6.horizontalSpace,
                      GestureDetector(
                        onTap: controller.toLogin,
                        child: Text(
                          tr(LocaleKeys.register_buttons_login_action),
                          style: TextStyle(color: _teal, fontSize: 13.sp, fontWeight: FontWeight.w800),
                        ),
                      ),
                    ],
                  ),
                  28.verticalSpace,
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
          colors: [Color(0xFF1A237E), _indigo, Color(0xFF5C6BC0)],
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
              width: 72.r,
              height: 72.r,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.18),
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.app_registration_rounded, size: 36.r, color: Colors.white),
            ),
            14.verticalSpace,
            Text(
              tr(LocaleKeys.register_title),
              style: TextStyle(color: Colors.white, fontSize: 20.sp, fontWeight: FontWeight.w900),
            ),
            8.verticalSpace,
            Text(
              tr(LocaleKeys.register_subtitle),
              style: TextStyle(color: Colors.white.withValues(alpha: 0.78), fontSize: 12.sp),
            ),
            24.verticalSpace,
          ],
        ),
      ),
    );
  }
}

class _AccountTypeCard extends StatelessWidget {
  final RegisterController controller;
  const _AccountTypeCard({required this.controller});

  static const _indigo = Color(0xFF3949AB);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.06), blurRadius: 20, offset: const Offset(0, 4))],
      ),
      padding: EdgeInsets.all(18.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(8.r),
                decoration: BoxDecoration(
                  color: _indigo.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Icon(Icons.category_rounded, color: _indigo, size: 18.r),
              ),
              10.horizontalSpace,
              Text(
                'نوع الحساب',
                style: TextStyle(fontWeight: FontWeight.w800, fontSize: 14.sp, color: Colors.grey.shade800),
              ),
            ],
          ),
          14.verticalSpace,
          Obx(() => Row(
            children: [
              Expanded(
                child: _TypeTile(
                  title: tr(LocaleKeys.register_account_type_clinic),
                  subtitle: 'عيادة طبية',
                  icon: Icons.local_hospital_rounded,
                  selected: controller.selectedAccountType.value == AccountType.clinic,
                  color: _indigo,
                  onTap: () => controller.selectAccountType(AccountType.clinic),
                ),
              ),
              12.horizontalSpace,
              Expanded(
                child: _TypeTile(
                  title: tr(LocaleKeys.register_account_type_lab),
                  subtitle: 'مختبر طبي',
                  icon: Icons.science_rounded,
                  selected: controller.selectedAccountType.value == AccountType.lab,
                  color: const Color(0xFF2563EB),
                  onTap: () => controller.selectAccountType(AccountType.lab),
                ),
              ),
            ],
          )),
        ],
      ),
    );
  }
}

class _TypeTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final bool selected;
  final Color color;
  final VoidCallback onTap;
  const _TypeTile({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.selected,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.all(14.r),
        decoration: BoxDecoration(
          color: selected ? color.withValues(alpha: 0.08) : Colors.grey.shade50,
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(
            color: selected ? color : Colors.grey.shade200,
            width: selected ? 1.5 : 1,
          ),
        ),
        child: Column(
          children: [
            Container(
              width: 44.r,
              height: 44.r,
              decoration: BoxDecoration(
                color: selected ? color.withValues(alpha: 0.15) : Colors.grey.shade100,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Icon(icon, color: selected ? color : Colors.grey.shade400, size: 22.r),
            ),
            10.verticalSpace,
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 12.sp,
                color: selected ? color : Colors.grey.shade700,
              ),
            ),
            4.verticalSpace,
            Text(
              subtitle,
              style: TextStyle(fontSize: 10.sp, color: Colors.grey.shade500),
            ),
            if (selected) ...[
              8.verticalSpace,
              Icon(Icons.check_circle_rounded, color: color, size: 16.r),
            ],
          ],
        ),
      ),
    );
  }
}

class _FormCard extends StatelessWidget {
  final RegisterController controller;
  const _FormCard({required this.controller});

  static const _indigo = Color(0xFF3949AB);
  static const _teal = Color(0xFF009688);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.06), blurRadius: 20, offset: const Offset(0, 4))],
      ),
      padding: EdgeInsets.all(20.r),
      child: Form(
        key: controller.formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _SectionLabel(label: 'معلومات العيادة', icon: Icons.business_rounded, color: _teal),
            12.verticalSpace,
            _AuthField(
              controller: controller.nameController,
              label: tr(LocaleKeys.register_fields_clinic_name_hint),
              icon: Icons.local_hospital_outlined,
              validator: controller.validateRequired,
            ),
            14.verticalSpace,
            _AuthField(
              controller: controller.licenseController,
              label: tr(LocaleKeys.register_fields_license_hint),
              icon: Icons.badge_outlined,
              validator: controller.validateRequired,
            ),
            22.verticalSpace,
            _SectionLabel(label: 'كلمة المرور', icon: Icons.lock_rounded, color: _indigo),
            12.verticalSpace,
            Obx(() => _AuthField(
              controller: controller.passwordController,
              label: tr(LocaleKeys.register_fields_password),
              icon: Icons.lock_outline,
              isPassword: controller.isPassHidden.value,
              validator: controller.validateRequired,
            )),
            14.verticalSpace,
            Obx(() => _AuthField(
              controller: controller.confirmPasswordController,
              label: tr(LocaleKeys.register_fields_confirm_password),
              icon: Icons.lock_reset_outlined,
              isPassword: controller.isConfirmPassHidden.value,
              validator: controller.validateConfirmPassword,
              inputAction: TextInputAction.done,
            )),
          ],
        ),
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color color;
  const _SectionLabel({required this.label, required this.icon, required this.color});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 3.5.w,
          height: 16.h,
          decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(4.r)),
        ),
        8.horizontalSpace,
        Icon(icon, color: color, size: 16.r),
        6.horizontalSpace,
        Text(label, style: TextStyle(fontWeight: FontWeight.w800, fontSize: 13.sp, color: color)),
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
  final TextInputType? keyboardType;

  const _AuthField({
    required this.controller,
    required this.label,
    required this.icon,
    this.isPassword = false,
    this.inputAction = TextInputAction.next,
    this.validator,
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

class _GradientAuthButton extends StatelessWidget {
  final String label;
  final bool isLoading;
  final VoidCallback onTap;
  const _GradientAuthButton({required this.label, required this.isLoading, required this.onTap});

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
                  colors: [Color(0xFF3949AB), Color(0xFF1A237E)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
          color: isLoading ? Colors.grey.shade300 : null,
          borderRadius: BorderRadius.circular(14.r),
          boxShadow: isLoading
              ? []
              : [
                  BoxShadow(
                    color: const Color(0xFF3949AB).withValues(alpha: 0.38),
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
