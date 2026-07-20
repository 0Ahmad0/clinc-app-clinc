import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../config/theme/app_shadows.dart';
import '../../../../config/theme/app_spacing.dart';
import '../../../../shared/extensions/context_extensions.dart';
import '../../domain/onboarding_slide.dart';
import 'onboarding_chip.dart';

/// The hero illustration block: a gradient card with faint rings, a gently
/// floating circular illustration, and a floating info chip.
class OnboardingIllustration extends StatefulWidget {
  const OnboardingIllustration({super.key, required this.slide});

  final OnboardingSlide slide;

  @override
  State<OnboardingIllustration> createState() => _OnboardingIllustrationState();
}

class _OnboardingIllustrationState extends State<OnboardingIllustration>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 5500),
  )..repeat(reverse: true);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppSizes.onboardingArt,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Gradient card with two faint border rings clipped inside it.
          PositionedDirectional(
            top: 10,
            bottom: 10,
            start: 6,
            end: 6,
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: context.colors.illustrationGradient,
                borderRadius: BorderRadius.circular(AppRadius.art),
                boxShadow: AppShadows.elevatedCard,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(AppRadius.art),
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    PositionedDirectional(
                      top: -70,
                      start: -50,
                      child: Container(
                        width: 230,
                        height: 230,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.white.withValues(alpha: 0.14),
                            width: 1.5,
                          ),
                        ),
                      ),
                    ),
                    PositionedDirectional(
                      bottom: -90,
                      end: -60,
                      child: Container(
                        width: 260,
                        height: 260,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.white.withValues(alpha: 0.10),
                            width: 1.5,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Floating circular illustration, centered.
          PositionedDirectional(
            top: 36,
            start: 0,
            end: 0,
            child: Align(
              alignment: Alignment.topCenter,
              child: AnimatedBuilder(
                animation: _controller,
                builder: (context, child) => Transform.translate(
                  offset: Offset(
                    0,
                    -10 * Curves.easeInOut.transform(_controller.value),
                  ),
                  child: child,
                ),
                child: Container(
                  width: AppSizes.onboardingCircle,
                  height: AppSizes.onboardingCircle,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withValues(alpha: 0.13),
                    boxShadow: AppShadows.chip,
                  ),
                  child: ClipOval(
                    child: SvgPicture.asset(
                      widget.slide.asset,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
          ),
          // Floating info chip.
          PositionedDirectional(
            bottom: 26,
            start: AppSpacing.lg,
            child: OnboardingChip(
              icon: widget.slide.chipIcon,
              title: widget.slide.chipTitle,
              subtitle: widget.slide.chipSubtitle,
            ),
          ),
        ],
      ),
    );
  }
}
