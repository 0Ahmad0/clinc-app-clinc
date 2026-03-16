import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'splash_brand_section.dart';
import 'splash_footer.dart';
import 'splash_loading_dots.dart';
import 'splash_logo_circle.dart';

class SplashBody extends StatefulWidget {
  const SplashBody({super.key});

  @override
  State<SplashBody> createState() => _SplashBodyState();
}

class _SplashBodyState extends State<SplashBody> with TickerProviderStateMixin {
  static const _darkTeal = Color(0xFF004D40);
  static const _midTeal = Color(0xFF00695C);

  static const _kGradient = BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [_darkTeal, _midTeal, Color(0xFF00838F)],
      stops: [0.0, 0.55, 1.0],
    ),
  );

  late final AnimationController _heroCtrl;
  late final AnimationController _dotsCtrl;
  late final Animation<double> _logoScale;
  late final Animation<double> _logoOpacity;
  late final Animation<double> _textSlide;
  late final Animation<double> _textOpacity;
  late final Animation<double> _taglineOpacity;

  @override
  void initState() {
    super.initState();
    _heroCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
    _dotsCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..repeat();

    _logoScale = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 0.0, end: 1.2), weight: 65),
      TweenSequenceItem(tween: Tween(begin: 1.2, end: 1.0), weight: 35),
    ]).animate(CurvedAnimation(parent: _heroCtrl, curve: Curves.easeOutBack));

    _logoOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _heroCtrl,
        curve: const Interval(0.0, 0.45, curve: Curves.easeIn),
      ),
    );
    _textSlide = Tween<double>(begin: 30, end: 0).animate(
      CurvedAnimation(
        parent: _heroCtrl,
        curve: const Interval(0.4, 0.8, curve: Curves.easeOutCubic),
      ),
    );
    _textOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _heroCtrl,
        curve: const Interval(0.4, 0.8, curve: Curves.easeIn),
      ),
    );
    _taglineOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _heroCtrl,
        curve: const Interval(0.65, 1.0, curve: Curves.easeIn),
      ),
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
      decoration: _kGradient,
      child: Stack(
        children: [
          CustomPaint(size: size, painter: const _SplashBgPainter()),
          SafeArea(
            child: Column(
              children: [
                const Spacer(flex: 2),
                FadeTransition(
                  opacity: _logoOpacity,
                  child: ScaleTransition(
                    scale: _logoScale,
                    child: const SplashLogoCircle(),
                  ),
                ),
                30.verticalSpace,
                AnimatedBuilder(
                  animation: _heroCtrl,
                  builder: (_, __) => FadeTransition(
                    opacity: _textOpacity,
                    child: Transform.translate(
                      offset: Offset(0, _textSlide.value),
                      child: const SplashBrandName(),
                    ),
                  ),
                ),
                10.verticalSpace,
                FadeTransition(
                  opacity: _taglineOpacity,
                  child: const SplashTagline(),
                ),
                const Spacer(flex: 2),
                SplashLoadingDots(controller: _dotsCtrl),
                18.verticalSpace,
                const SplashFooter(),
                24.verticalSpace,
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SplashBgPainter extends CustomPainter {
  const _SplashBgPainter();

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
