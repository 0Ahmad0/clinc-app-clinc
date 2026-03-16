import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.find<SplashController>();
    return const Scaffold(body: _SplashBody());
  }
}

class _SplashBody extends StatefulWidget {
  const _SplashBody();
  @override
  State<_SplashBody> createState() => _SplashBodyState();
}

class _SplashBodyState extends State<_SplashBody> with TickerProviderStateMixin {
  late AnimationController _heroCtrl;
  late AnimationController _dotsCtrl;
  late Animation<double> _logoScale;
  late Animation<double> _logoOpacity;
  late Animation<double> _textSlide;
  late Animation<double> _textOpacity;
  late Animation<double> _taglineOpacity;

  static const _teal = Color(0xFF009688);
  static const _darkTeal = Color(0xFF004D40);
  static const _midTeal = Color(0xFF00695C);

  @override
  void initState() {
    super.initState();
    _heroCtrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 1200));
    _dotsCtrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 900))..repeat();

    _logoScale = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 0.0, end: 1.2), weight: 65),
      TweenSequenceItem(tween: Tween(begin: 1.2, end: 1.0), weight: 35),
    ]).animate(CurvedAnimation(parent: _heroCtrl, curve: Curves.easeOutBack));

    _logoOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _heroCtrl, curve: const Interval(0.0, 0.45, curve: Curves.easeIn)),
    );
    _textSlide = Tween<double>(begin: 30, end: 0).animate(
      CurvedAnimation(parent: _heroCtrl, curve: const Interval(0.4, 0.8, curve: Curves.easeOutCubic)),
    );
    _textOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _heroCtrl, curve: const Interval(0.4, 0.8, curve: Curves.easeIn)),
    );
    _taglineOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _heroCtrl, curve: const Interval(0.65, 1.0, curve: Curves.easeIn)),
    );

    Future.delayed(const Duration(milliseconds: 250), () {
      if (mounted) _heroCtrl.forward();
    });
  }

  @override
  void dispose() {
    _heroCtrl.dispose();
    _dotsCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [_darkTeal, _midTeal, Color(0xFF00838F)],
          stops: [0.0, 0.55, 1.0],
        ),
      ),
      child: Stack(
        children: [
          CustomPaint(size: size, painter: _SplashBgPainter()),
          SafeArea(
            child: Column(
              children: [
                const Spacer(flex: 2),
                AnimatedBuilder(
                  animation: _heroCtrl,
                  builder: (_, __) => FadeTransition(
                    opacity: _logoOpacity,
                    child: ScaleTransition(scale: _logoScale, child: _buildLogoCircle()),
                  ),
                ),
                30.verticalSpace,
                AnimatedBuilder(
                  animation: _heroCtrl,
                  builder: (_, __) => Transform.translate(
                    offset: Offset(0, _textSlide.value),
                    child: FadeTransition(
                      opacity: _textOpacity,
                      child: Text(
                        'ClinicPro',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 36.sp,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 0.8,
                        ),
                      ),
                    ),
                  ),
                ),
                10.verticalSpace,
                AnimatedBuilder(
                  animation: _heroCtrl,
                  builder: (_, __) => FadeTransition(
                    opacity: _taglineOpacity,
                    child: Text(
                      'نظام إدارة العيادات الذكي',
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.78),
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        letterSpacing: 0.4,
                      ),
                    ),
                  ),
                ),
                const Spacer(flex: 2),
                _AnimatedDots(controller: _dotsCtrl),
                18.verticalSpace,
                Opacity(
                  opacity: 0.45,
                  child: Text(
                    '© 2025 ClinicPro. جميع الحقوق محفوظة',
                    style: TextStyle(color: Colors.white, fontSize: 10.sp, letterSpacing: 0.5),
                  ),
                ),
                24.verticalSpace,
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLogoCircle() {
    return Container(
      width: 130.r,
      height: 130.r,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.2), blurRadius: 40, offset: const Offset(0, 14)),
          BoxShadow(color: Colors.white.withValues(alpha: 0.1), blurRadius: 20, spreadRadius: 6),
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
                color: const Color(0xFF009688).withValues(alpha: 0.08),
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

class _AnimatedDots extends StatelessWidget {
  final AnimationController controller;
  const _AnimatedDots({required this.controller});

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

class _SplashBgPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final p = Paint()..style = PaintingStyle.fill;
    p.color = Colors.white.withValues(alpha: 0.04);
    canvas.drawCircle(Offset(size.width * 0.87, size.height * 0.09), 105, p);
    canvas.drawCircle(Offset(size.width * 0.07, size.height * 0.22), 62, p);
    p.color = Colors.white.withValues(alpha: 0.025);
    canvas.drawCircle(Offset(size.width * 0.5, size.height * 0.87), 145, p);
    canvas.drawCircle(Offset(size.width * 0.14, size.height * 0.76), 85, p);
    p.color = const Color(0xFF4DB6AC).withValues(alpha: 0.07);
    canvas.drawCircle(Offset(size.width * 0.92, size.height * 0.62), 52, p);
    p.color = Colors.white.withValues(alpha: 0.03);
    canvas.drawCircle(Offset(size.width * 0.7, size.height * 0.35), 38, p);
  }

  @override
  bool shouldRepaint(covariant CustomPainter old) => false;
}
