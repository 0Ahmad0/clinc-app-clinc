import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/theme/app_motion.dart';
import '../../../../config/theme/app_spacing.dart';
import '../../../../shared/extensions/context_extensions.dart';
import '../cubit/onboarding_cubit.dart';
import '../cubit/onboarding_state.dart';

/// Page indicator: the active dot stretches into a pill; tapping a dot jumps.
class OnboardingDots extends StatelessWidget {
  const OnboardingDots({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnboardingCubit, OnboardingState>(
      builder: (context, state) {
        return Row(
          children: [
            for (var i = 0; i < OnboardingCubit.slideCount; i++)
              Padding(
                padding: const EdgeInsetsDirectional.only(
                  end: AppSpacing.xxs + 2,
                ),
                child: GestureDetector(
                  onTap: () => context.read<OnboardingCubit>().goTo(i),
                  child: AnimatedContainer(
                    duration: AppMotion.quick,
                    curve: AppMotion.emphasized,
                    width: i == state.index
                        ? AppSizes.dotActiveWidth
                        : AppSizes.dotHeight,
                    height: AppSizes.dotHeight,
                    decoration: BoxDecoration(
                      color: i == state.index
                          ? context.colors.primary600
                          : context.colors.primary500.withValues(alpha: 0.18),
                      borderRadius: BorderRadius.circular(AppRadius.pill),
                    ),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
