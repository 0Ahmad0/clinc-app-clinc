import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WelcomeHeroSection extends StatelessWidget {
  const WelcomeHeroSection({super.key});

  static const _teal = Color(0xFF009688);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 110.r,
          height: 110.r,
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.18),
                blurRadius: 30,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Icon(Icons.local_hospital_rounded, size: 56.r, color: _teal),
        ),
        30.verticalSpace,
        Text(
          'مرحباً بك في',
          style: TextStyle(
            color: Colors.white.withValues(alpha: 0.8),
            fontSize: 16.sp,
            fontWeight: FontWeight.w400,
          ),
        ),
        8.verticalSpace,
        Text(
          'ClinicPro',
          style: TextStyle(
            color: Colors.white,
            fontSize: 40.sp,
            fontWeight: FontWeight.w900,
            letterSpacing: 1.0,
          ),
        ),
        12.verticalSpace,
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 40.w),
          child: Text(
            'النظام الأكثر تطوراً لإدارة عيادتك بذكاء واحترافية',
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.75),
              fontSize: 13.sp,
              height: 1.6,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
