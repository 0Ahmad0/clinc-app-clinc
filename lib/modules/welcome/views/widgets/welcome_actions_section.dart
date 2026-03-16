import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../app/routes/app_routes.dart';
import '../../../../app/core/widgets/app_gradient_button.dart';

class WelcomeActionsSection extends StatelessWidget {
  const WelcomeActionsSection({super.key});

  static const _teal = Color(0xFF009688);

  static const _kLoginGradient = LinearGradient(
    colors: [Colors.white, Color(0xFFE8F5E9)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 28.w),
      child: Column(
        children: [
          AppGradientButton(
            label: 'تسجيل الدخول',
            gradient: _kLoginGradient,
            shadowColor: Colors.black26,
            textColor: _teal,
            prefixIcon: Icon(Icons.login_rounded, color: _teal, size: 20.r),
            onTap: () => Get.toNamed(AppRoutes.login),
          ),
          16.verticalSpace,
          AppOutlineGradientButton(
            label: 'إنشاء حساب جديد',
            borderColor: Colors.white.withValues(alpha: 0.6),
            textColor: Colors.white,
            prefixIcon: Icon(
              Icons.app_registration_rounded,
              color: Colors.white,
              size: 20.r,
            ),
            onTap: () => Get.toNamed(AppRoutes.register),
          ),
        ],
      ),
    );
  }
}
