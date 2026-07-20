import 'package:flutter/material.dart';

import '../../../../config/theme/app_spacing.dart';
import '../../../../shared/extensions/context_extensions.dart';

/// Translucent square action button used in the notifications header (back,
/// mark-all, clear-all).
class NotificationsHeaderAction extends StatelessWidget {
  const NotificationsHeaderAction({
    super.key,
    required this.icon,
    required this.onTap,
    this.tooltip,
  });

  final IconData icon;
  final VoidCallback onTap;
  final String? tooltip;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final button = SizedBox.square(
      dimension: AppSizes.hitTarget,
      child: Material(
        color: colors.onBrand.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(AppRadius.field),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(AppRadius.field),
          child: Icon(icon, size: AppSizes.iconMd, color: colors.onBrand),
        ),
      ),
    );
    return tooltip == null ? button : Tooltip(message: tooltip!, child: button);
  }
}
