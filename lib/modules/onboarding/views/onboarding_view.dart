import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:clinc_app_clinc/generated/locale_keys.g.dart';
import '../controllers/onboarding_controller.dart';
import '../../../app/core/constants/app_assets.dart';

class OnboardingView extends GetView<OnboardingController> {
  const OnboardingView({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Obx(() => AnimatedContainer(
            duration: const Duration(milliseconds: 400),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomCenter,
                colors: _pageGradient(controller.currentIndex.value),
                stops: const [0.0, 0.55, 1.0],
              ),
            ),
          )),
          SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
                  child: Align(
                    alignment: AlignmentDirectional.centerEnd,
                    child: Obx(() => AnimatedOpacity(
                      duration: const Duration(milliseconds: 200),
                      opacity: controller.isLast ? 0.0 : 1.0,
                      child: TextButton(
                        onPressed: controller.skip,
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.white.withValues(alpha: 0.85),
                          padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 6.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.r),
                            side: BorderSide(color: Colors.white.withValues(alpha: 0.4)),
                          ),
                        ),
                        child: Text(
                          tr(LocaleKeys.onboarding_skip),
                          style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w600),
                        ),
                      ),
                    )),
                  ),
                ),
                Expanded(
                  child: PageView.builder(
                    controller: controller.pageController,
                    itemCount: OnboardingController.pagesCount,
                    onPageChanged: controller.onPageChanged,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (_, i) => _OnboardingPage(index: i),
                  ),
                ),
                _BottomSection(controller: controller),
                32.verticalSpace,
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<Color> _pageGradient(int index) {
    switch (index) {
      case 0:
        return [const Color(0xFF006064), const Color(0xFF00838F), const Color(0xFFE0F7FA)];
      case 1:
        return [const Color(0xFF1A237E), const Color(0xFF3949AB), const Color(0xFFE8EAF6)];
      case 2:
      default:
        return [const Color(0xFF004D40), const Color(0xFF00695C), const Color(0xFFE0F2F1)];
    }
  }
}

class _OnboardingPage extends StatelessWidget {
  final int index;
  const _OnboardingPage({required this.index});

  static const _illustrations = [
    AppAssets.onboardingAppointments,
    AppAssets.onboardingTeam,
    AppAssets.onboardingReports,
  ];

  static const _icons = [
    Icons.calendar_month_rounded,
    Icons.people_rounded,
    Icons.bar_chart_rounded,
  ];

  @override
  Widget build(BuildContext context) {
    final title = tr('onboarding.titles.$index');
    final desc = tr('onboarding.descriptions.$index');

    return Column(
      children: [
        Expanded(
          flex: 5,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 32.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 200.r,
                  height: 200.r,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.15),
                    shape: BoxShape.circle,
                  ),
                  child: ClipOval(
                    child: Image.asset(
                      _illustrations[index],
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Icon(
                        _icons[index],
                        size: 90.r,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                24.verticalSpace,
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22.sp,
                    fontWeight: FontWeight.w900,
                    height: 1.25,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                ),
                12.verticalSpace,
                Text(
                  desc,
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.82),
                    fontSize: 14.sp,
                    height: 1.65,
                    fontWeight: FontWeight.w400,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 4,
                ),
              ],
            ),
          ),
        ),
        Expanded(flex: 2, child: SizedBox.shrink()),
      ],
    );
  }
}

class _BottomSection extends StatelessWidget {
  final OnboardingController controller;
  const _BottomSection({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final idx = controller.currentIndex.value;
      final isLast = controller.isLast;
      return Container(
        margin: EdgeInsets.symmetric(horizontal: 24.w),
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 24,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: Row(
          children: [
            Row(
              children: List.generate(OnboardingController.pagesCount, (i) {
                final active = i == idx;
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 280),
                  curve: Curves.easeOutCubic,
                  margin: EdgeInsets.only(right: 6.w),
                  height: 8.h,
                  width: active ? 24.w : 8.w,
                  decoration: BoxDecoration(
                    color: active ? const Color(0xFF009688) : Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(99),
                  ),
                );
              }),
            ),
            const Spacer(),
            GestureDetector(
              onTap: isLast ? controller.getStarted : controller.next,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 14.h),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF009688), Color(0xFF004D40)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(14.r),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF009688).withValues(alpha: 0.4),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      isLast ? tr(LocaleKeys.onboarding_get_started) : tr(LocaleKeys.onboarding_next),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    if (!isLast) ...[
                      6.horizontalSpace,
                      Icon(Icons.arrow_forward_rounded, color: Colors.white, size: 18.r),
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
