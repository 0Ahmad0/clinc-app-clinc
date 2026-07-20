import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../../../../config/theme/app_spacing.dart';
import '../../../../shared/extensions/context_extensions.dart';
import '../../../../shared/widgets/app_switch.dart';

/// One settings row: a tinted icon, a title with an optional subtitle and a
/// trailing control — a toggle when [onToggle] is given, otherwise a chevron
/// for navigation rows.
class SettingsRow extends StatelessWidget {
  const SettingsRow({
    super.key,
    required this.icon,
    required this.tint,
    required this.name,
    this.sub,
    this.onTap,
    this.toggleValue,
    this.onToggle,
  });

  final IconData icon;
  final Color tint;
  final String name;
  final String? sub;
  final VoidCallback? onTap;
  final bool? toggleValue;
  final VoidCallback? onToggle;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final content = Padding(
      padding: const EdgeInsetsDirectional.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm + 2,
      ),
      child: Row(
        children: [
          Container(
            width: AppSizes.iconBox,
            height: AppSizes.iconBox,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: tint.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(AppRadius.sm),
            ),
            child: Icon(icon, size: AppSizes.iconSm, color: tint),
          ),
          AppGaps.w12,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: context.textTheme.bodyMedium?.copyWith(
                    color: colors.ink,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                if (sub != null)
                  Text(
                    sub!,
                    style: context.textTheme.labelSmall?.copyWith(
                      color: colors.muted,
                    ),
                  ),
              ],
            ),
          ),
          if (onToggle != null)
            AppSwitch(value: toggleValue ?? false, onChanged: onToggle!)
          else if (onTap != null)
            Icon(
              Directionality.of(context) == TextDirection.rtl
                  ? Iconsax.arrow_left_2
                  : Iconsax.arrow_right_3,
              size: AppSizes.iconSm,
              color: colors.ink.withValues(alpha: 0.35),
            ),
        ],
      ),
    );
    if (onTap == null) return content;
    return Material(
      color: colors.surface.withValues(alpha: 0),
      child: InkWell(onTap: onTap, child: content),
    );
  }
}
