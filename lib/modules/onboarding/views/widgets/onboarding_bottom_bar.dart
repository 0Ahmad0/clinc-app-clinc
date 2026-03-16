import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../generated/locale_keys.g.dart';
import '../../controllers/onboarding_controller.dart';

/// White card at the bottom: animated dot indicators + next/get-started CTA.
class OnboardingBottomBar extends GetView<OnboardingController> {
  const OnboardingBottomBar({super.key});

  static const _teal    = Color(0xFF009688);
  static const _darkTeal = Color(0xFF004D40);

  @override
  Widget build(BuildContext context) {
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
      child: Obx(() => Row(
        children: [
          _DotsIndicator(current: controller.currentIndex.value),
          const Spacer(),
          _CtaButton(
            isLast: controller.isLast,
            onTap: controller.isLast ? controller.getStarted : controller.next,
          ),
        ],
      )),
    );
  }
}

// ── Private ───────────────────────────────────────────────────────────────────

class _DotsIndicator extends StatelessWidget {
  final int current;
  const _DotsIndicator({required this.current});

  static const _activeTeal = Color(0xFF009688);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(OnboardingController.pagesCount, (i) {
        final active = i == current;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 280),
          curve: Curves.easeOutCubic,
          margin: EdgeInsets.only(right: 6.w),
          height: 8.h,
          width: active ? 24.w : 8.w,
          decoration: BoxDecoration(
            color: active ? _activeTeal : Colors.grey.shade200,
            borderRadius: BorderRadius.circular(99),
          ),
        );
      }),
    );
  }
}

class _CtaButton extends StatelessWidget {
  final bool isLast;
  final VoidCallback onTap;
  const _CtaButton({required this.isLast, required this.onTap});

  static const _teal     = Color(0xFF009688);
  static const _darkTeal = Color(0xFF004D40);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 14.h),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [_teal, _darkTeal],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(14.r),
          boxShadow: [
            BoxShadow(
              color: _teal.withValues(alpha: 0.4),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              isLast
                  ? tr(LocaleKeys.onboarding_get_started)
                  : tr(LocaleKeys.onboarding_next),
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
    );
  }
}
