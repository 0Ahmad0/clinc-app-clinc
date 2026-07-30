import 'package:flutter/material.dart';

import '../../config/theme/app_spacing.dart';
import '../extensions/context_extensions.dart';
import 'app_shimmer_placeholder.dart';

/// Pill toggle that slides a white knob; green when on, hairline-gray when off.
class AppSwitch extends StatelessWidget {
  const AppSwitch({
    super.key,
    required this.value,
    required this.onChanged,
    this.loading = false,
  });

  final bool value;
  final VoidCallback onChanged;
  final bool loading;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      toggled: value,
      child: GestureDetector(
        onTap: loading ? null : onChanged,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          width: AppSizes.availabilitySwitchWidth,
          height: AppSizes.availabilitySwitchHeight,
          padding: const EdgeInsetsDirectional.all(3),
          decoration: BoxDecoration(
            color: value ? context.colors.success : context.colors.line,
            borderRadius: BorderRadius.circular(AppRadius.pill),
          ),
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 180),
            child: loading
                ? const AppShimmerPlaceholder(
                    key: ValueKey('switch-loading'),
                    height: double.infinity,
                    borderRadius: AppRadius.pill,
                  )
                : AnimatedAlign(
                    key: ValueKey('switch-ready'),
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
      ),
    );
  }
}
