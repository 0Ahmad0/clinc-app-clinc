import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../../../../config/theme/app_spacing.dart';
import '../../../../shared/extensions/context_extensions.dart';

/// Shown when the active tab has no notifications.
class NotificationsEmpty extends StatelessWidget {
  const NotificationsEmpty({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Padding(
      padding: const EdgeInsetsDirectional.symmetric(vertical: AppSpacing.xxl),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: AppSizes.doctorAvatar,
            height: AppSizes.doctorAvatar,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: colors.primary500.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(AppRadius.card),
            ),
            child: Icon(
              Iconsax.notification,
              size: AppSizes.iconLg + AppSpacing.xs,
              color: colors.primary500,
            ),
          ),
          AppGaps.h12,
          Text(
            context.l10n.notifEmpty,
            style: context.textTheme.bodyMedium?.copyWith(color: colors.muted),
          ),
        ],
      ),
    );
  }
}
