import 'package:flutter/material.dart';

import '../../../../config/theme/app_spacing.dart';
import '../../../../shared/extensions/context_extensions.dart';

import 'package:iconsax_flutter/iconsax_flutter.dart';

/// Tappable "from / to" time chip inside a schedule row — opens a time picker.
class AddDoctorTimeBox extends StatelessWidget {
  const AddDoctorTimeBox({
    super.key,
    required this.label,
    required this.time,
    required this.onTap,
    this.hasError = false,
  });

  final String label;
  final String time;
  final VoidCallback onTap;
  final bool hasError;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Material(
      color: colors.bg,
      borderRadius: BorderRadius.circular(AppRadius.sm),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppRadius.sm),
        child: Container(
          padding: const EdgeInsetsDirectional.symmetric(
            horizontal: AppSpacing.sm,
            vertical: AppSpacing.xs + 1,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppRadius.sm),
            border: Border.all(
              color: hasError
                  ? colors.danger
                  : colors.ink.withValues(alpha: 0.08),
              width: 1.5,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: context.textTheme.labelSmall?.copyWith(
                  color: colors.muted,
                ),
              ),
              Row(
                children: [
                  Text(
                    time,
                    textDirection: TextDirection.ltr,
                    style: context.textTheme.bodyMedium?.copyWith(
                      color: colors.ink,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const Spacer(),
                  Icon(
                    Iconsax.clock,
                    size: AppSizes.iconXs,
                    color: colors.primary500,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
