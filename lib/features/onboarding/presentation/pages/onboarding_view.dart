import 'package:flutter/material.dart';

import '../../../../config/theme/app_spacing.dart';
import '../widgets/onboarding_background_glow.dart';
import '../widgets/onboarding_dots.dart';
import '../widgets/onboarding_header.dart';
import '../widgets/onboarding_next_button.dart';
import '../widgets/onboarding_slides.dart';

/// Onboarding layout: header, animated slides, then dots + primary CTA.
class OnboardingView extends StatelessWidget {
  const OnboardingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const OnboardingBackgroundGlow(),
          SafeArea(
            bottom: false,
            child: Column(
              children: [
                const OnboardingHeader(),
                const Expanded(child: OnboardingSlides()),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(
                    AppSpacing.lg,
                    0,
                    AppSpacing.lg,
                    AppSpacing.xl,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: const [
                      OnboardingDots(),
                      SizedBox(height: AppSpacing.md),
                      OnboardingNextButton(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
