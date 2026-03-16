import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'widgets/onboarding_background.dart';
import 'widgets/onboarding_bottom_bar.dart';
import 'widgets/onboarding_page_view.dart';
import 'widgets/onboarding_skip_btn.dart';

/// Root shell — pure layout, zero logic.
class OnboardingView extends StatelessWidget {
  const OnboardingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        fit: StackFit.expand,
        children: [
          const OnboardingBackground(),
          SafeArea(
            child: Column(
              children: [
                const OnboardingSkipBtn(),
                const Expanded(child: OnboardingPageView()),
                const OnboardingBottomBar(),
                SizedBox(height: 32.h),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
