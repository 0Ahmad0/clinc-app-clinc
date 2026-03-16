import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../controllers/welcome_controller.dart';
import '../../../app/core/widgets/app_copyright_footer.dart';
import 'widgets/welcome_actions_section.dart';
import 'widgets/welcome_hero_section.dart';

class WelcomeView extends GetView<WelcomeController> {
  const WelcomeView({super.key});

  static const _kBg = BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [Color(0xFF004D40), Color(0xFF00695C), Color(0xFF00838F)],
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(decoration: _kBg),
          CustomPaint(
            size: MediaQuery.of(context).size,
            painter: const _WelcomeBgPainter(),
          ),
          SafeArea(
            child: Column(
              children: [
                const Spacer(flex: 2),
                const WelcomeHeroSection(),
                const Spacer(flex: 2),
                const WelcomeActionsSection(),
                32.verticalSpace,
                const AppCopyrightFooter(),
                20.verticalSpace,
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _WelcomeBgPainter extends CustomPainter {
  const _WelcomeBgPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final p = Paint()..style = PaintingStyle.fill;
    p.color = Colors.white.withValues(alpha: 0.04);
    canvas.drawCircle(Offset(size.width * 0.85, size.height * 0.1), 110, p);
    canvas.drawCircle(Offset(size.width * 0.07, size.height * 0.22), 70, p);
    p.color = Colors.white.withValues(alpha: 0.03);
    canvas.drawCircle(Offset(size.width * 0.5, size.height * 0.88), 160, p);
    canvas.drawCircle(Offset(size.width * 0.15, size.height * 0.75), 90, p);
  }

  @override
  bool shouldRepaint(covariant CustomPainter old) => false;
}
