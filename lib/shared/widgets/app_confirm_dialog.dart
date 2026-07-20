import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../../config/theme/app_spacing.dart';
import '../../core/enums/app_button_variant.dart';
import '../../core/enums/app_feedback_type.dart';
import '../extensions/context_extensions.dart';
import 'app_button.dart';

class AppConfirmDialog extends StatelessWidget {
  const AppConfirmDialog({
    super.key,
    required this.title,
    required this.message,
    required this.confirmLabel,
    required this.cancelLabel,
    this.type = AppFeedbackType.info,
  });

  final String title;
  final String message;
  final String confirmLabel;
  final String cancelLabel;
  final AppFeedbackType type;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final danger = type == AppFeedbackType.danger;
    final success = type == AppFeedbackType.success;
    final accent = danger
        ? colors.dangerFg
        : success
        ? colors.successFg
        : type == AppFeedbackType.warning
        ? colors.warningFg
        : colors.info;
    final icon = danger
        ? Iconsax.trash
        : success
        ? Iconsax.tick_circle
        : type == AppFeedbackType.warning
        ? Iconsax.warning_2
        : Iconsax.info_circle;

    return AlertDialog(
      icon: Container(
        width: AppSizes.buttonHeight,
        height: AppSizes.buttonHeight,
        decoration: BoxDecoration(
          color: accent.withValues(alpha: 0.1),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: accent, size: AppSizes.iconLg),
      ),
      title: Text(title, textAlign: TextAlign.center),
      content: Text(message, textAlign: TextAlign.center),
      actionsAlignment: MainAxisAlignment.center,
      actions: [
        Row(
          children: [
            Expanded(
              child: AppButton(
                label: cancelLabel,
                variant: AppButtonVariant.ghost,
                onPressed: () => Navigator.of(context).pop(false),
              ),
            ),
            AppGaps.w12,
            Expanded(
              child: AppButton(
                label: confirmLabel,
                variant: danger
                    ? AppButtonVariant.danger
                    : success
                    ? AppButtonVariant.success
                    : AppButtonVariant.primary,
                onPressed: () => Navigator.of(context).pop(true),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
