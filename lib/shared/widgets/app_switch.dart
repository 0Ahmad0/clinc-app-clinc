import 'package:flutter/material.dart';

import '../../config/theme/app_spacing.dart';
import '../extensions/context_extensions.dart';

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
    final colors = context.colors;
    final knobAlignment = value
        ? AlignmentDirectional.centerStart
        : AlignmentDirectional.centerEnd;
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
            color: value ? colors.success : colors.line,
            borderRadius: BorderRadius.circular(AppRadius.pill),
          ),
          child: AnimatedAlign(
            duration: const Duration(milliseconds: 250),
            alignment: knobAlignment,
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 160),
              child: loading
                  ? SizedBox.square(
                      key: const ValueKey('switch-loading'),
                      dimension: AppSizes.availabilityKnob,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: colors.surface,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: colors.ink.withValues(alpha: 0.08),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsetsDirectional.all(5),
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              value ? colors.successFg : colors.gray,
                            ),
                          ),
                        ),
                      ),
                    )
                  : Container(
                      key: const ValueKey('switch-ready'),
                      width: AppSizes.availabilityKnob,
                      height: AppSizes.availabilityKnob,
                      decoration: BoxDecoration(
                        color: colors.surface,
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
