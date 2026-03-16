import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SplashLogoCircle extends StatelessWidget {
  const SplashLogoCircle({super.key});

  static const _teal = Color(0xFF009688);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 130.r,
      height: 130.r,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2),
            blurRadius: 40,
            offset: const Offset(0, 14),
          ),
          BoxShadow(
            color: Colors.white.withValues(alpha: 0.1),
            blurRadius: 20,
            spreadRadius: 6,
          ),
        ],
      ),
      child: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: 100.r,
              height: 100.r,
              decoration: BoxDecoration(
                color: _teal.withValues(alpha: 0.08),
                shape: BoxShape.circle,
              ),
            ),
            Icon(Icons.local_hospital_rounded, size: 62.r, color: _teal),
          ],
        ),
      ),
    );
  }
}
