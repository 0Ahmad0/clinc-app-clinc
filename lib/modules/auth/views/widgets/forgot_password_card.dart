import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../../app/core/design/app_gradients.dart';
import '../../../../app/core/widgets/app_gradient_button.dart';
import '../../../../app/core/widgets/app_auth_field.dart';
import '../../../../generated/locale_keys.g.dart';
import '../../controllers/forgot_password_controller.dart';

const _kOrange = Color(0xFFF59E0B);
const _kDarkOrange = Color(0xFFB45309);

class ForgotPasswordCard extends StatelessWidget {
  final ForgotPasswordController controller;
  const ForgotPasswordCard({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
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
          const _InfoBanner(),
          20.verticalSpace,
          Form(
            key: controller.formKey,
            child: AppAuthField(
              controller: controller.identifierController,
              label: tr(LocaleKeys.forgot_password_fields_identifier_hint),
              icon: Icons.email_outlined,
              accentColor: _kOrange,
              keyboardType: TextInputType.emailAddress,
              inputAction: TextInputAction.done,
              onSubmitted: (_) => controller.sendResetLink(),
              validator: controller.validateRequired,
            ),
          ),
          24.verticalSpace,
          Obx(() => AppGradientButton(
            label: tr(LocaleKeys.forgot_password_buttons_submit),
            isLoading: controller.isLoading.value,
            onTap: controller.sendResetLink,
            gradient: AppGradients.amber,
            shadowColor: AppGradients.amberShadow,
          )),
        ],
      ),
    );
  }
}

class _InfoBanner extends StatelessWidget {
  const _InfoBanner();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(14.r),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            _kOrange.withValues(alpha: 0.12),
            _kOrange.withValues(alpha: 0.04),
          ],
        ),
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: _kOrange.withValues(alpha: 0.2)),
      ),
      child: Row(
        children: [
          Icon(Icons.info_outline_rounded, color: _kOrange, size: 18.r),
          10.horizontalSpace,
          Expanded(
            child: Text(
              'سنرسل لك رابط إعادة تعيين كلمة المرور على بريدك الإلكتروني أو رقم هاتفك',
              style: TextStyle(
                color: _kDarkOrange,
                fontSize: 11.sp,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
