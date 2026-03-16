import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../app/core/constants/app_assets.dart';

/// Single onboarding slide: illustration + title + description.
class OnboardingPage extends StatelessWidget {
  final int index;
  const OnboardingPage({super.key, required this.index});

  static const _illustrations = [
    AppAssets.onboardingAppointments,
    AppAssets.onboardingTeam,
    AppAssets.onboardingReports,
  ];

  static const _fallbackIcons = [
    Icons.calendar_month_rounded,
    Icons.people_rounded,
    Icons.bar_chart_rounded,
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 5,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 32.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _PageIllustration(
                  asset: _illustrations[index],
                  fallbackIcon: _fallbackIcons[index],
                ),
                24.verticalSpace,
                Text(
                  tr('onboarding.titles.$index'),
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
                  tr('onboarding.descriptions.$index'),
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
        const Expanded(flex: 2, child: SizedBox.shrink()),
      ],
    );
  }
}

// ── Private ───────────────────────────────────────────────────────────────────

class _PageIllustration extends StatelessWidget {
  final String asset;
  final IconData fallbackIcon;
  const _PageIllustration({required this.asset, required this.fallbackIcon});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200.r,
      height: 200.r,
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.15),
        shape: BoxShape.circle,
      ),
      child: ClipOval(
        child: Image.asset(
          asset,
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) => Icon(
            fallbackIcon,
            size: 90.r,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
