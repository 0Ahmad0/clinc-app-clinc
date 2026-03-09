import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../controllers/welcome_controller.dart';
import '../../../app/routes/app_routes.dart';

class WelcomeView extends GetView<WelcomeController> {
  const WelcomeView({super.key});

  static const _teal = Color(0xFF009688);
  static const _darkTeal = Color(0xFF004D40);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [_darkTeal, Color(0xFF00695C), Color(0xFF00838F)],
              ),
            ),
          ),
          CustomPaint(
            size: MediaQuery.of(context).size,
            painter: _WelcomeBgPainter(),
          ),
          SafeArea(
            child: Column(
              children: [
                const Spacer(flex: 2),
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
                const Spacer(flex: 2),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 28.w),
                  child: Column(
                    children: [
                      _GradientButton(
                        label: 'تسجيل الدخول',
                        icon: Icons.login_rounded,
                        colors: [Colors.white, Colors.white.withValues(alpha: 0.9)],
                        textColor: _teal,
                        onTap: () => Get.toNamed(AppRoutes.login),
                      ),
                      16.verticalSpace,
                      GestureDetector(
                        onTap: () => Get.toNamed(AppRoutes.register),
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(vertical: 16.h),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.white.withValues(alpha: 0.6), width: 1.5),
                            borderRadius: BorderRadius.circular(16.r),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.app_registration_rounded, color: Colors.white, size: 20.r),
                              10.horizontalSpace,
                              Text(
                                'إنشاء حساب جديد',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                32.verticalSpace,
                Opacity(
                  opacity: 0.45,
                  child: Text(
                    '© 2025 ClinicPro. جميع الحقوق محفوظة',
                    style: TextStyle(color: Colors.white, fontSize: 10.sp),
                  ),
                ),
                20.verticalSpace,
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _GradientButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final List<Color> colors;
  final Color textColor;
  final VoidCallback onTap;
  const _GradientButton({
    required this.label,
    required this.icon,
    required this.colors,
    required this.textColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 16.h),
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: colors),
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.15),
              blurRadius: 16,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: textColor, size: 20.r),
            10.horizontalSpace,
            Text(
              label,
              style: TextStyle(
                color: textColor,
                fontSize: 15.sp,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _WelcomeBgPainter extends CustomPainter {
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
