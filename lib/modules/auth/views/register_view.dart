import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../app/core/design/app_gradients.dart';
import '../../../app/core/widgets/app_gradient_button.dart';
import '../../../app/core/widgets/app_auth_field.dart';
import '../../../app/core/widgets/app_gradient_header.dart';
import '../../../generated/locale_keys.g.dart';
import '../controllers/register_controller.dart';
import '../../../app/data/account_type.dart';

class RegisterView extends GetView<RegisterController> {
  const RegisterView({super.key});

  static const _teal = Color(0xFF009688);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      body: Column(
        children: [
          AppGradientHeader(
            gradient: AppGradients.indigo,
            icon: Icons.app_registration_rounded,
            iconCircleSize: 72,
            iconSize: 36,
            title: tr(LocaleKeys.register_title),
            subtitle: tr(LocaleKeys.register_subtitle),
            leading: const AppHeaderBackButton(),
          ),
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
                  Obx(() => AppGradientButton(
                    label: tr(LocaleKeys.register_buttons_submit),
                    isLoading: controller.isLoading.value,
                    onTap: controller.register,
                    gradient: AppGradients.indigo,
                    shadowColor: AppGradients.indigoShadow,
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
                        onTap: () => Get.back(),
                        child: Text(
                          tr(LocaleKeys.register_buttons_login_action),
                          style: TextStyle(
                            color: _teal,
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w800,
                          ),
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
}

// ─── Account Type Selector ────────────────────────────────────────────────────

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
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
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
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 14.sp,
                  color: Colors.grey.shade800,
                ),
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
              child: Icon(
                icon,
                color: selected ? color : Colors.grey.shade400,
                size: 22.r,
              ),
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

// ─── Form Card ────────────────────────────────────────────────────────────────

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
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: EdgeInsets.all(20.r),
      child: Form(
        key: controller.formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _SectionLabel(label: 'معلومات العيادة', icon: Icons.business_rounded, color: _teal),
            12.verticalSpace,
            AppAuthField(
              controller: controller.nameController,
              label: tr(LocaleKeys.register_fields_clinic_name_hint),
              icon: Icons.local_hospital_outlined,
              validator: controller.validateRequired,
            ),
            14.verticalSpace,
            AppAuthField(
              controller: controller.licenseController,
              label: tr(LocaleKeys.register_fields_license_hint),
              icon: Icons.badge_outlined,
              validator: controller.validateRequired,
            ),
            22.verticalSpace,
            _SectionLabel(label: 'كلمة المرور', icon: Icons.lock_rounded, color: _indigo),
            12.verticalSpace,
            AppAuthField(
              controller: controller.passwordController,
              label: tr(LocaleKeys.register_fields_password),
              icon: Icons.lock_outline,
              isPassword: true,
              accentColor: _indigo,
              validator: controller.validateRequired,
            ),
            14.verticalSpace,
            AppAuthField(
              controller: controller.confirmPasswordController,
              label: tr(LocaleKeys.register_fields_confirm_password),
              icon: Icons.lock_reset_outlined,
              isPassword: true,
              accentColor: _indigo,
              validator: controller.validateConfirmPassword,
              inputAction: TextInputAction.done,
            ),
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

  const _SectionLabel({
    required this.label,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 3.5.w,
          height: 16.h,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(4.r),
          ),
        ),
        8.horizontalSpace,
        Icon(icon, color: color, size: 16.r),
        6.horizontalSpace,
        Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.w800,
            fontSize: 13.sp,
            color: color,
          ),
        ),
      ],
    );
  }
}
