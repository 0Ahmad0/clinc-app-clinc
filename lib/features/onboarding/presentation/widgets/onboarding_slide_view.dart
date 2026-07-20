import 'package:flutter/material.dart';

import '../../../../config/theme/app_spacing.dart';
import '../../../../shared/extensions/context_extensions.dart';
import '../../domain/onboarding_slide.dart';
import 'onboarding_illustration.dart';

/// One onboarding slide: illustration on top, text block below.
class OnboardingSlideView extends StatelessWidget {
  const OnboardingSlideView({super.key, required this.slide});

  final OnboardingSlide slide;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(
        AppSpacing.lg,
        AppSpacing.lg,
        AppSpacing.lg,
        0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          OnboardingIllustration(slide: slide),
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(
              AppSpacing.xxs,
              AppSpacing.xl,
              AppSpacing.xxs,
              0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 22,
                      height: 3,
                      decoration: BoxDecoration(
                        color: context.colors.primary600,
                        borderRadius: BorderRadius.circular(AppRadius.sm),
                      ),
                    ),
                    const SizedBox(width: AppSpacing.xs),
                    Text(
                      slide.kicker,
                      style: context.textTheme.bodySmall?.copyWith(
                        color: context.colors.primary600,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.4,
                        height: 1,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.sm),
                Text(
                  slide.title,
                  style: context.textTheme.headlineMedium?.copyWith(
                    fontSize: 30,
                    height: 1.3,
                  ),
                ),
                const SizedBox(height: AppSpacing.sm),
                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 320),
                  child: Text(
                    slide.description,
                    style: context.textTheme.bodyMedium?.copyWith(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      height: 1.8,
                      color: context.colors.paragraph,
                    ),
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
