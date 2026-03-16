import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SplashFooter extends StatelessWidget {
  const SplashFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: 0.45,
      child: Text(
        '© 2025 ClinicPro. جميع الحقوق محفوظة',
        style: TextStyle(
          color: Colors.white,
          fontSize: 10.sp,
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}
