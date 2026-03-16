import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SplashBrandName extends StatelessWidget {
  const SplashBrandName({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      'ClinicPro',
      style: TextStyle(
        color: Colors.white,
        fontSize: 36.sp,
        fontWeight: FontWeight.w900,
        letterSpacing: 0.8,
      ),
    );
  }
}

class SplashTagline extends StatelessWidget {
  const SplashTagline({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      'نظام إدارة العيادات الذكي',
      style: TextStyle(
        color: Colors.white.withValues(alpha: 0.78),
        fontSize: 14.sp,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.4,
      ),
    );
  }
}
