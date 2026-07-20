import 'package:flutter/material.dart';

import '../../config/theme/app_spacing.dart';
import '../extensions/context_extensions.dart';

/// Pill toggle that slides a white knob; green when on, hairline-gray when off.
class AppSwitch extends StatelessWidget {
  const AppSwitch({super.key, required this.value, required this.onChanged});

  final bool value;
  final VoidCallback onChanged;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      toggled: value,
      child: GestureDetector(
        onTap: onChanged,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          width: AppSizes.availabilitySwitchWidth,
          height: AppSizes.availabilitySwitchHeight,
          padding: const EdgeInsetsDirectional.all(3),
          decoration: BoxDecoration(
            color: value ? context.colors.success : context.colors.line,
            borderRadius: BorderRadius.circular(AppRadius.pill),
          ),
          child: AnimatedAlign(
            duration: const Duration(milliseconds: 250),
            alignment: value
                ? AlignmentDirectional.centerStart
                : AlignmentDirectional.centerEnd,
            child: Container(
              width: AppSizes.availabilityKnob,
              height: AppSizes.availabilityKnob,
              decoration: BoxDecoration(
                color: context.colors.surface,
                shape: BoxShape.circle,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
