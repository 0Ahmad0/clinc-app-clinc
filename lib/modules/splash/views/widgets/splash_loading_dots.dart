import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SplashLoadingDots extends StatelessWidget {
  final AnimationController controller;
  const SplashLoadingDots({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (_, __) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(3, (i) {
          final phase = (controller.value - i * 0.28).clamp(0.0, 1.0);
          final scale = 0.55 + 0.45 * math.sin(phase * math.pi);
          final alpha = 0.35 + 0.65 * scale;
          return AnimatedContainer(
            duration: Duration.zero,
            margin: EdgeInsets.symmetric(horizontal: 4.w),
            width: 8.r,
            height: 8.r,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: alpha),
              shape: BoxShape.circle,
            ),
            transform: Matrix4.identity()
              ..translate(4.0, 4.0)
              ..scale(scale)
              ..translate(-4.0, -4.0),
          );
        }),
      ),
    );
  }
}
