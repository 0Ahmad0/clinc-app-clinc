import 'package:flutter/material.dart';

import '../../../../config/theme/app_spacing.dart';
import '../../../../shared/extensions/context_extensions.dart';

/// Full-width filled sheet action that dims to a disabled look when [enabled]
/// is false.
class AppointmentConfirmButton extends StatelessWidget {
  const AppointmentConfirmButton({
    super.key,
    required this.label,
    required this.enabled,
    required this.background,
    required this.onTap,
  });

  final String label;
  final bool enabled;
  final Color background;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Material(
      color: enabled ? background : colors.line,
      borderRadius: BorderRadius.circular(AppRadius.field),
      child: InkWell(
        onTap: enabled ? onTap : null,
        borderRadius: BorderRadius.circular(AppRadius.field),
        child: SizedBox(
          height: AppSizes.buttonHeightSm,
          child: Center(
            child: Text(
              label,
              style: context.textTheme.labelLarge?.copyWith(
                color: enabled ? colors.onBrand : colors.muted,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
