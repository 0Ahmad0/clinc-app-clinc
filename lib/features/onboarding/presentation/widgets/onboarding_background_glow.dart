import 'package:flutter/material.dart';

import '../../../../shared/extensions/context_extensions.dart';

/// Soft brand glow in the top corner of the onboarding screen.
class OnboardingBackgroundGlow extends StatelessWidget {
  const OnboardingBackgroundGlow({super.key});

  @override
  Widget build(BuildContext context) {
    return PositionedDirectional(
      top: -180,
      end: -160,
      child: IgnorePointer(
        child: Container(
          width: 420,
          height: 420,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: RadialGradient(
              colors: [
                context.colors.primary500.withValues(alpha: 0.10),
                context.colors.primary500.withValues(alpha: 0.0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
