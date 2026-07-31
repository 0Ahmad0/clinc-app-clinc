import 'package:flutter/material.dart';

import '../../config/theme/app_shadows.dart';
import '../../config/theme/app_spacing.dart';
import '../../core/enums/app_button_variant.dart';
import '../extensions/context_extensions.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.label,
    this.onPressed,
    this.variant = AppButtonVariant.primary,
    this.icon,
    this.isLoading = false,
  });

  final String label;
  final VoidCallback? onPressed;
  final AppButtonVariant variant;
  final IconData? icon;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final enabled = onPressed != null && !isLoading;
    final primary = variant == AppButtonVariant.primary;
    final success = variant == AppButtonVariant.success;
    final danger = variant == AppButtonVariant.danger;
    final secondary = variant == AppButtonVariant.secondary;
    final foreground = primary || success
        ? colors.onBrand
        : danger
        ? colors.dangerFg
        : secondary
        ? colors.primary600
        : colors.gray;
    final background = success
        ? colors.success
        : danger
        ? colors.danger.withValues(alpha: 0.06)
        : secondary
        ? colors.primary500.withValues(alpha: 0.06)
        : colors.surface.withValues(alpha: 0);
    final border = danger
        ? colors.dangerFg.withValues(alpha: 0.35)
        : secondary
        ? colors.primary500.withValues(alpha: 0.35)
        : variant == AppButtonVariant.ghost
        ? colors.line
        : colors.surface.withValues(alpha: 0);

    return Opacity(
      opacity: enabled || isLoading ? 1 : 0.5,
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: primary ? colors.ctaGradient : null,
          color: primary ? null : background,
          borderRadius: BorderRadius.circular(AppRadius.field),
          border: Border.all(color: border, width: 1.5),
          boxShadow: enabled && (primary || success)
              ? AppShadows.primaryButton
              : null,
        ),
        child: Material(
          color: colors.surface.withValues(alpha: 0),
          child: InkWell(
            onTap: enabled ? onPressed : null,
            borderRadius: BorderRadius.circular(AppRadius.field),
            child: SizedBox(
              height: AppSizes.buttonHeightSm,
              child: Center(
                child: isLoading
                    ? SizedBox.square(
                        dimension: AppSizes.iconMd,
                        child: CircularProgressIndicator(
                          strokeWidth: 2.2,
                          valueColor: AlwaysStoppedAnimation<Color>(foreground),
                        ),
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (icon != null) ...[
                            Icon(
                              icon,
                              size: AppSizes.iconMd,
                              color: foreground,
                            ),
                            AppGaps.w8,
                          ],
                          Flexible(
                            child: Text(
                              label,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                              style: context.textTheme.labelLarge?.copyWith(
                                color: foreground,
                              ),
                            ),
                          ),
                        ],
                      ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
