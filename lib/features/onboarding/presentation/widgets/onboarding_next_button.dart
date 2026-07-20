import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../config/routes/app_routes.dart';
import '../../../../config/theme/app_shadows.dart';
import '../../../../config/theme/app_spacing.dart';
import '../../../../shared/extensions/context_extensions.dart';
import '../cubit/onboarding_cubit.dart';
import '../cubit/onboarding_state.dart';

/// The onboarding primary action: advances slides, or finishes on the last one.
class OnboardingNextButton extends StatelessWidget {
  const OnboardingNextButton({super.key});

  @override
  Widget build(BuildContext context) {
    final isRtl = Directionality.of(context) == TextDirection.rtl;

    return BlocBuilder<OnboardingCubit, OnboardingState>(
      builder: (context, state) {
        final cubit = context.read<OnboardingCubit>();
        final label = cubit.isLastSlide
            ? context.l10n.onboardingStart
            : context.l10n.onboardingNext;

        return DecoratedBox(
          decoration: BoxDecoration(
            gradient: context.colors.ctaGradient,
            borderRadius: BorderRadius.circular(AppRadius.button),
            boxShadow: AppShadows.primaryButton,
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(AppRadius.button),
              onTap: () {
                if (cubit.isLastSlide) {
                  context.go(AppRoutes.auth);
                } else {
                  cubit.next();
                }
              },
              child: SizedBox(
                height: AppSizes.buttonHeight,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      label,
                      style: context.textTheme.titleMedium?.copyWith(
                        fontSize: 16.5,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(width: AppSpacing.xs),
                    Transform.flip(
                      flipX: isRtl,
                      child: Text(
                        '→',
                        style: context.textTheme.titleLarge?.copyWith(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
