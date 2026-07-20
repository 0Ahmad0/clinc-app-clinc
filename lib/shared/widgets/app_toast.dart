import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../../config/theme/app_spacing.dart';
import '../../core/enums/app_feedback_type.dart';
import '../extensions/context_extensions.dart';

class AppToast {
  const AppToast._();

  static void show(
    BuildContext context, {
    required String title,
    required String message,
    AppFeedbackType type = AppFeedbackType.info,
  }) {
    final colors = context.colors;
    final accent = switch (type) {
      AppFeedbackType.success => colors.successFg,
      AppFeedbackType.warning => colors.warningFg,
      AppFeedbackType.danger => colors.dangerFg,
      AppFeedbackType.info => colors.info,
    };
    final icon = switch (type) {
      AppFeedbackType.success => Iconsax.tick_circle,
      AppFeedbackType.warning => Iconsax.warning_2,
      AppFeedbackType.danger => Iconsax.close_circle,
      AppFeedbackType.info => Iconsax.info_circle,
    };
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          backgroundColor: colors.surface,
          content: Row(
            children: [
              Icon(icon, color: accent, size: AppSizes.iconLg),
              AppGaps.w12,
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: context.textTheme.bodyMedium?.copyWith(
                        color: colors.ink,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      message,
                      style: context.textTheme.bodySmall?.copyWith(
                        color: colors.gray,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
  }
}
