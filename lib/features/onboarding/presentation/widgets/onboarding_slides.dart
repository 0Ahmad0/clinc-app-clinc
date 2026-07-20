import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/theme/app_motion.dart';
import '../../../../shared/extensions/context_extensions.dart';
import '../../domain/onboarding_slide.dart';
import '../cubit/onboarding_cubit.dart';
import '../cubit/onboarding_state.dart';
import 'onboarding_slide_view.dart';

/// Cross-fading stack of onboarding slides, driven by [OnboardingCubit].
class OnboardingSlides extends StatelessWidget {
  const OnboardingSlides({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final slides = <OnboardingSlide>[
      OnboardingSlide(
        asset: 'assets/images/ob_1.svg',
        chipIcon: '📅',
        kicker: l10n.onb1Kicker,
        title: l10n.onb1Title,
        description: l10n.onb1Desc,
        chipTitle: l10n.onb1ChipTitle,
        chipSubtitle: l10n.onb1ChipSub,
      ),
      OnboardingSlide(
        asset: 'assets/images/ob_2.svg',
        chipIcon: '⚡',
        kicker: l10n.onb2Kicker,
        title: l10n.onb2Title,
        description: l10n.onb2Desc,
        chipTitle: l10n.onb2ChipTitle,
        chipSubtitle: l10n.onb2ChipSub,
      ),
      OnboardingSlide(
        asset: 'assets/images/ob_3.svg',
        chipIcon: '🔒',
        kicker: l10n.onb3Kicker,
        title: l10n.onb3Title,
        description: l10n.onb3Desc,
        chipTitle: l10n.onb3ChipTitle,
        chipSubtitle: l10n.onb3ChipSub,
      ),
    ];

    final sign = Directionality.of(context) == TextDirection.rtl ? 1.0 : -1.0;

    return BlocBuilder<OnboardingCubit, OnboardingState>(
      builder: (context, state) {
        return Stack(
          fit: StackFit.expand,
          children: [
            for (var i = 0; i < slides.length; i++)
              IgnorePointer(
                ignoring: i != state.index,
                child: AnimatedSlide(
                  offset: Offset((i - state.index) * sign * 0.12, 0),
                  duration: AppMotion.slide,
                  curve: AppMotion.emphasized,
                  child: AnimatedOpacity(
                    opacity: i == state.index ? 1 : 0,
                    duration: AppMotion.fade,
                    child: OnboardingSlideView(slide: slides[i]),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
